Received: from eggs.gnu.org ([2001:4830:134:3::10]:33932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBn91-0002LB-2m
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBn8x-0005oT-Tv
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:33:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43848
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eBn8x-0005oK-OW
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:33:11 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6JTApi129497
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 14:33:05 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e2txeajyu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 14:33:04 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 12:33:03 -0700
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
	<20171106183925.16747-26-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 14:32:59 -0500
MIME-Version: 1.0
In-Reply-To: <20171106183925.16747-26-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <79f747d6-d739-d213-34db-17d304491e05@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 25/28] tpm-emulator: protect concurrent
 ctrl_chr access
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

On 11/06/2017 01:39 PM, Marc-Andr=C3=A9 Lureau wrote:
> The control chardev is being used from the data thread to set the
> locality of the next request. Altough the chr has a write mutex, we
> may potentially read the reply from another thread request.

Right, so there may be concurrency with the CMD_RESET/GET_TPMESTABLISHED=20
commands. All the other ones shouldn't be affected. It sound like a bug=20
in existing code.

>
> Add a mutex to protect from concurrent control commands.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   hw/tpm/tpm_emulator.c | 44 ++++++++++++++++++++++++++++--------------=
--
>   1 file changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index b77c0238c7..24cb61162f 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -71,15 +71,21 @@ typedef struct TPMEmulator {
>       ptm_cap caps; /* capabilities of the TPM */
>       uint8_t cur_locty_number; /* last set locality */
>       Error *migration_blocker;
> +
> +    QemuMutex mutex;
>   } TPMEmulator;
>
>
> -static int tpm_emulator_ctrlcmd(CharBackend *dev, unsigned long cmd, v=
oid *msg,
> +static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, v=
oid *msg,
>                                   size_t msg_len_in, size_t msg_len_out=
)
>   {
> +    CharBackend *dev =3D &tpm->ctrl_chr;
>       uint32_t cmd_no =3D cpu_to_be32(cmd);
>       ssize_t n =3D sizeof(uint32_t) + msg_len_in;
>       uint8_t *buf =3D NULL;
> +    int ret =3D -1;
> +
> +    qemu_mutex_lock(&tpm->mutex);
>
>       buf =3D g_alloca(n);
>       memcpy(buf, &cmd_no, sizeof(cmd_no));
> @@ -87,17 +93,21 @@ static int tpm_emulator_ctrlcmd(CharBackend *dev, u=
nsigned long cmd, void *msg,
>
>       n =3D qemu_chr_fe_write_all(dev, buf, n);
>       if (n <=3D 0) {
> -        return -1;
> +        goto end;
>       }
>
>       if (msg_len_out !=3D 0) {
>           n =3D qemu_chr_fe_read_all(dev, msg, msg_len_out);
>           if (n <=3D 0) {
> -            return -1;
> +            goto end;
>           }
>       }
>
> -    return 0;
> +    ret =3D 0;
> +
> +end:
> +    qemu_mutex_unlock(&tpm->mutex);
> +    return ret;
>   }
>
>   static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
> @@ -154,7 +164,7 @@ static int tpm_emulator_set_locality(TPMEmulator *t=
pm_emu, uint8_t locty_number,
>
>       DPRINTF("setting locality : 0x%x", locty_number);
>       loc.u.req.loc =3D locty_number;
> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SET_LOCALITY, &lo=
c,
> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_LOCALITY, &loc,
>                                sizeof(loc), sizeof(loc)) < 0) {
>           error_setg(errp, "tpm-emulator: could not set locality : %s",
>                      strerror(errno));
> @@ -200,8 +210,8 @@ error:
>   static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
>   {
>       DPRINTF("%s", __func__);
> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_GET_CAPABILITY,
> -                         &tpm_emu->caps, 0, sizeof(tpm_emu->caps)) < 0=
) {
> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_CAPABILITY,
> +                             &tpm_emu->caps, 0, sizeof(tpm_emu->caps))=
 < 0) {
>           error_report("tpm-emulator: probing failed : %s", strerror(er=
rno));
>           return -1;
>       }
> @@ -252,8 +262,8 @@ static int tpm_emulator_startup_tpm(TPMBackend *tb)
>       ptm_res res;
>
>       DPRINTF("%s", __func__);
> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_INIT, &init, size=
of(init),
> -                         sizeof(init)) < 0) {
> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
> +                             sizeof(init)) < 0) {
>           error_report("tpm-emulator: could not send INIT: %s",
>                        strerror(errno));
>           goto err_exit;
> @@ -276,7 +286,7 @@ static bool tpm_emulator_get_tpm_established_flag(T=
PMBackend *tb)
>       ptm_est est;
>
>       DPRINTF("%s", __func__);
> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_GET_TPMESTABLISHE=
D, &est,
> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_TPMESTABLISHED, &est,
>                                0, sizeof(est)) < 0) {
>           error_report("tpm-emulator: Could not get the TPM established=
 flag: %s",
>                        strerror(errno));
> @@ -300,7 +310,7 @@ static int tpm_emulator_reset_tpm_established_flag(=
TPMBackend *tb,
>       }
>
>       reset_est.u.req.loc =3D tpm_emu->cur_locty_number;
> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_RESET_TPMESTABLIS=
HED,
> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_RESET_TPMESTABLISHED,
>                                &reset_est, sizeof(reset_est),
>                                sizeof(reset_est)) < 0) {
>           error_report("tpm-emulator: Could not reset the establishment=
 bit: %s",
> @@ -329,7 +339,7 @@ static void tpm_emulator_cancel_cmd(TPMBackend *tb)
>       }
>
>       /* FIXME: make the function non-blocking, or it may block a VCPU =
*/
> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_CANCEL_TPM_CMD, &=
res, 0,
> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_CANCEL_TPM_CMD, &res, 0,
>                                sizeof(res)) < 0) {
>           error_report("tpm-emulator: Could not cancel command: %s",
>                        strerror(errno));
> @@ -377,8 +387,8 @@ static int tpm_emulator_prepare_data_fd(TPMEmulator=
 *tpm_emu)
>
>       qemu_chr_fe_set_msgfds(&tpm_emu->ctrl_chr, fds + 1, 1);
>
> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SET_DATAFD, &res,=
 0,
> -                    sizeof(res)) || res !=3D 0) {
> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_DATAFD, &res, 0,
> +                             sizeof(res)) < 0 || res !=3D 0) {
>           error_report("tpm-emulator: Failed to send CMD_SET_DATAFD: %s=
",
>                        strerror(errno));
>           goto err_exit;
> @@ -494,6 +504,7 @@ static void tpm_emulator_inst_init(Object *obj)
>       DPRINTF("%s", __func__);
>       tpm_emu->options =3D g_new0(TPMEmulatorOptions, 1);
>       tpm_emu->cur_locty_number =3D ~0;
> +    qemu_mutex_init(&tpm_emu->mutex);
>   }
>
>   /*
> @@ -503,8 +514,7 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_=
emu)
>   {
>       ptm_res res;
>
> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SHUTDOWN, &res, 0=
,
> -                             sizeof(res)) < 0) {
> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &res, 0, sizeof(re=
s)) < 0) {
>           error_report("tpm-emulator: Could not cleanly shutdown the TP=
M: %s",
>                        strerror(errno));
>       } else if (res !=3D 0) {
> @@ -529,6 +539,8 @@ static void tpm_emulator_inst_finalize(Object *obj)
>           migrate_del_blocker(tpm_emu->migration_blocker);
>           error_free(tpm_emu->migration_blocker);
>       }
> +
> +    qemu_mutex_destroy(&tpm_emu->mutex);
>   }
>
>   static void tpm_emulator_class_init(ObjectClass *klass, void *data)
