Received: from eggs.gnu.org ([2001:4830:134:3::10]:42752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJU8I-0002ZU-Qh
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJU8F-0003vW-NB
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:47:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cJU8F-0003vN-EJ
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:47:43 -0500
Date: Wed, 21 Dec 2016 07:47:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161220234738.GB2994@lemon>
References: <c532ac07-fd54-eedb-b3f0-548aeacf0a04@fam-schranz.de>
	<3dce9a63-6472-54c2-3455-52521a0a3651@redhat.com>
	<89d9fe09-3bdc-3c84-3ddf-f9462adb2068@fam-schranz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <89d9fe09-3bdc-3c84-3ddf-f9462adb2068@fam-schranz.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Strange/wrong behavior with iSCSI Tape devices in
 QEMU 2.8.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Holger Schranz <holger@fam-schranz.de>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, mueller-ralf@t-online.de

On Tue, 12/20 17:53, Holger Schranz wrote:
> Hi John,
>=20
> sorry or late. I will reproduce it and send you the QEMU command line
> instruction.
>=20
> About the guest system: LINUX SuSE SLES11 SP4.
>=20
> About 2.7.0 Release: it doesn't run without the patches for the issue:
> [Qemu-devel] [PATCH] iscsi: Fix divide-by-zero regression on raw SG dev=
ices
>=20
> (I can't find the issue number).

Are there any related message showing up in guest dmesg?

Is it possible to do a git bisect?

Also, does it work if you login with host side iscsi client (iscsiadm) an=
d pass
the /dev/sgX to QEMU?

Fam

>=20
> Best regards
>=20
> Holger
>=20
> Am 19.12.2016 um 18:30 schrieb John Snow:
> >=20
> > On 12/19/2016 04:05 AM, Holger Schranz wrote:
> > > # Strange/wrong behavior in QEMU 2.8.0-rc4
> > >=20
> > > After update from QEMU 2.6.2 to 2.8.0-rc4 the tape devices
> > > and the corresponding medium changer are no longer available
> > > in the VM quest system.
> > >=20
> > > The tape devices and the media changer are declared in the
> > > xml-file for libvirt. Both, tape drives and medium changer
> > > are avalilable via iSCSI.
> > >=20
> > > In a first rough investigation the login in iSCSI runs well
> > > but in QEMU, it seems the devices doesn't reported to the VM-Quest.
> > >=20
> > > ------------------
> > >=20
> > > Best regards
> > >=20
> > > Holger
> > >=20
> > Hi, thanks for the report; do you have a QEMU command line that we ca=
n
> > use to help reproduce the problem? It's easiest if we can cut libvirt
> > out of the loop.
> >=20
> > What is the architecture and version of the guest?
> >=20
> > Lastly, it looks like this worked in our 2.7 release if I'm reading y=
ou
> > correctly, so this is a change for the 2.8 release as far as you can
> > tell, right?
> >=20
> > --js
> >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > XML-Declration:
> > >=20
> > > .
> > > .
> > > .
> > >=20
> > > <!-- SCSI 2 -->
> > >      <controller type=3D'scsi' model=3D'virtio-scsi' index=3D'1'>
> > >        <alias name=3D'scsi1'/>
> > >      </controller>
> > >=20
> > > <!-- 2 x LTO5 -->
> > >      <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no' rawio=
=3D'yes'>
> > >        <source protocol=3D'iscsi'
> > > name=3D'iqn.2008-09.net.fsc:server.LT260_61003/4'>
> > >        <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
> > >        </source>
> > >        <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2' unit=3D'1'/>
> > >      </hostdev>
> > >=20
> > >      <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no' rawio=
=3D'yes'>
> > >        <source protocol=3D'iscsi'
> > > name=3D'iqn.2008-09.net.fsc:server.LT260_61003/5'>
> > >        <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
> > >        </source>
> > >        <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2' unit=3D'2'/>
> > >      </hostdev>
> > >=20
> > > <!-- Virtual media changer Fujitsu LT260 -->
> > >      <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no' rawio=
=3D'yes'>
> > >        <source protocol=3D'iscsi'
> > > name=3D'iqn.2008-09.net.fsc:server.LT260_61003/6'>
> > >        <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
> > >        </source>
> > >        <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2' unit=3D'3'/>
> > >      </hostdev>
> > >=20
> > > <!-- 2 x LTO6 (via PLP(LAN-attached library)) -->
> > >      <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no' rawio=
=3D'yes'>
> > >        <source protocol=3D'iscsi'
> > > name=3D'iqn.2008-09.net.fsc:server.LT60_61005/3'>
> > >        <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
> > >        </source>
> > >        <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2' unit=3D'4'/>
> > >      </hostdev>
> > >=20
> > >      <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no' rawio=
=3D'yes'>
> > >        <source protocol=3D'iscsi'
> > > name=3D'iqn.2008-09.net.fsc:server.LT60_61005/4'>
> > >        <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
> > >        </source>
> > >        <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2' unit=3D'5'/>
> > >      </hostdev>
> > > .
> > > .
> > > .
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > >=20
> > >=20
> > > correct behavior/Result inside the VM-Quest together with QEMU/KVM =
2.6.2
> > > / 2.7.0
> > > --
> > > (VCSTCS82:A)IUP1:~ # lsscsi -g
> > > [0:2:0:0]    disk    FTS      PRAID EP420i     4.25  /dev/sda /dev/=
sg0
> > > [3:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+  /dev/sr0 /dev/=
sg1
> > > [8:0:2:1]    tape    HP       Ultrium 5-SCSI   0001  /dev/st3 /dev/=
sg6
> > > [8:0:2:2]    tape    HP       Ultrium 5-SCSI   0001  /dev/st2 /dev/=
sg5
> > > [8:0:2:3]    mediumx FUJITSU  ETERNUS LT260    6.20  - /dev/sg4
> > > [8:0:2:4]    tape    HP       Ultrium 6-SCSI   23AB  /dev/st1 /dev/=
sg3
> > > [8:0:2:5]    tape    HP       Ultrium 6-SCSI   23AB  /dev/st0 /dev/=
sg2
> > > [11:0:0:0]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdb /dev/=
sg7
> > > [11:0:0:2]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdh /dev/=
sg13
> > > [11:0:0:3]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdg /dev/=
sg12
> > > [11:0:0:4]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdf /dev/=
sg11
> > > [11:0:0:5]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sde /dev/=
sg10
> > > [11:0:0:6]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdd /dev/=
sg9
> > > [11:0:0:7]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdc /dev/=
sg8
> > > [11:0:0:15]  disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdi /dev/=
sg14
> > > (VCSTCS82:A)IUP1:~ #
> > >=20
> > >=20
> > >=20
> > > Wrong behavior/Result inside the VM-Quest together with QEMU/KVM 2.=
8.0-RC4
> > > --
> > > (VCSTCS82:A)IUP1:~ # lsscsi -g
> > > [0:2:0:0]    disk    FTS      PRAID EP420i     4.25  /dev/sda /dev/=
sg0
> > > [3:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+  /dev/sr0 /dev/=
sg1
> > > [11:0:1:0]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdj /dev/=
sg10
> > > [11:0:1:2]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdp /dev/=
sg16
> > > [11:0:1:3]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdo /dev/=
sg15
> > > [11:0:1:4]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdn /dev/=
sg14
> > > [11:0:1:5]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdm /dev/=
sg13
> > > [11:0:1:6]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdl /dev/=
sg12
> > > [11:0:1:7]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdk /dev/=
sg11
> > > [11:0:1:15]  disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdq /dev/=
sg17
> > > (VCSTCS82:A)IUP1:~ #
> > >=20
>=20
>=20
> ---
> Diese E-Mail wurde von Avast Antivirus-Software auf Viren gepr=FCft.
> https://www.avast.com/antivirus
>=20
>=20
