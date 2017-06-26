Received: from eggs.gnu.org ([2001:4830:134:3::10]:56999)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dPSKj-0004oO-6C
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dPSKg-0006FS-3f
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:37:33 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:37864 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dPSKf-0006EB-QD
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:37:30 -0400
References: <0f83a15d-66b0-36aa-e5a4-d03cd37757c9@kamp.de>
	<20170626082838.GA4348@noname.redhat.com>
	<0e6586f9-85eb-efcd-4825-20066a7c869a@kamp.de>
	<20170626095719.GB4348@noname.redhat.com>
	<b82ab934-ddc3-2d50-09cf-764f2165f2c8@kamp.de>
	<20170626112112.GC4348@noname.redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <236b5d26-16ee-04e1-6eee-83a228e1e5db@kamp.de>
Date: Mon, 26 Jun 2017 13:37:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170626112112.GC4348@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QCOW2 support for LZO compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu block <qemu-block@nongnu.org>, den@openvz.org, qemu-devel@nongnu.org

Am 26.06.2017 um 13:21 schrieb Kevin Wolf:
> Am 26.06.2017 um 12:08 hat Peter Lieven geschrieben:
>> Am 26.06.2017 um 11:57 schrieb Kevin Wolf:
>>> Am 26.06.2017 um 11:20 hat Peter Lieven geschrieben:
>>>>> So he chose a different algorithm (zstd). When I asked, he posted a
>>>>> comparison of algorithms (however a generic one and not measured in the
>>>>> context of qemu) that suggests that LZO would be slightly faster, but
>>>>> have a considerable worse compression ratio with the settings that were
>>>>> benchmarked.
>>>> My idea to choose LZO was that it is widely available and available in
>>>> any distro you can think of. We already have probing for it in configure.
>>>> My concern with ZSTD would be that it seems there are no packages
>>>> available for most distros and that it seems to be multi-threaded. I don't
>>>> know if this will cause any trouble?
>>> The availability and that we already link against LZO is a good point. I
>>> think we want to avoid a situation where compressed qcow2 files can't be
>>> read by binaries of popular distributions - after all, downloadable
>>> images are an important use case for compressed images.
>> As long as the default remains gzip I don't see any issues. If you choose
>> a different algorithm, you should know what you are doing.
> If we add a better compression algorithm, then it's clear to me that the
> goal is to make it the default in a year or two.
>
>>>>> I think it's clear that if there is any serious interest in compression,
>>>>> we'll want to support at least one more algorithm. What we still need to
>>>>> evaluate is which one(s) to take, and whether a simple incompatible flag
>>>>> in the header like in Den's patch is enough or whether we should add a
>>>>> whole new header field for the compression algorithm (like we already
>>>>> have for encryption).
>>>>  From my side there clearly is interest in optimizing the compression. Its
>>>> even possible to speed up zlib by 3-4x times by choosing other parameters
>>>> for deflate which unfortunately are not compatible with our inflate settings.
>>>>
>>>> I don't know if its worth creating a new header field. Even if we spent to bits
>>>> in the end (one for LZO and one for ZSDT). I think this wouldn't hurt. However,
>>>> there are likely to pop up new compression algorithms in the future and
>>>> a header would be more flexible.
>>> That we could just use different parameters is an important hint that
>>> maybe we don't just need bits to select an algorithm, but also some
>>> space for parameters for the selected algorithm. In this case I think we
>>> need a header change anyway.
>> The issue is, you don't know in advance how much space will be needed
>> for the paramters.  Maybe it would be simpler to have different
>> settings for a compression algorithm threated as different algorithms.
>> Like zstd-fast, zstd, zstd-slow, gzip, lzo, lzo-slow etc.
> Yes, how much space is needed for parameters depends on the algorithm.
> Normally, when adding an incompatible feature, you would put the new
> options inside the main header. However, nothing stops us from using a
> header extension instead like we would with compatible features.
>
> So I think this is what we could do:
>
>   * Add a header extension type per algorithm that contains the
>     parameters that are needed for this parameter
>
>   * Add a header field that selects the compression algorithm (e.g. a
>     32 bit field containing the matching header extension ID). Images
>     that contain compression header extensions that don't match this
>     header field (or images containing the same compression header
>     extension type more than once) are rejected
>
>   * Add an incompatible feature flag that indicates presence of the
>     header field + header extension

The header extension per algorithm should be optional. LZO1X for instance
takes no arguments.

>
>>>> I just don't want to make it too complicated and as you pointed out
>>>> compression is not that interesting for most people - maybe due to its
>>>> speed.
>>> In fact, I think it could be the poor integration in qemu. Compressed
>>> images might be more appealing if you couldn't only write compressed
>>> data with special-case operations like 'qemu-img convert', but just give
>>> an option that you want all writes to be compressed and then use it like
>>> any other image.
>> Then we should start to improve that.
> Thanks for volunteering. ;-)

I will try to prepare a patchset for adding LZO support.

Peter
