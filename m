Received: from eggs.gnu.org ([209.51.188.92]:45276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gukAm-0007al-Oc
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 15:33:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gukAl-0001h9-LU
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 15:33:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gukAl-0001e2-9F
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 15:33:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so11713483wrg.1
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:33:22 -0800 (PST)
References: <20190215153600.1770727-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <95ef4389-b09e-dad7-d070-72c32e7e75f6@redhat.com>
Date: Fri, 15 Feb 2019 21:33:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190215153600.1770727-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/smbios: fix offset of type 3 sku field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 2/15/19 4:36 PM, Daniel P. Berrangé wrote:
> The type 3 SMBIOS structure[1] ends with fields
> 
>   ...
>   0x14  - contained element count
>   0x15  - contained element record length
>   0x16  - sku number
> 
> The smbios_type_3 struct missed the contained element record
> length field, causing sku number to be reported at the wrong
> offset.
> 
> [1] https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.1.1.pdf
> 

Fixes: e41fca3da72

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/smbios/smbios.c           | 1 +
>  include/hw/firmware/smbios.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 818be8a838..47be9071fa 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -563,6 +563,7 @@ static void smbios_build_type_3_table(void)
>      t->height = 0;
>      t->number_of_power_cords = 0;
>      t->contained_element_count = 0;
> +    t->contained_element_record_length = 0;
>      SMBIOS_TABLE_SET_STR(3, sku_number_str, type3.sku);
>  
>      SMBIOS_BUILD_TABLE_POST;
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index eeb5a4d7b6..6fef32a3c9 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -162,6 +162,7 @@ struct smbios_type_3 {
>      uint8_t height;
>      uint8_t number_of_power_cords;
>      uint8_t contained_element_count;
> +    uint8_t contained_element_record_length;
>      uint8_t sku_number_str;
>      /* contained elements follow */
>  } QEMU_PACKED;
> 
