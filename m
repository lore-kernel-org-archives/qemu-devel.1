Received: from eggs.gnu.org ([2001:4830:134:3::10]:39917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXOqB-0002gv-Cj
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXOq8-0007ti-3j
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:07:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gXOq7-0007tR-TU
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:07:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so1555315wrw.5
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 03:07:35 -0800 (PST)
References: <20181212222648.595-1-marcandre.lureau@redhat.com>
	<20181212222648.595-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6ca032b5-f623-d9b3-13cd-2fda914bc6a5@redhat.com>
Date: Thu, 13 Dec 2018 12:07:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181212222648.595-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v13 1/6] tpm: add a "ppi" boolean property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, stefanb@linux.vnet.ibm.com, f4bug@amsat.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>

On 12/12/18 11:26 PM, Marc-André Lureau wrote:
> The following patches implement the TPM Physical Presence Interface,
> make use of a new memory region and a fw_cfg entry. Enable PPI by
> default with >=4.0 machine type, to avoid migration issues.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/compat.h | 11 ++++++++++-
>  hw/tpm/tpm_crb.c    |  3 +++
>  hw/tpm/tpm_tis.c    |  3 +++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 70958328fe..db368c5c74 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -2,7 +2,16 @@
>  #define HW_COMPAT_H
>  
>  #define HW_COMPAT_3_1 \
> -    /* empty */
> +    { \
> +        .driver   = "tpm-crb", \
> +        .property = "ppi", \
> +        .value    = "false", \
> +    }, \
> +    { \
> +        .driver   = "tpm-tis", \
> +        .property = "ppi", \
> +        .value    = "false", \
> +    },
>  
>  #define HW_COMPAT_3_0 \
>      /* empty */
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index a92dd50437..d5b0ac5920 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -41,6 +41,8 @@ typedef struct CRBState {
>      MemoryRegion cmdmem;
>  
>      size_t be_buffer_size;
> +
> +    bool ppi_enabled;
>  } CRBState;
>  
>  #define CRB(obj) OBJECT_CHECK(CRBState, (obj), TYPE_TPM_CRB)
> @@ -221,6 +223,7 @@ static const VMStateDescription vmstate_tpm_crb = {
>  
>  static Property tpm_crb_properties[] = {
>      DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
> +    DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index d9322692ee..cbb9a84a5b 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -81,6 +81,8 @@ typedef struct TPMState {
>      TPMVersion be_tpm_version;
>  
>      size_t be_buffer_size;
> +
> +    bool ppi_enabled;
>  } TPMState;
>  
>  #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
> @@ -950,6 +952,7 @@ static const VMStateDescription vmstate_tpm_tis = {
>  static Property tpm_tis_properties[] = {
>      DEFINE_PROP_UINT32("irq", TPMState, irq_num, TPM_TIS_IRQ),
>      DEFINE_PROP_TPMBE("tpmdev", TPMState, be_driver),
> +    DEFINE_PROP_BOOL("ppi", TPMState, ppi_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> 
