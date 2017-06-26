Received: from eggs.gnu.org ([2001:4830:134:3::10]:60970)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dPQkt-0002eY-5A
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dPQko-0003c7-9j
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:56:27 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:35529 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dPQkn-0003bO-W2
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:56:22 -0400
References: <0f83a15d-66b0-36aa-e5a4-d03cd37757c9@kamp.de>
	<20170626082838.GA4348@noname.redhat.com>
	<0e6586f9-85eb-efcd-4825-20066a7c869a@kamp.de>
	<1d6aaab3-b62a-74cc-ab4b-22bb8aa676dc@openvz.org>
From: Peter Lieven <pl@kamp.de>
Message-ID: <56cce4a4-e9d4-4fd0-1293-cfa1794652ca@kamp.de>
Date: Mon, 26 Jun 2017 11:56:15 +0200
MIME-Version: 1.0
In-Reply-To: <1d6aaab3-b62a-74cc-ab4b-22bb8aa676dc@openvz.org>
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
To: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel@nongnu.org

Am 26.06.2017 um 11:33 schrieb Denis V. Lunev:
> On 06/26/2017 12:20 PM, Peter Lieven wrote:
>> Am 26.06.2017 um 10:28 schrieb Kevin Wolf:
>>> [ Cc: qemu-devel; don't post to qemu-block only! ]
>>>
>>> Am 26.06.2017 um 09:57 hat Peter Lieven geschrieben:
>>>> Hi,
>>>>
>>>> I am currently working on optimizing speed for compressed QCOW2
>>>> images. We use them for templates and would also like to use them for
>>>> backups, but the latter is almost infeasible because using gzip for
>>>> compression is horribly slow. I tried to experiment with different
>>>> options to deflate, but in the end I think its better to use a
>>>> different compression algorithm for cases where speed matters. As we
>>>> already have probing for it in configure and as it is widely used I
>>>> would like to use LZO for that purpose. I think it would be best to
>>>> have a flag to indicate that compressed blocks use LZO compression,
>>>> but I would need a little explaination which of the feature fields I
>>>> have to use to prevent an older (incompatible) Qemu opening LZO
>>>> compressed QCOW2 images.
>>>>
>>>> I also have already some numbers. I converted a fresh Debian 9 Install
>>>> which has an uncomressed QCOW2 size of 1158 MB with qemu-img to a
>>>> compressed QCOW2.  With GZIP compression the result is 356MB whereas
>>>> the LZO version is 452MB. However, the current GZIP variant uses 35
>>>> seconds for this operation where LZO only needs 4 seconds. I think is
>>>> is a good trade in especially when its optional so the user can
>>>> choose.
>>>>
>>>> What are your thoughts?
>>> We had a related RFC patch by Den earlier this year, which never
>>> received many comment and never got out of RFC:
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04682.html
>> I was not aware of that one. Thanks for pointing out.
>>
>>> So he chose a different algorithm (zstd). When I asked, he posted a
>>> comparison of algorithms (however a generic one and not measured in the
>>> context of qemu) that suggests that LZO would be slightly faster, but
>>> have a considerable worse compression ratio with the settings that were
>>> benchmarked.
>> My idea to choose LZO was that it is widely available and available in
>> any distro you can think of. We already have probing for it in configure.
>> My concern with ZSTD would be that it seems there are no packages
>> available for most distros and that it seems to be multi-threaded. I
>> don't
>> know if this will cause any trouble?
>>
> We have had that compression working in multithreaded process.

Do you have a patchset ready ?

>
>>> I think it's clear that if there is any serious interest in compression,
>>> we'll want to support at least one more algorithm. What we still need to
>>> evaluate is which one(s) to take, and whether a simple incompatible flag
>>> in the header like in Den's patch is enough or whether we should add a
>>> whole new header field for the compression algorithm (like we already
>>> have for encryption).
>>  From my side there clearly is interest in optimizing the compression. Its
>> even possible to speed up zlib by 3-4x times by choosing other parameters
>> for deflate which unfortunately are not compatible with our inflate
>> settings.
>>
>> I don't know if its worth creating a new header field. Even if we
>> spent to bits
>> in the end (one for LZO and one for ZSDT). I think this wouldn't hurt.
>> However,
>> there are likely to pop up new compression algorithms in the future and
>> a header would be more flexible.
>>
>> I just don't want to make it too complicated and as you pointed out
>> compression is
>> not that interesting for most people - maybe due to its speed.
>>
> I think we need something generic but simple. I think that we should not
> support compression with the different algorithm in the single file.

Agreed. The compression algorithm should be specified at create time.

>
> Speaking about compression, we do have different constraints for
> different situation, f.e. backups are written once and rarely read while
> generic compression in backing store is read frequently but never
> read. Thus the exact algorithm should be selectable.

Okay, so we have gzip (default) and zstd. If the patches for ZStd are ready
I don't mind to drop support for LZO. I think both ZStd and LZO both offer
good compression and decompression speed compared to gzip.

Peter
