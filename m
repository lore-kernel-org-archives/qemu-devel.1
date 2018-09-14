Received: from eggs.gnu.org ([2001:4830:134:3::10]:53844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1g0kq6-00085Y-M2
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 05:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1g0kq5-0005eu-NF
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 05:56:38 -0400
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Fri, 14 Sep 2018 10:56:22 +0100
Message-Id: <20180914095622.19698-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] curl: Make sslverify=off disable host as well
 as peer verification.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jcody@redhat.com
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

The sslverify setting is supposed to turn off all TLS certificate
checks in libcurl.  However because of the way we use it, it only
turns off peer certificate authenticity checks
(CURLOPT_SSL_VERIFYPEER).  This patch makes it also turn off the check
that the server name in the certificate is the same as the server
you're connecting to (CURLOPT_SSL_VERIFYHOST).

We can use Google's server at 8.8.8.8 which happens to have a bad TLS
certificate to demonstrate this:

$ ./qemu-img create -q -f qcow2 -b 'json: { "file.sslverify": "off", "fil=
e.driver": "https", "file.url": "https://8.8.8.8/foo" }' /var/tmp/file.qc=
ow2
qemu-img: /var/tmp/file.qcow2: CURL: Error opening file: SSL: no alternat=
ive certificate subject name matches target host name '8.8.8.8'
Could not open backing image to determine size.

With this patch applied, qemu-img connects to the server regardless of
the bad certificate:

$ ./qemu-img create -q -f qcow2 -b 'json: { "file.sslverify": "off", "fil=
e.driver": "https", "file.url": "https://8.8.8.8/foo" }' /var/tmp/file.qc=
ow2
qemu-img: /var/tmp/file.qcow2: CURL: Error opening file: The requested UR=
L returned error: 404 Not Found

(The 404 error is expected because 8.8.8.8 is not actually serving a
file called "/foo".)

Of course the default (without sslverify=3Doff) remains to always check
the certificate:

$ ./qemu-img create -q -f qcow2 -b 'json: { "file.driver": "https", "file=
.url": "https://8.8.8.8/foo" }' /var/tmp/file.qcow2
qemu-img: /var/tmp/file.qcow2: CURL: Error opening file: SSL: no alternat=
ive certificate subject name matches target host name '8.8.8.8'
Could not open backing image to determine size.

Further information about the two settings is available here:

https://curl.haxx.se/libcurl/c/CURLOPT_SSL_VERIFYPEER.html
https://curl.haxx.se/libcurl/c/CURLOPT_SSL_VERIFYHOST.html

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 block/curl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 229bb84a27..fabb2b4da7 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -483,6 +483,8 @@ static int curl_init_state(BDRVCURLState *s, CURLStat=
e *state)
         curl_easy_setopt(state->curl, CURLOPT_URL, s->url);
         curl_easy_setopt(state->curl, CURLOPT_SSL_VERIFYPEER,
                          (long) s->sslverify);
+        curl_easy_setopt(state->curl, CURLOPT_SSL_VERIFYHOST,
+                         s->sslverify ? 2L : 0L);
         if (s->cookie) {
             curl_easy_setopt(state->curl, CURLOPT_COOKIE, s->cookie);
         }
--=20
2.19.0.rc0
