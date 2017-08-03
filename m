Received: from eggs.gnu.org ([2001:4830:134:3::10]:38459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ddC6q-0006bB-Sx
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 05:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ddC6o-0002Bo-7e
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 05:08:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ddC6n-00029P-UT
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 05:07:58 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  3 Aug 2017 11:07:46 +0200
Message-Id: <20170803090746.30532-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] build-sys: add --disable-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, philippe.mathieu.daude@gmail.com, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

Learn to compile out vhost-user (net, scsi & upcoming users). Keep it
enabled by default on non-win32, that is assumed to be POSIX. Fail if
trying to enable it on win32.

When trying to make a vhost-user netdev, it gives the following error:

-netdev vhost-user,id=3Dfoo,chardev=3Dchr-test: Parameter 'type' expects =
a netdev backend type

And similar error with the HMP/QMP monitors.

While at it, rename CONFIG_VHOST_NET_TEST CONFIG_VHOST_USER_NET_TEST
since it's a vhost-user specific variable.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/virtio-pci.c            |  4 ++--
 configure                         | 28 ++++++++++++++++++++++++++--
 default-configs/pci.mak           |  2 +-
 default-configs/s390x-softmmu.mak |  2 +-
 tests/Makefile.include            |  6 +++---
 5 files changed, 33 insertions(+), 9 deletions(-)

v3:
- user error_exit in configure
- drop patch to compile out net/vhost-user.c

v2:
- remove some #ifdef, reuse CONFIG_VHOST_NET_USED
- split the patch to have net/vhost-user.c compiled out (adding 2 ifdefs)
- fail if --enable-vhost-user on win32

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5d14bd66dc..8b0d6b69cd 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2135,7 +2135,7 @@ static const TypeInfo vhost_scsi_pci_info =3D {
 };
 #endif
=20
-#ifdef CONFIG_LINUX
+#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
 /* vhost-user-scsi-pci */
 static Property vhost_user_scsi_pci_properties[] =3D {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
@@ -2665,7 +2665,7 @@ static void virtio_pci_register_types(void)
 #ifdef CONFIG_VHOST_SCSI
     type_register_static(&vhost_scsi_pci_info);
 #endif
-#ifdef CONFIG_LINUX
+#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
     type_register_static(&vhost_user_scsi_pci_info);
 #endif
 #ifdef CONFIG_VHOST_VSOCK
diff --git a/configure b/configure
index 987f59ba88..dd73cce62f 100755
--- a/configure
+++ b/configure
@@ -306,6 +306,7 @@ tcg=3D"yes"
 vhost_net=3D"no"
 vhost_scsi=3D"no"
 vhost_vsock=3D"no"
+vhost_user=3D""
 kvm=3D"no"
 hax=3D"no"
 rdma=3D""
@@ -1282,6 +1283,14 @@ for opt do
   ;;
   --enable-vxhs) vxhs=3D"yes"
   ;;
+  --disable-vhost-user) vhost_user=3D"no"
+  ;;
+  --enable-vhost-user)
+      vhost_user=3D"yes"
+      if test "$mingw32" =3D "yes"; then
+          error_exit "vhost-user isn't available on win32"
+      fi
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1290,6 +1299,14 @@ for opt do
   esac
 done
=20
+if test "$vhost_user" =3D ""; then
+    if test "$mingw32" =3D "yes"; then
+        vhost_user=3D"no"
+    else
+        vhost_user=3D"yes"
+    fi
+fi
+
 case "$cpu" in
     ppc)
            CPU_CFLAGS=3D"-m32"
@@ -1518,6 +1535,7 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
   tools           build qemu-io, qemu-nbd and qemu-image tools
   vxhs            Veritas HyperScale vDisk backend support
   crypto-afalg    Linux AF_ALG crypto backend driver
+  vhost-user      vhost-user support
=20
 NOTE: The object files are built at the place where configure is launche=
d
 EOF
@@ -5348,6 +5366,7 @@ echo "libcap-ng support $cap_ng"
 echo "vhost-net support $vhost_net"
 echo "vhost-scsi support $vhost_scsi"
 echo "vhost-vsock support $vhost_vsock"
