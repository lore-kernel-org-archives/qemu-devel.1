Received: from eggs.gnu.org ([2001:4830:134:3::10]:47105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IPy-0001PB-9n
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 17:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IPv-00062A-2R
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 17:15:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IPu-00061r-Jv
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 17:15:34 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2SLFNt2056649
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 17:15:33 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h0gs4mwbr-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 17:15:32 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 28 Mar 2018 15:15:29 -0600
References: <1521236796-24551-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1521236796-24551-4-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CJqfUJK2WTEVQKMm6Kdbo4q-KP2V4ONNS4u+bdAOfKMXw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 17:15:25 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJqfUJK2WTEVQKMm6Kdbo4q-KP2V4ONNS4u+bdAOfKMXw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <2f81c4df-7de6-8225-a781-4275c0d9ae0e@linux.vnet.ibm.com>
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 03/28/2018 11:48 AM, Marc-Andr=E9 Lureau wrote:
> Hi
>
> On Fri, Mar 16, 2018 at 10:46 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Extend the docs related to TPM with specs related to VM save and
>> restore and a troubleshooting guide for TPM migration.
>>
> Thanks a lot for writing this! some questions below
>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   docs/specs/tpm.txt | 106 +++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>   1 file changed, 106 insertions(+)
>>
>> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
>> index d1d7157..c230c4c 100644
>> --- a/docs/specs/tpm.txt
>> +++ b/docs/specs/tpm.txt
>> @@ -200,3 +200,109 @@ crw-------. 1 root root 10, 224 Jul 11 10:11 /de=
v/tpm0
>>   PCR-00: 35 4E 3B CE 23 9F 38 59 ...
>>   ...
>>   PCR-23: 00 00 00 00 00 00 00 00 ...
>> +
>> +
>> +=3D=3D=3D Migration with the TPM emulator =3D=3D=3D
>> +
>> +The TPM emulator supports the following types of virtual machine migr=
ation:
>> +
>> +- VM save / restore (migration into a file)
>> +- Network migration
>> +- Snapshotting (migration into storage like QoW2 or QED)
>> +
>> +The following command sequences can be used to test VM save / restore.
>> +
>> +
>> +In a 1st terminal start an instance of a swtpm using the following co=
mmand:
>> +
>> +mkdir /tmp/mytpm1
>> +swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
>> +  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
>> +  --log level=3D20 --tpm2
>> +
>> +In a 2nd terminal start the VM:
>> +
>> +qemu-system-x86_64 -display sdl -enable-kvm \
>> +  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
>> +  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
>> +  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
>> +  -device tpm-tis,tpmdev=3Dtpm0 \
>> +  -monitor stdio \
>> +  test.img
>> +
>> +Verify that the attached TPM is working as expected using application=
s inside
>> +the VM.
>> +
>> +To store the state of the VM use the following command in the QEMU mo=
nitor in
>> +the 2nd terminal:
>> +
>> +(qemu) migrate "exec:cat > testvm.bin"
>> +(qemu) quit
>> +
>> +At this point a file called 'testvm.bin' should exists and the swtpm =
and QEMU
>> +processes should have ended.
> When is swtpm ending, when qemu leaves? Hopefully you can do several
> migrate commands.

Yes, QEMU does not send it the signal to shut down. We can fall back to=20
the source if the destination fails.

>
>> +
>> +To test 'VM restore' you have to start the swtpm with the same parame=
ters
>> +as before. If previously a TPM 2 [--tpm2] was saved, --tpm2 must now =
be
>> +passed again on the command line.
>> +
>> +In the 1st terminal restart the swtpm with the same command line as b=
efore:
>> +
>> +swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
>> +  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
>> +  --log level=3D20 --tpm2
> Does that mean the tpmstate directory content must be the same and
> thus migrated as well? Can in be empty in the destination? If not,
> what should be done to initialize it? Could it be empty instead?

QEMU migrates the state of the TPM with the CMD_GET_STATEBLOB to=20
retrieve the state blobs and CMD_SET_STATEBLOB to set them on the=20
destination. The destination only needs to have the TPM running but the=20
directory must have been created (--tpmstate dir=3D...).

One can try this with localhost migration over the network as well, but=20
I didn't want to show this more complicated scenario in the doc:

destination QEMU:
sudo ./x86_64-softmmu/qemu-system-x86_64 -vnc :11 -enable-kvm -m 1024=20
-smp 8 -boot d -L /usr/share/seabios -bios bios-256k.bin -boot menu=3Don=20
-chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm2/ctrl.sock -tpmdev=20
emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis,tpmdev=3Dtpm0 -monito=
r=20
stdio -chardev file,id=3Dpts2,path=3D/tmp/seabios.log -device=20
isa-serial,chardev=3Dpts2 /var/lib/libvirt/images/FC27 -incoming "exec:nc=
=20
-l 127.0.0.1 12345"

source QEMU:
sudo ./x86_64-softmmu/qemu-system-x86_64 -vnc :10 -enable-kvm -m 1024=20
-smp 8 -boot d -L /usr/share/seabios -bios bios-256k.bin -boot menu=3Don=20
-chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/ctrl.sock -tpmdev=20
emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis,tpmdev=3Dtpm0 -monito=
r=20
stdio -chardev file,id=3Dpts2,path=3D/tmp/seabios.log -device=20
isa-serial,chardev=3Dpts2  /var/lib/libvirt/images/FC27

(qemu) migrate "exec:nc 127.0.0.1 12345"

Just tested again.

     Stefan


>> +
>> +In the 2nd terminal restore the state of the VM using the additonal
>> +'-incoming' option.
>> +
>> +qemu-system-x86_64 -display sdl -enable-kvm \
>> +  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
>> +  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
>> +  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
>> +  -device tpm-tis,tpmdev=3Dtpm0 \
>> +  -incoming "exec:cat < testvm.bin" \
>> +  test.img
>> +
>> +
>> +Troubleshooting migration:
>> +
>> +There are several reasons why migration may fail. In case of problems=
,
>> +please ensure that the command lines adhere to the following rules an=
d,
>> +if possible, that identical versions of QEMU and swtpm are used at al=
l
>> +times.
>> +
>> +VM save and restore:
>> + - QEMU command line parameters should be identical apart from the
>> +   '-incoming' option on VM restore
>> + - swtpm command line parameters should be identical
>> +
>> +VM migration to 'localhost':
>> + - QEMU command line parameters should be identical apart from the
>> +   '-incoming' option on the destination side
>> + - swtpm command line parameters should point to two different
>> +   directories on the source and destination swtpm (--tpmstate dir=3D=
...)
>> +   (especially if different versions of libtpms were to be used on th=
e
>> +   same machine).
>> +
>> +VM migration across the network:
>> + - QEMU command line parameters should be identical apart from the
>> +   '-incoming' option on the destination side
>> + - swtpm command line parameters should be identical
>> +
>> +VM Snapshotting:
>> + - QEMU command line parameters should be identical
>> + - swtpm command line parameters should be identical
>> +
>> +
>> +Besides that, migration failure reasons on the swtpm level may includ=
e
>> +the following:
>> +
>> + - the versions of the swtpm on the source and destination sides are
>> +   incompatible
>> +   - downgrading of TPM state may not be supported
>> +   - the source and destination libtpms were compiled with different
>> +     compile-time options and the destination side refuses to accept =
the
>> +     state
>> + - different migration keys are used on the source and destination si=
de
>> +   and the destination side cannot decrypt the migrated state
>> +   (swtpm ... --migration-key ... )
>> --
>> 2.5.5
>>
>
>
>
