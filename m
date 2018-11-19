Received: from eggs.gnu.org ([2001:4830:134:3::10]:51434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnl3-0000J4-Fn
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnl2-0002d4-6K
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:49 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Nov 2018 11:54:24 -0600
Message-Id: <20181119175427.2298497-10-eblake@redhat.com>
In-Reply-To: <20181119175427.2298497-1-eblake@redhat.com>
References: <20181119175427.2298497-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/12] tests: add iotests helpers for dealing
 with TLS certificates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Add helpers to common.tls for creating TLS certificates for a CA,
server and client.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20181116155325.22428-6-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: spelling and quoting touchups]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/common.tls | 137 ++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 tests/qemu-iotests/common.tls

diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/common.tl=
s
new file mode 100644
index 00000000000..cecab269ec6
--- /dev/null
+++ b/tests/qemu-iotests/common.tls
@@ -0,0 +1,137 @@
+#!/bin/bash
+#
+# Helpers for TLS related config
+#
+# Copyright (C) 2018 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+tls_dir=3D"${TEST_DIR}/tls"
+
+function tls_x509_cleanup()
+{
+    rm -f "${tls_dir}"/*.pem
+    rm -f "${tls_dir}"/*/*.pem
+    rmdir "${tls_dir}"/*
+    rmdir "${tls_dir}"
+}
+
+
+function tls_x509_init()
+{
+    mkdir -p "${tls_dir}"
+
+    # use a fixed key so we don't waste system entropy on
+    # each test run
+    cat > "${tls_dir}/key.pem" <<EOF
+-----BEGIN PRIVATE KEY-----
+MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALVcr
+BL40Tm6yq88FBhJNw1aaoCjmtg0l4dWQZ/e9Fimx4ARxFpT+ji4FE
+Cgl9s/SGqC+1nvlkm9ViSo0j7MKDbnDB+VRHDvMAzQhA2X7e8M0n9
+rPolUY2lIVC83q0BBaOBkCj2RSmT2xTEbbC2xLukSrg2WP/ihVOxc
+kXRuyFtzAgMBAAECgYB7slBexDwXrtItAMIH6m/U+LUpNe0Xx48OL
+IOn4a4whNgO/o84uIwygUK27ZGFZT0kAGAk8CdF9hA6ArcbQ62s1H
+myxrUbF9/mrLsQw1NEqpuUk9Ay2Tx5U/wPx35S3W/X2AvR/ZpTnCn
+2q/7ym9fyiSoj86drD7BTvmKXlOnOwQJBAPOFMp4mMa9NGpGuEssO
+m3Uwbp6lhcP0cA9MK+iOmeANpoKWfBdk5O34VbmeXnGYWEkrnX+9J
+bM4wVhnnBWtgBMCQQC+qAEmvwcfhauERKYznMVUVksyeuhxhCe7EK
+mPh+U2+g0WwdKvGDgO0PPt1gq0ILEjspMDeMHVdTwkaVBo/uMhAkA
+Z5SsZyCP2aTOPFDypXRdI4eqRcjaEPOUBq27r3uYb/jeboVb2weLa
+L1MmVuHiIHoa5clswPdWVI2y0em2IGoDAkBPSp/v9VKJEZabk9Frd
+a+7u4fanrM9QrEjY3KhduslSilXZZSxrWjjAJPyPiqFb3M8XXA26W
+nz1KYGnqYKhLcBAkB7dt57n9xfrhDpuyVEv+Uv1D3VVAhZlsaZ5Pp
+dcrhrkJn2sa/+O8OKvdrPSeeu/N5WwYhJf61+CPoenMp7IFci
+-----END PRIVATE KEY-----
+EOF
+}
+
+
+function tls_x509_create_root_ca()
+{
+    name=3D${1:-ca-cert}
+
+    cat > "${tls_dir}/ca.info" <<EOF
+cn =3D Cthulhu Dark Lord Enterprises $name
+ca
+cert_signing_key
+EOF
+
+    certtool --generate-self-signed \
+             --load-privkey "${tls_dir}/key.pem" \
+             --template "${tls_dir}/ca.info" \
+             --outfile "${tls_dir}/$name-cert.pem" 2>&1 | head -1
+
+    rm -f "${tls_dir}/ca.info"
+}
+
+
+function tls_x509_create_server()
+{
+    caname=3D$1
+    name=3D$2
+
+    mkdir -p "${tls_dir}/$name"
+    cat > "${tls_dir}/cert.info" <<EOF
+organization =3D Cthulhu Dark Lord Enterprises $name
+cn =3D localhost
+dns_name =3D localhost
+dns_name =3D localhost.localdomain
+ip_address =3D 127.0.0.1
+ip_address =3D ::1
+tls_www_server
+encryption_key
+signing_key
+EOF
+
+    certtool --generate-certificate \
+             --load-ca-privkey "${tls_dir}/key.pem" \
+             --load-ca-certificate "${tls_dir}/$caname-cert.pem" \
+             --load-privkey "${tls_dir}/key.pem" \
+             --template "${tls_dir}/cert.info" \
+             --outfile "${tls_dir}/$name/server-cert.pem" 2>&1 | head -1
+    ln -s "${tls_dir}/$caname-cert.pem" "${tls_dir}/$name/ca-cert.pem"
+    ln -s "${tls_dir}/key.pem" "${tls_dir}/$name/server-key.pem"
+
+    rm -f "${tls_dir}/cert.info"
+}
+
+
+function tls_x509_create_client()
+{
+    caname=3D$1
+    name=3D$2
+
+    mkdir -p "${tls_dir}/$name"
+    cat > "${tls_dir}/cert.info" <<EOF
+country =3D South Pacific
+locality =3D  R'lyeh
+organization =3D Cthulhu Dark Lord Enterprises $name
+cn =3D localhost
+tls_www_client
+encryption_key
+signing_key
+EOF
+
+    certtool --generate-certificate \
+             --load-ca-privkey "${tls_dir}/key.pem" \
+             --load-ca-certificate "${tls_dir}/$caname-cert.pem" \
+             --load-privkey "${tls_dir}/key.pem" \
+             --template "${tls_dir}/cert.info" \
+             --outfile "${tls_dir}/$name/client-cert.pem" 2>&1 | head -1
+    ln -s "${tls_dir}/$caname-cert.pem" "${tls_dir}/$name/ca-cert.pem"
+    ln -s "${tls_dir}/key.pem" "${tls_dir}/$name/client-key.pem"
+
+    rm -f "${tls_dir}/cert.info"
+}
--=20
2.17.2
