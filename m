Received: from eggs.gnu.org ([209.51.188.92]:50447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQI-0007F6-1k
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQE-0001FN-CA
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:44 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  4 May 2019 06:05:24 -0600
Message-Id: <20190504120528.6389-7-pbonzini@redhat.com>
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 6/9] configure: add control-flow protection
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org

Control-flow protection requires object files to note which features
are supported.  The linker will merge them to the set of features that
are supported by all object files.  The compiler creates these notes
when the -fcf-protection option is passed, but we have to blacklist
some object files that only support a subset of the full control-flow
protection feature set.

Even without any further host-specific patches, user-mode emulation
binaries can already use shadow stacks, because they don't need
coroutines and don't include the problematic util/coroutine-*.o
object files.  Likewise, system-mode emulation binaries will enable
indirect branch tracking if built without TCG support.

The next patches will improve the situation so that QEMU can be built
with full protection on x86 hosts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target    |  3 +++
 configure          | 29 +++++++++++++++++++++++++++++
 util/Makefile.objs |  5 +++++
 3 files changed, 37 insertions(+)

diff --git a/Makefile.target b/Makefile.target
index ae02495951..667682779b 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -111,6 +111,9 @@ obj-y += exec.o
 obj-y += accel/
 obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-op-gvec.o
 obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/optimize.o
+ifeq ($(CONFIG_CF_PROTECTION),y)
+tcg/tcg.o-cflags := -fcf-protection=return
+endif
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-$(CONFIG_TCG) += fpu/softfloat.o
diff --git a/configure b/configure
index 26e62a4ab1..946ff7825a 100755
--- a/configure
+++ b/configure
@@ -449,6 +449,7 @@ win_sdk="no"
 want_tools="yes"
 libiscsi=""
 libnfs=""
+cf_protection="no"      # leave it disabled until we can test performance
 coroutine=""
 coroutine_pool=""
 debug_stack_usage="no"
@@ -1267,6 +1268,10 @@ for opt do
   ;;
   --with-pkgversion=*) pkgversion="$optarg"
   ;;
+  --enable-cf-protection) cf_protection="yes"
+  ;;
+  --disable-cf-protection) cf_protection="no"
+  ;;
   --with-coroutine=*) coroutine="$optarg"
   ;;
   --disable-coroutine-pool) coroutine_pool="no"
@@ -1796,6 +1801,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   lzfse           support of lzfse compression library
                   (for reading lzfse-compressed dmg images)
   seccomp         seccomp support
+  cf-protection   Control-flow protection
   coroutine-pool  coroutine freelist (better performance)
   glusterfs       GlusterFS backend
   tpm             TPM support
@@ -5176,6 +5182,25 @@ if have_backend "dtrace"; then
   fi
 fi
 
+##########################################
+# detect Control-flow protection support in the toolchain
+
+if test "$cf_protection" != no; then
+  write_c_skeleton;
+  if ! compile_prog "-fcf-protection" "" ; then
+    if test "$cf_protection" = yes; then
+      feature_not_found "cf_protection" 'Control-flow protection is not supported by your toolchain'
+    fi
+    cf_protection=no
+  fi
+fi
+if test "$cf_protection" = ""; then
+  cf_protection=yes
+fi
+if test "$cf_protection" = "yes"; then
+  QEMU_CFLAGS="-fcf-protection $QEMU_CFLAGS"
+fi
+
 ##########################################
 # check and set a backend for coroutine
 
@@ -6361,6 +6386,7 @@ echo "netmap support    $netmap"
 echo "Linux AIO support $linux_aio"
 echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
+echo "CF protection     $cf_protection"
 echo "KVM support       $kvm"
 echo "HAX support       $hax"
 echo "HVF support       $hvf"
@@ -6571,6 +6597,9 @@ fi
 if test "$profiler" = "yes" ; then
   echo "CONFIG_PROFILER=y" >> $config_host_mak
 fi
+if test "$cf_protection" = "yes" ; then
+  echo "CONFIG_CF_PROTECTION=y" >> $config_host_mak
+fi
 if test "$slirp" != "no"; then
   echo "CONFIG_SLIRP=y" >> $config_host_mak
   echo "CONFIG_SMBD_COMMAND=\"$smbd\"" >> $config_host_mak
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 2167ffc862..d7add70b63 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -42,6 +42,11 @@ util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
 ifeq ($(ARCH),x86_64)
 coroutine-asm.o-cflags := -mno-red-zone
 endif
+ifeq ($(CONFIG_CF_PROTECTION),y)
+coroutine-sigaltstack.o-cflags := -fcf-protection=branch
+coroutine-ucontext.o-cflags := -fcf-protection=branch
+coroutine-asm.o-cflags += -fcf-protection=branch
+endif
 util-obj-y += buffer.o
 util-obj-y += timed-average.o
 util-obj-y += base64.o
-- 
2.21.0
