Received: from eggs.gnu.org ([209.51.188.92]:51964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gk8k2-0007cz-B9
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gk8k0-0007nW-0F
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:33:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gk8jz-0007Vf-L3
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:33:55 -0500
References: <20190117090259.32713-1-sgarzare@redhat.com>
	<20190117090259.32713-6-sgarzare@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <0bbdcb55-27d9-7098-10f4-aa7aef0a1c24@oracle.com>
Date: Thu, 17 Jan 2019 14:33:38 +0000
MIME-Version: 1.0
In-Reply-To: <20190117090259.32713-6-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/5] optionrom/pvh: load initrd from
 fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, George Kennedy <george.kennedy@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, liam.merwick@oracle.com

Hi Stefano,

On 17/01/2019 09:02, Stefano Garzarella wrote:
> If we found initrd through fw_cfg, we can load it and use the
> first module of hvm_start_info to pass initrd address and size
> to the kernel.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   pc-bios/optionrom/pvh_main.c |  21 +++++++++++++++++++--
>   pc-bios/pvh.bin              | Bin 1536 -> 1536 bytes
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/optionrom/pvh_main.c b/pc-bios/optionrom/pvh_main.c
> index f355476e68..d1b8b4b96e 100644
> --- a/pc-bios/optionrom/pvh_main.c
> +++ b/pc-bios/optionrom/pvh_main.c
> @@ -46,6 +46,7 @@ struct pvh_e820_table {
>   struct pvh_e820_table pvh_e820 __attribute__ ((aligned));
>   
>   static struct hvm_start_info start_info;
> +static struct hvm_modlist_entry ramdisk_mod;
>   static uint8_t cmdline_buffer[CMDLINE_BUFSIZE];
>   
>   
> @@ -71,8 +72,8 @@ extern void pvh_load_kernel(void) asm("pvh_load_kernel");
>   void pvh_load_kernel(void)
>   {
>       void *cmdline_addr = &cmdline_buffer;
> -    void *kernel_entry;
> -    uint32_t cmdline_size, fw_cfg_version = bios_cfg_version();
> +    void *kernel_entry, *initrd_addr;
> +    uint32_t cmdline_size, initrd_size, fw_cfg_version = bios_cfg_version();
>   
>       start_info.magic = XEN_HVM_START_MAGIC_VALUE;
>       start_info.version = 1;
> @@ -110,6 +111,22 @@ void pvh_load_kernel(void)
>                           fw_cfg_version);
>       start_info.cmdline_paddr = (uintptr_t)cmdline_addr;
>   
> +    /* Check if we have the initrd to load */
> +    bios_cfg_read_entry(&initrd_size, FW_CFG_INITRD_SIZE, 4, fw_cfg_version);
> +    if (initrd_size) {
> +        bios_cfg_read_entry(&initrd_addr, FW_CFG_INITRD_ADDR, 4,
> +                            fw_cfg_version);
> +        bios_cfg_read_entry(initrd_addr, FW_CFG_INITRD_DATA, initrd_size,
> +                            fw_cfg_version);
> +
> +        ramdisk_mod.paddr = (uintptr_t)initrd_addr;
> +        ramdisk_mod.size = initrd_size;
> +
> +        /* The first module is always ramdisk. */
> +        start_info.modlist_paddr = (uintptr_t)&ramdisk_mod;
> +        start_info.nr_modules = 1;
> +    }
> +
>       bios_cfg_read_entry(&kernel_entry, FW_CFG_KERNEL_ENTRY, 4, fw_cfg_version);
>   
>       asm volatile("jmp *%1" : : "b"(&start_info), "c"(kernel_entry));
> diff --git a/pc-bios/pvh.bin b/pc-bios/pvh.bin

I'm not sure what this binary is doing here but it reminded me that the 
following entries should be added to .gitignore in one of the patches.

#	pc-bios/optionrom/pvh.bin
#	pc-bios/optionrom/pvh.img
#	pc-bios/optionrom/pvh.raw

other than that, the code here LGTM so for that

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> index 38a41761014957d50eb55d790b6957888cbeee0a..8033080ada2db4c4613fdc3bb5a69d79c7b0c0ca 100644
> GIT binary patch
> delta 735
> zcmZqRY2cYKndyM&#;Nv<`Y|dZ$5|Uh85k;#<{2MnZ2__v85kHA9sn{HZvYZIPJmb|
> zfW&duHKLQ5nUrMIfhw902-q@k@G+F$J<hrSC<y|`S(k`Tc4U&S-@w4az+ic-T<m2U
> z69Yr<HjpGxgXJ;)wosrzw?N~kpkNn;ZV#5mj{zY;3Y-^99~fR*3^J!vbP15`Eo0c1
> zzzXD<s2q1u0U8F>|Cout)f{N^UIC!Q4iTVG=c}~$y9I%~ogfvxH7Wv~w?60W5Uq#G
> zb^8ECzJtWNSyZ}1R9F_z0NXGJNbcZ<DuU@10jqOS5otY88nQzGD7y<}QQCW$0*+lE
> zt3K!K289;TXpa96n~%su$Hm7U?k!Pcm;iP@C<qup_A@ZNwE6%4fA1DG5F4yu2N#e9
> zax=_C9<XzTprSw{MY?NLz=GW_Dm;r5fc6|`O#zZ102C5goB<ZffeP&asaQM#EH(uy
> zcAT|GlmilnFD)iJGRxEpyomk#|34@!c7fD%et6*v;$wse*j2kg!O{z~>V*bKQ3x<N
> zE|p|Lq(IIGO7Xnlg_tL@3*>Z=Q(yf415}LN%^5^G8scV%O`y;R+Qji<3DDe^<^K@j
> Z2no&!h6hlR%ga4L7i~VsEX~MR4FFIY;aUIy
> 
> delta 434
> zcmZqRY2cYKnW;f!<5YV_{Sp<C<E#!M3=9=V^Nf$Px&T>>3=9kl8-R?(1wdj)2Z)sc
> zB#yJ@h)iZ?Qj%c@s%SnSV9UV4$549rIBNn>5(JL3rie^-WRk9*!N9`6V0pM)?4=n{
> zY40|WBv6CpVg5E%pg^}k<ENlt7lm#Qmd1|(Awde97fT-)URn$?r&BZqNcNU7>~;W}
> z(J7;H+(iY*0P26n#NRp{$k;2u3Un37%Fb75@AnA;c{@QWdTUffIzN5R*&&(+mFxBa
> zirfc@b+f2+hp4bDjsV*b10;6{Ko!CC3V_t@289Gro525v%|~RS<Kklv_ij-Gs$@u;
> z0Cpb8iy$ro!^@b-51D1cMPB^<`~N@4rd^^y(asw$-h%iT_JOV01+ui)MMdDn3812v
> j<^TWx2l~|T0E*vVzWMk6|K^V@e2kM=|4(AIW9$F`FOZ8_
> 
