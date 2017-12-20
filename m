Received: from eggs.gnu.org ([2001:4830:134:3::10]:54433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eReH0-0003nD-6I
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eReGw-000560-1J
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:19:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eReGv-00055J-Oj
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:18:57 -0500
Date: Wed, 20 Dec 2017 13:18:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171220131848.GB2349@work-vm>
References: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<20171212164114.GF2409@work-vm>
	<e37d8871-544f-3c4f-3a59-bb66dc5c8b67@linux.vnet.ibm.com>
	<b5c7e566-34f0-adb0-0fcb-bf272cbb0a81@redhat.com>
	<225a4478-dc5e-a067-f207-e8a183afa0d9@linux.vnet.ibm.com>
	<9b719ebe-8b38-708c-45a7-d377a583f899@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9b719ebe-8b38-708c-45a7-d377a583f899@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] hmp: 'info snapshots' not showing the id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: seeteena <s1seetee@linux.vnet.ibm.com>, lma@suse.com, qemu-devel@nongnu.org

* Max Reitz (mreitz@redhat.com) wrote:
> On 2017-12-18 10:24, seeteena wrote:
> >=20
> >=20
> > On 12/15/2017 02:48 PM, Max Reitz wrote:
> >> On 2017-12-13 05:50, seeteena wrote:
> >>> Hi David,
> >>>
> >>> While creating snapshots when tag name '0' used in the very first a=
nd followed by tag name '1' then snapshot created with tag name '0' is ge=
tting erased.=20
> >>> A snapshot is identified by a name computed either from an id, whic=
h is basically a numerical counter starting at 1 for qcow2, or from a tag=
, which is a string (provided
> >>> by the user or automatically computed).=20
> >>>
> >>> (qemu) savevm 0
> >>>
> >>> This creates a snapshot with tag '0' and id '1'.
> >> That's something someone has complained about already, as far as I
> >> remember, and this is indeed an issue.
> >>
> >>>> (qemu) savevm 1
> >>> This deletes snapshot with name '1' (ie, with id '1') and creates s=
napshot with tag '1' and id '1'.
> >> I think this is the issue, not info snapshots.
> >>
> >>> From the output of 'info snapshots' id '1' is not seen for tag '0' =
instead seeing an empty field.
> >>>
> >>> ID        TAG                 VM SIZE                DATE       VM =
CLOCK
> >>> --        0                      338M 2017-10-16 13:44:35   00:02:0=
7.491
> >>>
> >>> If an ID shown as '1' in the above then user can understand the abo=
ve documented stuff i.e "If there is already a snapshot with the same tag=
 or ID, it is replaced".
> >>> The '--' in ID field is annoying.
> >> Maybe, but this patch is wrong still.  Commit 3a1ee711904 says exact=
ly why:
> >>
> >>> The patch uses snapshot name instead of snapshot id to determine wh=
ether a
> >>> snapshot is fully available and uses '--' instead of snapshot id in=
 output
> >>> because the snapshot id is not guaranteed to be the same on all ima=
ges.
> >> info snapshots first shows a list of snapshots that are present on a=
ll
> >> disks.  However, those are matched by name and not by ID, so the ID =
is
> >> not necessarily the same.
> >>
> >> Therefore, we can only print it if it is.  Sure, we can do that, but
> >> your patch is missing that check.
> > =A0As you referred I had checked Commit 3a1ee711904. Does it mean tha=
t we
> > need to add the check option for ID as well along with name to get th=
e
> > list of snapshots that are present on all disks with my patch ?
> > so info snapshots shows list of snapshots that are present on all dis=
ks
> > that matched either by ID or name.
> >=20
> > like
> > if (bdrv_all_find_snapshot(sn_tab[i].name, &bs1) =3D=3D 0) ||
> > (bdrv_all_find_snapshot(sn_tab[i].id_str, &bs1) =3D=3D 0)
>=20
> Kind of true, but I think that first this is a separate issue and
> secondly, this can get rather hairy.  (See below under (3).)
>=20
> So there are three things:
>=20
> (1) We probably should not allow snapshot names that could be IDs.
> Easiest way to solve this: Names have to start with a non-digit.

Is this something we're in a position to change, or is it part of the
API that user programs can end up using?

Dave

> (2) If we want to print a global snapshot's common ID, we need to affir=
m
> that this ID is indeed the same on all disks before we can print it.
> Same for names, but currently the name is always the same on all disks
> because that is how we identify global snapshots.
>=20
> (3) You can give an ID to loadvm and then it will load the snapshot wit=
h
> that ID from all disks.  So if you have snapshots with a common ID on
> all disks, these are kind of global snapshots, too, even though they
> don't share a name.  Thus, they should probably be included in the
> listing (this is what you have just proposed).
> I don't like this at all, though.  A snapshot's ID is not really
> user-controlled, it's just some auto-generated number.  Therefore, just
> because the ID of a snapshot matches across multiple disks, this doesn'=
t
> mean that they are related whatsoever.
> So, first, I don't think loadvm should work with IDs (at least not
> across multiple disks).  But I don't think this really needs to be fixe=
d.
> On the other hand, I really don't think info snapshots should list
> snapshots that match by ID, because a matching ID does not mean that
> snapshots are actually related.  A matching name usually does, though,
> so I think what we currently do is sufficient and the right way to do i=
t.
>=20
> Max
>=20



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
