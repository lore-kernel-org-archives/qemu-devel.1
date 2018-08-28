Received: from eggs.gnu.org ([2001:4830:134:3::10]:52663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fuex8-0002vM-Tj
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fuex3-0007Ka-0y
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:26:42 -0400
Date: Tue, 28 Aug 2018 16:26:26 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180828142626.GM122225@angien.pipo.sk>
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eWmFpGZayiNrn4FL"
Content-Disposition: inline
In-Reply-To: <20180810162658.6562-2-kwolf@redhat.com>
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com


--eWmFpGZayiNrn4FL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 18:26:57 +0200, Kevin Wolf wrote:
> The block-commit QMP command required specifying the top and base nodes
> of the commit jobs using the file name of that node. While this works
> in simple cases (local files with absolute paths), the file names
> generated for more complicated setups can be hard to predict.
>=20
> This adds two new options top-node and base-node to the command, which
> allow specifying node names instead. They are mutually exclusive with
> the old options.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 24 ++++++++++++++++++------
>  blockdev.c           | 32 ++++++++++++++++++++++++++++++--
>  2 files changed, 48 insertions(+), 8 deletions(-)

While the below is not strictly relevant to this patch usage
block-commit is not possible when using -blockdev. Thus the new
arguments are not very useful otherwise.

With the new options I'm getting:

{"execute":"block-commit",
 "arguments": { "device":"libvirt-3-format",
                "job-id":"libvirt-3-format",
                "top-node":"libvirt-8-format",
                "base-node":"libvirt-9-format",
                "auto-finalize":true,
                "auto-dismiss":false},
 "id":"libvirt-16"}

{"id":"libvirt-16",
 "error":{"class":"GenericError",
          "desc":"Block node is read-only"}}

I'm pointing into the backing chain so the files are declared as read-only.

It works just-fine if I open them as read-write with
-blockdev/blockdev-add but that obviously is not correct as you can't
then share parts of the backing chain with other VMs due to image
locking.

libvirt-3-format is read-write and all other node names are readonly in
the above example.

The same also happens when using filenames:

{"execute":"block-commit",
 "arguments" : {"device":"libvirt-3-format",
                "job-id":"libvirt-3-format",
                "top":"/var/lib/libvirt/images/rhel7.3.1483615252",
                "base":"/var/lib/libvirt/images/rhel7.3.1483605924",
                "auto-finalize":true,
                "auto-dismiss":false},
 "id":"libvirt-13"}

{"id":"libvirt-13","error":{"class":"GenericError","desc":"Block node is re=
ad-only"}}


When I use the drive alias rather than the node-name for the 'device'
argument it works as expected.

{"execute":"block-commit",
 "arguments": { "device":"drive-virtio-disk0",
                "job-id":"drive-virtio-disk0",
                "top":"/var/lib/libvirt/images/rhel7.3.1483536402",
                "base":"/var/lib/libvirt/images/rhel7.3.1483545313"},
 "id":"libvirt-18"}


I was not able to find anything which would allow to reopen the file R/W
in case of the block-commit operation, but I suspect it should be done
automatically as previously it was done that way prior to -blockdev.

Peter

--eWmFpGZayiNrn4FL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAluFW48ACgkQHGwCByjY
1GougQ/6A4jFDsp60GLDGVHihjot8tB2z4MrnqGbIA3ebQ6XnRFqdX8DR72Tli8v
iUAwEg2PiPNX1P4ToeBxXwB5cTTWnmwzU+J+8oDF2qJy6E7SwLA/U6Z9LsD/32ds
yudMrYM/RJYICeBkEObFcblH+RaghJLsTWdjReyAAurepF1bk1Xhyc9OyM0YL5/7
Z/zMPwhhWBpI5Yoq59viTIIXTKtoZGW8VaKy7PrY9nNXZZcif12ZmvEkR4W0t84m
hq+0hR5w9oQInDULPoRwVVxXRVAnE/PdLy90QPOClDuzHUpvnwGWWi3LRdpkAkQS
nFeB1OzkDQ2Zh7Ylc0txapJ9w+rAORECc6yvHC4/ZTOqIIuJn2NEGJy3iPAJ7Rqw
7CSxaPKJBX8IYL2C+pJGWS/fVfTk4mcPW8uTmJ16J4KHQpT13k6IUdXoSGVLjf6k
hsDQ7CpjVeERjakPRWB/PtgDYxEVSss3XmvlWQ5oARmgUzrMpE7Awqb6/Yy+GacA
wxM1nPj/RWiljJDbfkArZWDeFzhvXjqZJJaPRczWh3YESmCNj509i5iexFJ/c9jh
Ln1+JHyrGyvz+55yVhuQTEfjyhRK2MYuOnMjsErZl+yqQVPniaotDg8o4KHl7rP0
sYQ3/ll8/eZMxBiHCMdqxZkFIKQUWFH3DmRDGD15bk7yI2IVd8E=
=Q/vN
-----END PGP SIGNATURE-----

--eWmFpGZayiNrn4FL--
