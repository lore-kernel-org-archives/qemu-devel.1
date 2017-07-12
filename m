Received: from eggs.gnu.org ([2001:4830:134:3::10]:44234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVFrG-0001c0-2v
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVFrC-0001wb-A0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:31:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dVFrC-0001w1-0h
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:31:02 -0400
Date: Wed, 12 Jul 2017 12:30:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170712113055.GE5237@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170711124411.10499-1-berrange@redhat.com>
	<149978289196.30.5533219451464874880@5d477a5b5989>
	<20170712091335.GC5237@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170712091335.GC5237@redhat.com>
Subject: Re: [Qemu-devel] [PULL v1 0/5] Merge sockets 2017/07/11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, famz@redhat.com

On Wed, Jul 12, 2017 at 10:13:35AM +0100, Daniel P. Berrange wrote:
> On Tue, Jul 11, 2017 at 07:21:32AM -0700, no-reply@patchew.org wrote:
> > Hi,
> > 
> > This series failed automatic build test. Please find the testing commands and
> > their output below. If you have docker installed, you can probably reproduce it
> > locally.
> > 
> > Message-id: 20170711124411.10499-1-berrange@redhat.com
> > Type: series
> > Subject: [Qemu-devel] [PULL v1 0/5] Merge sockets 2017/07/11
> > 
> 
> [snip]
> 
> >   GTESTER check-qtest-x86_64
> >   GTESTER check-qtest-aarch64
> 
> [snip]
> 
> > **
> > ERROR:/tmp/qemu-test/src/tests/test-sockets-proto.c:849:test_listen: assertion failed: (data->ipv4 == 0)
> 
> The problem here is that we're running qtests for x86_64 and
> aarch64 in parallel, and both are trying to bind to the same
> IPv4/IPv6 ports and so one fails.

A further problem was that the check for network protocol support was not
strong enough to skip the test when docker uses --net=none.

I'm going to squash the following into the v2 PULL request


diff --git a/tests/Makefile.include b/tests/Makefile.include
index 77b70f2..1266ed7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -337,7 +337,7 @@ check-qtest-s390x-y = tests/boot-serial-test$(EXESUF)
 
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
-check-qtest-generic-y += tests/test-sockets-proto$(EXESUF)
+check-qtest-x86_64-y += tests/test-sockets-proto$(EXESUF)
 
 qapi-schema += alternate-any.json
 qapi-schema += alternate-array.json
diff --git a/tests/test-sockets-proto.c b/tests/test-sockets-proto.c
index 1d6beda..89d557f 100644
--- a/tests/test-sockets-proto.c
+++ b/tests/test-sockets-proto.c
@@ -656,7 +656,7 @@ static QSocketsData test_data[] = {
       .args = "-vnc :::3100,to=9005,ipv4=off,ipv6=off" },
 };
 
-static int check_bind(const char *hostname)
+static int check_bind(const char *hostname, int family)
 {
     int fd = -1;
     struct addrinfo ai, *res = NULL;
@@ -665,7 +665,7 @@ static int check_bind(const char *hostname)
 
     memset(&ai, 0, sizeof(ai));
     ai.ai_flags = AI_CANONNAME | AI_ADDRCONFIG;
-    ai.ai_family = AF_UNSPEC;
+    ai.ai_family = family;
     ai.ai_socktype = SOCK_STREAM;
 
     /* lookup */
@@ -754,10 +754,10 @@ static int check_resolve_order(void)
 
 static int check_protocol_support(void)
 {
-    if (check_bind("0.0.0.0") < 0) {
+    if (check_bind("127.0.0.1", AF_INET) < 0) {
         return -1;
     }
-    if (check_bind("::") < 0) {
+    if (check_bind("::1", AF_INET6) < 0) {
         return -1;
     }
 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