+echo "vhost-user support $vhost_user"
 echo "Trace backends    $trace_backends"
 if have_backend "simple"; then
 echo "Trace output file $trace_file-<pid>"
@@ -5757,12 +5776,15 @@ fi
 if test "$vhost_scsi" =3D "yes" ; then
   echo "CONFIG_VHOST_SCSI=3Dy" >> $config_host_mak
 fi
-if test "$vhost_net" =3D "yes" ; then
+if test "$vhost_net" =3D "yes" -a "$vhost_user" =3D "yes"; then
   echo "CONFIG_VHOST_NET_USED=3Dy" >> $config_host_mak
 fi
 if test "$vhost_vsock" =3D "yes" ; then
   echo "CONFIG_VHOST_VSOCK=3Dy" >> $config_host_mak
 fi
+if test "$vhost_user" =3D "yes" ; then
+  echo "CONFIG_VHOST_USER=3Dy" >> $config_host_mak
+fi
 if test "$blobs" =3D "yes" ; then
   echo "INSTALL_BLOBS=3Dyes" >> $config_host_mak
 fi
@@ -6358,7 +6380,9 @@ if supported_kvm_target $target; then
     echo "CONFIG_KVM=3Dy" >> $config_target_mak
     if test "$vhost_net" =3D "yes" ; then
         echo "CONFIG_VHOST_NET=3Dy" >> $config_target_mak
-        echo "CONFIG_VHOST_NET_TEST_$target_name=3Dy" >> $config_host_ma=
k
+        if test "$vhost_user" =3D "yes" ; then
+            echo "CONFIG_VHOST_USER_NET_TEST_$target_name=3Dy" >> $confi=
g_host_mak
+        fi
     fi
 fi
 if supported_hax_target $target; then
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index acaa70301a..a758630d30 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -43,4 +43,4 @@ CONFIG_VGA=3Dy
 CONFIG_VGA_PCI=3Dy
 CONFIG_IVSHMEM_DEVICE=3D$(CONFIG_IVSHMEM)
 CONFIG_ROCKER=3Dy
-CONFIG_VHOST_USER_SCSI=3D$(CONFIG_LINUX)
+CONFIG_VHOST_USER_SCSI=3D$(and $(CONFIG_VHOST_USER),$(CONFIG_LINUX))
diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-so=
ftmmu.mak
index b227a36179..51191b77df 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -1,6 +1,6 @@
 CONFIG_PCI=3Dy
 CONFIG_VIRTIO_PCI=3Dy
-CONFIG_VHOST_USER_SCSI=3D$(CONFIG_LINUX)
+CONFIG_VHOST_USER_SCSI=3D$(and $(CONFIG_VHOST_USER),$(CONFIG_LINUX))
 CONFIG_VIRTIO=3Dy
 CONFIG_SCLPCONSOLE=3Dy
 CONFIG_TERMINAL3270=3Dy
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 59e536bf0b..eb4895f94a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -255,9 +255,9 @@ check-qtest-i386-y +=3D tests/pc-cpu-test$(EXESUF)
 check-qtest-i386-y +=3D tests/q35-test$(EXESUF)
 check-qtest-i386-y +=3D tests/vmgenid-test$(EXESUF)
 gcov-files-i386-y +=3D hw/pci-host/q35.c
-check-qtest-i386-$(CONFIG_VHOST_NET_TEST_i386) +=3D tests/vhost-user-tes=
t$(EXESUF)
-ifeq ($(CONFIG_VHOST_NET_TEST_i386),)
-check-qtest-x86_64-$(CONFIG_VHOST_NET_TEST_x86_64) +=3D tests/vhost-user=
-test$(EXESUF)
+check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) +=3D tests/vhost-use=
r-test$(EXESUF)
+ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
+check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) +=3D tests/vhost=
-user-test$(EXESUF)
 endif
 check-qtest-i386-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
 check-qtest-i386-y +=3D tests/test-filter-mirror$(EXESUF)
--=20
2.14.0.rc0.1.g40ca67566
