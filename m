Received: from eggs.gnu.org ([209.51.188.92]:51875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipl5-0003sf-5g
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipkw-0006xv-5H
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:35 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipkm-0006kA-4g
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:22 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 01:03:22 +0100
Message-Id: <20190114000326.29847-62-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 61/65] build-sys: use a seperate slirp-obj-y &&
 slirp.mo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This will allow to have cflags for the whole slirp.mo -objs.
It makes it possible to build tests that links only with
slirp-obj-y (and not the whole common-obj).

It is also a step towards building slirp as a shared library, although
this requires a bit more thoughts to build with
net/slirp.o (CONFIG_SLIRP would need to be 'm') and other build issues.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 Makefile.objs       |  3 +--
 Makefile.target     |  5 ++++-
 slirp/Makefile.objs | 35 ++++++++++++++++++++++++++++++-----
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 2121120492..67a054b08a 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -17,6 +17,7 @@ util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.o=
)
 util-obj-y +=3D qapi/qapi-introspect.o
=20
 chardev-obj-y =3D chardev/
+slirp-obj-$(CONFIG_SLIRP) =3D slirp/
=20
 #######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
@@ -79,8 +80,6 @@ common-obj-y +=3D vl.o
 vl.o-cflags :=3D $(GPROF_CFLAGS) $(SDL_CFLAGS)
 common-obj-$(CONFIG_TPM) +=3D tpm.o
=20
-common-obj-$(CONFIG_SLIRP) +=3D slirp/
-
 common-obj-y +=3D backends/
 common-obj-y +=3D chardev/
=20
diff --git a/Makefile.target b/Makefile.target
index 44ec4b630c..39f72e81be 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -165,6 +165,7 @@ target-obj-y :=3D
 block-obj-y :=3D
 common-obj-y :=3D
 chardev-obj-y :=3D
+slirp-obj-y :=3D
 include $(SRC_PATH)/Makefile.objs
 dummy :=3D $(call unnest-vars,,target-obj-y)
 target-obj-y-save :=3D $(target-obj-y)
@@ -177,7 +178,8 @@ dummy :=3D $(call unnest-vars,.., \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
-               common-obj-m)
+               common-obj-m \
+               slirp-obj-y)
 target-obj-y :=3D $(target-obj-y-save)
 all-obj-y +=3D $(common-obj-y)
 all-obj-y +=3D $(target-obj-y)
@@ -186,6 +188,7 @@ all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(chard=
ev-obj-y)
 all-obj-$(CONFIG_USER_ONLY) +=3D $(crypto-aes-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)
+all-obj-$(CONFIG_SOFTMMU) +=3D $(slirp-obj-y)
=20
 $(QEMU_PROG_BUILD): config-devices.mak
=20
diff --git a/slirp/Makefile.objs b/slirp/Makefile.objs
index 28049b03cd..21653f69e9 100644
--- a/slirp/Makefile.objs
+++ b/slirp/Makefile.objs
@@ -1,5 +1,30 @@
-common-obj-y =3D cksum.o if.o ip_icmp.o ip6_icmp.o ip6_input.o ip6_outpu=
t.o \
-               ip_input.o ip_output.o dnssearch.o dhcpv6.o
-common-obj-y +=3D slirp.o mbuf.o misc.o sbuf.o socket.o tcp_input.o tcp_=
output.o
-common-obj-y +=3D tcp_subr.o tcp_timer.o udp.o udp6.o bootp.o tftp.o arp=
_table.o \
-                ndp_table.o ncsi.o
+slirp-obj-y =3D slirp.mo
+
+slirp.mo-objs =3D \
+	arp_table.o \
+	bootp.o \
+	cksum.o \
+	dhcpv6.o \
+	dnssearch.o \
+	if.o \
+	ip6_icmp.o \
+	ip6_input.o \
+	ip6_output.o \
+	ip_icmp.o \
+	ip_input.o \
+	ip_output.o \
+	mbuf.o \
+	misc.o \
+	ncsi.o \
+	ndp_table.o \
+	sbuf.o \
+	slirp.o \
+	socket.o \
+	tcp_input.o \
+	tcp_output.o \
+	tcp_subr.o \
+	tcp_timer.o \
+	tftp.o \
+	udp.o \
+	udp6.o \
+	$(NULL)
--=20
2.20.1
