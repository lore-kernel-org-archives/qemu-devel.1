Received: from eggs.gnu.org ([2001:4830:134:3::10]:51831)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dYGfl-0000cU-VP
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dYGfi-0007xg-Qc
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:59:42 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:52469 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dYGfi-0007wn-EJ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:59:38 -0400
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
	<1500560441-5670-2-git-send-email-pl@kamp.de>
	<72303744-31bc-1c28-2d34-5926975b0b2d@redhat.com>
	<2177e9ee-73c6-cc7d-76a4-e56749be5815@kamp.de>
	<79e8a12e-8446-9031-46bb-0df32e2c22af@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <74b524ee-dd88-8052-9a05-c51ae0291cee@kamp.de>
Date: Thu, 20 Jul 2017 20:59:32 +0200
MIME-Version: 1.0
In-Reply-To: <79e8a12e-8446-9031-46bb-0df32e2c22af@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 01/10] specs/qcow2: add compress format
 extension
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

Am 20.07.2017 um 20:31 schrieb Eric Blake:
> On 07/20/2017 11:26 AM, Peter Lieven wrote:
>>> I haven't yet checked your code implementation to see where you are
>>> setting window sizes, to know if window size is something that should be
>>> a tunable in the file format.
>>>
>> You don't have to know the window size that was used. The docs of zlib
>>
>> just say, that the windowSize specified at inflate must be greater or equal
>>
>> to the one used at deflate. So if we change the code to use 15 we can safely
>>
>> decompress old clusters that where compressed with 12.
> Then you DO have to know the window size.  If I write my own qcow2
> parser, and don't know what size you picked on compression, then how do
> I know that the size I pick is >= your size during my decompression?
>
> Even if you DON'T want size to be a tunable (and I'm on the fence on
> that one), you STILL need the spec to state that for maximum
> compatibility, when the incompatible feature is off, implementations
> MUST use window size 12 for compression; and that when the compression
> extension is used, implementations MUST use window size 15.
>
> Or, by having window size be a tunable in the extension header allows
> implementations to record window size, then you allow implemenations to
> explicitly KNOW what window size they must meet or exceed.
>

But they still have to now what values to use if the header is absent.


Bottom line, you are right. Its cleaner to have that value in the header and

default it to zlib, level 0, windowBits 12 if the header is absent and on the other

side don't write the header if these values are used.


I checked the spec again expect for the windowBits nothing else is passed as

a parameter to inflateinit2.


Here is what is written about the windowBits provided to inflateInit2:

" The windowBits parameter is the base two logarithm of the maximum window size (the size of the history buffer). It should be in the range 8..15 for this version of the library. The default value is 15 if inflateInit is used instead. windowBits must be greater than or equal to the windowBitsvalue provided to deflateInit2() while compressing, or it must be equal to 15 if deflateInit2() was not used. If a compressed stream with a larger window size is given as input, inflate() will return with the error code Z_DATA_ERROR instead of trying to allocate a larger window."


I checked through the parameters of some compression algorithms. Most obviously have a positive interger for a compression level. And at least some have not a window as zlib, but a dictionary size which is also a power of two. So it might be reasonable to have that second

uint8_t also in the default header for a window/dictionary size exponent.


So it would propose to update the header like this:


    Byte  0 - 13:  compress_format_name
              14:  compress_level (uint8_t)
              15:  compress_window_exp (uint8_t)


Peter
