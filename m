Received: from eggs.gnu.org ([2001:4830:134:3::10]:40268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1z97-0002c1-TG
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1z92-0004e3-Pf
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:20:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42574
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1z92-0004cv-Jd
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:20:44 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AIImKt120116
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 14:20:41 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dh2grb657-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 14:20:40 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 12:20:40 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<f752e248-a50a-337b-a0aa-8347103640ed@linux.vnet.ibm.com>
	<CAJ+F1CLnPZhC1-GtxRAJjySDmOdeu+jc1yq=VqUizgJRFtuTTQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 14:20:37 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLnPZhC1-GtxRAJjySDmOdeu+jc1yq=VqUizgJRFtuTTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <431bfbbf-3c6d-972e-bcb5-f8dba675d574@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/42] TPM: code cleanup & CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

On 10/10/2017 08:14 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi Stefan
>
> On Tue, Oct 10, 2017 at 4:34 AM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> On 10/09/2017 06:55 PM, Marc-Andr=C3=A9 Lureau wrote:
>>> Hi,
>>>
>>> I accumulated a series of patch doing some TPM code cleanup while
>>> doing review. I removed some dead code, simplified other parts, and
>>> tried to isolate implementation of the backend and frontend by using =
a
>>> new TPMIf interface. I solved a few issues, and added some FIXME for
>>> what should be tackled.  Finally, I implemented a simple CRB device
>>> (tpm 2.0) that is work in progress for now - it works fine with
>>> passthrough, but swtpm/libtpms with win10 has some issues that need
>>> more investigations.
>>
>> You are using the swtpm with --tpm2, right? And I suppose you are usin=
g the
>> tpm2-preview.rev146 branch of libtpms. What are the symptoms?
> Yes, I was using tpm2-preview.rev146.ossl11 branch
>
> Windows complained about malfunctioning TPM 2.0 device, despite doing
> many exchanges. Sadly, I couldn't find many option to make libtpms a
> bit more verbose, as I am not able to parse the hexdump. I haven't
> spent much time investigating yet.

libtpms's TPM 2 code doesn't have a lot of debugging output. The only=20
solution for now is to crank up the log level to 20 and have it log into=20
a file. It at least shows the exchange of messages.

>
>> Most of this series looks good to me. I'll go over it again and will a=
dd my
>> Reviewed-by. It seems to have some build problems, though.
> I fixed the build issue (gcc on centos is a bit old), last version is
> https://github.com/elmarco/qemu/commits/tpm.
>
>> For libtpms + swtpm the biggest challenge is supporting state migratio=
n,
>> especially with TPM2. I have that working on the swtpm level in form o=
f test
>> cases and also with the old CUSE TPM support in QEMU + libvirt mgmt. s=
tack
>> with CUSE support. So ideally we would get to that point as well with =
the
>> QEMU TPM emulator device to make sure suspend/resume, snapshotting, an=
d
>> migration work. libtpms 0.6 should have TPM 2 code and ideally swtpm 0=
.1
>> would support TPM 2 as well.
> Yes! thanks a lot for working on this, this is indeed essential. How
> close are you from releasing the migration code?
>
> Depending how quickly this series is reviewed & merged, I would like
> to work on cleaning up the threading code next.

I haven't worked on the suspend/resume part. It would have to be a port=20
of these 3 patches:
https://github.com/stefanberger/qemu-tpm/commit/9d8c9c3f0df288242d03f78d3=
b103099c1910574
https://github.com/stefanberger/qemu-tpm/commit/b9ea09d2e26eac92b4a1604a7=
afa695c4fc2735e
https://github.com/stefanberger/qemu-tpm/commit/27d332dc3b2c6bfd0fcd38e69=
f5c899651f3a5d8


    Stefan


