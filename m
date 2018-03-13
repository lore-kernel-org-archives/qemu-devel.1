Received: from eggs.gnu.org ([2001:4830:134:3::10]:34798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evmnd-0002qx-Px
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evmna-0000ty-Jb
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:29:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1evmna-0000tS-Aw
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:29:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A8D665D1F
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 16:29:13 +0000 (UTC)
Date: Tue, 13 Mar 2018 10:29:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180313102911.339d7ffa@w520.home>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/22] KVM patches for QEMU 2.12 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 13 Mar 2018 13:56:16 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> The following changes since commit fb5fff15881ba7a002924b967eb211c002897983:
> 
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180312-pull-request' into staging (2018-03-12 18:35:37 +0000)
> 
> are available in the git repository at:
> 
> 
>   git://github.com/bonzini/qemu.git tags/for-upstream-sev
> 
> for you to fetch changes up to 297dabdd6b39ce1e2ed2e69b4b2afc024e07ad09:
> 
>   sev/i386: add sev_get_capabilities() (2018-03-13 12:04:04 +0100)
> 
> ----------------------------------------------------------------
> * Migrate MSR_SMI_COUNT (Liran)
> * Update kernel headers (Gerd, myself)
> * SEV support (Brijesh)
> 
> I have not tested non-x86 compilation, but I reordered the SEV patches
> so that all non-x86-specific changes go first to catch any possible
> issues (which weren't there anyway :)).

32bit build issues, feel free to roll into culprit commits:

commit b9ca34408a4d523d4484e6e8f3334723132eacd9
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Tue Mar 13 10:03:22 2018 -0600

    i386/sev: 32bit build fixes
    
    Use %z for portable size_t printing.
    
    Cannot cast directly from point to integer of different size.
    
    Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 34733f925475..019d84cef2c7 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -70,7 +70,7 @@ sev_ioctl(int fd, int cmd, void *data, int *error)
 
     input.id = cmd;
     input.sev_fd = fd;
-    input.data = (__u64)data;
+    input.data = (__u64)(unsigned long)data;
 
     r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &input);
 
@@ -131,13 +131,13 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
     int r;
     struct kvm_enc_region range;
 
-    range.addr = (__u64)host;
+    range.addr = (__u64)(unsigned long)host;
     range.size = size;
 
     trace_kvm_memcrypt_register_region(host, size);
     r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
     if (r) {
-        error_report("%s: failed to register region (%p+%#lx) error '%s'",
+        error_report("%s: failed to register region (%p+%#zx) error '%s'",
                      __func__, host, size, strerror(errno));
         exit(1);
     }
@@ -149,13 +149,13 @@ sev_ram_block_removed(RAMBlockNotifier *n, void *host, size_t size)
     int r;
     struct kvm_enc_region range;
 
-    range.addr = (__u64)host;
+    range.addr = (__u64)(unsigned long)host;
     range.size = size;
 
     trace_kvm_memcrypt_unregister_region(host, size);
     r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_UNREG_REGION, &range);
     if (r) {
-        error_report("%s: failed to unregister region (%p+%#lx)",
+        error_report("%s: failed to unregister region (%p+%#zx)",
                      __func__, host, size);
     }
 }
@@ -588,7 +588,7 @@ sev_launch_update_data(uint8_t *addr, uint64_t len)
         return 1;
     }
 
-    update.uaddr = (__u64)addr;
+    update.uaddr = (__u64)(unsigned long)addr;
     update.len = len;
     trace_kvm_sev_launch_update_data(addr, len);
     ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
diff --git a/target/i386/trace-events b/target/i386/trace-events
index b1fbde6e40fe..6a19a69af5d0 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -8,8 +8,8 @@ kvm_x86_update_msi_routes(int num) "Updated %d MSI routes"
 
 # target/i386/sev.c
 kvm_sev_init(void) ""
-kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%lu"
-kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
+kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%zu"
+kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%zu"
 kvm_sev_change_state(const char *old, const char *new) "%s -> %s"
 kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
 kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
