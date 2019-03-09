Received: from eggs.gnu.org ([209.51.188.92]:36033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Qqs-0006mS-67
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 20:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Qqr-0007yP-DF
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 20:32:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2Qqr-0007xg-54
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 20:32:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id f65so14091885wma.2
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 17:32:37 -0800 (PST)
References: <20190309004826.9027-1-lersek@redhat.com>
	<20190309004826.9027-7-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2d33be0b-aa53-2038-01b0-0afed368aea8@redhat.com>
Date: Sat, 9 Mar 2019 02:32:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190309004826.9027-7-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/10] roms/Makefile: replace the $(EFIROM)
 target with "edk2-basetools"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, qemu-devel@nongnu.org

Hi Laszlo,

On 3/9/19 1:48 AM, Laszlo Ersek wrote:
> We don't (can't) have a recipe for building just $(EFIROM); therefore,
> while we call the target $(EFIROM), we actually build all of the edk2
> BaseTools. Rename the target to edk2-basetools, and update the iPXE
> prerequisite accordingly. This will let other targets depend on
> "edk2-basetools", where an $(EFIROM) pre-requisite would be misleading.
> 
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  roms/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/roms/Makefile b/roms/Makefile
> index 78d5dd18c301..2e83ececa25a 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -102,7 +102,7 @@ pxe-rom-%: build-pxe-roms
>  
>  efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
>  
> -efi-rom-%: build-pxe-roms build-efi-roms $(EFIROM)
> +efi-rom-%: build-pxe-roms build-efi-roms edk2-basetools
>  	$(EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
>  		-b ipxe/src/bin/$(VID)$(DID).rom \
>  		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
> @@ -120,7 +120,7 @@ build-efi-roms: build-pxe-roms
>  		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>  		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
>  
> -$(EFIROM):
> +edk2-basetools:

Should we add:

        $(MAKE) -f Makefile.edk2 submodules

from your next patch?

There might be a circular dependency else, if the user doesn't init the
submodules manually.

The next patch add a make dependency 'efi' -> 'edk2-basetools', but
'edk2-basetools' build the BaseTools within edk2/.

>  	$(MAKE) -C edk2/BaseTools
>  
>  slof:
> 
