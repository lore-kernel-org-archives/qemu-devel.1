Received: from eggs.gnu.org ([2001:4830:134:3::10]:54099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp639-0000Rl-PN
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp636-0005sM-IP
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:09:55 -0400
Date: Mon, 13 Aug 2018 09:09:23 +0300
In-Reply-To: <ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-7-lbloch@janustech.com>
	<w5136vm8m8u.fsf@maestria.local.igalia.com>
	<ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <BDD8E417-5EE2-4B3A-BF19-C37A7BBD0330@janustech.com>
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
To: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>



On August 13, 2018 4:39:35 AM EEST, Max Reitz <mreitz@redhat=2Ecom> wrote:
>On 2018-08-10 14:00, Alberto Garcia wrote:
>> On Fri 10 Aug 2018 08:26:44 AM CEST, Leonid Bloch wrote:
>>> The upper limit on the L2 cache size is increased from 1 MB to 32
>MB=2E
>>> This is done in order to allow default full coverage with the L2
>cache
>>> for images of up to 256 GB in size (was 8 GB)=2E Note, that only the
>>> needed amount to cover the full image is allocated=2E The value which
>is
>>> changed here is just the upper limit on the L2 cache size, beyond
>which
>>> it will not grow, even if the size of the image will require it to=2E
>>>
>>> Signed-off-by: Leonid Bloch <lbloch@janustech=2Ecom>
>>=20
>> Reviewed-by: Alberto Garcia <berto@igalia=2Ecom>
>>=20
>>> -#define DEFAULT_L2_CACHE_MAX_SIZE (1 * MiB)
>>> +#define DEFAULT_L2_CACHE_MAX_SIZE (32 * MiB)
>>=20
>> The patch looks perfect to me now and I'm fine with this change, but
>> this is quite an increase from the previous default value=2E If anyone
>> thinks that this is too aggressive (or too little :)) I'm all ears=2E
>
>This is just noise from the sidelines (so nothing too serious), but
>anyway, I don't like it very much=2E
>
>My first point is that the old limit doesn't mean you can only use 8 GB
>qcow2 images=2E  You can use more, you just can't access more than 8 GB
>randomly=2E  I know I'm naive, but I think that the number of use cases
>where you need random IOPS spread out over more than 8 GB of an image
>are limited=2E
>
>My second point is that qemu still allocated 128 MB of RAM by default=2E
>Using 1/4th of that for every qcow2 image you attach to the VM seems a
>bit much=2E
>
>Now it gets a bit complicated=2E  This series makes cache-clean-interval
>default to 10 minutes, so it shouldn't be an issue in practice=2E  But
>one
>thing to note is that this is a Linux-specific feature, so on every
>other system, this really means 32 MB per image=2E  (Also, 10 minutes
>means that whenever I boot up my VM with a couple of disks with random
>accesses all over the images during boot, I might end up using 32 MB
>per
>image again (for 10 min), even though I don't really need that
>performance=2E)
>
>Now if we really rely on that cache-clean-interval, why not make it
>always cover the whole image by default?  I don't really see why we
>should now say "256 GB seems reasonable, and 32 MB doesn't sound like
>too much, let's go there"=2E  (Well, OK, I do see how you end up using 32
>MB as basically a safety margin, where you'd say that anything above it
>is just unreasonable=2E)
>
>Do we update the limit in a couple of years again because people have
>more RAM and larger disks then?  (Maybe we do?)
>
>My personal opinion is this: Most users should be fine with 8 GB of
>randomly accessible image space (this may be wrong)=2E  Whenever a user
>does have an application that uses more than 8 GB, they are probably in
>an area where they want to do some performance tuning anyway=2E=20
>Requiring
>them to set l2-cache-full in that case seems reasonable to me=2E  Pushing
>the default to 256 GB to me looks a bit like just letting them run into
>the problem later=2E  It doesn't solve the issue that you need to do some
>performance tuning if you have a bit of a special use case (but maybe
>I'm wrong and accessing more than 8 GB randomly is what everybody does
>with their VMs)=2E
>
>(Maybe it's even a good thing to limit it to a smaller number so users
>run into the issue sooner than later=2E=2E=2E)
>
>OTOH, this change means that everyone on a non-Linux system will have
>to
>use 32 MB of their RAM per qcow2 image, and everyone on a Linux system
>will potentially use it e=2Eg=2E during boot when you do access a lot
>randomly (even though the performance usually is not of utmost
>importance then (important, but not extremely so))=2E  But then again,
>this will probably only affect a single disk (the one with the OS on
>it), so it won't be too bad=2E
>
>So my stance is:
>
>(1) Is it really worth pushing the default to 256 GB if you probably
>have to do a bit of performance tuning anyway when you get past 8 GB
>random IOPS?  I think it's reasonable to ask users to use l2-cache-full
>or adjust the cache to their needs=2E
>
>(2) For non-Linux systems, this seems to really mean 32 MB of RAM per
>qcow2 image=2E  That's 1/4th of default VM RAM=2E  Is that worth it?
>
>(3) For Linux, I don't like it much either, but that's because I'm
>stupid=2E  The fact that if you don't need this much random I/O only your
>boot disk may cause a RAM usage spike, and even then it's going to go
>down after 10 minutes, is probably enough to justify this change=2E
>
>
>I suppose my moaning would subside if we only increased the default on
>systems that actually support cache-clean-interval=2E=2E=2E?
>
>Max
>
>
>PS: I also don't quite like how you got to the default of 10 minutes of
>the cache-clean-interval=2E  You can't justify using 32 MB as the default
>cache size by virtue of "We have a cache-clean-interval now", and then
>justify a CCI of 10 min by "It's just for VMs which sit idle"=2E
>
>No=2E  If you rely on CCI to be there to make the cache size reasonable
>by
>default for whatever the user is doing with their images, you have to
>consider that fact when choosing a CCI=2E
>
>Ideally we'd probably want a soft and a hard cache limit, but I don't
>know=2E=2E=2E
>
>(Like, a soft cache limit of 1 MB with a CCI of 10 min, and a hard
>cache
>limit of 32 MB with a CCI of 1 min by default=2E  So whenever your cache
>uses more than 1 MB of RAM, your CCI is 1 min, and whenever it's below,
>your CCI is 10 min=2E)

Max, thanks for your insight=2E Indeed some good points=2E
Considering this, I'm thinking to set the limit to 16 MB, and the CCI to 5=
 min=2E What do you think?
Modern Windows installations should gain performance from being able to ra=
ndom I/O to >8 GB chunks, and data processing tasks where each data set is =
8+ GB for sure do (did benchmarks)=2E And the maximum is only ever used if =
(a) the image is large enough and (b) it is indeed used=2E
While taking 256 GB images as the "limit" can be considered an overshoot, =
128 GB is quite reasonable, I think=2E

Your idea with "soft" and "hard" limits is great! I'm tempted to implement=
 this=2E Say 4 MB with 10 min=2E, and 16 MB with 5 min?

Leonid=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
