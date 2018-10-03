Received: from eggs.gnu.org ([2001:4830:134:3::10]:34642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1g7i1Z-0006rY-AK
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1g7i1V-0007Xz-9B
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:21:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1g7i1U-0007WM-U2
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:21:09 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w93EF5DV124034
	for <qemu-devel@nongnu.org>; Wed, 3 Oct 2018 10:21:07 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mvwvj4d9k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 10:21:06 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 3 Oct 2018 08:21:06 -0600
References: <20181003132129.11210-1-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 3 Oct 2018 10:21:02 -0400
MIME-Version: 1.0
In-Reply-To: <20181003132129.11210-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <b37baca4-cab1-f6f1-f35f-70b867ec07a1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] tests/tpm: fix
 tpm_util_swtpm_has_tpm2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 10/3/18 9:21 AM, Marc-Andr=C3=A9 Lureau wrote:
> Using g_spawn_async_with_pipes() is more complicated than running the
> sync version. The async version returns a file descriptor for stdout, w=
hich may
> not be fully read. Sometime "--tpm2" will failed to be read, and will
> cause the related test to be silently skipped.
>
> Use g_spawn_sync() instead, simplifying the code and fixing the race.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/tpm-util.c | 46 ++++++++++++++++++++--------------------------
>   1 file changed, 20 insertions(+), 26 deletions(-)
>
> diff --git a/tests/tpm-util.c b/tests/tpm-util.c
> index 9f3f156e42..ae4aaf35ca 100644
> --- a/tests/tpm-util.c
> +++ b/tests/tpm-util.c
> @@ -145,39 +145,33 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
>       g_assert_cmpmem(buffer, exp_resp_size, exp_resp, exp_resp_size);
>   }
>
> -static gboolean tpm_util_swtpm_has_tpm2(void)
> +static bool tpm_util_swtpm_has_tpm2(void)
>   {
> -    gint mystdout;
> -    gboolean succ;
> -    unsigned i;
> -    char buffer[10240];
> -    ssize_t n;
> -    gchar *swtpm_argv[] =3D {
> -        g_strdup("swtpm"), g_strdup("socket"), g_strdup("--help"), NUL=
L
> +    bool has_tpm2 =3D false;
> +    char *out =3D NULL;
> +    static const char *argv[] =3D {
> +        "swtpm", "socket", "--help", NULL
>       };
>
> -    succ =3D g_spawn_async_with_pipes(NULL, swtpm_argv, NULL,
> -                                    G_SPAWN_SEARCH_PATH, NULL, NULL, N=
ULL,
> -                                    NULL, &mystdout, NULL, NULL);
> -    if (!succ) {
> -        goto cleanup;
> +    if (!g_spawn_sync(NULL /* working_dir */,
> +                      (char **)argv,
> +                      NULL /* envp */,
> +                      G_SPAWN_SEARCH_PATH,
> +                      NULL /* child_setup */,
> +                      NULL /* user_data */,
> +                      &out,
> +                      NULL /* err */,
> +                      NULL /* exit_status */,
> +                      NULL)) {
> +        return false;
>       }
>
> -    n =3D read(mystdout, buffer, sizeof(buffer) - 1);
> -    if (n < 0) {
> -        goto cleanup;
> -    }
> -    buffer[n] =3D 0;
> -    if (!strstr(buffer, "--tpm2")) {
> -        succ =3D false;
> -    }
> -
> - cleanup:
> -    for (i =3D 0; swtpm_argv[i]; i++) {
> -        g_free(swtpm_argv[i]);
> +    if (strstr(out, "--tpm2")) {
> +        has_tpm2 =3D true;
>       }
>
> -    return succ;
> +    g_free(out);
> +    return has_tpm2;
>   }
>
>   gboolean tpm_util_swtpm_start(const char *path, GPid *pid,

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
