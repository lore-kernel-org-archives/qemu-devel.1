Received: from eggs.gnu.org ([2001:4830:134:3::10]:38683)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dYTe7-0003Cx-Mj
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dYTe2-000879-Ql
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:50:51 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:43167 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dYTe2-00085Z-Cw
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:50:46 -0400
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
	<1500560441-5670-9-git-send-email-pl@kamp.de>
	<6c67ca5d-56be-548b-8854-5891818c4217@redhat.com>
	<8b0c6cba-3a8e-62dd-35af-46dc05420ec7@kamp.de>
	<6a336b66-1fe9-cc1f-414c-75852c65d04d@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <3bf2ce79-a929-ae0e-c36a-d6de30381221@kamp.de>
Date: Fri, 21 Jul 2017 10:50:38 +0200
MIME-Version: 1.0
In-Reply-To: <6a336b66-1fe9-cc1f-414c-75852c65d04d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 08/10] block/qcow2: start using the
 compress format extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

Am 20.07.2017 um 21:19 schrieb Eric Blake:
> On 07/20/2017 11:30 AM, Peter Lieven wrote:
>
>>> The new code is now unconditionally initializing with -15 instead of
>>> -12.  Does that matter, or does decompression work regardless of window
>>> size used at creation, as long as the initialized size at decompression
>>> is at least as large?  On the other hand, I guess that means if someone
>>> compresses with a large window, and then I initialize the decompressor
>>> with a small window, my decompression will fail?  That's why knowing the
>>> minimum window size should be part of the spec, whether or not we make
>>> it a tunable.
>> The decompression is supposed to fail if you compress with 15 and
>> decompress with 12. In fact it doesn't.
> Actually, I think (this is my guess here, not actual researched fact)
> that the decompression error is possible ONLY if compression produced a
> symbol that actually required more than 12 bits of memory - to get that
> large of a symbol, you need to compress a lot of bits.  For our default
> cluster of 64k, it might very well be that you rarely, if ever,
> encounter a single cluster that compresses differently under window size
> 15 than it did under window size 12 (other than perhaps the speed at
> which compression took place), because there simply wasn't enough
> content to reach the point where you needed a symbol in the compression
> stream using more than 12 bits.  So in that case, compressing under 15
> and decompressing under 12 doesn't hit the error.  But as you get larger
> cluster sizes (2M clusters), or perhaps if you pass particularly nasty
> sequences of input to compression (I'm not sure what sequences would
> have the right properties), then you do indeed result in a compression
> stream that starts to encounter symbols exceeding the window size.
>
> But if my guess is right, then don't read the docs as "decompression
> will fail", but rather as "decompression may fail" if you set the
> decompress window smaller than the compression window.
>
>> I would like to avoid the windowBits in the qcow2 header as it makes
>>
>> the code to read and write it more complicated. If you don't like the change
>>
>> of the windowBits we can even stick with 12. If someone wants fast compression
>>
>> he will likely not use zlib at all and use lzo.
> Also, note that historically, 'compress -b N' has allowed tuning the
> window size; current POSIX states that compress only has to support
> windows from 9 to 14, but permits implementations to use up to 16 (and
> future POSIX is considering improving the compress utility to require
> support for 16 as the window size, https://posix.rhansen.org/p/bug1041).
>  I don't know why gzip didn't expose a '-b N' windowsize parameter the
> way compress did, but it sounds like the same thing.
>
>> I just changed the windowBits to 15 as it increases speed and improves compression.
> Does windowBits 16 make any difference?

16 is not allowed. Deflate allows only 2^8 through 2^15 window size.
While we are talking, I thing we should choose not zlib but deflate for the
compress format name.

Peter
