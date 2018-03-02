Received: from eggs.gnu.org ([2001:4830:134:3::10]:49133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erkbY-0007C8-QU
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erkbU-0005ud-LH
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:20:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1erkbU-0005sr-5k
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:20:04 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w22DG5YX114548
	for <qemu-devel@nongnu.org>; Fri, 2 Mar 2018 08:20:02 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gf54bw8cu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 08:20:02 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 2 Mar 2018 08:20:01 -0500
References: <1519934373-3629-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1519934373-3629-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CLUyeroa3wDDnC2tgAbvo+GChT4aADQUWF5y7Zn6_3KsQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 2 Mar 2018 08:19:56 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLUyeroa3wDDnC2tgAbvo+GChT4aADQUWF5y7Zn6_3KsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <39d6fbab-28d5-974b-2fe6-8eb31ba68ef1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/2] tpm: extend TPM emulator with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 03/02/2018 04:26 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi Stefan
>
> On Thu, Mar 1, 2018 at 8:59 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Extend the TPM emulator backend device with state migration support.
>>
>> The external TPM emulator 'swtpm' provides a protocol over
>> its control channel to retrieve its state blobs. We implement
>> functions for getting and setting the different state blobs.
>> In case the setting of the state blobs fails, we return a
>> negative errno code to fail the start of the VM.
>>
>> Since we have an external TPM emulator, we need to make sure
>> that we do not migrate the state for as long as it is busy
>> processing a request. We need to wait for notification that
>> the request has completed processing.
> Because qemu will have to deal with an external state, managed by the
> tpm emulator (different from other storage/nvram):
>
> - the emulator statedir must be different between source and dest? Can
> it be the same?

You mean for local migration? I would suggest it be different=20
directories though it may work with the same. I haven't tried it like=20
that and the critical case here is local migration between different=20
versions of the swtpm and for example downgrading of state from v3 to v1=20
being refused.

> - what is the story regarding versionning? Can you migrate from/to any
> version, or only the same version?

I just redid the state marshalling/unmarshalling of the TPM 2=20
implementation. All structures that are written out are ID'ed and=20
versioned and accomodate compile-time optional parts. As for migration=20
between different versions, I am not sure what to promise about this=20
right now. So if you migrate a structure of the TPM 2 from v1 to v2 and=20
v2 has some new fields that v1 didn't have, we need default values to=20
assign to these new fields, which may or may not be possible depending=20
on circumstances and semantics of the fields. In the end it comes down=20
to upgradeability of the TPM 2 implementation. The current=20
implementation supports revision 146 of the TPM 2 specs. I cannot=20
predict the future and what future versions may add to the code and the=20
state of the device. Design/development of the TPM 2 is ongoing while=20
companies are producing TPM 2 chips following specs of a certain time.=20
They also have that problem of having to upgrade a device to a later=20
spec but could refuse to do so and tell you to buy a new machine. So in=20
our case it may actually be more difficult with the expected upgrade=20
path. If the state cannot be upgraded because default values cannot be=20
found, we would have to stop at a certain revision.

> - can the host source and destination be of different endianess?

Yes. All state is marshalled in big endian format. I have test cases in=20
swtpm that cover that. State produced on a x86_64 can be consumed on=20
ppc64 big endian.

> - how is suspend and snapshot working?

The tpm_emulator backend uses the same mechanisms to store state as all=20
the other devices do, except that we retrieve the state via .pre_save=20
from an external device where we fill buffers that are part of the=20
'normal' state of the device. You have come across the TPMSizedBuffers=20
that are being marshalled and those carry that state.

I have tried local migration to a file as well as local migration via=20
netcat. Both work.

>
> There are probably other complications that I can't think of
> immediately, but David or Juan help may help avoid mistakes.
>
> It probably deserves a few explanations in docs/specs/tpm.txt.
>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   hw/tpm/tpm_emulator.c | 312 ++++++++++++++++++++++++++++++++++++++++=
++++++++--
> It would be worth to add some basic tests. Either growing our own
> tests/tpm-emu.c test emulator
>
> or checking that swtpm is present (and of required version?) to
> run/skip the test a more complete test.

