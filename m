Received: from eggs.gnu.org ([209.51.188.92]:51894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyJ-0004aH-KK
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyI-0004Nt-PX
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:55 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:33995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldyI-0004Mx-It
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:54 -0500
Received: by mail-wm1-x336.google.com with SMTP id y185so6738241wmd.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:54 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:06:02 +0100
Message-Id: <1548093980-43088-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/49] optionrom/pvh: load initrd from fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>

From: Stefano Garzarella <sgarzare@redhat.com>

If we found initrd through fw_cfg, we can load it and use the
first module of hvm_start_info to pass initrd address and size
to the kernel.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Based-on: <1547554687-12687-1-git-send-email-liam.merwick@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/optionrom/pvh_main.c |  21 +++++++++++++++++++--
 pc-bios/pvh.bin              | Bin 1536 -> 1536 bytes
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/pc-bios/optionrom/pvh_main.c b/pc-bios/optionrom/pvh_main.c
index 1dcc5c9..a015e1b 100644
--- a/pc-bios/optionrom/pvh_main.c
+++ b/pc-bios/optionrom/pvh_main.c
@@ -46,6 +46,7 @@ struct pvh_e820_table {
 struct pvh_e820_table pvh_e820 asm("pvh_e820") __attribute__ ((aligned));
 
 static struct hvm_start_info start_info;
+static struct hvm_modlist_entry ramdisk_mod;
 static uint8_t cmdline_buffer[CMDLINE_BUFSIZE];
 
 
@@ -71,8 +72,8 @@ extern void pvh_load_kernel(void) asm("pvh_load_kernel");
 void pvh_load_kernel(void)
 {
     void *cmdline_addr = &cmdline_buffer;
-    void *kernel_entry;
-    uint32_t cmdline_size, fw_cfg_version = bios_cfg_version();
+    void *kernel_entry, *initrd_addr;
+    uint32_t cmdline_size, initrd_size, fw_cfg_version = bios_cfg_version();
 
     start_info.magic = XEN_HVM_START_MAGIC_VALUE;
     start_info.version = 1;
@@ -110,6 +111,22 @@ void pvh_load_kernel(void)
                         fw_cfg_version);
     start_info.cmdline_paddr = (uintptr_t)cmdline_addr;
 
+    /* Check if we have the initrd to load */
+    bios_cfg_read_entry(&initrd_size, FW_CFG_INITRD_SIZE, 4, fw_cfg_version);
+    if (initrd_size) {
+        bios_cfg_read_entry(&initrd_addr, FW_CFG_INITRD_ADDR, 4,
+                            fw_cfg_version);
+        bios_cfg_read_entry(initrd_addr, FW_CFG_INITRD_DATA, initrd_size,
+                            fw_cfg_version);
+
+        ramdisk_mod.paddr = (uintptr_t)initrd_addr;
+        ramdisk_mod.size = initrd_size;
+
+        /* The first module is always ramdisk. */
+        start_info.modlist_paddr = (uintptr_t)&ramdisk_mod;
+        start_info.nr_modules = 1;
+    }
+
     bios_cfg_read_entry(&kernel_entry, FW_CFG_KERNEL_ENTRY, 4, fw_cfg_version);
 
     asm volatile("jmp *%1" : : "b"(&start_info), "c"(kernel_entry));
diff --git a/pc-bios/pvh.bin b/pc-bios/pvh.bin
index 38a41761014957d50eb55d790b6957888cbeee0a..8033080ada2db4c4613fdc3bb5a69d79c7b0c0ca 100644
GIT binary patch
delta 735
zcmZqRY2cYKndyM&#;Nv<`Y|dZ$5|Uh85k;#<{2MnZ2__v85kHA9sn{HZvYZIPJmb|
zfW&duHKLQ5nUrMIfhw902-q@k@G+F$J<hrSC<y|`S(k`Tc4U&S-@w4az+ic-T<m2U
z69Yr<HjpGxgXJ;)wosrzw?N~kpkNn;ZV#5mj{zY;3Y-^99~fR*3^J!vbP15`Eo0c1
zzzXD<s2q1u0U8F>|Cout)f{N^UIC!Q4iTVG=c}~$y9I%~ogfvxH7Wv~w?60W5Uq#G
zb^8ECzJtWNSyZ}1R9F_z0NXGJNbcZ<DuU@10jqOS5otY88nQzGD7y<}QQCW$0*+lE
zt3K!K289;TXpa96n~%su$Hm7U?k!Pcm;iP@C<qup_A@ZNwE6%4fA1DG5F4yu2N#e9
zax=_C9<XzTprSw{MY?NLz=GW_Dm;r5fc6|`O#zZ102C5goB<ZffeP&asaQM#EH(uy
zcAT|GlmilnFD)iJGRxEpyomk#|34@!c7fD%et6*v;$wse*j2kg!O{z~>V*bKQ3x<N
zE|p|Lq(IIGO7Xnlg_tL@3*>Z=Q(yf415}LN%^5^G8scV%O`y;R+Qji<3DDe^<^K@j
Z2no&!h6hlR%ga4L7i~VsEX~MR4FFIY;aUIy

delta 434
zcmZqRY2cYKnW;f!<5YV_{Sp<C<E#!M3=9=V^Nf$Px&T>>3=9kl8-R?(1wdj)2Z)sc
zB#yJ@h)iZ?Qj%c@s%SnSV9UV4$549rIBNn>5(JL3rie^-WRk9*!N9`6V0pM)?4=n{
zY40|WBv6CpVg5E%pg^}k<ENlt7lm#Qmd1|(Awde97fT-)URn$?r&BZqNcNU7>~;W}
z(J7;H+(iY*0P26n#NRp{$k;2u3Un37%Fb75@AnA;c{@QWdTUffIzN5R*&&(+mFxBa
zirfc@b+f2+hp4bDjsV*b10;6{Ko!CC3V_t@289Gro525v%|~RS<Kklv_ij-Gs$@u;
z0Cpb8iy$ro!^@b-51D1cMPB^<`~N@4rd^^y(asw$-h%iT_JOV01+ui)MMdDn3812v
j<^TWx2l~|T0E*vVzWMk6|K^V@e2kM=|4(AIW9$F`FOZ8_

-- 
1.8.3.1
