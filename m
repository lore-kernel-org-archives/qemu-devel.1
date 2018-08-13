Received: from eggs.gnu.org ([2001:4830:134:3::10]:50843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpEVG-0005DA-Lc
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpEVE-0005Qy-Oi
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:11:30 -0400
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-7-lbloch@janustech.com>
	<w5136vm8m8u.fsf@maestria.local.igalia.com>
	<ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
	<20180813112333.GD4323@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e9a77f1e-6b9e-3fea-69c9-c18638961a2e@redhat.com>
Date: Mon, 13 Aug 2018 17:11:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180813112333.GD4323@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="doyBnZH1Kqe8RpyANkz7sqhxiZ3iW7c9U"
Subject: Re: [Qemu-devel] [PATCH v7 6/9] qcow2: Increase the default upper
 limit on the L2 cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--doyBnZH1Kqe8RpyANkz7sqhxiZ3iW7c9U
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Message-ID: <e9a77f1e-6b9e-3fea-69c9-c18638961a2e@redhat.com>
Subject: Re: [PATCH v7 6/9] qcow2: Increase the default upper limit on the L2
 cache size
References: <20180810062647.23211-1-lbloch@janustech.com>
 <20180810062647.23211-7-lbloch@janustech.com>
 <w5136vm8m8u.fsf@maestria.local.igalia.com>
 <ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
 <20180813112333.GD4323@localhost.localdomain>
In-Reply-To: <20180813112333.GD4323@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-08-13 13:23, Kevin Wolf wrote:
> Am 13.08.2018 um 03:39 hat Max Reitz geschrieben:
>> On 2018-08-10 14:00, Alberto Garcia wrote:
>>> On Fri 10 Aug 2018 08:26:44 AM CEST, Leonid Bloch wrote:
>>>> The upper limit on the L2 cache size is increased from 1 MB to 32 MB=
=2E
>>>> This is done in order to allow default full coverage with the L2 cac=
he
>>>> for images of up to 256 GB in size (was 8 GB). Note, that only the
>>>> needed amount to cover the full image is allocated. The value which =
is
>>>> changed here is just the upper limit on the L2 cache size, beyond wh=
ich
>>>> it will not grow, even if the size of the image will require it to.
>>>>
>>>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
>>>
>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>>
>>>> -#define DEFAULT_L2_CACHE_MAX_SIZE (1 * MiB)
>>>> +#define DEFAULT_L2_CACHE_MAX_SIZE (32 * MiB)
>>>
>>> The patch looks perfect to me now and I'm fine with this change, but
>>> this is quite an increase from the previous default value. If anyone
>>> thinks that this is too aggressive (or too little :)) I'm all ears.
>>
>> This is just noise from the sidelines (so nothing too serious), but
>> anyway, I don't like it very much.
>>
>> My first point is that the old limit doesn't mean you can only use 8 G=
B
>> qcow2 images.  You can use more, you just can't access more than 8 GB
>> randomly.  I know I'm naive, but I think that the number of use cases
>> where you need random IOPS spread out over more than 8 GB of an image
>> are limited.
>=20
> I think I can see use cases for databases that are spead across more
> than 8 GB.

Sure, there are use cases.  But that's not quite the general case, that
was my point.

>            But you're right, it's a tradeoff and users can always
> increase the cache size in theory if they need more performance. But
> then, they can also decrease the cache size if they need more memory.

True.  But the issue here is: When your disk performance drops, you are
likely to look into what causes your disk to be slow.  Maybe you're lazy
and switch to raw.  Maybe you aren't and discover that the cache may be
an issue, so you adjust those options to your needs.

When your RAM runs low, at least I would never think of some disk image
cache, to be honest.  So I probably would either not use qemu or
increase my swap size.

> Let's be honest: While qcow2 does have some room for functional
> improvements, it mostly has an image problem, which comes from the fact=

> that there are cases where performance drops drastically. Benchmarks ar=
e
> a very important use case and they do random I/O over more than 8 GB.

As long as it's our benchmarks, setting the right options is easy. O:-)

> Not properly supporting such cases out-of-the-box is the reason why
> people are requesting that we add features to raw images even if they
> require on-disk metadata. If we want to avoid this kind of nonsense, we=