Ok, I'll have to look into that. I do have several test cases in swtpm=20
for that already.

>
>>   1 file changed, 302 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
>> index b787aee..da877e5 100644
>> --- a/hw/tpm/tpm_emulator.c
>> +++ b/hw/tpm/tpm_emulator.c
>> @@ -55,6 +55,19 @@
>>   #define TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps & (cap)=
) =3D=3D (cap))
>>
>>   /* data structures */
>> +
>> +/* blobs from the TPM; part of VM state when migrating */
>> +typedef struct TPMBlobBuffers {
>> +    uint32_t permanent_flags;
>> +    TPMSizedBuffer permanent;
>> +
>> +    uint32_t volatil_flags;
>> +    TPMSizedBuffer volatil;
>> +
>> +    uint32_t savestate_flags;
>> +    TPMSizedBuffer savestate;
>> +} TPMBlobBuffers;
>> +
>>   typedef struct TPMEmulator {
>>       TPMBackend parent;
>>
>> @@ -70,6 +83,8 @@ typedef struct TPMEmulator {
>>
>>       unsigned int established_flag:1;
>>       unsigned int established_flag_cached:1;
>> +
>> +    TPMBlobBuffers state_blobs;
> Suspicious addition, it shouldn't be necessary in running state. It
> could be allocated on demand? Even better if the field is removed, but
> this may not be possible with VMSTATE macros.

This is the field that will carry the external devices' state blobs.

>>   } TPMEmulator;
>>
>>
>> @@ -301,7 +316,8 @@ static int tpm_emulator_set_buffer_size(TPMBackend=
 *tb,
>>       return 0;
>>   }
>>
>> -static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize=
)
>> +static int _tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersiz=
e,
>> +                                     bool is_resume)
> Using underscore-prefixed names is discouraged. Call it tpm_emulator_in=
it?
>
>>   {
>>       TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>>       ptm_init init =3D {
>> @@ -309,12 +325,17 @@ static int tpm_emulator_startup_tpm(TPMBackend *=
tb, size_t buffersize)
>>       };
>>       ptm_res res;
>>
>> +    DPRINTF("%s   is_resume: %d", __func__, is_resume);
>> +
> extra spaces, you may also add buffersize while at it.
>
>>       if (buffersize !=3D 0 &&
>>           tpm_emulator_set_buffer_size(tb, buffersize, NULL) < 0) {
>>           goto err_exit;
>>       }
>>
>> -    DPRINTF("%s", __func__);
>> +    if (is_resume) {
>> +        init.u.req.init_flags =3D cpu_to_be32(PTM_INIT_FLAG_DELETE_VO=
LATILE);
>> +    }
> Since it's a flags, and for future extensibility, I would suggest |=3D.
>
>> +
>>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
>>                                sizeof(init)) < 0) {
>>           error_report("tpm-emulator: could not send INIT: %s",
>> @@ -333,6 +354,11 @@ err_exit:
>>       return -1;
>>   }
>>
>> +static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize=
)
>> +{
>> +    return _tpm_emulator_startup_tpm(tb, buffersize, false);
>> +}
>> +
>>   static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
>>   {
>>       TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>> @@ -431,16 +457,21 @@ static size_t tpm_emulator_get_buffer_size(TPMBa=
ckend *tb)
>>   static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
>>   {
>>       Error *err =3D NULL;
>> +    ptm_cap caps =3D PTM_CAP_GET_STATEBLOB | PTM_CAP_SET_STATEBLOB |
>> +                   PTM_CAP_STOP;
>>
>> -    error_setg(&tpm_emu->migration_blocker,
>> -               "Migration disabled: TPM emulator not yet migratable")=
;
>> -    migrate_add_blocker(tpm_emu->migration_blocker, &err);
>> -    if (err) {
>> -        error_report_err(err);
>> -        error_free(tpm_emu->migration_blocker);
>> -        tpm_emu->migration_blocker =3D NULL;
>> +    if (!TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_emu, caps)) {
>> +        error_setg(&tpm_emu->migration_blocker,
>> +                   "Migration disabled: TPM emulator does not support=
 "
>> +                   "migration");
>> +        migrate_add_blocker(tpm_emu->migration_blocker, &err);
>> +        if (err) {
>> +            error_report_err(err);
>> +            error_free(tpm_emu->migration_blocker);
>> +            tpm_emu->migration_blocker =3D NULL;
>>
>> -        return -1;
>> +            return -1;
>> +        }
>>       }
>>
>>       return 0;
>> @@ -569,6 +600,263 @@ static const QemuOptDesc tpm_emulator_cmdline_op=
ts[] =3D {
>>       { /* end of list */ },
>>   };
>>
>> +/*
>> + * Transfer a TPM state blob from the TPM into a provided buffer.
>> + *
>> + * @tpm_emu: TPMEmulator
>> + * @type: the type of blob to transfer
>> + * @tsb: the TPMSizeBuffer to fill with the blob
>> + * @flags: the flags to return to the caller
>> + */
>> +static int tpm_emulator_get_state_blob(TPMEmulator *tpm_emu,
>> +                                       uint8_t type,
>> +                                       TPMSizedBuffer *tsb,
>> +                                       uint32_t *flags)
>> +{
>> +    ptm_getstate pgs;
>> +    ptm_res res;
>> +    ssize_t n;
>> +    uint32_t totlength, length;
>> +
>> +    tpm_sized_buffer_reset(tsb);
>> +
>> +    pgs.u.req.state_flags =3D cpu_to_be32(PTM_STATE_FLAG_DECRYPTED);
>> +    pgs.u.req.type =3D cpu_to_be32(type);
>> +    pgs.u.req.offset =3D 0;
>> +
>> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_STATEBLOB,
>> +                             &pgs, sizeof(pgs.u.req),
>> +                             offsetof(ptm_getstate, u.resp.data)) < 0=
) {
>> +        error_report("tpm-emulator: could not get state blob type %d =
: %s",
>> +                     type, strerror(errno));
>> +        return -1;
> (I guess some day vmstate functions should have an Error ** argument)
>
>> +    }
>> +
>> +    res =3D be32_to_cpu(pgs.u.resp.tpm_result);
>> +    if (res !=3D 0 && (res & 0x800) =3D=3D 0) {
>> +        error_report("tpm-emulator: Getting the stateblob (type %d) f=
ailed "
>> +                     "with a TPM error 0x%x", type, res);
>> +        return -1;
>> +    }
>> +
>> +    totlength =3D be32_to_cpu(pgs.u.resp.totlength);
>> +    length =3D be32_to_cpu(pgs.u.resp.length);
>> +    if (totlength !=3D length) {
>> +        error_report("tpm-emulator: Expecting to read %u bytes "
>> +                     "but would get %u", totlength, length);
>> +        return -1;
>> +    }
>> +
>> +    *flags =3D be32_to_cpu(pgs.u.resp.state_flags);
>> +
>> +    tsb->buffer =3D g_malloc(totlength);
> That TPMSizedBuffer is not really useful. Use GArray or qemu Buffer ?
> (and we could drop TPMSizedBuffer).
>
>> +    n =3D qemu_chr_fe_read_all(&tpm_emu->ctrl_chr, tsb->buffer, totle=
ngth);
>> +    if (n !=3D totlength) {
>> +        error_report("tpm-emulator: Could not read stateblob (type %d=
) : %s",
>> +                     type, strerror(errno));
>> +        return -1;
>> +    }
>> +    tsb->size =3D totlength;
>> +
>> +    DPRINTF("got state blob type %d, %d bytes, flags 0x%08x\n",
>> +            type, tsb->size, *flags);
>> +
>> +    return 0;
>> +}
>> +
>> +static int tpm_emulator_get_state_blobs(TPMEmulator *tpm_emu)
>> +{
>> +    TPMBlobBuffers *state_blobs =3D &tpm_emu->state_blobs;
>> +
>> +    if (tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
>> +                                    &state_blobs->permanent,
>> +                                    &state_blobs->permanent_flags) < =
0 ||
>> +        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
>> +                                    &state_blobs->volatil,
>> +                                    &state_blobs->volatil_flags) < 0 =
||
>> +        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
>> +                                    &state_blobs->savestate,
>> +                                    &state_blobs->savestate_flags) < =
0) {
>> +        goto err_exit;
>> +    }
>> +
>> +    return 0;
>> +
>> + err_exit:
>> +    tpm_sized_buffer_reset(&state_blobs->volatil);
>> +    tpm_sized_buffer_reset(&state_blobs->permanent);
>> +    tpm_sized_buffer_reset(&state_blobs->savestate);
>> +
>> +    return -1;
>> +}
>> +
>> +/*
>> + * Transfer a TPM state blob to the TPM emulator.
>> + *
>> + * @tpm_emu: TPMEmulator
>> + * @type: the type of TPM state blob to transfer
>> + * @tsb: TPMSizeBuffer containing the TPM state blob
>> + * @flags: Flags describing the (encryption) state of the TPM state b=
lob
>> + */
>> +static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
>> +                                       uint32_t type,
>> +                                       TPMSizedBuffer *tsb,
>> +                                       uint32_t flags)
>> +{
>> +    uint32_t offset =3D 0;
>> +    ssize_t n;
>> +    ptm_setstate pss;
>> +    ptm_res tpm_result;
>> +
>> +    if (tsb->size =3D=3D 0) {
>> +        return 0;
>> +    }
>> +
>> +    pss =3D (ptm_setstate) {
>> +        .u.req.state_flags =3D cpu_to_be32(flags),
>> +        .u.req.type =3D cpu_to_be32(type),
>> +        .u.req.length =3D cpu_to_be32(tsb->size),
>> +    };
>> +
>> +    /* write the header only */
>> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
>> +                             offsetof(ptm_setstate, u.req.data), 0) <=
 0) {
>> +        error_report("tpm-emulator: could not set state blob type %d =
: %s",
>> +                     type, strerror(errno));
>> +        return -1;
>> +    }
>> +
>> +    /* now the body */
>> +    n =3D qemu_chr_fe_write_all(&tpm_emu->ctrl_chr,
>> +                              &tsb->buffer[offset], tsb->size);
>> +    if (n !=3D tsb->size) {
>> +        error_report("tpm-emulator: Writing the stateblob (type %d) "
>> +                     "failed: %s", type, strerror(errno));
>> +        return -1;
>> +    }
>> +
>> +    /* now get the result */
>> +    n =3D qemu_chr_fe_read_all(&tpm_emu->ctrl_chr,
>> +                             (uint8_t *)&pss, sizeof(pss.u.resp));
>> +    if (n !=3D sizeof(pss.u.resp)) {
>> +        error_report("tpm-emulator: Reading response from writing sta=
teblob "
>> +                     "(type %d) failed: %s", type, strerror(errno));
>> +        return -1;
>> +    }
>> +
>> +    tpm_result =3D be32_to_cpu(pss.u.resp.tpm_result);
>> +    if (tpm_result !=3D 0) {
>> +        error_report("tpm-emulator: Setting the stateblob (type %d) f=
ailed "
>> +                     "with a TPM error 0x%x", type, tpm_result);
>> +        return -1;
>> +    }
>> +
>> +    DPRINTF("set the state blob type %d, %d bytes, flags 0x%08x\n",
>> +            type, tsb->size, flags);
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Set all the TPM state blobs.
>> + *
>> + * Returns a negative errno code in case of error.
>> + */
>> +static int tpm_emulator_set_state_blobs(TPMBackend *tb)
>> +{
>> +    TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>> +    TPMBlobBuffers *state_blobs =3D &tpm_emu->state_blobs;
>> +
>> +    DPRINTF("%s: %d", __func__, __LINE__);
>> +
>> +    if (tpm_emulator_stop_tpm(tb) < 0) {
>> +        return -EIO;
>> +    }
>> +
>> +    if (tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
>> +                                    &state_blobs->permanent,
>> +                                    state_blobs->permanent_flags) < 0=
 ||
>> +        tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
>> +                                    &state_blobs->volatil,
>> +                                    state_blobs->volatil_flags) < 0 |=
|
>> +        tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
>> +                                    &state_blobs->savestate,
>> +                                    state_blobs->savestate_flags) < 0=
) {
>> +        return -EBADMSG;
>> +    }
>> +
>> +    DPRINTF("DONE SETTING STATEBLOBS");
> UPPERCASES!
>
>> +
>> +    return 0;
>> +}
>> +
>> +static int tpm_emulator_pre_save(void *opaque)
>> +{
>> +    TPMBackend *tb =3D opaque;
>> +    TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>> +
>> +    DPRINTF("%s", __func__);
>> +
>> +    tpm_backend_finish_sync(tb);
>> +
>> +    /* get the state blobs from the TPM */
>> +    return tpm_emulator_get_state_blobs(tpm_emu);
>> +}
>> +
>> +/*
>> + * Load the TPM state blobs into the TPM.
>> + *
>> + * Returns negative errno codes in case of error.
>> + */
>> +static int tpm_emulator_post_load(void *opaque,
>> +                                  int version_id __attribute__((unuse=
d)))
> unnecessary attribute
>
>> +{
>> +    TPMBackend *tb =3D opaque;
>> +    int ret;
>> +
>> +    ret =3D tpm_emulator_set_state_blobs(tb);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    if (_tpm_emulator_startup_tpm(tb, 0, true) < 0) {
>> +        return -EIO;
>> +    }
>> +
> I dislike the mix of functions returning errno and others, and the
> lack of Error **, but it's not specific to this patch. Ok.  :)
>
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_tpm_emulator =3D {
>> +    .name =3D "tpm-emulator",
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 0,
> version_id =3D 1 & minimum_version_id =3D 0 ?
>
> It's the first version, let's have version_id =3D 0 (and you could
> remove minimum_version).
>
>> +    .minimum_version_id_old =3D 0,
> No need to specify that, no load_state_old() either
>
>> +    .pre_save =3D tpm_emulator_pre_save,
>> +    .post_load =3D tpm_emulator_post_load,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_UINT32(state_blobs.permanent_flags, TPMEmulator),
>> +        VMSTATE_UINT32(state_blobs.permanent.size, TPMEmulator),
>> +        VMSTATE_VBUFFER_ALLOC_UINT32(state_blobs.permanent.buffer,
>> +                                     TPMEmulator, 1, 0,
>> +                                     state_blobs.permanent.size),
>> +
>> +        VMSTATE_UINT32(state_blobs.volatil_flags, TPMEmulator),
>> +        VMSTATE_UINT32(state_blobs.volatil.size, TPMEmulator),
>> +        VMSTATE_VBUFFER_ALLOC_UINT32(state_blobs.volatil.buffer,
>> +                                     TPMEmulator, 1, 0,
>> +                                     state_blobs.volatil.size),
>> +
>> +        VMSTATE_UINT32(state_blobs.savestate_flags, TPMEmulator),
>> +        VMSTATE_UINT32(state_blobs.savestate.size, TPMEmulator),
>> +        VMSTATE_VBUFFER_ALLOC_UINT32(state_blobs.savestate.buffer,
>> +                                     TPMEmulator, 1, 0,
>> +                                     state_blobs.savestate.size),
>> +
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static void tpm_emulator_inst_init(Object *obj)
>>   {
>>       TPMEmulator *tpm_emu =3D TPM_EMULATOR(obj);
>> @@ -577,6 +865,8 @@ static void tpm_emulator_inst_init(Object *obj)
>>       tpm_emu->options =3D g_new0(TPMEmulatorOptions, 1);
>>       tpm_emu->cur_locty_number =3D ~0;
>>       qemu_mutex_init(&tpm_emu->mutex);
>> +
>> +    vmstate_register(NULL, -1, &vmstate_tpm_emulator, obj);
>>   }
>>
>>   /*
>> @@ -613,6 +903,8 @@ static void tpm_emulator_inst_finalize(Object *obj=
)
>>       }
>>
>>       qemu_mutex_destroy(&tpm_emu->mutex);
>> +
>> +    vmstate_unregister(NULL, &vmstate_tpm_emulator, obj);
>>   }
>>
>>   static void tpm_emulator_class_init(ObjectClass *klass, void *data)
>> --
>> 2.5.5
>>
>>
> looks good to me overall
>
Thanks for the review. I'll fix your concerns.


    Stefan4
