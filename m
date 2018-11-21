Received: from eggs.gnu.org ([2001:4830:134:3::10]:50906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPafl-0005MB-7q
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPaff-0002W1-BH
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPaff-0002UT-2S
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:31 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:30 +0400
Message-Id: <20181121220647.18844-14-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 13/30] build-sys: use a seperate
 slirp-obj-y && slirp.mo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This will allow to have cflags for the whole slirp.mo -objs.
It makes it possible to build tests that links only with
slirp-obj-y (and not the whole common-obj).

It is also a step towards building slirp as a shared library, although
this requires a bit more thoughts to build with
net/slirp.o (CONFIG_SLIRP would need to be 'm') and other build issues.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile.objs       |  3 +--
 Makefile.target     |  5 ++++-
 slirp/Makefile.objs | 35 ++++++++++++++++++++++++++++++-----
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 31852eaf8f..a11050a7aa 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -61,6 +61,7 @@ util-obj-y +=3D qapi/qapi-events-ui.o
 util-obj-y +=3D qapi/qapi-introspect.o
=20
 chardev-obj-y =3D chardev/
+slirp-obj-$(CONFIG_SLIRP) =3D slirp/
=20
 #######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
@@ -123,8 +124,6 @@ common-obj-y +=3D vl.o
 vl.o-cflags :=3D $(GPROF_CFLAGS) $(SDL_CFLAGS)
 common-obj-$(CONFIG_TPM) +=3D tpm.o
=20
-common-obj-$(CONFIG_SLIRP) +=3D slirp/
-
 common-obj-y +=3D backends/
 common-obj-y +=3D chardev/
=20
diff --git a/Makefile.target b/Makefile.target
index 4d56298bbf..3a970b1b77 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -168,6 +168,7 @@ target-obj-y :=3D
 block-obj-y :=3D
 common-obj-y :=3D
 chardev-obj-y :=3D
+slirp-obj-y :=3D
 include $(SRC_PATH)/Makefile.objs
 dummy :=3D $(call unnest-vars,,target-obj-y)
 target-obj-y-save :=3D $(target-obj-y)
@@ -180,9 +181,11 @@ dummy :=3D $(call unnest-vars,.., \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
-               common-obj-m)
+               common-obj-m \
+               slirp-obj-y)
 target-obj-y :=3D $(target-obj-y-save)
 all-obj-y +=3D $(common-obj-y)
+all-obj-y +=3D $(slirp-obj-y)
 all-obj-y +=3D $(target-obj-y)
 all-obj-y +=3D $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(chardev-obj-y)
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
2.20.0.rc1
