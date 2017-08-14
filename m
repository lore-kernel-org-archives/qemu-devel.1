Received: from eggs.gnu.org ([2001:4830:134:3::10]:40393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhEHv-0007hA-6v
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhEHt-0005z4-PX
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:16:07 -0400
Date: Mon, 14 Aug 2017 15:15:14 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170814121514.6gjfu7ehv4ysnjkq@postretch>
References: <w51valyjj7j.fsf@maestria.local.igalia.com>
	<20170808134544.paekftiounmirhbo@postretch>
	<w51poc6jeln.fsf@maestria.local.igalia.com>
	<20170808145620.wlb5rdutuseutclx@postretch>
	<w51mv7aje27.fsf@maestria.local.igalia.com>
	<20170809093612.oee2u5kdgyojheqm@postretch>
	<w51y3qslxyz.fsf@maestria.local.igalia.com>
	<20170809134205.dbkx5cuvjpbaxftv@postretch>
	<w51valwlrzc.fsf@maestria.local.igalia.com>
	<20170809153942.GI4213@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="licm3cphpxrclfbp"
Content-Disposition: inline
In-Reply-To: <20170809153942.GI4213@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--licm3cphpxrclfbp
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 05:39:42PM +0200, Kevin Wolf wrote:
>Am 09.08.2017 um 16:45 hat Alberto Garcia geschrieben:
>> On Wed 09 Aug 2017 03:42:07 PM CEST, Manos Pitsidianakis wrote:
>> > On Wed, Aug 09, 2017 at 02:36:20PM +0200, Alberto Garcia wrote:
>> >>On Wed 09 Aug 2017 11:36:12 AM CEST, Manos Pitsidianakis wrote:
>> >>> On Tue, Aug 08, 2017 at 05:04:48PM +0200, Alberto Garcia wrote:
>> >>>>On Tue 08 Aug 2017 04:56:20 PM CEST, Manos Pitsidianakis wrote:
>> >>>>>>> So basically if we have anonymous groups, we accept limits in the
>> >>>>>>> driver options but only without a group-name.
>> >>>>>>
>> >>>>>>In the commit message you do however have limits and a group name,=
 is
>> >>>>>>that a mistake?
>> >>>>>>
>> >>>>>>    -drive driver=3Dthrottle,file.filename=3Dfoo.qcow2, \
>> >>>>>>           limits.iops-total=3D...,throttle-group=3Dbar
>> >>>>>
>> >>>>> Sorry this wasn't clear, I'm actually proposing to remove limits f=
rom
>> >>>>> the throttle driver options and only create/config throttle groups=
 via
>> >>>>> -object/object-add.
>> >>>>
>> >>>>Sorry I think it was me who misunderstood :-) Anyway in the new
>> >>>>command-line API I would be more inclined to have limits defined usi=
ng
>> >>>>"-object throttle-group" and -drive would only reference the group i=
d.
>> >>>>
>> >>>>I understand that this implies that it wouldn't be possible to create
>> >>>>anonymous groups (at least not from the command line), is that a
>> >>>>problem?
>> >>>
>> >>> We can accept anonymous groups if a user specifies limits but not a
>> >>> group name in the throttle driver. (The only case where limits would
>> >>> be acccepted)
>> >>
>> >>Yeah but that's only if we have the limits.iops-total=3D... options in=
 the
