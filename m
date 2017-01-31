Received: from eggs.gnu.org ([2001:4830:134:3::10]:58393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYhf7-0007bp-2S
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYhf6-0007ls-7N
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:16:33 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-23-vsementsov@virtuozzo.com>
	<b24dd2ce-2472-d170-2d09-dbe2bf85edd8@redhat.com>
	<aaf5add3-f612-b504-5589-442ec432366f@virtuozzo.com>
	<66c726b0-3ee4-36fa-9842-b2729733172b@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f9b4dbf0-beda-8e5e-7b0f-57ee9e381be4@redhat.com>
Date: Wed, 1 Feb 2017 00:16:20 +0100
MIME-Version: 1.0
In-Reply-To: <66c726b0-3ee4-36fa-9842-b2729733172b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qKqJGdrW7CG7DAFVrX9AD7RkXBuvR2OLM"
Subject: Re: [Qemu-devel] [PATCH 22/24] block/dirty-bitmap: deep release
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qKqJGdrW7CG7DAFVrX9AD7RkXBuvR2OLM
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <f9b4dbf0-beda-8e5e-7b0f-57ee9e381be4@redhat.com>
Subject: Re: [PATCH 22/24] block/dirty-bitmap: deep release dirty bitmaps
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-23-vsementsov@virtuozzo.com>
 <b24dd2ce-2472-d170-2d09-dbe2bf85edd8@redhat.com>
 <aaf5add3-f612-b504-5589-442ec432366f@virtuozzo.com>
 <66c726b0-3ee4-36fa-9842-b2729733172b@redhat.com>
In-Reply-To: <66c726b0-3ee4-36fa-9842-b2729733172b@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 01.02.2017 00:00, Max Reitz wrote:
> On 31.01.2017 17:03, Vladimir Sementsov-Ogievskiy wrote:

[...]

>> I've started to rewrite it in that way and it seems like deep almost
>> always will be false. What about just move call to
>> bs->drv->bdrv_remove_persistent_dirty_bitmap() directly to
>> qmp_block_dirty_bitmap_remove and add parameter
>> 'remove_persistent' (or 'remove_from_storage', to make it maximum
>> descriptive) only to this qmp command?
>=20
> Or you could add an explicit bdrv_remove_persistent_dirty_bitmap() whic=
h
> just wraps the bs->drv function.
>=20
>> Or even without that parameter, as leaving inconsistent version of
>> bitmap in the storage doesn't seem useful.
>=20
> Hm, right, the bitmap will be automatically removed from the image once=

> it's closed, right?

[No, it won't.]

But you're right, if a persistent bitmap is completely removed by the
user, it should probably be always removed from the image file, too.

The only use I could think of for dropping a bitmap from memory but
wanting to keep it in the file is for keeping it at a certain state. It
would make more sense to allow the user to disable a bitmap to achieve
this, though.

We don't have a block-dirty-bitmap-disable command yet, though, but I
guess it shouldn't be too hard to add...?

(Anyway, it's something that's out of scope for this series, I think.)

Max


--qKqJGdrW7CG7DAFVrX9AD7RkXBuvR2OLM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRGsQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AmtoH/RTws3owHmCauaqSnqW3lURvcbtEvgpt
IIfcIwpr6knwm+ZNqmLMiHZFGAelLsio8a4zefpE9GHwCKqi1CcVhT/RNZDgPKLg
YEqPxFLzOgWhmmeoZQHYLTYCWyYofO1H1mUZDPyfXR5/za689R3hmNe07rk/Dx+z
+QWbjwUU9AM/yl5+1wERMuI5/Y7Vz70Hvc4uMjyLzptuLyn7hq1zJ0V7wU8PhakN
9FhC/VfcnHeM+cJIX4j7G79jdpddc1akE6LDwenfxtD9x5uYTIv+JFVlxTXYtP8P
xCVJS10y7u8CwdU6CCFgTM67wVV8QZjUfpcXJkR/ZMcOr28Lh2NqH94=
=N9FS
-----END PGP SIGNATURE-----

--qKqJGdrW7CG7DAFVrX9AD7RkXBuvR2OLM--
