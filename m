Received: from eggs.gnu.org ([2001:4830:134:3::10]:51126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2191-0002Nu-F8
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e218y-00019z-9V
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:28:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e218y-00019k-1R
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:28:48 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AKSRG2028378
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:28:44 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dh2s6r5qw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:28:44 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 16:28:43 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-30-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:28:40 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-30-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c7f746e1-2cef-899c-af5c-c5b949d732c7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 29/42] tpm-be: update optional function
 pointers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com

On 10/09/2017 06:56 PM, Marc-Andr=C3=A9 Lureau wrote:
> QEMU code doesn't generally have assert() for mandatory
> callbacks/function pointers, probably because the crash is pretty
> obvious. Document the methods instead of going into the code.
>
> Make get_tpm_options() mandatory to implement (since all
> backend implementation have it).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   include/sysemu/tpm_backend.h | 5 ++++-
>   backends/tpm.c               | 9 +--------
>   2 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index a893e586ae..594bb50782 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -66,15 +66,18 @@ struct TPMBackendClass {
>
>       TPMBackend *(*create)(QemuOpts *opts, const char *id);
>
> -    /* start up the TPM on the backend */
> +    /* start up the TPM on the backend - optional */
>       int (*startup_tpm)(TPMBackend *t);
>
> +    /* optional */
>       void (*reset)(TPMBackend *t);
>
>       void (*cancel_cmd)(TPMBackend *t);
>
> +    /* optional */
>       bool (*get_tpm_established_flag)(TPMBackend *t);
>
> +    /* optional */
>       int (*reset_tpm_established_flag)(TPMBackend *t, uint8_t locty);
>
>       TPMVersion (*get_tpm_version)(TPMBackend *t);
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 7e636fbc7a..7777467c44 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -33,7 +33,6 @@ static void tpm_backend_worker_thread(gpointer data, =
gpointer user_data)
>       TPMBackend *s =3D TPM_BACKEND(user_data);
>       TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    assert(k->handle_request !=3D NULL);
>       k->handle_request(s, (TPMBackendCmd *)data);
>
>       qemu_bh_schedule(s->bh);
> @@ -114,8 +113,6 @@ void tpm_backend_cancel_cmd(TPMBackend *s)
>   {
>       TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    assert(k->cancel_cmd);
> -
>       k->cancel_cmd(s);
>   }
>
> @@ -139,8 +136,6 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *=
s)
>   {
>       TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    assert(k->get_tpm_version);
> -
>       return k->get_tpm_version(s);
>   }
>
> @@ -152,9 +147,7 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
>
>       info->id =3D g_strdup(s->id);
>       info->model =3D tic->model;
> -    if (k->get_tpm_options) {
> -        info->options =3D k->get_tpm_options(s);
> -    }
> +    info->options =3D k->get_tpm_options(s);
>
>       return info;
>   }