>> >>throttle driver. If we "remove limits from the throttle driver options
>> >>and only create/config throttle groups via -object/object-add" we
>> >>cannot
>> >>do that.
>> >
>> > We can check that groups is not defined at the same time as limits,
>>
>> I'm not sure if I'm following the conversation anymore :-) let's try to
>> recap:
>>
>>   a) Groups are defined like this (with the current patches):
>>
>>      -object throttle-group,id=3Dfoo,x-iops-total=3D100,x-..
>>
>>   b) Throttle nodes are defined like this:
>>
>>      -drive driver=3Dthrottle,file.filename=3Dfoo.qcow2, \
>>             limits.iops-total=3D...,throttle-group=3Dbar
>>
>>   c) Therefore limits can be defined either in (a) or (b)
>>
>>   d) If we omit throttle-group=3D... in (b), we would create an anonymous
>>      group.
>>
>>   e) The -drive syntax from (b) has the "problem" that it's possible to
>>      define several nodes with the same throttling group but different
>>      limits. The last one would win (as the legacy syntax does), but
>>      that's not something completely straightforward for the end user.
>>
>>   f) The syntax from (b) also has the problem that there's one more
>>      place that needs code to parse throttling limits.
>>
>>   g) We can solve (e) and (f) if we remove the limits.* options
>>      altogether from the throttling filter. In that case you would need
>>      to define a throttle-group object and use the throttle-group option
>>      of the filter node in all cases.
>>
>>   h) If we remove the limits.* options we cannot have anonymous groups
>>      anymore (at least not using this API). My question is: is it a
>>      problem? What would we lose? What benefits do anonymous groups
>>      bring us?
>
>As I understand it, basically only the convenience of begin able to
>specify a limit directly in -drive rather than having to create an
>-object and reference its ID.
>
>>   i) We can of course maintain the limits.* options, but disallow
>>      throttle-group when they are present. That way we would allow
>>      anonymous groups and we would solve the ambiguity problem described
>>      in (e). My question is: is it worth it?
>
>Maybe not. Depends on how important we consider the convenience feature.
>
>> >>> Not creating eponymous throttle groups via the throttle driver means
>> >>> we don't need throttle_groups anymore, since even anonymous ones
>> >>> don't need to be accounted for in a list.
>> >>
>> >>I don't follow you here, how else do you get a group by its name?
>> >
>> > If all eponymous groups are managed by the QOM tree, we should be able
>> > to iterate over the object root container for all ThrottleGroups just
>> > like qmp_query_iothreads() in iothread.c
>>
>> Mmm... can't we actually use the root container now already? (even with
>> anonymous groups I mean). Why do we need throttle_groups?
>
>Anonymous groups don't have a parent, so they aren't accessible through
>the root container.

Anonymous groups wouldn't have to be in any kind of list, since they
shouldn't be accessible by others and they don't have a name. They have
a refcount of 1 and are owned by their filter node.
(throttle_groups is used in throttle_group_incref() to fetch a tg with a
name and increase its reference count). They will also not be accessible
with qom-set and qom-get.

I've prepared the root container change and will include it in the next=20
revision.  Do we go with anonymous groups and disallow limits.* with=20
throttle-group, or do we drop anonymous groups altogether?

--licm3cphpxrclfbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmRlFEACgkQc2J8L2kN
9xD54w/8COIxJv0DpshgoCcgl+venGQ762LwNDoxQ3EZgW+up+SPsl4bt4Sxy8IX
mfElrKxUa7xlMHn4ujnOQeu2DW0ftUWQbRaVz1rLHJ+bZ7rBYCtNfw3tT5rhwBdJ
aB3jkcSBlsDOLyVWQWcsh54HDYSsv3J3woUSUjF79DfmT6MFVECJi7bWar2UpDb5
gOF7UNOOalJhvG36Nd7b1vrg0R1TyMY19BgLl60JGXjygYJBISZC0VeWE4T/qdPR
xd/fBSd9UUOlosouia6NjgEA9nPT1NNzaQyQHf8KVzCj+UBL6nn2Scn6qLhyxjls
pdtUqFdPAtWMbtd9Dbom6nelYZbWzvh9Px+WYyIP5WOnQ+GHP7OzVlG1e4aKYBeL
uNAuDe5mouytQXCwlEg2yDyUR6mfFC4BttDXuVr2fRJxLw0aWadIXDQYfFLE7fOp
c6fzEX9nvG29q3ddOzjIoYUrZqNX7V6tAeOxJxLcr8rQ+tNWo2CvZW6rWqspwZaK
HaeSLvXkPzx5XuWC7Clztjw7gEY0WWbT01GEYH0wL3XUEDe99FBWSOYGhlQ973tM
LzF0rqrx3YS+s5dOoBPdeSAd8EbuJWEpqwsHU7jgKPdfWqNoKPbP9knOhbq7B0h5
CjG2zuNzqDavJsKA9sEID7FA6qflVHbQ0TYT7v1ZVEExhjYjzi4=
=Q9U8
-----END PGP SIGNATURE-----

--licm3cphpxrclfbp--