>
>
> thanks
>
>>     Regards,
>>         Stefan
>>
>>
>>> seabios CRB support is required for TPM 2.0 & emulation
>>> (https://mail.coreboot.org/pipermail/seabios/2017-October/011839.html=
)
>>>
>>> Comments/review welcome!
>>>
>>> Based-on: <1507222112-20315-1-git-send-email-stefanb@linux.vnet.ibm.c=
om>
>>>
>>> Marc-Andr=C3=A9 Lureau (42):
>>>     tpm-tis: remove unused hw_access argument
>>>     tpm-tis: remove RAISE_STS_IRQ
>>>     tpm: make tpm_get_backend_driver() static
>>>     tpm: lookup tpm backend class in tpm_driver_find_by_type()
>>>     tpm: replace tpm_get_backend_driver() to drop be_drivers
>>>     tpm: remove tpm_register_driver()
>>>     tpm: move TPMSizedBuffer to tpm_tis.h
>>>     tpm: remove TPMDriverOps
>>>     tpm: remove init() class method
>>>     tpm: remove configure_tpm() hop
>>>     tpm: remove unused TPMBackendCmd
>>>     tpm: remove needless cast
>>>     tpm: remove locty argument from receive_cb
>>>     tpm: add TPMBackendCmd to hold the request state
>>>     tpm-emulator: fix error handling
>>>     tpm: remove locty_data from TPMState
>>>     tpm-tis: move TPMState to TIS header
>>>     tpm-tis: remove tpm_tis.h header
>>>     tpm-tis: fold TPMTISEmuState in TPMState
>>>     tpm: add a QOM TPM interface
>>>     tpm: move recv_data_callback to TPM interface
>>>     tpm-backend: store TPMIf interface, improve backend_init()
>>>     tpm-tis: no longer expose TPMState
>>>     tpm-be: call request_completed() out of thread
>>>     tpm-be: report error instead of front-end
>>>     tpm-be: ask model to the TPM interface
>>>     tpm: remove unused opened code
>>>     tpm-passthrough: don't save guessed cancel_path in options
>>>     tpm-be: update optional function pointers
>>>     tpm-passthrough: pass TPMPassthruState to handle_device_opts
>>>     tpm-backend: move set 'id' to common code
>>>     tpm-passthrough: make it safer to destroy after creation
>>>     tpm-passthrough: remove error cleanup from handle_device_opts
>>>     tpm-passthrough: workaround a possible race
>>>     tpm-tis: simplify header inclusion
>>>     tpm: rename qemu_find_tpm() -> qemu_find_tpm_be()
>>>     tpm: lookup the the TPM interface instead of TIS device
>>>     tpm: add TPM interface to lookup TPM version
>>>     tpm: add tpm_cmd_get_size() to tpm_util
>>>     acpi: change TPM TIS data conditions
>>>     tpm-emulator: add a FIXME comment about blocking cancel
>>>     WIP: add TPM CRB device
>>>
>>>    qapi/tpm.json                      |   7 +-
>>>    hw/tpm/tpm_int.h                   |  25 +-
>>>    hw/tpm/tpm_tis.h                   |  70 ------
>>>    hw/tpm/tpm_util.h                  |   8 +-
>>>    include/hw/acpi/tpm.h              |  65 +++++
>>>    include/sysemu/tpm.h               |  59 +++--
>>>    include/sysemu/tpm_backend.h       |  70 ++----
>>>    backends/tpm.c                     | 121 ++++-----
>>>    hw/i386/acpi-build.c               |  33 ++-
>>>    hw/tpm/tpm_crb.c                   | 320 ++++++++++++++++++++++++
>>>    hw/tpm/tpm_emulator.c              |  95 +++----
>>>    hw/tpm/tpm_passthrough.c           | 114 +++------
>>>    hw/tpm/tpm_tis.c                   | 499
>>> +++++++++++++++++++------------------
>>>    hw/tpm/tpm_util.c                  |   1 +
>>>    tpm.c                              |  63 ++---
>>>    default-configs/i386-softmmu.mak   |   1 +
>>>    default-configs/x86_64-softmmu.mak |   1 +
>>>    hw/tpm/Makefile.objs               |   1 +
>>>    scripts/checkpatch.pl              |   1 -
>>>    19 files changed, 899 insertions(+), 655 deletions(-)
>>>    delete mode 100644 hw/tpm/tpm_tis.h
>>>    create mode 100644 hw/tpm/tpm_crb.c
>>>
>>
>
>
