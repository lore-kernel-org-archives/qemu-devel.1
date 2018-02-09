Received: from eggs.gnu.org ([2001:4830:134:3::10]:38738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ekDPg-0002Rd-OB
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ekDPc-0006xA-9m
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:28:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55272 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ekDPc-0006wX-4n
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:28:40 -0500
Date: Fri, 9 Feb 2018 18:28:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180209182819.GH2428@work-vm>
References: <20180207160638.98872-17-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207160638.98872-17-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v7 17/26] target/i386: encrypt bios rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Richard Henderson <rth@twiddle.net>

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> SEV requires that guest bios must be encrypted before booting the guest.

I'm curious; is it just the main BIOS that needs encryption - what about
things like device/PXE rom images?

Dave

> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  hw/i386/pc_sysfw.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 6b183747fcea..8ddbbf74d330 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -112,6 +112,8 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
>      pflash_t *system_flash;
>      MemoryRegion *flash_mem;
>      char name[64];
> +    void *flash_ptr;
> +    int ret, flash_size;
>  
>      sector_bits = 12;
>      sector_size = 1 << sector_bits;
> @@ -168,6 +170,17 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
>          if (unit == 0) {
>              flash_mem = pflash_cfi01_get_memory(system_flash);
>              pc_isa_bios_init(rom_memory, flash_mem, size);
> +
> +            /* Encrypt the pflash boot ROM */
> +            if (kvm_memcrypt_enabled()) {
> +                flash_ptr = memory_region_get_ram_ptr(flash_mem);
> +                flash_size = memory_region_size(flash_mem);
> +                ret = kvm_memcrypt_encrypt_data(flash_ptr, flash_size);
> +                if (ret) {
> +                    error_report("failed to encrypt pflash rom");
> +                    exit(1);
> +                }
> +            }
>          }
>      }
>  }
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
