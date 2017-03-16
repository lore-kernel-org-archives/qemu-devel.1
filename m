Received: from eggs.gnu.org ([2001:4830:134:3::10]:42033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coZpA-0005Ay-KX
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 14:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coZp6-0002CH-QD
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 14:08:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1coZp6-0002BR-Jo
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 14:08:28 -0400
Date: Thu, 16 Mar 2017 18:08:23 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170316180823.GI15193@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<CAFEAcA-2mcGih5bscnMsevTNTy71g9kE7OjTy3hYJKeGoGQw-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-2mcGih5bscnMsevTNTy71g9kE7OjTy3hYJKeGoGQw-g@mail.gmail.com>
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Mar 16, 2017 at 06:01:35PM +0000, Peter Maydell wrote:
> On 16 March 2017 at 15:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> > (Technically right this instant 'mips' and 's390' would be in the
> > 'dump' list, since I don't personally have access yet. But we have
> > a plan for s390, and it turns out there is a mips machine in the
> > gcc compile farm which I'm just checking out.)
> 
> ...unfortunately the gcc compile farm mips board (1) is very slow
> and (2) has very little disk space free in /tmp, which means that
> it can't pass "make check" because for instance tests/test-replication
> assumes it can write comparatively large test files to /tmp/...

This should be enough to make it use the local build dir instead:

diff --git a/tests/test-replication.c b/tests/test-replication.c
index fac2da3..2a61a23 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -19,14 +19,14 @@
 
 /* primary */
 #define P_ID "primary-id"
-static char p_local_disk[] = "/tmp/p_local_disk.XXXXXX";
+static char p_local_disk[] = "p_local_disk.XXXXXX";
 
 /* secondary */
 #define S_ID "secondary-id"
 #define S_LOCAL_DISK_ID "secondary-local-disk-id"
-static char s_local_disk[] = "/tmp/s_local_disk.XXXXXX";
-static char s_active_disk[] = "/tmp/s_active_disk.XXXXXX";
-static char s_hidden_disk[] = "/tmp/s_hidden_disk.XXXXXX";
+static char s_local_disk[] = "s_local_disk.XXXXXX";
+static char s_active_disk[] = "s_active_disk.XXXXXX";
+static char s_hidden_disk[] = "s_hidden_disk.XXXXXX";
 
 /* FIXME: steal from blockdev.c */
 QemuOptsList qemu_drive_opts = {


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
