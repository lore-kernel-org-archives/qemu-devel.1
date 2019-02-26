Received: from eggs.gnu.org ([209.51.188.92]:33059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyfw3-00084g-GA
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyfvy-0001Yc-CK
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:50:24 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 26 Feb 2019 10:50:13 -0600
Message-Id: <20190226165013.24867-4-eblake@redhat.com>
In-Reply-To: <20190226165013.24867-1-eblake@redhat.com>
References: <20190226165013.24867-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 3/3] iotests: avoid broken pipe with certtool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

When we run "certtool 2>&1 | head -1" the latter command is likely to
complete and exit before certtool has written everything it wants to
stderr. In at least the RHEL-7 gnutls 3.3.29 this causes certtool to
quit with broken pipe before it has finished writing the desired
output file to disk. This causes non-deterministic failures of the
iotest 233 because the certs are sometimes zero length files.
If certtool fails the "head -1" means we also lose any useful error
message it would have printed.

Thus this patch gets rid of the pipe and post-processes the output in a
more flexible & reliable manner.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190220145819.30969-3-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/common.tls | 48 +++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/common.tl=
s
index eae81789bbc..3caf989d28c 100644
--- a/tests/qemu-iotests/common.tls
+++ b/tests/qemu-iotests/common.tls
@@ -29,6 +29,17 @@ tls_x509_cleanup()
 }


+tls_certtool()
+{
+    certtool "$@" 1>"${tls_dir}"/certtool.log 2>&1
+    if test "$?" =3D 0; then
+      head -1 "${tls_dir}"/certtool.log
+    else
+      cat "${tls_dir}"/certtool.log
+    fi
+    rm -f "${tls_dir}"/certtool.log
+}
+
 tls_x509_init()
 {
     (certtool --help) >/dev/null 2>&1 || \
@@ -71,10 +82,11 @@ ca
 cert_signing_key
 EOF

-    certtool --generate-self-signed \
-             --load-privkey "${tls_dir}/key.pem" \
-             --template "${tls_dir}/ca.info" \
-             --outfile "${tls_dir}/$name-cert.pem" 2>&1 | head -1
+    tls_certtool \
+        --generate-self-signed \
+        --load-privkey "${tls_dir}/key.pem" \
+        --template "${tls_dir}/ca.info" \
+        --outfile "${tls_dir}/$name-cert.pem"

     rm -f "${tls_dir}/ca.info"
 }
@@ -98,12 +110,14 @@ encryption_key
 signing_key
 EOF

-    certtool --generate-certificate \
-             --load-ca-privkey "${tls_dir}/key.pem" \
-             --load-ca-certificate "${tls_dir}/$caname-cert.pem" \
-             --load-privkey "${tls_dir}/key.pem" \
-             --template "${tls_dir}/cert.info" \
-             --outfile "${tls_dir}/$name/server-cert.pem" 2>&1 | head -1
+    tls_certtool \
+        --generate-certificate \
+        --load-ca-privkey "${tls_dir}/key.pem" \
+        --load-ca-certificate "${tls_dir}/$caname-cert.pem" \
+        --load-privkey "${tls_dir}/key.pem" \
+        --template "${tls_dir}/cert.info" \
+        --outfile "${tls_dir}/$name/server-cert.pem"
+
     ln -s "${tls_dir}/$caname-cert.pem" "${tls_dir}/$name/ca-cert.pem"
     ln -s "${tls_dir}/key.pem" "${tls_dir}/$name/server-key.pem"

@@ -127,12 +141,14 @@ encryption_key
 signing_key
 EOF

-    certtool --generate-certificate \
-             --load-ca-privkey "${tls_dir}/key.pem" \
-             --load-ca-certificate "${tls_dir}/$caname-cert.pem" \
-             --load-privkey "${tls_dir}/key.pem" \
-             --template "${tls_dir}/cert.info" \
-             --outfile "${tls_dir}/$name/client-cert.pem" 2>&1 | head -1
+    tls_certtool \
+        --generate-certificate \
+        --load-ca-privkey "${tls_dir}/key.pem" \
+        --load-ca-certificate "${tls_dir}/$caname-cert.pem" \
+        --load-privkey "${tls_dir}/key.pem" \
+        --template "${tls_dir}/cert.info" \
+        --outfile "${tls_dir}/$name/client-cert.pem"
+
     ln -s "${tls_dir}/$caname-cert.pem" "${tls_dir}/$name/ca-cert.pem"
     ln -s "${tls_dir}/key.pem" "${tls_dir}/$name/client-key.pem"

--=20
2.20.1
