Received: from eggs.gnu.org ([2001:4830:134:3::10]:51523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqE5-0007sd-Ls
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqE4-0003wi-OZ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqE4-0003vh-HB
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:36 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:17 +0100
Message-Id: <1543851204-41186-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/71] vhost-net: compile it on all targets
 that have virtio-net.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

This shows a preexisting bug: if a KVM target did not have virtio-net ena=
bled,
it would fail with undefined symbols when vhost was enabled.  This must n=
ow
be fixed, lest targets that have no virtio-net fail to compile.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure              | 11 ++++-------
 hw/net/Makefile.objs   |  4 ++--
 include/exec/poison.h  |  1 -
 tests/Makefile.include |  5 +----
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/configure b/configure
index cda17ef..b3b4464 100755
--- a/configure
+++ b/configure
@@ -6512,7 +6512,10 @@ fi
 if test "$vhost_scsi" =3D "yes" ; then
   echo "CONFIG_VHOST_SCSI=3Dy" >> $config_host_mak
 fi
-if test "$vhost_net" =3D "yes" -a "$vhost_user" =3D "yes"; then
+if test "$vhost_net" =3D "yes" ; then
+  echo "CONFIG_VHOST_NET=3Dy" >> $config_host_mak
+fi
+if test "$vhost_net_user" =3D "yes" ; then
   echo "CONFIG_VHOST_NET_USER=3Dy" >> $config_host_mak
 fi
 if test "$vhost_crypto" =3D "yes" ; then
@@ -7275,12 +7278,6 @@ if supported_xen_target $target; then
 fi
 if supported_kvm_target $target; then
     echo "CONFIG_KVM=3Dy" >> $config_target_mak
-    if test "$vhost_net" =3D "yes" ; then
-        echo "CONFIG_VHOST_NET=3Dy" >> $config_target_mak
-        if test "$vhost_user" =3D "yes" ; then
-            echo "CONFIG_VHOST_USER_NET_TEST_$target_name=3Dy" >> $confi=
g_host_mak
-        fi
-    fi
 fi
 if supported_hax_target $target; then
     echo "CONFIG_HAX=3Dy" >> $config_target_mak
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index c2705e6..2d7ee0a 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -37,8 +37,8 @@ obj-$(CONFIG_PSERIES) +=3D spapr_llan.o
 obj-$(CONFIG_XILINX_ETHLITE) +=3D xilinx_ethlite.o
=20
 obj-$(CONFIG_VIRTIO_NET) +=3D virtio-net.o
-obj-$(CONFIG_VHOST_NET) +=3D vhost_net.o
-common-obj-$(call lnot,$(CONFIG_VHOST_NET)) +=3D vhost_net-stub.o
+common-obj-$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET)) +=3D vh=
ost_net.o
+common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_N=
ET))) +=3D vhost_net-stub.o
 common-obj-$(CONFIG_ALL) +=3D vhost_net-stub.o
=20
 obj-$(CONFIG_ETSEC) +=3D fsl_etsec/etsec.o fsl_etsec/registers.o \
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 32d5378..b158632 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -85,7 +85,6 @@
 #pragma GCC poison CONFIG_XTENSA_DIS
=20
 #pragma GCC poison CONFIG_LINUX_USER
-#pragma GCC poison CONFIG_VHOST_NET
 #pragma GCC poison CONFIG_KVM
 #pragma GCC poison CONFIG_SOFTMMU
=20
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8e882ed..3e3b16b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -204,10 +204,7 @@ check-qtest-i386-$(CONFIG_USB_XHCI_NEC) +=3D tests/u=
sb-hcd-xhci-test$(EXESUF)
 check-qtest-i386-y +=3D tests/cpu-plug-test$(EXESUF)
 check-qtest-i386-y +=3D tests/q35-test$(EXESUF)
 check-qtest-i386-y +=3D tests/vmgenid-test$(EXESUF)
-check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) +=3D tests/vhost-use=
r-test$(EXESUF)
-ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
-check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) +=3D tests/vhost=
-user-test$(EXESUF)
-endif
+check-qtest-i386-$(CONFIG_VHOST_NET_USER) +=3D tests/vhost-user-test$(EX=
ESUF)
 check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tests/tpm-crb-swtpm-test$(EXESUF=
)
 check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tests/tpm-crb-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tests/tpm-tis-swtpm-test$(EXESUF=
)
--=20
1.8.3.1
