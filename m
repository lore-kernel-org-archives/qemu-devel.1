Received: from eggs.gnu.org ([2001:4830:134:3::10]:40162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fqkKQ-0007BT-RL
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fqkKP-0001yx-SA
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:22:34 -0400
References: <20180815025614.53588-1-eblake@redhat.com>
	<20180815025614.53588-3-eblake@redhat.com>
	<48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
	<4aa899d3-c622-6acf-128c-513f95c55ed5@redhat.com>
	<d8c5df8d-7ae2-8ddc-aa71-38ec06b79988@redhat.com>
	<20180816071515.GC5511@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f349dcef-2a59-8a8c-38d5-641d83833561@redhat.com>
Date: Fri, 17 Aug 2018 21:22:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180816071515.GC5511@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oNdzxwOTZ1kAcIaAKNGxfhJP1BkTAukuW"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: Add dd seek= option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, fullmanet@gmail.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oNdzxwOTZ1kAcIaAKNGxfhJP1BkTAukuW
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 fullmanet@gmail.com, qemu-block@nongnu.org
Message-ID: <f349dcef-2a59-8a8c-38d5-641d83833561@redhat.com>
Subject: Re: [PATCH 2/2] qemu-img: Add dd seek= option
References: <20180815025614.53588-1-eblake@redhat.com>
 <20180815025614.53588-3-eblake@redhat.com>
 <48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
 <4aa899d3-c622-6acf-128c-513f95c55ed5@redhat.com>
 <d8c5df8d-7ae2-8ddc-aa71-38ec06b79988@redhat.com>
 <20180816071515.GC5511@localhost.localdomain>
In-Reply-To: <20180816071515.GC5511@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-08-16 09:15, Kevin Wolf wrote:
> Am 16.08.2018 um 04:49 hat Max Reitz geschrieben:
>> On 2018-08-16 04:39, Eric Blake wrote:
>>> If convert were more powerful, I'd be fine dropping 'qemu-img dd' aft=
er
>>> a proper deprecation period.
>>
>> Technically it has those features already, with the raw block driver's=

>> offset and size parameters.
>=20
> In a way, yes. It requires you to precreate the target image, though,
> because --target-image-opts requires -n.
>=20
> We'll probably want to fix something in this area anyway because in the=

> common case, you already need those options to even precreate the image=
,
> and qemu-img create doesn't support open options for the protocol layer=

> either (unlike blockdev-create).
>=20
>>>> ((That gave me a good idea.=A0 Actually, it's probably not such a go=
od
>>>> idea, but I guess I'll do it in my spare time anyway.=A0 A qemu-img =
fuse
>>>> might be nice which represents an image as a raw image at some mount=

>>>> point.=A0 Benefits over qemu-nbd: (1) You don't need root, (2) you d=
on't
>>>> need to type modprobe nbd.))
>>>
>>> So the kernel->userspace translation would be happening via the FUSE
>>> interface instead of the NBD interface.=A0 Data still bounces around =
just
>>> as much, but it might be a fun project.=A0 Does fuse behave well when=

>>> serving exactly one file at the mountpoint, rather than the more typi=
cal
>>> file system rooted in a directory?=A0 NBD at least has the benefit of=

>>> claiming to be a block device all along, rather than complicating the=

>>> user interface with POSIX file system rules (which you'll be bending,=

>>> because you are serving exactly one file instead of a system).
>=20
> To make it more real, you could expose a snapshots/ subdirectory. Or
> maybe better not.
>=20
>> Well, but I can just pretend my FUSE file is a block device, no?
>>
>> Also, I just discovered something really interesting: FUSE allows you =
to
>> specify a single file as a mountpoint.
>>
>> And you know what?  You can open the original file before you replace =
it
>> by the FUSE "filesystem".
>>
>> So my fun interface is going to looks like this:
>>
>> $ qemu-img fuse foo.qcow2
>>
>> And then your foo.qcow2 is a raw image until the next "fusermount -u
>> foo.qcow2"!  Isn't that fun?
>=20
> Yes, sounds fun. Until you realise that I'd actually like to merge
> something like this when it exists. ;-)

Well, for reference:

https://git.xanclic.moe/XanClic/qemu/commits/branch/qemu-img-fuse

(The main issue now is that you don't see FUSE error messages,
because...  Well.  FUSE likes to fork the daemon process itself, but for
some reason that doesn't really work with qemu.  I don't really want to
investigate that, instead I rather like to declare it broken and launch
FUSE in foreground mode, and then do the forking ourselves (like
qemu-nbd does).  But then we lose all error output from FUSE, because we
have to close stderr before we get to the main loop...

(I suppose I can just look into what fuse_main() does exactly and
replicate that.  The doc says using fuse_main() is just lazy anyway. O:-P=
))

> For a more serious implementation, maybe it should even be a separate
> qemu-fuse rather than a qemu-img subcommand.

True.  It doesn't really fit well into qemu-img.

(To me, qemu-img is about exposing block layer features without the user
having to use qemu proper.  Exporting an image over FUSE really is not a
block layer feature.)

Max


--oNdzxwOTZ1kAcIaAKNGxfhJP1BkTAukuW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt3IG8ACgkQ9AfbAGHV
z0CPrAf6A003gvl9Dz+iiqkvPh0Xxpt7aNH7vu5kpr6NtcyH18+ISHykxxaai9PB
+zfIUnP3fAxEJ0cZsSgXsNzCNr4/kcGE1Y77cvEOkUDJSnzKO5P7CP5bxo5oP/yc
IRPUtlCp3KhFQphL2z2TCtWnjwTywaqA5QDywb6hoQEsxTXgEBeNei6ZOUT1mxu9
fCTlHCeTjv/XgUG6ZadEQifpVi1CspYHnub3sEtO69e72cpjh5wjrx+QcxUJwcec
RPYXDaI/JuL9BElxH8FafQZrQmsAFjEjrVvPBgw8SUJduSa0czg6wx3Z1mutA5mw
rbUlyghqHNwib3j+2iOF/j3XCtB91w==
=o5De
-----END PGP SIGNATURE-----

--oNdzxwOTZ1kAcIaAKNGxfhJP1BkTAukuW--
