Received: from eggs.gnu.org ([2001:4830:134:3::10]:60132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f1DJM-0003ig-Tc
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f1DJL-0006Vf-Iq
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:48:28 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f1DJL-0006Uv-8i
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:48:27 -0400
Received: by mail-wm0-x22f.google.com with SMTP id r82so6285768wme.0
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 08:48:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521236796-24551-4-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1521236796-24551-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1521236796-24551-4-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 28 Mar 2018 17:48:24 +0200
Message-ID: <CAJ+F1CJqfUJK2WTEVQKMm6Kdbo4q-KP2V4ONNS4u+bdAOfKMXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 for 2.13 3/4] docs: tpm: add VM
 save/restore example and troubleshooting guide
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Fri, Mar 16, 2018 at 10:46 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Extend the docs related to TPM with specs related to VM save and
> restore and a troubleshooting guide for TPM migration.
>

Thanks a lot for writing this! some questions below

> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  docs/specs/tpm.txt | 106 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 106 insertions(+)
>
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index d1d7157..c230c4c 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -200,3 +200,109 @@ crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/t=
pm0
>  PCR-00: 35 4E 3B CE 23 9F 38 59 ...
>  ...
>  PCR-23: 00 00 00 00 00 00 00 00 ...
> +
> +
> +=3D=3D=3D Migration with the TPM emulator =3D=3D=3D
> +
> +The TPM emulator supports the following types of virtual machine migrati=
on:
> +
> +- VM save / restore (migration into a file)
> +- Network migration
> +- Snapshotting (migration into storage like QoW2 or QED)
> +
> +The following command sequences can be used to test VM save / restore.
> +
> +
> +In a 1st terminal start an instance of a swtpm using the following comma=
nd:
> +
> +mkdir /tmp/mytpm1
> +swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
> +  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
> +  --log level=3D20 --tpm2
> +
> +In a 2nd terminal start the VM:
> +
> +qemu-system-x86_64 -display sdl -enable-kvm \
> +  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> +  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> +  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> +  -device tpm-tis,tpmdev=3Dtpm0 \
> +  -monitor stdio \
> +  test.img
> +
> +Verify that the attached TPM is working as expected using applications i=
nside
> +the VM.
> +
> +To store the state of the VM use the following command in the QEMU monit=
or in
> +the 2nd terminal:
> +
> +(qemu) migrate "exec:cat > testvm.bin"
> +(qemu) quit
> +
> +At this point a file called 'testvm.bin' should exists and the swtpm and=
 QEMU
> +processes should have ended.

When is swtpm ending, when qemu leaves? Hopefully you can do several
migrate commands.

> +
> +To test 'VM restore' you have to start the swtpm with the same parameter=
s
> +as before. If previously a TPM 2 [--tpm2] was saved, --tpm2 must now be
> +passed again on the command line.
> +
> +In the 1st terminal restart the swtpm with the same command line as befo=
re:
> +
> +swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
> +  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
> +  --log level=3D20 --tpm2

Does that mean the tpmstate directory content must be the same and
thus migrated as well? Can in be empty in the destination? If not,
what should be done to initialize it? Could it be empty instead?

> +
> +In the 2nd terminal restore the state of the VM using the additonal
> +'-incoming' option.
> +
> +qemu-system-x86_64 -display sdl -enable-kvm \
> +  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> +  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> +  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> +  -device tpm-tis,tpmdev=3Dtpm0 \
> +  -incoming "exec:cat < testvm.bin" \
> +  test.img
> +
> +
> +Troubleshooting migration:
> +
> +There are several reasons why migration may fail. In case of problems,
> +please ensure that the command lines adhere to the following rules and,
> +if possible, that identical versions of QEMU and swtpm are used at all
> +times.
> +
> +VM save and restore:
> + - QEMU command line parameters should be identical apart from the
> +   '-incoming' option on VM restore
> + - swtpm command line parameters should be identical
> +
> +VM migration to 'localhost':
> + - QEMU command line parameters should be identical apart from the
> +   '-incoming' option on the destination side
> + - swtpm command line parameters should point to two different
> +   directories on the source and destination swtpm (--tpmstate dir=3D...=
)
> +   (especially if different versions of libtpms were to be used on the
> +   same machine).
> +
> +VM migration across the network:
> + - QEMU command line parameters should be identical apart from the
> +   '-incoming' option on the destination side
> + - swtpm command line parameters should be identical
> +
> +VM Snapshotting:
> + - QEMU command line parameters should be identical
> + - swtpm command line parameters should be identical
> +
> +
> +Besides that, migration failure reasons on the swtpm level may include
> +the following:
> +
> + - the versions of the swtpm on the source and destination sides are
> +   incompatible
> +   - downgrading of TPM state may not be supported
> +   - the source and destination libtpms were compiled with different
> +     compile-time options and the destination side refuses to accept the
> +     state
> + - different migration keys are used on the source and destination side
> +   and the destination side cannot decrypt the migrated state
> +   (swtpm ... --migration-key ... )
> --
> 2.5.5
>




--=20
Marc-Andr=C3=A9 Lureau
