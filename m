Received: from eggs.gnu.org ([2001:4830:134:3::10]:57123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1TGI-00017g-Ix
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 04:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1TGD-0006Pd-EL
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 04:50:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f1TGD-0006PT-8E
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 04:50:17 -0400
Date: Thu, 29 Mar 2018 09:50:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180329085004.GC2982@work-vm>
References: <1521236796-24551-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1521236796-24551-4-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CJqfUJK2WTEVQKMm6Kdbo4q-KP2V4ONNS4u+bdAOfKMXw@mail.gmail.com>
	<2f81c4df-7de6-8225-a781-4275c0d9ae0e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2f81c4df-7de6-8225-a781-4275c0d9ae0e@linux.vnet.ibm.com>
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>

* Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> On 03/28/2018 11:48 AM, Marc-Andr=E9 Lureau wrote:
> > Hi
> >=20
> > On Fri, Mar 16, 2018 at 10:46 PM, Stefan Berger
> > <stefanb@linux.vnet.ibm.com> wrote:
> > > Extend the docs related to TPM with specs related to VM save and
> > > restore and a troubleshooting guide for TPM migration.
> > >=20
> > Thanks a lot for writing this! some questions below
> >=20
> > > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > > ---
> > >   docs/specs/tpm.txt | 106 ++++++++++++++++++++++++++++++++++++++++=
+++++++++++++
> > >   1 file changed, 106 insertions(+)
> > >=20
> > > diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> > > index d1d7157..c230c4c 100644
> > > --- a/docs/specs/tpm.txt
> > > +++ b/docs/specs/tpm.txt
> > > @@ -200,3 +200,109 @@ crw-------. 1 root root 10, 224 Jul 11 10:11 =
/dev/tpm0
> > >   PCR-00: 35 4E 3B CE 23 9F 38 59 ...
> > >   ...
> > >   PCR-23: 00 00 00 00 00 00 00 00 ...
> > > +
> > > +
> > > +=3D=3D=3D Migration with the TPM emulator =3D=3D=3D
> > > +
> > > +The TPM emulator supports the following types of virtual machine m=
igration:
> > > +
> > > +- VM save / restore (migration into a file)
> > > +- Network migration
> > > +- Snapshotting (migration into storage like QoW2 or QED)
> > > +
> > > +The following command sequences can be used to test VM save / rest=
ore.
> > > +
> > > +
> > > +In a 1st terminal start an instance of a swtpm using the following=
 command:
> > > +
> > > +mkdir /tmp/mytpm1
> > > +swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
> > > +  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
> > > +  --log level=3D20 --tpm2
> > > +
> > > +In a 2nd terminal start the VM:
> > > +
> > > +qemu-system-x86_64 -display sdl -enable-kvm \
> > > +  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> > > +  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> > > +  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> > > +  -device tpm-tis,tpmdev=3Dtpm0 \
> > > +  -monitor stdio \
> > > +  test.img
> > > +
> > > +Verify that the attached TPM is working as expected using applicat=
ions inside
> > > +the VM.
> > > +
> > > +To store the state of the VM use the following command in the QEMU=
 monitor in
> > > +the 2nd terminal:
> > > +
> > > +(qemu) migrate "exec:cat > testvm.bin"
> > > +(qemu) quit
> > > +
> > > +At this point a file called 'testvm.bin' should exists and the swt=
pm and QEMU
> > > +processes should have ended.
> > When is swtpm ending, when qemu leaves? Hopefully you can do several
> > migrate commands.
>=20
> Yes, QEMU does not send it the signal to shut down. We can fall back to=
 the
> source if the destination fails.
>=20
> >=20
> > > +
> > > +To test 'VM restore' you have to start the swtpm with the same par=
ameters
> > > +as before. If previously a TPM 2 [--tpm2] was saved, --tpm2 must n=
ow be
> > > +passed again on the command line.
> > > +
> > > +In the 1st terminal restart the swtpm with the same command line a=
s before:
> > > +
> > > +swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
> > > +  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
> > > +  --log level=3D20 --tpm2
> > Does that mean the tpmstate directory content must be the same and
> > thus migrated as well? Can in be empty in the destination? If not,
> > what should be done to initialize it? Could it be empty instead?
>=20
> QEMU migrates the state of the TPM with the CMD_GET_STATEBLOB to retrie=
ve
> the state blobs and CMD_SET_STATEBLOB to set them on the destination. T=
he
> destination only needs to have the TPM running but the directory must h=
ave
> been created (--tpmstate dir=3D...).
>=20
> One can try this with localhost migration over the network as well, but=
 I
> didn't want to show this more complicated scenario in the doc:
>=20
> destination QEMU:
> sudo ./x86_64-softmmu/qemu-system-x86_64 -vnc :11 -enable-kvm -m 1024 -=
smp 8
> -boot d -L /usr/share/seabios -bios bios-256k.bin -boot menu=3Don -char=
dev
> socket,id=3Dchrtpm,path=3D/tmp/mytpm2/ctrl.sock -tpmdev
> emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis,tpmdev=3Dtpm0 -moni=
tor stdio
> -chardev file,id=3Dpts2,path=3D/tmp/seabios.log -device isa-serial,char=
dev=3Dpts2
> /var/lib/libvirt/images/FC27 -incoming "exec:nc -l 127.0.0.1 12345"
>=20
> source QEMU:
> sudo ./x86_64-softmmu/qemu-system-x86_64 -vnc :10 -enable-kvm -m 1024 -=
smp 8
> -boot d -L /usr/share/seabios -bios bios-256k.bin -boot menu=3Don -char=
dev
> socket,id=3Dchrtpm,path=3D/tmp/mytpm1/ctrl.sock -tpmdev
> emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis,tpmdev=3Dtpm0 -moni=
tor stdio
> -chardev file,id=3Dpts2,path=3D/tmp/seabios.log -device isa-serial,char=
dev=3Dpts2
> /var/lib/libvirt/images/FC27
>=20
> (qemu) migrate "exec:nc 127.0.0.1 12345"

Migration has a tcp form that's a bit easier;
-incoming tcp:127.0.0.1:12345
migrate tcp:127.0.0.1:12345

Dave

> Just tested again.
>=20
>     Stefan
>=20
>=20
> > > +
> > > +In the 2nd terminal restore the state of the VM using the additona=
l
> > > +'-incoming' option.
> > > +
> > > +qemu-system-x86_64 -display sdl -enable-kvm \
> > > +  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> > > +  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> > > +  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> > > +  -device tpm-tis,tpmdev=3Dtpm0 \
> > > +  -incoming "exec:cat < testvm.bin" \
> > > +  test.img
> > > +
> > > +
> > > +Troubleshooting migration:
> > > +
> > > +There are several reasons why migration may fail. In case of probl=
ems,
> > > +please ensure that the command lines adhere to the following rules=
 and,
> > > +if possible, that identical versions of QEMU and swtpm are used at=
 all
> > > +times.
> > > +
> > > +VM save and restore:
> > > + - QEMU command line parameters should be identical apart from the
> > > +   '-incoming' option on VM restore
> > > + - swtpm command line parameters should be identical
> > > +
> > > +VM migration to 'localhost':
> > > + - QEMU command line parameters should be identical apart from the
> > > +   '-incoming' option on the destination side
> > > + - swtpm command line parameters should point to two different
> > > +   directories on the source and destination swtpm (--tpmstate dir=
=3D...)
> > > +   (especially if different versions of libtpms were to be used on=
 the
> > > +   same machine).
> > > +
> > > +VM migration across the network:
> > > + - QEMU command line parameters should be identical apart from the
> > > +   '-incoming' option on the destination side
> > > + - swtpm command line parameters should be identical
> > > +
> > > +VM Snapshotting:
> > > + - QEMU command line parameters should be identical
> > > + - swtpm command line parameters should be identical
> > > +
> > > +
> > > +Besides that, migration failure reasons on the swtpm level may inc=
lude
> > > +the following:
> > > +
> > > + - the versions of the swtpm on the source and destination sides a=
re
> > > +   incompatible
> > > +   - downgrading of TPM state may not be supported
> > > +   - the source and destination libtpms were compiled with differe=
nt
> > > +     compile-time options and the destination side refuses to acce=
pt the
> > > +     state
> > > + - different migration keys are used on the source and destination=
 side
> > > +   and the destination side cannot decrypt the migrated state
> > > +   (swtpm ... --migration-key ... )
> > > --
> > > 2.5.5
> > >=20
> >=20
> >=20
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
