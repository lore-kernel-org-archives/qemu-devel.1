Received: from eggs.gnu.org ([2001:4830:134:3::10]:45164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNeGr-0004py-6Q
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNeGq-0005ui-BO
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:34:53 -0500
References: <20181011072135.588-1-famz@redhat.com>
	<20181011072135.588-3-famz@redhat.com>
	<w51tvkjkbmc.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8924431e-f533-70bc-4efa-848f9641fbc4@redhat.com>
Date: Fri, 16 Nov 2018 14:34:25 +0100
MIME-Version: 1.0
In-Reply-To: <w51tvkjkbmc.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hDU8kHdobSjONjJpBwKeYQyRoXE0rDXtX"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 2/3] file-posix: Drop
 s->lock_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hDU8kHdobSjONjJpBwKeYQyRoXE0rDXtX
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <8924431e-f533-70bc-4efa-848f9641fbc4@redhat.com>
Subject: Re: [Qemu-block] [PATCH v5 2/3] file-posix: Drop s->lock_fd
References: <20181011072135.588-1-famz@redhat.com>
 <20181011072135.588-3-famz@redhat.com>
 <w51tvkjkbmc.fsf@maestria.local.igalia.com>
In-Reply-To: <w51tvkjkbmc.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.11.18 14:54, Alberto Garcia wrote:
> On Thu 11 Oct 2018 09:21:34 AM CEST, Fam Zheng wrote:
>> The lock_fd field is not strictly necessary because transferring locke=
d
>> bytes from old fd to the new one shouldn't fail anyway. This spares th=
e
>> user one fd per image.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> One of my tests (not published yet) starts to fail after this
> patch. Here's how you can reproduce the error:
>=20
> $ qemu-img create -f qcow2 hd.qcow2 4G
> $ qemu-system-x86_64 -qmp stdio
>=20
> { "execute": "qmp_capabilities" }
> { "execute": "blockdev-add", "arguments": {"driver": "qcow2", "node-nam=
e": "hd0", "file": {"driver": "file", "filename": "hd.qcow2", "locking": =
"on" }}}
> { "execute": "human-monitor-command", "arguments": {"command-line": "qe=
mu-io hd0 \"reopen -o file.locking=3Don\""}}
> { "execute": "human-monitor-command", "arguments": {"command-line": "qe=
mu-io hd0 \"reopen -o file.locking=3Doff\""}}
> { "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
> { "execute": "blockdev-add", "arguments": {"driver": "qcow2", "node-nam=
e": "hd0", "file": {"driver": "file", "filename": "hd.qcow2"}}}
>=20
> {"error": {"class": "GenericError", "desc": "Failed to get \"consistent=
 read\" lock"}}

To me that looks like a problem in the general reopen code.
raw_reopen_prepare() is called and succeeds.  Then bdrv_reopen_prepare()
notices the option wasn't handled and therefore fails.
bdrv_reopen_multiple() thus doesn't set bs_entry->prepared to true,
which means raw_reopen_abort() won't be called.

We should always call either BlockDriver.bdrv_reopen_commit() or
BlockDriver.bdrv_reopen_abort() when BlockDriver.bdrv_reopen_prepare()
succeeded.

Max


--hDU8kHdobSjONjJpBwKeYQyRoXE0rDXtX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvux2EACgkQ9AfbAGHV
z0CgDwgAg3OUcL8aLEIT7K1YEwxl1heWeILKSyGKLiuKZvnKkPeV4br95FoVdb7D
gbMGLZDINIlK8+VooI9ruEGZnLHeiwGWNiAxygwTOt+chxcYjHwMLnimlc8JxxBO
B9sfUUCppMGr74UViaJrW+YWEGo7f7nLt++YuHGaVVy97J+dc290Vuf6c8nQTFfE
f4w3nguZ8j8ts7376U/BeuHH+6YL/rDw5jJAU3uAd7aXE4Vk7BbVxKfxZOQJrMta
6vJJ0c6eqmLJCW8VstbDJxtaIvyWBsxIrCC+OvBWqkRz2TkYplLu14IGVhe10gPG
cfTRHUnYk0ENictwkjXxUt4A+VPHiQ==
=95wp
-----END PGP SIGNATURE-----

--hDU8kHdobSjONjJpBwKeYQyRoXE0rDXtX--
