Received: from eggs.gnu.org ([209.51.188.92]:43228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw7xf-0004Lz-3E
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw7xd-0000uF-40
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:09:35 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 19 Feb 2019 10:09:20 -0600
Message-Id: <20190219160920.32705-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] iotests: Avoid SIGPIPE death to certtool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, thuth@redhat.com, berrange@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Our use of 'head -1' to log less output of certtool during
iotest 233 could result in certtool dying early due to SIGPIPE
if it generates enough output; if that happens, the certificate
it was supposed to generate may be zero length, which causes
failures such as:

  =3D=3D check TLS client to plain server fails =3D=3D
 -qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls=
-creds=3Dtls0': Denied by server for option 5 (starttls)
 -server reported: TLS not configured
 -qemu-nbd: Denied by server for option 5 (starttls)
 -server reported: TLS not configured
 +qemu-nbd: Unable to import client certificate /tmp/qemu-iotests-quick-2=
8354/tls/client1/client-cert.pem: Base64 unexpected header error.

Fix the pipelines to consume all output.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/common.tls | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/common.tl=
s
index eae81789bbc..15c6e8c8425 100644
--- a/tests/qemu-iotests/common.tls
+++ b/tests/qemu-iotests/common.tls
@@ -74,7 +74,7 @@ EOF
     certtool --generate-self-signed \
              --load-privkey "${tls_dir}/key.pem" \
              --template "${tls_dir}/ca.info" \
-             --outfile "${tls_dir}/$name-cert.pem" 2>&1 | head -1
+             --outfile "${tls_dir}/$name-cert.pem" 2>&1 | sed -n 1p

     rm -f "${tls_dir}/ca.info"
 }
@@ -103,7 +103,7 @@ EOF
              --load-ca-certificate "${tls_dir}/$caname-cert.pem" \
              --load-privkey "${tls_dir}/key.pem" \
              --template "${tls_dir}/cert.info" \
-             --outfile "${tls_dir}/$name/server-cert.pem" 2>&1 | head -1
+             --outfile "${tls_dir}/$name/server-cert.pem" 2>&1 | sed -n =
1p
     ln -s "${tls_dir}/$caname-cert.pem" "${tls_dir}/$name/ca-cert.pem"
     ln -s "${tls_dir}/key.pem" "${tls_dir}/$name/server-key.pem"

@@ -132,7 +132,7 @@ EOF
              --load-ca-certificate "${tls_dir}/$caname-cert.pem" \
              --load-privkey "${tls_dir}/key.pem" \
              --template "${tls_dir}/cert.info" \
-             --outfile "${tls_dir}/$name/client-cert.pem" 2>&1 | head -1
+             --outfile "${tls_dir}/$name/client-cert.pem" 2>&1 | sed -n =
1p
     ln -s "${tls_dir}/$caname-cert.pem" "${tls_dir}/$name/ca-cert.pem"
     ln -s "${tls_dir}/key.pem" "${tls_dir}/$name/client-key.pem"

--=20
2.20.1