> need to improve the out-of-the-box experience with qcow2.

Reasonable indeed.

>> My second point is that qemu still allocated 128 MB of RAM by default.=

>> Using 1/4th of that for every qcow2 image you attach to the VM seems a=

>> bit much.
>=20
> Well, that's more because 128 MB is ridiculously low today and you won'=
t
> be able to run any recent guest without overriding the default.

I'm running my L4Linux just fine over here! O:-)

My point here was -- if the default RAM size is as low as it is (and
nobody seems to want to increase it), does it make sense if we try to
increase our defaults?

I suppose you could say that not adjusting the RAM default is a bad
decision, but it's not our decision, so there's nothing we can do about
that.

I suppose you could also say that adjusting the RAM size is easier than
adjusting the qcow2 cache size.

So, yeah.  True.

>> Now it gets a bit complicated.  This series makes cache-clean-interval=

>> default to 10 minutes, so it shouldn't be an issue in practice.  But o=
ne
>> thing to note is that this is a Linux-specific feature, so on every
>> other system, this really means 32 MB per image.
>=20
> That's a bit inaccurate in this generality: On non-Linux, it means 32 M=
B
> per fully accessed image with a size >=3D 256 GB.
>=20
>> (Also, 10 minutes means that whenever I boot up my VM with a couple of=

>> disks with random accesses all over the images during boot, I might
>> end up using 32 MB per image again (for 10 min), even though I don't
>> really need that performance.)
>=20
> If your system files are fragmented in a way that a boot will access
> every 512 MB chunk in a 256 GB disk, you should seriously think about
> fixing that...
>=20
> This is a pathological case that shouldn't define our defaults. Random
> I/O over 256 GB is really a pathological case, too, but people are
> likely to actually test it. They aren't going to systematically test a
> horribly fragmented system that wouldn't happen in reality.

True.

>> Now if we really rely on that cache-clean-interval, why not make it
>> always cover the whole image by default?  I don't really see why we
>> should now say "256 GB seems reasonable, and 32 MB doesn't sound like
>> too much, let's go there".  (Well, OK, I do see how you end up using 3=
2
>> MB as basically a safety margin, where you'd say that anything above i=
t
>> is just unreasonable.)
>>
>> Do we update the limit in a couple of years again because people have
>> more RAM and larger disks then?  (Maybe we do?)
>=20
> Possibly. I see those defaults as values that we can adjust to reality
> whenever we think the old values don't reflect the important cases well=

> enough any more.

OK.

>> My personal opinion is this: Most users should be fine with 8 GB of
>> randomly accessible image space (this may be wrong).  Whenever a user
>> does have an application that uses more than 8 GB, they are probably i=
n
>> an area where they want to do some performance tuning anyway.  Requiri=
ng
>> them to set l2-cache-full in that case seems reasonable to me.
>=20
> In principle, I'd agree. I'd even say that management tools should
> always explicitly set those options instead of relying on our defaults.=

> But management tools have been ignoring these options for a long time
> and keep doing so.
>=20
> And honestly, if you can't spend a few megabytes for the caches, it's
> just as reasonable that you should set l2-cache to a lower value. You'l=
l
> need some more tweaking anyway to reduce the memory footprint.

It isn't, because as I explained above, it is more reasonable to expect
people to find out about disk options because their disk performance is
abysmal than because their RAM is exhausted.

I would like to say "but it is nearly as reasonable", but I really don't
think so.

>> Pushing the default to 256 GB to me looks a bit like just letting them=

>> run into the problem later.  It doesn't solve the issue that you need
>> to do some performance tuning if you have a bit of a special use case
>> (but maybe I'm wrong and accessing more than 8 GB randomly is what
>> everybody does with their VMs).
>>
>> (Maybe it's even a good thing to limit it to a smaller number so users=

>> run into the issue sooner than later...)
>=20
> Definitely not when their management tool doesn't give them the option
> of changing the value.

That is true.

> Being slow makes qcow2 look really bad. In contrast, I don't think I've=

> ever heard anyone complain about memory usage of qcow2.

Yeah, because it never was an issue.  It might (in theory) become now.

Also note again that people might just not realize the memory usage is
due to qcow2.

