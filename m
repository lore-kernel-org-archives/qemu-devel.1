Received: from eggs.gnu.org ([2001:4830:134:3::10]:48724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erxHx-0001CS-81
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erxHu-0004Lg-3m
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:52:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46924
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1erxHt-0004Hp-Rf
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:52:42 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w232nB59070877
	for <qemu-devel@nongnu.org>; Fri, 2 Mar 2018 21:52:40 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gff73ekjq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 21:52:39 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 2 Mar 2018 21:52:39 -0500
References: <1519934373-3629-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1519934373-3629-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CLUyeroa3wDDnC2tgAbvo+GChT4aADQUWF5y7Zn6_3KsQ@mail.gmail.com>
	<20180302101427.GB3154@work-vm>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 2 Mar 2018 21:52:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180302101427.GB3154@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <57ac3b64-831e-2245-45f4-08d3970bbf6d@linux.vnet.ibm.com>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Juan Quintela <quintela@redhat.com>, QEMU <qemu-devel@nongnu.org>

On 03/02/2018 05:14 AM, Dr. David Alan Gilbert wrote:
> * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
>> Hi Stefan
>>
>> On Thu, Mar 1, 2018 at 8:59 PM, Stefan Berger
>> <stefanb@linux.vnet.ibm.com> wrote:
>>> Extend the TPM emulator backend device with state migration support.
>>>
>>> The external TPM emulator 'swtpm' provides a protocol over
>>> its control channel to retrieve its state blobs. We implement
>>> functions for getting and setting the different state blobs.
>>> In case the setting of the state blobs fails, we return a
>>> negative errno code to fail the start of the VM.
>>>
>>> Since we have an external TPM emulator, we need to make sure
>>> that we do not migrate the state for as long as it is busy
>>> processing a request. We need to wait for notification that
>>> the request has completed processing.
>> Because qemu will have to deal with an external state, managed by the
>> tpm emulator (different from other storage/nvram):
>>
>> - the emulator statedir must be different between source and dest? Can
>> it be the same?
>> - what is the story regarding versionning? Can you migrate from/to any
>> version, or only the same version?
>> - can the host source and destination be of different endianess?
>> - how is suspend and snapshot working?
>>
>> There are probably other complications that I can't think of
>> immediately, but David or Juan help may help avoid mistakes.
> Yes, I think that just about covers it.
>
>> It probably deserves a few explanations in docs/specs/tpm.txt.
>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>> ---
>>>   hw/tpm/tpm_emulator.c | 312 +++++++++++++++++++++++++++++++++++++++=
+++++++++--
>> It would be worth to add some basic tests. Either growing our own
>> tests/tpm-emu.c test emulator
>>
>> or checking that swtpm is present (and of required version?) to
>> run/skip the test a more complete test.
>>
>>>   1 file changed, 302 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
>>> index b787aee..da877e5 100644
>>> --- a/hw/tpm/tpm_emulator.c
>>> +++ b/hw/tpm/tpm_emulator.c
>>> @@ -55,6 +55,19 @@
>>>   #define TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps & (cap=
)) =3D=3D (cap))
>>>
>>>   /* data structures */
>>> +
>>> +/* blobs from the TPM; part of VM state when migrating */
>>> +typedef struct TPMBlobBuffers {
>>> +    uint32_t permanent_flags;
>>> +    TPMSizedBuffer permanent;
>>> +
>>> +    uint32_t volatil_flags;
>>> +    TPMSizedBuffer volatil;
>>> +
>>> +    uint32_t savestate_flags;
>>> +    TPMSizedBuffer savestate;
>>> +} TPMBlobBuffers;
>>> +
>>>   typedef struct TPMEmulator {
>>>       TPMBackend parent;
>>>
>>> @@ -70,6 +83,8 @@ typedef struct TPMEmulator {
>>>
>>>       unsigned int established_flag:1;
>>>       unsigned int established_flag_cached:1;
>>> +
>>> +    TPMBlobBuffers state_blobs;
>> Suspicious addition, it shouldn't be necessary in running state. It
>> could be allocated on demand? Even better if the field is removed, but
>> this may not be possible with VMSTATE macros.
>>
>>>   } TPMEmulator;
>>>
>>>
>>> @@ -301,7 +316,8 @@ static int tpm_emulator_set_buffer_size(TPMBacken=
d *tb,
>>>       return 0;
>>>   }
>>>
>>> -static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersiz=
e)
>>> +static int _tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersi=
ze,
>>> +                                     bool is_resume)
>> Using underscore-prefixed names is discouraged. Call it tpm_emulator_i=
nit?
>>
>>>   {
>>>       TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>>>       ptm_init init =3D {
>>> @@ -309,12 +325,17 @@ static int tpm_emulator_startup_tpm(TPMBackend =
*tb, size_t buffersize)
>>>       };
>>>       ptm_res res;
>>>
>>> +    DPRINTF("%s   is_resume: %d", __func__, is_resume);
>>> +
>> extra spaces, you may also add buffersize while at it.
> Also it would be good to use trace_'s where possible rather than
> DPRINTFs.

Here's a branch where I am doing that now:

https://github.com/stefanberger/qemu-tpm/commits/tracing

I would leave a DEBUG_TIS in the tpm_tis.c, though.

>> That TPMSizedBuffer is not really useful. Use GArray or qemu Buffer ?
>> (and we could drop TPMSizedBuffer).
> Also, given this is an arbitrary sized chunk, this should probably use
> g_try_malloc and check the result rather than letting g_malloc assert o=
n
> failure (especially true on the source side).

Will fix. Thanks.


>
>>> +    n =3D qemu_chr_fe_read_all(&tpm_emu->ctrl_chr, tsb->buffer, totl=
ength);
>>> +    if (n !=3D totlength) {
>>> +        error_report("tpm-emulator: Could not read stateblob (type %=
d) : %s",
>>> +                     type, strerror(errno));
>>> +        return -1;
>>> +    }
>>> +    tsb->size =3D totlength;
>>> +
>>> +    DPRINTF("got state blob type %d, %d bytes, flags 0x%08x\n",
>>> +            type, tsb->size, *flags);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int tpm_emulator_get_state_blobs(TPMEmulator *tpm_emu)
>>> +{
>>> +    TPMBlobBuffers *state_blobs =3D &tpm_emu->state_blobs;
>>> +
>>> +    if (tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT=
,
>>> +                                    &state_blobs->permanent,
>>> +                                    &state_blobs->permanent_flags) <=
 0 ||
>>> +        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
>>> +                                    &state_blobs->volatil,
>>> +                                    &state_blobs->volatil_flags) < 0=
 ||
