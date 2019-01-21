Received: from eggs.gnu.org ([209.51.188.92]:45512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gldVW-0002lg-Pz
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gldVV-00064P-WC
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:37:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gldVV-00063B-Oe
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:37:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so24380916wrw.5
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 09:37:09 -0800 (PST)
References: <20190118120143.21631-1-sgarzare@redhat.com>
	<20190118120143.21631-4-sgarzare@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <18a8918c-b4d6-1165-4064-d80c97316eec@redhat.com>
Date: Mon, 21 Jan 2019 18:37:04 +0100
MIME-Version: 1.0
In-Reply-To: <20190118120143.21631-4-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 3/5] optionrom: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 18/01/19 13:01, Stefano Garzarella wrote:
> The new pvh.bin option rom can be used with SeaBIOS to boot
> uncompressed kernel using the x86/HVM direct boot ABI.
> 
> pvh.S contains the entry point of the option rom. It runs
> in real mode, loads the e820 table querying the BIOS, and
> then it switches to 32bit protected mode and jumps to the
> pvh_load_kernel() written in pvh_main.c.
> pvh_load_kernel() loads the cmdline and kernel entry_point
> using fw_cfg, then it looks for RSDP, fills the
> hvm_start_info required by x86/HVM ABI, and finally jumps
> to the kernel entry_point.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

... and, for mingw:

diff --git a/pc-bios/optionrom/pvh_main.c b/pc-bios/optionrom/pvh_main.c
index d1b8b4b..a015e1b 100644
--- a/pc-bios/optionrom/pvh_main.c
+++ b/pc-bios/optionrom/pvh_main.c
@@ -43,7 +43,7 @@ struct pvh_e820_table {
     struct hvm_memmap_table_entry table[E820_MAXENTRIES];
 };

-struct pvh_e820_table pvh_e820 __attribute__ ((aligned));
+struct pvh_e820_table pvh_e820 asm("pvh_e820") __attribute__ ((aligned));

 static struct hvm_start_info start_info;
 static struct hvm_modlist_entry ramdisk_mod;


Paolo
