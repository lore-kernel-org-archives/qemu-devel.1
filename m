Received: from eggs.gnu.org ([2001:4830:134:3::10]:33793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d35iA-0000Ga-3g
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d35i7-0000c0-1H
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:01:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36507
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1d35i6-0000bo-RG
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:01:14 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PIsADI102032
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 15:01:13 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a1v4s90u0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 15:01:13 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 13:01:11 -0600
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
	<1491575431-32170-8-git-send-email-amarnath.valluri@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 15:01:07 -0400
MIME-Version: 1.0
In-Reply-To: <1491575431-32170-8-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <6f1fd088-1c3b-da1e-3e9b-68feaf1429b4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/9] tpm-backend: Move realloc_buffer()
 implementation to base class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, marcandre.lureau@gmail.com

On 04/07/2017 10:30 AM, Amarnath Valluri wrote:
> Provide base implementation of realloc_buffer(), so that backend implementations
> can resue.
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---
>   backends/tpm.c           |  9 ++++++++-
>   hw/tpm/tpm_passthrough.c | 12 ------------
>   2 files changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 3493df6..0da73e6 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -88,8 +88,15 @@ bool tpm_backend_had_startup_error(TPMBackend *s)
>   size_t tpm_backend_realloc_buffer(TPMBackend *s, TPMSizedBuffer *sb)
>   {
>       TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
> +    if (!k->ops->realloc_buffer) {
> +        size_t wanted_size = 4096; /* Linux tpm.c buffer size */
>
> -    assert(k->ops->realloc_buffer);
> +        if (sb->size != wanted_size) {
> +            sb->buffer = g_realloc(sb->buffer, wanted_size);
> +            sb->size = wanted_size;
> +        }
> +        return sb->size;
> +    }
>
>       return k->ops->realloc_buffer(sb);
>   }
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 8e11ed3..1bffb6d 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -258,17 +258,6 @@ static bool tpm_passthrough_get_startup_error(TPMBackend *tb)
>       return tpm_pt->had_startup_error;
>   }
>
> -static size_t tpm_passthrough_realloc_buffer(TPMSizedBuffer *sb)
> -{
> -    size_t wanted_size = 4096; /* Linux tpm.c buffer size */
> -
> -    if (sb->size != wanted_size) {
> -        sb->buffer = g_realloc(sb->buffer, wanted_size);
> -        sb->size = wanted_size;
> -    }
> -    return sb->size;
> -}
> -
>   static void tpm_passthrough_cancel_cmd(TPMBackend *tb)
>   {
>       TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
> @@ -470,7 +459,6 @@ static const TPMDriverOps tpm_passthrough_driver = {
>       .opts                     = tpm_passthrough_cmdline_opts,
>       .desc                     = tpm_passthrough_create_desc,
>       .create                   = tpm_passthrough_create,
> -    .realloc_buffer           = tpm_passthrough_realloc_buffer,
>       .reset                    = tpm_passthrough_reset,
>       .had_startup_error        = tpm_passthrough_get_startup_error,
>       .cancel_cmd               = tpm_passthrough_cancel_cmd,


If you don't need this realloc_buffer function in your driver, you could 
entirely remove it.