>>> +        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE=
,
>>> +                                    &state_blobs->savestate,
>>> +                                    &state_blobs->savestate_flags) <=
 0) {
>>> +        goto err_exit;
>>> +    }
>>> +
>>> +    return 0;
>>> +
>>> + err_exit:
>>> +    tpm_sized_buffer_reset(&state_blobs->volatil);
>>> +    tpm_sized_buffer_reset(&state_blobs->permanent);
>>> +    tpm_sized_buffer_reset(&state_blobs->savestate);
>>> +
>>> +    return -1;
>>> +}
>>> +
>>> +/*
>>> + * Transfer a TPM state blob to the TPM emulator.
>>> + *
>>> + * @tpm_emu: TPMEmulator
>>> + * @type: the type of TPM state blob to transfer
>>> + * @tsb: TPMSizeBuffer containing the TPM state blob
>>> + * @flags: Flags describing the (encryption) state of the TPM state =
blob
>>> + */
>>> +static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
>>> +                                       uint32_t type,
>>> +                                       TPMSizedBuffer *tsb,
>>> +                                       uint32_t flags)
>>> +{
>>> +    uint32_t offset =3D 0;
>>> +    ssize_t n;
>>> +    ptm_setstate pss;
>>> +    ptm_res tpm_result;
>>> +
>>> +    if (tsb->size =3D=3D 0) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    pss =3D (ptm_setstate) {
>>> +        .u.req.state_flags =3D cpu_to_be32(flags),
>>> +        .u.req.type =3D cpu_to_be32(type),
>>> +        .u.req.length =3D cpu_to_be32(tsb->size),
>>> +    };
>>> +
>>> +    /* write the header only */
>>> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
>>> +                             offsetof(ptm_setstate, u.req.data), 0) =
< 0) {
>>> +        error_report("tpm-emulator: could not set state blob type %d=
 : %s",
>>> +                     type, strerror(errno));
>>> +        return -1;
>>> +    }
>>> +
>>> +    /* now the body */
>>> +    n =3D qemu_chr_fe_write_all(&tpm_emu->ctrl_chr,
>>> +                              &tsb->buffer[offset], tsb->size);
>>> +    if (n !=3D tsb->size) {
>>> +        error_report("tpm-emulator: Writing the stateblob (type %d) =
"
>>> +                     "failed: %s", type, strerror(errno));
>>> +        return -1;
>>> +    }
>>> +
>>> +    /* now get the result */
>>> +    n =3D qemu_chr_fe_read_all(&tpm_emu->ctrl_chr,
>>> +                             (uint8_t *)&pss, sizeof(pss.u.resp));
>>> +    if (n !=3D sizeof(pss.u.resp)) {
>>> +        error_report("tpm-emulator: Reading response from writing st=
ateblob "
>>> +                     "(type %d) failed: %s", type, strerror(errno));
>>> +        return -1;
>>> +    }
>>> +
>>> +    tpm_result =3D be32_to_cpu(pss.u.resp.tpm_result);
>>> +    if (tpm_result !=3D 0) {
>>> +        error_report("tpm-emulator: Setting the stateblob (type %d) =
failed "
>>> +                     "with a TPM error 0x%x", type, tpm_result);
>>> +        return -1;
>>> +    }
>>> +
>>> +    DPRINTF("set the state blob type %d, %d bytes, flags 0x%08x\n",
>>> +            type, tsb->size, flags);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/*
>>> + * Set all the TPM state blobs.
>>> + *
>>> + * Returns a negative errno code in case of error.
>>> + */
>>> +static int tpm_emulator_set_state_blobs(TPMBackend *tb)
>>> +{
>>> +    TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>>> +    TPMBlobBuffers *state_blobs =3D &tpm_emu->state_blobs;
>>> +
>>> +    DPRINTF("%s: %d", __func__, __LINE__);
>>> +
>>> +    if (tpm_emulator_stop_tpm(tb) < 0) {
>>> +        return -EIO;
>>> +    }
>>> +
>>> +    if (tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT=
,
>>> +                                    &state_blobs->permanent,
>>> +                                    state_blobs->permanent_flags) < =
0 ||
>>> +        tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
>>> +                                    &state_blobs->volatil,
>>> +                                    state_blobs->volatil_flags) < 0 =
||
>>> +        tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE=
,
>>> +                                    &state_blobs->savestate,
>>> +                                    state_blobs->savestate_flags) < =
0) {
>>> +        return -EBADMSG;
>>> +    }
>>> +
>>> +    DPRINTF("DONE SETTING STATEBLOBS");
>> UPPERCASES!
>>
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int tpm_emulator_pre_save(void *opaque)
>>> +{
>>> +    TPMBackend *tb =3D opaque;
>>> +    TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>>> +
>>> +    DPRINTF("%s", __func__);
>>> +
>>> +    tpm_backend_finish_sync(tb);
>>> +
>>> +    /* get the state blobs from the TPM */
>>> +    return tpm_emulator_get_state_blobs(tpm_emu);
>>> +}
>>> +
>>> +/*
>>> + * Load the TPM state blobs into the TPM.
>>> + *
>>> + * Returns negative errno codes in case of error.
>>> + */
>>> +static int tpm_emulator_post_load(void *opaque,
>>> +                                  int version_id __attribute__((unus=
ed)))
>> unnecessary attribute
>>
>>> +{
>>> +    TPMBackend *tb =3D opaque;
>>> +    int ret;
>>> +
>>> +    ret =3D tpm_emulator_set_state_blobs(tb);
>>> +    if (ret < 0) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    if (_tpm_emulator_startup_tpm(tb, 0, true) < 0) {
>>> +        return -EIO;
>>> +    }
>>> +
>> I dislike the mix of functions returning errno and others, and the
>> lack of Error **, but it's not specific to this patch. Ok.  :)
>>
>>> +    return 0;
>>> +}
>>> +
>>> +static const VMStateDescription vmstate_tpm_emulator =3D {
>>> +    .name =3D "tpm-emulator",
>>> +    .version_id =3D 1,
>>> +    .minimum_version_id =3D 0,
>> version_id =3D 1 & minimum_version_id =3D 0 ?
>>
>> It's the first version, let's have version_id =3D 0 (and you could
>> remove minimum_version).
>>
>>> +    .minimum_version_id_old =3D 0,
>> No need to specify that, no load_state_old() either
>>
>>> +    .pre_save =3D tpm_emulator_pre_save,
>>> +    .post_load =3D tpm_emulator_post_load,
>>> +    .fields =3D (VMStateField[]) {
>>> +        VMSTATE_UINT32(state_blobs.permanent_flags, TPMEmulator),
>>> +        VMSTATE_UINT32(state_blobs.permanent.size, TPMEmulator),
>>> +        VMSTATE_VBUFFER_ALLOC_UINT32(state_blobs.permanent.buffer,
>>> +                                     TPMEmulator, 1, 0,
>>> +                                     state_blobs.permanent.size),
>>> +
>>> +        VMSTATE_UINT32(state_blobs.volatil_flags, TPMEmulator),
>>> +        VMSTATE_UINT32(state_blobs.volatil.size, TPMEmulator),
>>> +        VMSTATE_VBUFFER_ALLOC_UINT32(state_blobs.volatil.buffer,
>>> +                                     TPMEmulator, 1, 0,
>>> +                                     state_blobs.volatil.size),
>>> +
>>> +        VMSTATE_UINT32(state_blobs.savestate_flags, TPMEmulator),
>>> +        VMSTATE_UINT32(state_blobs.savestate.size, TPMEmulator),
>>> +        VMSTATE_VBUFFER_ALLOC_UINT32(state_blobs.savestate.buffer,
>>> +                                     TPMEmulator, 1, 0,
>>> +                                     state_blobs.savestate.size),
>>> +
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>> +};
>>> +
>>>   static void tpm_emulator_inst_init(Object *obj)
>>>   {
>>>       TPMEmulator *tpm_emu =3D TPM_EMULATOR(obj);
>>> @@ -577,6 +865,8 @@ static void tpm_emulator_inst_init(Object *obj)
>>>       tpm_emu->options =3D g_new0(TPMEmulatorOptions, 1);
>>>       tpm_emu->cur_locty_number =3D ~0;
>>>       qemu_mutex_init(&tpm_emu->mutex);
>>> +
>>> +    vmstate_register(NULL, -1, &vmstate_tpm_emulator, obj);
>>>   }
>>>
>>>   /*
>>> @@ -613,6 +903,8 @@ static void tpm_emulator_inst_finalize(Object *ob=
j)
>>>       }
>>>
>>>       qemu_mutex_destroy(&tpm_emu->mutex);
>>> +
>>> +    vmstate_unregister(NULL, &vmstate_tpm_emulator, obj);
> It's best to avoid the vmstate_register/unregister and just set the
> dc->vmsd pointer during class_init; see hw/virtio/virtio-balloon.c
> virtio_balloon_class_init for an example.

hw/tpm/tpm_emulator.c:909:tpm_emulator_class_init: Object 0x55f4cbc72680=20
is not an instance of type device
Aborted

Can we leave it as it is ?


Thanks for the review.

    Stefan
