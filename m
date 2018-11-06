Received: from eggs.gnu.org ([2001:4830:134:3::10]:34907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJpdC-0001yn-AU
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 19:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJpdB-0002sa-C7
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 19:54:10 -0500
References: <20181019113424.25727-1-armbru@redhat.com>
	<d370d182-01c8-f4ab-ed63-207a9dc4c4d6@redhat.com>
	<87r2fz5ywu.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3b245d71-abe1-9ae2-1671-7d29a1676d70@redhat.com>
Date: Tue, 6 Nov 2018 01:54:00 +0100
MIME-Version: 1.0
In-Reply-To: <87r2fz5ywu.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J2yFul0tjXWA87RPly1p2oICQbOAL3vnX"
Subject: Re: [Qemu-devel] [PATCH] block: Make more block drivers
 compile-time configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jeff@codyprime.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J2yFul0tjXWA87RPly1p2oICQbOAL3vnX
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jeff@codyprime.org,
 qemu-block@nongnu.org
Message-ID: <3b245d71-abe1-9ae2-1671-7d29a1676d70@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Make more block drivers compile-time
 configurable
References: <20181019113424.25727-1-armbru@redhat.com>
 <d370d182-01c8-f4ab-ed63-207a9dc4c4d6@redhat.com>
 <87r2fz5ywu.fsf@dusky.pond.sub.org>
In-Reply-To: <87r2fz5ywu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.11.18 16:25, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 19.10.18 13:34, Markus Armbruster wrote:
>>> From: Jeff Cody <jcody@redhat.com>
>>>
>>> This adds configure options to control the following block drivers:
>>>
>>> * Bochs
>>> * Cloop
>>> * Dmg
>>> * Qcow (V1)
>>> * Vdi
>>> * Vvfat
>>> * qed
>>> * parallels
>>> * sheepdog
>>>
>>> Each of these defaults to being enabled.
>>>
>>> Signed-off-by: Jeff Cody <jcody@redhat.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>
>>> Hmm, we got quite a few --enable-BLOCK-DRIVER now.  Perhaps a single
>>> list-valued option similar --target-list would be better.  Could be
>>> done on top.
>>>
>>>  block/Makefile.objs | 22 ++++++++---
>>>  configure           | 91 +++++++++++++++++++++++++++++++++++++++++++=
++
>>>  2 files changed, 107 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>>> index c8337bf186..1cad9fc4f1 100644
>>> --- a/block/Makefile.objs
>>> +++ b/block/Makefile.objs
>    @@ -1,10 +1,18 @@
>    -block-obj-y +=3D raw-format.o qcow.o vdi.o vmdk.o cloop.o bochs.o v=
pc.o vvfat.o dmg.o
>    +block-obj-y +=3D raw-format.o vmdk.o vpc.o
>    +block-obj-$(CONFIG_QCOW1) +=3D qcow.o
>    +block-obj-$(CONFIG_VDI) +=3D vdi.o
>    +block-obj-$(CONFIG_CLOOP) +=3D cloop.o
>    +block-obj-$(CONFIG_BOCHS) +=3D bochs.o
>    +block-obj-$(CONFIG_VVFAT) +=3D vvfat.o
>    +block-obj-$(CONFIG_DMG) +=3D dmg.o
>    +
>     block-obj-y +=3D qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-sna=
pshot.o qcow2-cache.o qcow2-bitmap.o
>>
>> [...]
>>
>>> @@ -45,7 +54,8 @@ gluster.o-libs     :=3D $(GLUSTERFS_LIBS)
>>>  vxhs.o-libs        :=3D $(VXHS_LIBS)
>>>  ssh.o-cflags       :=3D $(LIBSSH2_CFLAGS)
>>>  ssh.o-libs         :=3D $(LIBSSH2_LIBS)
>>> -block-obj-$(if $(CONFIG_BZIP2),m,n) +=3D dmg-bz2.o
>>> +block-obj-dmg-bz2$(if $(CONFIG_BZIP2),m,n) +=3D dmg-bz2.o
>>> +block-obj-$(CONFIG_DMG) +=3D $(block-obj-dmg-bz2-y)
>>
>> This defines "block-obj-dmg-bz2m" or "block-obj-dmg-bz2n", so
>> "block-obj-dmg-bz2-y" is never defined (note both the missing hyphen a=
nd
>> the "m" vs. "y").
>>
>> How about:
>>
>> block-obj-dmg-bz2-$(CONFIG_BZIP2) +=3D dmg-bz2.o
>=20
> As far as I can tell, CONFIG_BZIP2 is either undefined or "y".  Thus,
> block-obj-dmg-bz2-y is either left undefined or set to dmg-bz2.o.

Yes.

> Perhaps the '+=3D' be ':=3D', but we seem to use '+=3D' pretty
> indiscriminately.

Yep.  I don't know.  Whatever works, and both do, so...

>> block-obj-$(if $(CONFIG_DMG),m,n) +=3D $(block-obj-dmg-bz2-y)
>=20
> As far as I can tell, CONFIG_DMG is also either undefined or "y".  So,
> this adds dmg-bz2.o to block-obj-m if both CONFIG_BZIP2 and CONFIG_DMG
> are enabled.

Yes.

> Shouldn't it be added to block-obj-y, like dmg.o, or am I confused?

The behavior before this patch was to add it to block-obj-m.
27685a8dd08c051fa6d641fe46106fc0dfa51073 has the explanation: We want
the bz2 part to be a module so you can launch qemu even without libbz2
around.  Only when you use dmg will it load that module.

(And if you dig deeper, it was 88d88798b7efe that (intentionally) broke
 that intended behavior, until it was restored by the above commit.)

>> Bonus point: The "+=3D" are naturally aligned!
>=20
> Woot!

:-)

Max

>> (Fun fact on the side: I tried downloading some dmg image, but qemu
>> refused to open that.  ("sector count 409600 for chunk 4 is larger tha=
n
>> max (131072)" -- yeah, yeah, I know that I'm not the largest guy) -- b=
ut
>> you can test it just by replacing "dmg-bz2.o" by "does-not-exist.o", a=
nd
>> then make complains normally, but stops complaining with --disable-dmg=

>> or --disable-bzip2.)
>=20
> Thanks!
>=20



--J2yFul0tjXWA87RPly1p2oICQbOAL3vnX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvg5igACgkQ9AfbAGHV
z0DF6Af+MCzvjkQHOvQy7VWAWbdNbhvFkOyPIKWSuF+LvXMr+QBCN4PJ5MuH9gHf
I//9pNQ4Dm3Uuw3W992sZypdBp5qLQm90ZyxGSQl5H9VfffZNWpLAPB9HW4Y1bv8
F6rW075HRJEwpypeDi85RdXe1QtzJHmou4WeYveEHOp5qQpTpfXIBefxsROYuKCV
Lm4Mg5yNMPWVR1BWzbXsR1AJnrV8uP8c5/R7iTPGCvBvUFrN9zngcZaYOz0FtmWP
3VsSLhuKVoqP1XiJtbNDi5pMqJe7MMoLiqzMT3D3XlDsZQvoM/vZz29lVRjnyULV
a9qmmacakrjROANGUtHDZfZWYszLcA==
=G+8T
-----END PGP SIGNATURE-----

--J2yFul0tjXWA87RPly1p2oICQbOAL3vnX--
