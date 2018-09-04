Received: from eggs.gnu.org ([2001:4830:134:3::10]:54711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fxCCk-0001gK-Jq
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 10:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fxCCj-0006Ri-Kk
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 10:21:18 -0400
Date: Tue, 4 Sep 2018 16:21:06 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180904142106.GD3803@andariel.pipo.sk>
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
	<20180828142626.GM122225@angien.pipo.sk>
	<20180903150311.GC14463@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <20180903150311.GC14463@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, berto@igalia.com


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 17:03:11 +0200, Kevin Wolf wrote:
> Am 28.08.2018 um 16:26 hat Peter Krempa geschrieben:
> > On Fri, Aug 10, 2018 at 18:26:57 +0200, Kevin Wolf wrote:
> > > The block-commit QMP command required specifying the top and base nod=
es
> > > of the commit jobs using the file name of that node. While this works
> > > in simple cases (local files with absolute paths), the file names
> > > generated for more complicated setups can be hard to predict.
> > >=20
> > > This adds two new options top-node and base-node to the command, which
> > > allow specifying node names instead. They are mutually exclusive with
> > > the old options.
> > >=20
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  qapi/block-core.json | 24 ++++++++++++++++++------
> > >  blockdev.c           | 32 ++++++++++++++++++++++++++++++--
> > >  2 files changed, 48 insertions(+), 8 deletions(-)
> >=20
> > While the below is not strictly relevant to this patch usage
> > block-commit is not possible when using -blockdev. Thus the new
> > arguments are not very useful otherwise.
> >=20
> > With the new options I'm getting:
> >=20
> > {"execute":"block-commit",
> >  "arguments": { "device":"libvirt-3-format",
> >                 "job-id":"libvirt-3-format",
> >                 "top-node":"libvirt-8-format",
> >                 "base-node":"libvirt-9-format",
> >                 "auto-finalize":true,
> >                 "auto-dismiss":false},
> >  "id":"libvirt-16"}
> >=20
> > {"id":"libvirt-16",
> >  "error":{"class":"GenericError",
> >           "desc":"Block node is read-only"}}
> >=20
> > I'm pointing into the backing chain so the files are declared as read-o=
nly.
> >=20
> > It works just-fine if I open them as read-write with
> > -blockdev/blockdev-add but that obviously is not correct as you can't
> > then share parts of the backing chain with other VMs due to image
> > locking.
> >=20
> > libvirt-3-format is read-write and all other node names are readonly in
> > the above example.
> >=20
> > The same also happens when using filenames:
> >=20
> > {"execute":"block-commit",
> >  "arguments" : {"device":"libvirt-3-format",
> >                 "job-id":"libvirt-3-format",
> >                 "top":"/var/lib/libvirt/images/rhel7.3.1483615252",
> >                 "base":"/var/lib/libvirt/images/rhel7.3.1483605924",
> >                 "auto-finalize":true,
> >                 "auto-dismiss":false},
> >  "id":"libvirt-13"}
> >=20
> > {"id":"libvirt-13","error":{"class":"GenericError","desc":"Block node i=
s read-only"}}
>=20
> I see what's happening here. So we have a graph like this:
>=20
>      guest device
>           |
>           v
>     overlay-format -------> backing-format
>     [read-only=3Doff]         [read-only=3Don]
>           |                        |
>           v                        v
>     overlay-proto           backing-proto
>     [read-only=3Doff]         [read-only=3Don]
>=20
> The difference between your -blockdev use and -drive is that you
> explicitly specify the read-only option for backing-proto (and you use a
> separate -blockdev option anyway), so it doesn't just inherit it from
> backing-format.
>=20
> Now, when the commit job tries to reopen backing-format, your explicit
> read-only=3Don for backing-proto still takes precedence and the node stays
> read-only. If you hadn't used a separate -blockdev for backing-proto,
> but included it in the definition for backing-format and left out the
> read-only option, it would have inherited the option and reopen would
> adjust both nodes. This is what happens with -drive.
>=20
> So essentially, I guess, all places that want to switch between
> read-only and read-write need to learn which other nodes (apart from the
> top-level node they are interested in) must be reopened as well.

We theoretically can always open the protocol layer read-write if it
does not conflict with the image locking code (I did not test that).

Changing to opening them as dependancy of the format layer would
complicate things with blockdev-create where that would not be possible
and would require blockdev-add(proto), blockdev-create,
blockdev-del(proto),blockdev-add (format+proto).

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAluOlNIACgkQHGwCByjY
1GqAaA//aBksXp0U5AcM7Kza4CDLcRMFrj7fNK6YbPBF7Ikv+t6bpLcZgBJEa5pR
e8DvSnnuB+YWtLvcXcxodGeJF3SzrcUDHpN4/vmAF/88wjsURKzNjPYYjh8wUgyh
3eD1cMkhUGDDW8VLdu3gTxhTe7sxvn6Uoo94bldEH2xPpNQ++DuWC5AfO19RxVCj
5LxOcGh5f1imuu+7dkzwgIcRw8e7y1ipO+y5kkEbPfU0Y803SvGpg1/WRzamOqQN
Eip3kjTyOn3kQi6/x1P3vfWFHXc/TRd0USmChzKZPhwUJ/2vqNDPr6uZwoZH8pyX
gViOXKnpx2WlkSvdVg9vRXtkjXo5BQRzfD7LemboVwX21al3fUBNzsG1slyRYXRo
fMGt2zy9VyqPShqpMDBpzWNNzOLtNh6KyelucqX2sqsJU9LAH0yWj5ECnc0d3/DJ
DNuLHM4Ool8LfNBy4JjPMEswDf87Cwl572pXRYk4zQdY66MiOE3G6ekxTA1QeDtr
MrfA2Bd9HvBFvi0yhu4vb6o+DOUkOUrOKGCC/6eN+X/00iHbPx8lJT34IbReFqeI
fCq7FK4+03CwySUtUVAd7dLf09uEHrLD8vICel5+2Sl1eb/qnQKvGFGuWAFKClMt
LwYYy51a6XnieegAL+dKV7fRGjNRLmeurZ1uSxmhoBuYrC7WZfg=
=r6Hg
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
