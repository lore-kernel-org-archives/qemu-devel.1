Received: from eggs.gnu.org ([209.51.188.92]:34306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGoFT-0005oa-SB
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGoFP-0008Gb-3B
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:21:25 -0400
Date: Wed, 17 Apr 2019 18:21:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190417172109.GW7535@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190401145741.28322-1-eblake@redhat.com>
	<d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
	<39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2] qemu-img: Saner printing of
 large file sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Apr 17, 2019 at 11:58:57AM -0500, Eric Blake wrote:
> On 4/10/19 2:28 PM, Max Reitz wrote:
> > On 01.04.19 16:57, Eric Blake wrote:
> >> Disk sizes close to INT64_MAX cause overflow, for some pretty
> >> ridiculous output:
> >>
> >>   $ ./nbdkit -U - memory size=3D$((2**63 - 512)) --run 'qemu-img inf=
o $nbd'
> >>   image: nbd+unix://?socket=3D/tmp/nbdkitHSAzNz/socket
> >>   file format: raw
> >>   virtual size: -8388607T (9223372036854775296 bytes)
> >>   disk size: unavailable
> >>
>=20
> >=20
> > There are more iotests this breaks.  First, there is 059 for vmdk, wh=
ich
> > looks just like the rest.
>=20
> Easy enough; I was able to reproduce.
>=20
> >=20
> > But for -m32, it gets a bit more difficult.  Every size above 999 GB
> > (1000 GB gets rounded to 1 TB, which is 2^31 * 512) gets printed as
> > "inf [unit]":
>=20
> Ouch - pre-existing bug in size_to_str(); I'll have to fix that, then
> send a v3.
>=20
> Kevin, do you want to unqueue this from block-next until then?
>=20
> >=20
> > But regardless of the iotests, we shouldn=E2=80=99t show the size as =
infinite
> > just because of -m32.
>=20
> Is there an easy docker setup for building -m32?

QEMU has a "fedora-i386-cross" image you can at least do builds in
Hopefully its good enough for make check too

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
