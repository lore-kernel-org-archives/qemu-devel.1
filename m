Received: from eggs.gnu.org ([2001:4830:134:3::10]:47768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emikC-0001KJ-TO
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emik8-0006Z7-K6
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:20:16 -0500
References: <1518735273-16089-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518735273-16089-7-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4ff97ab0-d848-05a4-9ac2-344bd67e73ef@redhat.com>
Date: Fri, 16 Feb 2018 17:20:06 +0100
MIME-Version: 1.0
In-Reply-To: <1518735273-16089-7-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v6 06/12] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 15.02.2018 23:54, Collin L. Walling wrote:
> Set boot menu options for an s390 guest and store them in
> the iplb. These options are set via the QEMU command line
> option:
> 
>     -boot menu=on|off[,splash-time=X]
> 
> or via the libvirt domain xml:
> 
>     <os>
>       <bootmenu enable='yes|no' timeout='X'/>
>     </os>
> 
> Where X represents some positive integer representing
> milliseconds.
> 
> Any value set for loadparm will override all boot menu options.
> If loadparm=PROMPT, then the menu will be enabled without a
> timeout.
> 
> The absence of any boot options on the command line will flag
> to later use the zipl boot loader values.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c          | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/ipl.h          |  9 +++++++--
>  pc-bios/s390-ccw/iplb.h |  6 ++++--
>  3 files changed, 59 insertions(+), 4 deletions(-)
[....]
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index cab8a97..7c3cab8 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -60,10 +60,15 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>  
>  #define QIPL_ADDRESS  0xcc
>  
> +#define BOOT_MENU_FLAG_CMD_OPTS  0x80
> +#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
> +
>  struct QemuIplParameters {
> -    uint8_t  reserved1[4];
> +    uint8_t  boot_menu_flags;
> +    uint8_t  reserved1;
> +    uint32_t boot_menu_timeout;
>      uint64_t netboot_start_addr;

The netboot_start_addr field is now never aligned anymore, neither on
the host side, nor in guest memory. Not a big problem since the struct
is declared with "QEMU_PACKED", but still ... it's always nicer to try
to align fields to their natural boundaries. So maybe move
boot_menu_flags and reserved1 after netboot_start_addr ?

> -    uint8_t  reserved2[16];
> +    uint8_t  reserved2[14];
>  } QEMU_PACKED;
>  typedef struct QemuIplParameters QemuIplParameters;

 Thomas
