Received: from eggs.gnu.org ([2001:4830:134:3::10]:55221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCX7T-00014z-GS
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCX7O-0005VK-K6
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:38:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58420
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eCX7O-0005V3-Db
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:38:38 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8KbSXD069984
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 15:38:29 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e45u62a86-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 15:38:29 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 15:38:28 -0500
References: <1510170356-16953-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 8 Nov 2017 15:38:24 -0500
MIME-Version: 1.0
In-Reply-To: <1510170356-16953-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <9dcf6e2e-3f31-c4a4-a5da-50892a777f10@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] tpm: Add a caching layer for the TPM
 Established flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Cc: amarnath.valluri@intel.com

On 11/08/2017 02:45 PM, Stefan Berger wrote:
> Add a caching layer for the TPM established flag so that we don't
> need to go to the backend every time the flag is read by accessing
> the REG_ACCESS register.

The v2 I just sent moves this to the tpm_emulator.

     Stefan

>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>   hw/tpm/tpm_tis.c | 27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 7402528..6b81bbf 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -95,6 +95,9 @@ struct TPMState {
>       char *backend;
>       TPMBackend *be_driver;
>       TPMVersion be_tpm_version;
> +
> +    unsigned int established_flag:1;
> +    unsigned int established_flag_cached:1;
>   };
>
>   #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
> @@ -529,6 +532,26 @@ static void tpm_tis_dump_state(void *opaque, hwaddr addr)
>   }
>   #endif
>
> +static void tpm_tis_reset_tpm_established_flag(TPMState *s,
> +                                               uint8_t locty)
> +{
> +    s->established_flag_cached = 0;
> +
> +    tpm_backend_reset_tpm_established_flag(s->be_driver, locty);
> +}
> +
> +static unsigned int tpm_tis_get_tpm_established_flag(TPMState *s)
> +{
> +    if (s->established_flag_cached) {
> +        return s->established_flag;
> +    }
> +
> +    s->established_flag = !tpm_backend_get_tpm_established_flag(s->be_driver);
> +    s->established_flag_cached = 1;
> +
> +    return s->established_flag;
> +}
> +
>   /*
>    * Read a register of the TIS interface
>    * See specs pages 33-63 for description of the registers
> @@ -556,7 +579,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
>           if (tpm_tis_check_request_use_except(s, locty)) {
>               val |= TPM_TIS_ACCESS_PENDING_REQUEST;
>           }
> -        val |= !tpm_backend_get_tpm_established_flag(s->be_driver);
> +        val |= tpm_tis_get_tpm_established_flag(s);
>           break;
>       case TPM_TIS_REG_INT_ENABLE:
>           val = s->loc[locty].inte;
> @@ -840,7 +863,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
>
>               if (val & TPM_TIS_STS_RESET_ESTABLISHMENT_BIT) {
>                   if (locty == 3 || locty == 4) {
> -                    tpm_backend_reset_tpm_established_flag(s->be_driver, locty);
> +                    tpm_tis_reset_tpm_established_flag(s, locty);
>                   }
>               }
>           }