>                                                         Our choice of a=

> default should reflect that, especially considering that we only use
> the memory on demand. If your image is only 32 GB, you'll never use mor=
e
> than 4 MB of cache.

Well, OK, yes.  This is an especially important point when it really is
about hosts that have limited memory.  In those cases, users probably
won't run huge images anyway.

>                     And if your image is huge, but only access part of
> it, we also won't use the full 32 MB.

On Linux. O:-)

>> OTOH, this change means that everyone on a non-Linux system will have =
to
>> use 32 MB of their RAM per qcow2 image, and everyone on a Linux system=

>> will potentially use it e.g. during boot when you do access a lot
>> randomly (even though the performance usually is not of utmost
>> importance then (important, but not extremely so)).  But then again,
>> this will probably only affect a single disk (the one with the OS on
>> it), so it won't be too bad.
>>
>> So my stance is:
>>
>> (1) Is it really worth pushing the default to 256 GB if you probably
>> have to do a bit of performance tuning anyway when you get past 8 GB
>> random IOPS?  I think it's reasonable to ask users to use l2-cache-ful=
l
>> or adjust the cache to their needs.
>>
>> (2) For non-Linux systems, this seems to really mean 32 MB of RAM per
>> qcow2 image.  That's 1/4th of default VM RAM.  Is that worth it?
>>
>> (3) For Linux, I don't like it much either, but that's because I'm
>> stupid.  The fact that if you don't need this much random I/O only you=
r
>> boot disk may cause a RAM usage spike, and even then it's going to go
>> down after 10 minutes, is probably enough to justify this change.
>>
>>
>> I suppose my moaning would subside if we only increased the default on=

>> systems that actually support cache-clean-interval...?

So it's good that you have calmed my nerves about how this might be
problematic on Linux systems (it isn't in practice, although I disagree
that people will find qcow2 to be the fault when their memory runs out),
but you haven't said anything about non-Linux systems.  I understand
that you don't care, but as I said here, this was my only substantial
concern anyway.

>> Max
>>
>>
>> PS: I also don't quite like how you got to the default of 10 minutes o=
f
>> the cache-clean-interval.  You can't justify using 32 MB as the defaul=
t
>> cache size by virtue of "We have a cache-clean-interval now", and then=

>> justify a CCI of 10 min by "It's just for VMs which sit idle".
>>
>> No.  If you rely on CCI to be there to make the cache size reasonable =
by
>> default for whatever the user is doing with their images, you have to
>> consider that fact when choosing a CCI.
>>
>> Ideally we'd probably want a soft and a hard cache limit, but I don't
>> know...
>>
>> (Like, a soft cache limit of 1 MB with a CCI of 10 min, and a hard cac=
he
>> limit of 32 MB with a CCI of 1 min by default.  So whenever your cache=

>> uses more than 1 MB of RAM, your CCI is 1 min, and whenever it's below=
,
>> your CCI is 10 min.)
>=20
> I've actually thought of something like this before, too. Maybe we
> should do that. But that can be done on top of this series.

Sure.

Max


--doyBnZH1Kqe8RpyANkz7sqhxiZ3iW7c9U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltxn5YACgkQ9AfbAGHV
z0AP4Af+LdDbq3oBRDCb78wPNzSgQ18/tXYbViYO57xJBxRKTRuPE/DFrptuqC+Q
sUwLnCns3LyU1moUe9ZcdzLR5WfKYI/Ind+d8uxUtN+b43zeYwS/KOzY0upcFWIT
o5ebxrMUOfKzVfRKRrrer0uli593Jc7TXsp9vILRjrHw2mdafHwZYLuRcxykw1j/
3D0oYuzlMtR/2N5Aha5DeY++AtQoQsrjvmMjxG68j/gC9gB+pZfJ2S5X3WSB1wyP
70yyLg9oIJx36r3LnUWLlKKh4Wp9JDwALVtP/OxO/sW450AixM4D+cw2dgInspBj
e/NvTmpTamc8MFQXuDXvDZPwYChwkA==
=6dZj
-----END PGP SIGNATURE-----

--doyBnZH1Kqe8RpyANkz7sqhxiZ3iW7c9U--
