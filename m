Received: from eggs.gnu.org ([2001:4830:134:3::10]:43540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eC1k2-0003he-Bm
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eC1jw-0000fX-6l
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:08:26 -0500
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:53439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eC1jw-0000fI-13
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:08:20 -0500
Received: by mail-vk0-x244.google.com with SMTP id k195so7680134vke.10
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 03:08:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7aa51688-2a80-b934-2b21-4673f4a600cc@linux.vnet.ibm.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
	<20171106183925.16747-26-marcandre.lureau@redhat.com>
	<79f747d6-d739-d213-34db-17d304491e05@linux.vnet.ibm.com>
	<67468788.36927096.1510006298683.JavaMail.zimbra@redhat.com>
	<7aa51688-2a80-b934-2b21-4673f4a600cc@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Nov 2017 12:08:18 +0100
Message-ID: <CAJ+F1CLiyKOt5-oT8YShQjhH2OpUHeuYGy_bmO0ZcCxaiWJoLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: amarnath valluri <amarnath.valluri@intel.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Nov 7, 2017 at 2:11 AM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> On 11/06/2017 05:11 PM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> Hi
>>
>> ----- Original Message -----
>>>
>>> On 11/06/2017 01:39 PM, Marc-Andr=C3=A9 Lureau wrote:
>>>>
>>>> The control chardev is being used from the data thread to set the
>>>> locality of the next request. Altough the chr has a write mutex, we
>>>> may potentially read the reply from another thread request.
>>>
>>> Right, so there may be concurrency with the CMD_RESET/GET_TPMESTABLISHE=
D
>>> commands. All the other ones shouldn't be affected. It sound like a bug
>>> in existing code.
>>>
>> I think so too, I'll rebase on master for 2.11, unless you can trivially
>> cherry-pick it.
>
>
> I could trivially cherry-pick it. Now can I send it as a pull request ?
>

Sure, thanks!


>    Stefan
>
>
>>
>>>> Add a mutex to protect from concurrent control commands.
>>>>
>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>
>>> Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>
>>>
>> thanks
>>
>>>> ---
>>>>    hw/tpm/tpm_emulator.c | 44
>>>> ++++++++++++++++++++++++++++----------------
>>>>    1 file changed, 28 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
>>>> index b77c0238c7..24cb61162f 100644
>>>> --- a/hw/tpm/tpm_emulator.c
>>>> +++ b/hw/tpm/tpm_emulator.c
>>>> @@ -71,15 +71,21 @@ typedef struct TPMEmulator {
>>>>        ptm_cap caps; /* capabilities of the TPM */
>>>>        uint8_t cur_locty_number; /* last set locality */
>>>>        Error *migration_blocker;
>>>> +
>>>> +    QemuMutex mutex;
>>>>    } TPMEmulator;
>>>>
>>>>
>>>> -static int tpm_emulator_ctrlcmd(CharBackend *dev, unsigned long cmd,
>>>> void
>>>> *msg,
>>>> +static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd,
>>>> void
>>>> *msg,
>>>>                                    size_t msg_len_in, size_t
>>>> msg_len_out)
>>>>    {
>>>> +    CharBackend *dev =3D &tpm->ctrl_chr;
>>>>        uint32_t cmd_no =3D cpu_to_be32(cmd);
>>>>        ssize_t n =3D sizeof(uint32_t) + msg_len_in;
>>>>        uint8_t *buf =3D NULL;
>>>> +    int ret =3D -1;
>>>> +
>>>> +    qemu_mutex_lock(&tpm->mutex);
>>>>
>>>>        buf =3D g_alloca(n);
>>>>        memcpy(buf, &cmd_no, sizeof(cmd_no));
>>>> @@ -87,17 +93,21 @@ static int tpm_emulator_ctrlcmd(CharBackend *dev,
>>>> unsigned long cmd, void *msg,
>>>>
>>>>        n =3D qemu_chr_fe_write_all(dev, buf, n);
>>>>        if (n <=3D 0) {
>>>> -        return -1;
>>>> +        goto end;
>>>>        }
>>>>
>>>>        if (msg_len_out !=3D 0) {
>>>>            n =3D qemu_chr_fe_read_all(dev, msg, msg_len_out);
>>>>            if (n <=3D 0) {
>>>> -            return -1;
>>>> +            goto end;
>>>>            }
>>>>        }
>>>>
>>>> -    return 0;
>>>> +    ret =3D 0;
>>>> +
>>>> +end:
>>>> +    qemu_mutex_unlock(&tpm->mutex);
>>>> +    return ret;
>>>>    }
>>>>
>>>>    static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
>>>> @@ -154,7 +164,7 @@ static int tpm_emulator_set_locality(TPMEmulator
>>>> *tpm_emu, uint8_t locty_number,
>>>>
>>>>        DPRINTF("setting locality : 0x%x", locty_number);
>>>>        loc.u.req.loc =3D locty_number;
>>>> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SET_LOCALITY,
>>>> &loc,
>>>> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_LOCALITY, &loc,
>>>>                                 sizeof(loc), sizeof(loc)) < 0) {
>>>>            error_setg(errp, "tpm-emulator: could not set locality : %s=
",
>>>>                       strerror(errno));
>>>> @@ -200,8 +210,8 @@ error:
>>>>    static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
>>>>    {
>>>>        DPRINTF("%s", __func__);
>>>> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_GET_CAPABILITY,
>>>> -                         &tpm_emu->caps, 0, sizeof(tpm_emu->caps)) < =
0)
>>>> {
>>>> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_CAPABILITY,
>>>> +                             &tpm_emu->caps, 0, sizeof(tpm_emu->caps)=
)
>>>> <
>>>> 0) {
>>>>            error_report("tpm-emulator: probing failed : %s",
>>>>            strerror(errno));
>>>>            return -1;
>>>>        }
>>>> @@ -252,8 +262,8 @@ static int tpm_emulator_startup_tpm(TPMBackend *tb=
)
>>>>        ptm_res res;
>>>>
>>>>        DPRINTF("%s", __func__);
>>>> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_INIT, &init,
>>>> sizeof(init),
>>>> -                         sizeof(init)) < 0) {
>>>> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
>>>> +                             sizeof(init)) < 0) {
>>>>            error_report("tpm-emulator: could not send INIT: %s",
>>>>                         strerror(errno));
>>>>            goto err_exit;
>>>> @@ -276,7 +286,7 @@ static bool
>>>> tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
>>>>        ptm_est est;
>>>>
>>>>        DPRINTF("%s", __func__);
>>>> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr,
>>>> CMD_GET_TPMESTABLISHED,
>>>> &est,
>>>> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_TPMESTABLISHED, &est,
>>>>                                 0, sizeof(est)) < 0) {
>>>>            error_report("tpm-emulator: Could not get the TPM establish=
ed
>>>>            flag: %s",
>>>>                         strerror(errno));
>>>> @@ -300,7 +310,7 @@ static int
>>>> tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
>>>>        }
>>>>
>>>>        reset_est.u.req.loc =3D tpm_emu->cur_locty_number;
>>>> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr,
>>>> CMD_RESET_TPMESTABLISHED,
>>>> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_RESET_TPMESTABLISHED,
>>>>                                 &reset_est, sizeof(reset_est),
>>>>                                 sizeof(reset_est)) < 0) {
>>>>            error_report("tpm-emulator: Could not reset the establishme=
nt
>>>>            bit: %s",
>>>> @@ -329,7 +339,7 @@ static void tpm_emulator_cancel_cmd(TPMBackend *tb=
)
>>>>        }
>>>>
>>>>        /* FIXME: make the function non-blocking, or it may block a VCP=
U
>>>> */
>>>> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_CANCEL_TPM_CMD,
>>>> &res,
>>>> 0,
>>>> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_CANCEL_TPM_CMD, &res, 0,
>>>>                                 sizeof(res)) < 0) {
>>>>            error_report("tpm-emulator: Could not cancel command: %s",
>>>>                         strerror(errno));
>>>> @@ -377,8 +387,8 @@ static int tpm_emulator_prepare_data_fd(TPMEmulato=
r
>>>> *tpm_emu)
>>>>
>>>>        qemu_chr_fe_set_msgfds(&tpm_emu->ctrl_chr, fds + 1, 1);
>>>>
>>>> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SET_DATAFD, &res=
,
>>>> 0,
>>>> -                    sizeof(res)) || res !=3D 0) {
>>>> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_DATAFD, &res, 0,
>>>> +                             sizeof(res)) < 0 || res !=3D 0) {
>>>>            error_report("tpm-emulator: Failed to send CMD_SET_DATAFD:
>>>> %s",
>>>>                         strerror(errno));
>>>>            goto err_exit;
>>>> @@ -494,6 +504,7 @@ static void tpm_emulator_inst_init(Object *obj)
>>>>        DPRINTF("%s", __func__);
>>>>        tpm_emu->options =3D g_new0(TPMEmulatorOptions, 1);
>>>>        tpm_emu->cur_locty_number =3D ~0;
>>>> +    qemu_mutex_init(&tpm_emu->mutex);
>>>>    }
>>>>
>>>>    /*
>>>> @@ -503,8 +514,7 @@ static void tpm_emulator_shutdown(TPMEmulator
>>>> *tpm_emu)
>>>>    {
>>>>        ptm_res res;
>>>>
>>>> -    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SHUTDOWN, &res, =
0,
>>>> -                             sizeof(res)) < 0) {
>>>> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &res, 0,
>>>> sizeof(res))
>>>> < 0) {
>>>>            error_report("tpm-emulator: Could not cleanly shutdown the
>>>> TPM:
>>>>            %s",
>>>>                         strerror(errno));
>>>>        } else if (res !=3D 0) {
>>>> @@ -529,6 +539,8 @@ static void tpm_emulator_inst_finalize(Object *obj=
)
>>>>            migrate_del_blocker(tpm_emu->migration_blocker);
>>>>            error_free(tpm_emu->migration_blocker);
>>>>        }
>>>> +
>>>> +    qemu_mutex_destroy(&tpm_emu->mutex);
>>>>    }
>>>>
>>>>    static void tpm_emulator_class_init(ObjectClass *klass, void *data)
>>>
>>>
>>>
>
>



--=20
Marc-Andr=C3=A9 Lureau
