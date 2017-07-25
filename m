Received: from eggs.gnu.org ([2001:4830:134:3::10]:34676)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1da6SV-00015E-Ax
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 16:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1da6SR-0004Fg-A2
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 16:29:35 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:60577 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1da6SR-0004F2-0P
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 16:29:31 -0400
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
	<1500993699-19299-2-git-send-email-pl@kamp.de>
	<e4639625-7674-dfa8-8597-3e142b9931a0@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <8f1f2bd2-4509-e603-218d-942859d6316f@kamp.de>
Date: Tue, 25 Jul 2017 22:29:25 +0200
MIME-Version: 1.0
In-Reply-To: <e4639625-7674-dfa8-8597-3e142b9931a0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V5 01/10] specs/qcow2: add compress format
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

Am 25.07.2017 um 17:03 schrieb Eric Blake:
> On 07/25/2017 09:41 AM, Peter Lieven wrote:
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>  docs/interop/qcow2.txt | 51 +++++++++++++++++++++++++++++++++++++++++++++++++-
>>  roms/ipxe              |  2 +-
>>  2 files changed, 51 insertions(+), 2 deletions(-)
>>
>> +
>> +== Compress format extension ==
>> +
>> +The compress format extension is an optional header extension. It provides
>> +the ability to specify the compress algorithm and compress parameters
> s/the compress algorithm/the compression algorithm/
>
>> +that are used for compressed clusters. This new header MUST be present if
>> +the incompatible-feature bit "compress format bit" is set and MUST be absent
>> +otherwise.
>> +
>> +The fields of the compress format extension are:
>> +
>> +    Byte  0 - 13:  compress_format_name (padded with zeros, but not
>> +                   necessarily null terminated if it has full length).
>> +                   Valid compression format names currently are:
>> +
>> +                   deflate: Standard zlib deflate compression without
>> +                            compression header
> Why did you name it "deflate" instead of "zlib" again?

zlib provides raw deflate encoding and gzip encoding both with and without header afaik.
We use raw deflate encoding without header in QEMU. And the name of the algorithm is deflate.
I found it more appropriate than zlib.

>
>> +
>> +              14:  compress_level (uint8_t)
>> +
>> +                   0 = default compress level (valid for all formats, default)
>> +
>> +                   Additional valid compression levels for deflate compression:
>> +
>> +                   All values between 1 and 9. 1 gives best speed, 9 gives best
>> +                   compression. The default compression level is defined by zlib
>> +                   and currently defaults to 6.
>> +
>> +              15:  compress_window_size (uint8_t)
>> +
>> +                   Window or dictionary size used by the compression format.
>> +                   Currently only used by the deflate compression algorithm.
> What must this be set to for other algorithms?  I guess we get to that
> in later patches.

Its only used by the deflate algorithm. At this point we only have that algorithm.
lzo has no such encoding. If we add e.g. lzma it has a dictionary size which is
a power of two (typcial value would be 2^20).

>
>> +
>> +                   Valid window sizes for deflate compression range from 8 to
>> +                   15 inclusively.
>> +
>> +Note: Omitting the incompatible "Compress format bit" results in the usage
>> +of deflate compression with default compression level and a window size of 12
>> +(which was default before QEMU 2.11). If exactly these parameters are choosen
> s/choosen/chosen,/
>
>> +it is free to the implementation to omit the "Compress format bit" and the
> s/it is free to the implementation to omit/the implementation may omit/
>
>> +compress format extension when updating the QCOW2 header.
>> +
>> +
>>  == Host cluster management ==
>>  
>>  qcow2 manages the allocation of host clusters by maintaining a reference count
>> diff --git a/roms/ipxe b/roms/ipxe
>> index 0600d3a..b991c67 160000
>> --- a/roms/ipxe
>> +++ b/roms/ipxe
>> @@ -1 +1 @@
>> -Subproject commit 0600d3ae94f93efd10fc6b3c7420a9557a3a1670
>> +Subproject commit b991c67c1d91574ef22336cc3a5944d1e63230c9
> Oops.

Yes, oops. But I guess I have to respin anyway ;-)

Can you also have a look at the remainder of the series?

Thanks,
Peter
