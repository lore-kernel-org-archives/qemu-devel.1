Received: from eggs.gnu.org ([2001:4830:134:3::10]:34496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyF0i-0005TE-Sq
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyF0h-0004CA-Ks
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:33:12 -0400
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-5-mreitz@redhat.com>
	<w5136uot46b.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3ed9672d-12ba-1a89-e960-617e779bcba9@redhat.com>
Date: Fri, 7 Sep 2018 13:32:58 +0200
MIME-Version: 1.0
In-Reply-To: <w5136uot46b.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JaWbRBeQOVQLNwt27nMPfvCmxkGTR6xZQ"
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 04/31] block: Add
 BDS.auto_backing_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JaWbRBeQOVQLNwt27nMPfvCmxkGTR6xZQ
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <3ed9672d-12ba-1a89-e960-617e779bcba9@redhat.com>
Subject: Re: [PATCH for-3.1 v10 04/31] block: Add BDS.auto_backing_file
References: <20180809213528.14738-1-mreitz@redhat.com>
 <20180809213528.14738-5-mreitz@redhat.com>
 <w5136uot46b.fsf@maestria.local.igalia.com>
In-Reply-To: <w5136uot46b.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-05 16:22, Alberto Garcia wrote:
> On Thu 09 Aug 2018 11:35:01 PM CEST, Max Reitz wrote:
>> If the backing file is overridden, this most probably does change the
>> guest-visible data of a BDS.  Therefore, we will need to consider this=

>> in bdrv_refresh_filename().
>>
>> To see whether it has been overridden, we might want to compare
>> bs->backing_file and bs->backing->bs->filename.  However,
>> bs->backing_file is changed by bdrv_set_backing_hd() (which is just us=
ed
>> to change the backing child at runtime, without modifying the image
>> header), so bs->backing_file most of the time simply contains a copy o=
f
>> bs->backing->bs->filename anyway, so it is useless for such a
>> comparison.
>=20
> What's the point of bs->backing_file then? In what cases is it differen=
t
> from backing->bs->filename?

Good question!  Yes, why?

One thing is when you have detached the backing file, bs->backing_file
will stay the same, even though backing is now NULL.  But that is pretty
much useless, I couldn't find any part in the block layer which relies
on this.

The other is... Fun.  When you create the BDS, it is different, because
the format driver will just put the filename it got from the image
header there.  So imagine you have this configuration:

$ mkdir foo
$ qemu-img create -f qcow2 foo/base.qcow2 64M
$ qemu-img create -f qcow2 -b base.qcow2 foo/top.qcow2

Now when you open foo/top.qcow2, backing_file will contain "base.qcow2"
at first.  This is what bdrv_open_backing_file() expects (because that's
what bdrv_get_full_backing_filename() is for).

But when the backing BDS is attached, bdrv_set_backing_hd() (through
bdrv_backing_attach()) will update backing_file to "foo/base.qcow2" (or
probably the absolute equivalent, I can't remember).

That seems really pointless to me, and after more investigation, I
couldn't find any reason for why bdrv_backing_attach() should update
backing_file.  Especially considering this behavior breaks things, like
bdrv_find_backing_image(), which again would expect "base.qcow2" (i.e. a
filename relative to the overlay).

So in short, functions in the block layer that query backing_file
generally expect it to be what's in the image header; while on the other
hand functions that set backing_file ignore that expectation half of the
time.


So consequentially, there is a "block: Leave BDS.backing_file constant"
patch in my "block: Deal with filters" series.  It makes backing_file
always report what the image header says.


Now you will probably ask: OK, nice, but why do you still need
auto_backing_file then?  Wouldn't that change be enough to just use
backing_file?

The issue here is that the image header may contain a filename that
bdrv_refresh_filename() will transform.  Say your image header says
"nbd:localhost:10809" for the backing file.  So that's what backing_file
will report, too.  bdrv_refresh_filename() however will make
backing->bs->filename report "nbd://localhost:10809".  So if you'd
compare backing_file against backing->bs->filename, you'd see a
difference and you'd have to assume the backing file was overridden,
when in fact it wasn't.

That's what we still need auto_backing_file for: It does not always
reflect the image header, instead it is supposed to reflect the
bdrv_refresh_filename() result for the BDS that is opened when you open
the backing filename given in the image header.

(At least that would be desirable; we cannot always conform to that
specification, but we'll try at least.)

Max


--JaWbRBeQOVQLNwt27nMPfvCmxkGTR6xZQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluSYeoACgkQ9AfbAGHV
z0A9eAf+Pkwe2cRHdnHhNarKJ0BNNv75bfgSEMNH7RH6B/zyRtxhwSLYyVl16PZy
8ps7G5bH5vT0oQApKDSg1RzqT9/SG1qF/3OHEtBezL5SKOQKoYHolFJuBQPrn4K/
b9Vxo//dnzZvrtwe/h/PmQKCxMCM/+rm0w6HodMYdf4ap/D9G/j2EQLz1Qe3os1m
vtVWhlDPVSjxtJT7493LAv8CybWxOZQxkCwUMqECz5XhOsRWSCgAJ1yFD4oC0C4+
4qfBD5SADsiRejRBx21WPyzTfCOQWFfeZpkuIf/ZHA8MD57MZnPgloTHIHlTNGbz
/dFXNgc2sa70H7jnRl1HHN84ks0BqQ==
=AQjC
-----END PGP SIGNATURE-----

--JaWbRBeQOVQLNwt27nMPfvCmxkGTR6xZQ--
