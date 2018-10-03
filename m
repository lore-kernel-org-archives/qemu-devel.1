Received: from eggs.gnu.org ([2001:4830:134:3::10]:35485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1g7i5D-0002EV-Cs
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1g7i5A-0002Nm-1x
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:24:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56958
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1g7i59-0002NO-SQ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:24:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w93EOZb3011064
	for <qemu-devel@nongnu.org>; Wed, 3 Oct 2018 10:24:55 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2mvy361a6r-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 10:24:54 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 3 Oct 2018 08:24:54 -0600
References: <20181003132129.11210-1-marcandre.lureau@redhat.com>
	<20181003132129.11210-2-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 3 Oct 2018 10:24:49 -0400
MIME-Version: 1.0
In-Reply-To: <20181003132129.11210-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <462b2190-58a9-08be-08fc-c126a4224c96@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] tests/tpm: mark swtpm test as skipped
 instead of successful
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
> If swtpm is not found in $PATH or --tpm2 isn't supported, let's mark
> the test as SKIP.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/tpm-util.h  |  2 ++
>   tests/tpm-tests.c | 33 +++++++++++++++++++++------------
>   tests/tpm-util.c  |  8 +-------
>   3 files changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/tests/tpm-util.h b/tests/tpm-util.h
> index 330b9657fe..9e98bc5124 100644
> --- a/tests/tpm-util.h
> +++ b/tests/tpm-util.h
> @@ -32,6 +32,8 @@ void tpm_util_pcrextend(QTestState *s, tx_func *tx);
>   void tpm_util_pcrread(QTestState *s, tx_func *tx,
>                         const unsigned char *exp_resp, size_t exp_resp_=
size);
>
> +bool tpm_util_swtpm_has_tpm2(void);
> +
>   gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
>                                 SocketAddress **addr, GError **error);
>   void tpm_util_swtpm_kill(GPid pid);
> diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
> index 10c6592aac..e640777aa9 100644
> --- a/tests/tpm-tests.c
> +++ b/tests/tpm-tests.c
> @@ -18,6 +18,17 @@
>   #include "libqtest.h"
>   #include "tpm-tests.h"
>
> +static bool
> +tpm_test_swtpm_skip(void)
> +{
> +    if (!tpm_util_swtpm_has_tpm2()) {
> +        g_test_skip("swtpm not in PATH or missing --tpm2 support");
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>   void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
>                            const char *ifmodel)
>   {
> @@ -28,12 +39,13 @@ void tpm_test_swtpm_test(const char *src_tpm_path, =
tx_func *tx,
>       GPid swtpm_pid;
>       GError *error =3D NULL;
>
> -    succ =3D tpm_util_swtpm_start(src_tpm_path, &swtpm_pid, &addr, &er=
ror);
> -    /* succ may be false if swtpm is not available */
> -    if (!succ) {
> +    if (tpm_test_swtpm_skip()) {
>           return;
>       }
>
> +    succ =3D tpm_util_swtpm_start(src_tpm_path, &swtpm_pid, &addr, &er=
ror);
> +    g_assert_true(succ);
> +
>       args =3D g_strdup_printf(
>           "-chardev socket,id=3Dchr,path=3D%s "
>           "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
> @@ -74,19 +86,17 @@ void tpm_test_swtpm_migration_test(const char *src_=
tpm_path,
>       GError *error =3D NULL;
>       QTestState *src_qemu, *dst_qemu;
>
> -    succ =3D tpm_util_swtpm_start(src_tpm_path, &src_tpm_pid,
> -                                &src_tpm_addr, &error);
> -    /* succ may be false if swtpm is not available */
> -    if (!succ) {
> +    if (tpm_test_swtpm_skip()) {
>           return;
>       }
>
> +    succ =3D tpm_util_swtpm_start(src_tpm_path, &src_tpm_pid,
> +                                &src_tpm_addr, &error);
> +    g_assert_true(succ);
> +
>       succ =3D tpm_util_swtpm_start(dst_tpm_path, &dst_tpm_pid,
>                                   &dst_tpm_addr, &error);
> -    /* succ may be false if swtpm is not available */
> -    if (!succ) {
> -        goto err_src_tpm_kill;
> -    }
> +    g_assert_true(succ);
>
>       tpm_util_migration_start_qemu(&src_qemu, &dst_qemu,
>                                     src_tpm_addr, dst_tpm_addr, uri,
> @@ -118,7 +128,6 @@ void tpm_test_swtpm_migration_test(const char *src_=
tpm_path,
>           qapi_free_SocketAddress(dst_tpm_addr);
>       }
>
> -err_src_tpm_kill:
>       tpm_util_swtpm_kill(src_tpm_pid);
>       if (src_tpm_addr) {
>           g_unlink(src_tpm_addr->u.q_unix.path);
> diff --git a/tests/tpm-util.c b/tests/tpm-util.c
> index ae4aaf35ca..e08b137651 100644
> --- a/tests/tpm-util.c
> +++ b/tests/tpm-util.c
> @@ -145,7 +145,7 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
>       g_assert_cmpmem(buffer, exp_resp_size, exp_resp, exp_resp_size);
>   }
>
> -static bool tpm_util_swtpm_has_tpm2(void)
> +bool tpm_util_swtpm_has_tpm2(void)
>   {
>       bool has_tpm2 =3D false;
>       char *out =3D NULL;
> @@ -190,11 +190,6 @@ gboolean tpm_util_swtpm_start(const char *path, GP=
id *pid,
>       gboolean succ;
>       unsigned i;
>
> -    succ =3D tpm_util_swtpm_has_tpm2();
> -    if (!succ) {
> -        goto cleanup;
> -    }
> -
>       *addr =3D g_new0(SocketAddress, 1);
>       (*addr)->type =3D SOCKET_ADDRESS_TYPE_UNIX;
>       (*addr)->u.q_unix.path =3D g_build_filename(path, "sock", NULL);
> @@ -202,7 +197,6 @@ gboolean tpm_util_swtpm_start(const char *path, GPi=
d *pid,
>       succ =3D g_spawn_async(NULL, swtpm_argv, NULL, G_SPAWN_SEARCH_PAT=
H,
>                            NULL, NULL, pid, error);
>
> -cleanup:
>       for (i =3D 0; swtpm_argv[i]; i++) {
>           g_free(swtpm_argv[i]);
>       }

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
