Received: from eggs.gnu.org ([2001:4830:134:3::10]:60949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ciKVB-00054k-QX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ciKV7-0005XP-Hb
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:34:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ciKV7-0005XL-AG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:34:01 -0500
Date: Mon, 27 Feb 2017 13:33:56 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170227123356.tgmtbiwcoswdb256@eukaryote>
References: <CAFrogKUMUSYF4a7gfO3ruO5hSm6qG6oVjp0vxAO-UNRMLxB54A@mail.gmail.com>
	<20170227110106.GE28403@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170227110106.GE28403@stefanha-x1.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Question regarding Snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Tim Cusack <thagrasshoppa@gmail.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, eblake@redhat.com

On Mon, Feb 27, 2017 at 11:01:06AM +0000, Stefan Hajnoczi wrote:
> On Wed, Feb 22, 2017 at 03:06:41PM -0600, Tim Cusack wrote:
> > I have a scenario that perhaps not many have attempted, but I still h=
ope
> > that it is possible.
> >=20
> > Scenario:
> >=20
> > I would like to have a Base Windows 7 VM in KVM/QEMU.
> >=20
> > I would follow the following process (confirmed it works)
> >=20
> > 1. Shutdown running domain
> > - virsh shutdown <Domain>
> > 2. Remove existing disk from Domain XML:
> > - virt-xml BASE --remove-device --disk target=3Dhda
> > 3. Add Correct Disk image for Snapshot to Domain XML:
> > - virt-xml BASE --add-device --disk
> > /var/lib/libvirt/images/BASE.qcow2,format=3Dqcow2,target=3Dhda,bus=3D=
ide
> > 4. Create the snapshot with description
> > - virsh snapshot-create-as BASE <Model>.qcow2 "OEM, Model" --disk-onl=
y
> > --atomic
> > 5. Start Snapshot
> > - virsh start FA2BASE
>=20
> This process uses libvirt instead of QEMU commands.  Adding libvirt
> mailing list.
>=20
> >=20
> > All that works, but my question and issue is this:
> >=20
> > Can you make a snapshot, then go back to the base and ignore that sna=
pshot
> > like a closed branch, make another snapshot, and then go back and for=
th
> > from each to each?

If you edit the '--disk' element as above and point to the right
'snapshot', you should be able to switch between several of them.

    <digression>
    The correct term is 'overlay', let me quote Eric Blake,
    from his 2015 KVM Forum presentation ("Backing Chain Management" --
    recommend it), where Eric warns about points in time vs. file names:
       =20
        Given the chain =E2=80=9CA <- B <- C=E2=80=9D, we have 2 points i=
n time and an
        active layer:
   =20
          - Point 1: Guest state when B was created, contained in file A
          - Point 2: Guest state when C was created, contained in A+B
          - Active layer: Current guest state, contained in A+B+C
   =20
        Be careful with naming choices: Naming a file after the time it
        is created is misleading -- the guest data for that point in
        time is NOT contained in that file.  Rather, think of files as a
        delta from the backing file.)=20
    </digression>

And conveniently, you can tell libvirt to not track the metadata:

  $ virsh snapshot-create-as --domain vm1 guest-state1 \
      --diskspec vda,file=3D/export/overlay1.qcow2 \
      --disk-only --atomic --no-metadata

This way, libvirt will not track 'overlay1.qcow2'.  But if you do need
it, as you know, just update the=20


For the long answer to the complications involved in reverting to
external snapshots, refer this (long read):

https://wiki.libvirt.org/page/I_created_an_external_snapshot,_but_libvirt=
_will_not_let_me_delete_or_revert_to_it

> > My reasons for needing this are that I have tools and software that d=
oesnt
> > play nice together, and would like to keep them separated on differen=
t
> > snapshots, but never really need to have more than one up at a time.
> >=20
> > This would allow me to have only 1 windows license per computer, and =
the
> > ability to just change from tool to tool with simple front end to vir=
sh to
> > remove the disk from the .xml and add the other one.
> >=20
> > So like this:
> > Tool A is on snapshot A
> > Tool B is on snapshot B
> > go through steps 1-5 above to go back and forth.
> >=20
> > I know that I can not merge things back into the base,=20

How did you arrive at that conclusion?  I realize you tell further below
that you don't need it, but I should point out that it _is_ possible, if
need be, to merge things into base:

    http://wiki.libvirt.org/page/Live-merge-an-entire-disk-image-chain-in=
cluding-current-active-disk

> > but I really don't
> > need to do that, in fact, I can throw away the tool snapshots when ne=
w
> > tools come out, by making new snapshots from the base when new tools =
come
> > out.
> >=20
> > We have done this already, but we had an issue where the ability to w=
rite
> > to the snapshots seemed to stop.

Without more details like libvirt logs (with QEMU log filters), hard to
tell what's going on.

> > Reason unknown, everything worked one day and next could not write to=
 any
> > snapshot, but could still load the base and work on it fine.
> >=20
> > This might be the wrong mailing list to post to, if so, could anyone =
point
> > out a more appropriate one?
> >=20
> > Tim



--=20
/kashyap
