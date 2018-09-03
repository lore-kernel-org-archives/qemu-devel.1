Received: from eggs.gnu.org ([2001:4830:134:3::10]:48088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fwqOD-0003ld-HW
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fwqOB-0007rS-FR
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:03:41 -0400
Date: Mon, 3 Sep 2018 17:03:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180903150311.GC14463@dhcp-200-186.str.redhat.com>
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
	<20180828142626.GM122225@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20180828142626.GM122225@angien.pipo.sk>
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, berto@igalia.com


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.08.2018 um 16:26 hat Peter Krempa geschrieben:
> On Fri, Aug 10, 2018 at 18:26:57 +0200, Kevin Wolf wrote:
> > The block-commit QMP command required specifying the top and base nodes
> > of the commit jobs using the file name of that node. While this works
> > in simple cases (local files with absolute paths), the file names
> > generated for more complicated setups can be hard to predict.
> >=20
> > This adds two new options top-node and base-node to the command, which
> > allow specifying node names instead. They are mutually exclusive with
> > the old options.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-core.json | 24 ++++++++++++++++++------
> >  blockdev.c           | 32 ++++++++++++++++++++++++++++++--
> >  2 files changed, 48 insertions(+), 8 deletions(-)
>=20
> While the below is not strictly relevant to this patch usage
> block-commit is not possible when using -blockdev. Thus the new
> arguments are not very useful otherwise.
>=20
> With the new options I'm getting:
>=20
> {"execute":"block-commit",
>  "arguments": { "device":"libvirt-3-format",
>                 "job-id":"libvirt-3-format",
>                 "top-node":"libvirt-8-format",
>                 "base-node":"libvirt-9-format",
>                 "auto-finalize":true,
>                 "auto-dismiss":false},
>  "id":"libvirt-16"}
>=20
> {"id":"libvirt-16",
>  "error":{"class":"GenericError",
>           "desc":"Block node is read-only"}}
>=20
> I'm pointing into the backing chain so the files are declared as read-onl=
y.
>=20
> It works just-fine if I open them as read-write with
> -blockdev/blockdev-add but that obviously is not correct as you can't
> then share parts of the backing chain with other VMs due to image
> locking.
>=20
> libvirt-3-format is read-write and all other node names are readonly in
> the above example.
>=20
> The same also happens when using filenames:
>=20
> {"execute":"block-commit",
>  "arguments" : {"device":"libvirt-3-format",
>                 "job-id":"libvirt-3-format",
>                 "top":"/var/lib/libvirt/images/rhel7.3.1483615252",
>                 "base":"/var/lib/libvirt/images/rhel7.3.1483605924",
>                 "auto-finalize":true,
>                 "auto-dismiss":false},
>  "id":"libvirt-13"}
>=20
> {"id":"libvirt-13","error":{"class":"GenericError","desc":"Block node is =
read-only"}}

I see what's happening here. So we have a graph like this:

     guest device
          |
          v
    overlay-format -------> backing-format
    [read-only=3Doff]         [read-only=3Don]
          |                        |
          v                        v
    overlay-proto           backing-proto
    [read-only=3Doff]         [read-only=3Don]

The difference between your -blockdev use and -drive is that you
explicitly specify the read-only option for backing-proto (and you use a
separate -blockdev option anyway), so it doesn't just inherit it from
backing-format.

Now, when the commit job tries to reopen backing-format, your explicit
read-only=3Don for backing-proto still takes precedence and the node stays
read-only. If you hadn't used a separate -blockdev for backing-proto,
but included it in the definition for backing-format and left out the
read-only option, it would have inherited the option and reopen would
adjust both nodes. This is what happens with -drive.

So essentially, I guess, all places that want to switch between
read-only and read-write need to learn which other nodes (apart from the
top-level node they are interested in) must be reopened as well.

This looks a bit messy. :-/

Any good ideas anyone?

Kevin

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbjU0vAAoJEH8JsnLIjy/WFY8P/RdKQeuxi1UAGKG2COWPNV6e
WBjvrPEnFXCR6YWt8OlBN5TYPRqIBw6IcOJK2MbTJwKemqQS4g0a4/Qc4lwkXjdn
3QRcW/I0dz7F3TRNGEKTVpuN4gyEbk1ELd8aHqgW7Z2ex2eRV+A4jAHMLwDQsFOI
yIMg8FD61fgQBc9jSxHWFpmmZu1k4nmIYF8n9b5kCwFxC0VRCYQ0+HlYxd2WsiTs
VrLvDiQdTzolJw0r17/gjl/aCVmccamX3F+1jCY0/cI0sbmwC9agIL67r8XrrGGR
PwTWJ6eHAocFSjxFMe9w7uEFSqJdzbvQI5t5ER8Mz/vLy3m5eAWjCorNXQAEicS9
3hsegp9nql1377tb5OljPIW1Ei5bHGVdYLOaLXltNSrGvP9P+AD2Zyb9jPAuUwMy
D43YN7amk5dstiSP6bhvJkTUbGQthrKZAny05EC79jK/cP8PfbsgMlRAwMrG/I69
3kHdM8NpTH3fHdfghsPbo+5CiTwmoWQyIKgpB+DLehp2FHSQx9SDPJBa0ccFF3VG
coqS+C8szMJGGHdAR/W5w1uHXFOcWogIMt9Yz8P0JBJfcpwDNGZhGYkP/9uBa1B1
a3hZTRuFEIS3da28XG7cwuxLds+oeNIAnTvnv34pS7IpVi4nJVmWHvie9q8M3TJX
6a6tnV5TE1F22f5RSEtD
=LKjW
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
