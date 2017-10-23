Received: from eggs.gnu.org ([2001:4830:134:3::10]:59417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6abj-0005uA-MA
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6abe-00085Y-KJ
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:09:23 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:54118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6abe-00085S-FA
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:09:18 -0400
Received: by mail-qt0-x244.google.com with SMTP id n61so25536502qte.10
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 04:09:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171023102903.256AF7456A0@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <894e2612-fe81-03bc-84d1-79dd9b6392f5@amsat.org>
Date: Mon, 23 Oct 2017 08:09:15 -0300
MIME-Version: 1.0
In-Reply-To: <20171023102903.256AF7456A0@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Fix compile with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Hi Zoltan,

On 10/23/2017 07:24 AM, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  tpm.c | 7 ++++---
>  vl.c  | 2 ++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tpm.c b/tpm.c
> index 45520f5..b625cd4 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -30,8 +30,6 @@ void tpm_register_model(enum TpmModel model)
>      tpm_models[model] = true;
>  }
>  
> -#ifdef CONFIG_TPM
> -
>  static const TPMBackendClass *
>  tpm_be_find_by_type(enum TpmType type)
>  {
> @@ -48,6 +46,8 @@ tpm_be_find_by_type(enum TpmType type)
>      return TPM_BACKEND_CLASS(oc);
>  }
>  
> +#ifdef CONFIG_TPM
> +
>  /*
>   * Walk the list of available TPM backend drivers and display them on the
>   * screen.
> @@ -208,8 +208,9 @@ TPMInfoList *qmp_query_tpm(Error **errp)
>              continue;
>          }
>          info = g_new0(TPMInfoList, 1);
> +#ifdef CONFIG_TPM
>          info->value = tpm_backend_query_tpm(drv);
> -
> +#endif
>          if (!cur_item) {
>              head = cur_item = info;
>          } else {
> diff --git a/vl.c b/vl.c
> index 0723835..dbfd06d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4905,7 +4905,9 @@ int main(int argc, char **argv, char **envp)
>      res_free();
>  
>      /* vhost-user must be cleaned up before chardevs.  */
> +#ifdef CONFIG_TPM
>      tpm_cleanup();
> +#endif
>      net_cleanup();
>      audio_cleanup();
>      monitor_cleanup();

Can you instead add tpm_cleanup() in stubs/tpm.c?

Regards,

Phil.
