Received: from eggs.gnu.org ([2001:4830:134:3::10]:58669)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dW8Zz-0001h9-On
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dW8Zw-0001fi-ML
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:56:55 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:35515 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dW8Zw-0001dB-Cz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:56:52 -0400
References: <1500026205-15542-1-git-send-email-pl@kamp.de>
	<1500026205-15542-2-git-send-email-pl@kamp.de>
	<76298257-8593-eea6-7593-9d11d002375f@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <bae10332-4f1e-6278-ed3d-0a93f7bb164b@kamp.de>
Date: Fri, 14 Jul 2017 23:56:44 +0200
MIME-Version: 1.0
In-Reply-To: <76298257-8593-eea6-7593-9d11d002375f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3 1/9] specs/qcow2: add compress format
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

Am 14.07.2017 um 16:52 schrieb Eric Blake:
> On 07/14/2017 04:56 AM, Peter Lieven wrote:
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>  docs/interop/qcow2.txt | 35 ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>> index d7fdb1f..c2d3dab 100644
>> --- a/docs/interop/qcow2.txt
>> +++ b/docs/interop/qcow2.txt
>> @@ -86,7 +86,12 @@ in the description of a field.
>>                                  be written to (unless for regaining
>>                                  consistency).
>>  
>> -                    Bits 2-63:  Reserved (set to 0)
>> +                    Bit 2:      Compress format bit.  If and only if this bit
>> +                                is set then the compress format extension
>> +                                MUST be present and MUST be parsed and checked
>> +                                for compatibility.
>> +
>> +                    Bits 3-63:  Reserved (set to 0)
>>  
>>           80 -  87:  compatible_features
>>                      Bitmask of compatible features. An implementation can
>> @@ -137,6 +142,7 @@ be stored. Each extension has a structure like the following:
>>                          0x6803f857 - Feature name table
>>                          0x23852875 - Bitmaps extension
>>                          0x0537be77 - Full disk encryption header pointer
>> +                        0xC03183A3 - Compress format extension
>>                          other      - Unknown header extension, can be safely
>>                                       ignored
>>  
>> @@ -311,6 +317,33 @@ The algorithms used for encryption vary depending on the method
>>     in the LUKS header, with the physical disk sector as the
>>     input tweak.
>>  
>> +
>> +== Compress format extension ==
>> +
>> +The compress format extension is an optional header extension. It provides
>> +the ability to specify the compress algorithm and compress parameters
>> +that are used for compressed clusters. This new header MUST be present if
>> +the incompatible-feature bit "compress format bit" is set and MUST be absent
>> +otherwise.
> Probably worth mentioning that omitting the incompatible "Compress
> format bit" is the same as setting it and populating the Compress format
> extension with "zlib"/0.  Don't know if that fits better here, or up
> above at the incompatible feature bit section.

Its not exactly the same. Its zlib with default compression, but the old
default was to use 12 windowBits whereas windowBits are 15 when
the header is present. The reason behind this is that the inflate call
needs the maximum alllowed windowBits as parameter. In theory
it should fail if it has a 12 as parameter and receives an input stream
with 15. My zlib doesn't, but the docs say something else.
The change of the windowBits to 15 yields in about 15% better compression
time and about 5% better compression ratio.

>
>> +
>> +The fields of the compress format extension are:
>> +
>> +    Byte  0 - 15:  compress_format_name (padded with zeros, but not
>> +                   necessarily null terminated if it has full length).
>> +                   Valid compression format names currently are:
>> +
>> +                   zlib: Standard zlib deflate compression
> 16 bytes,
>
>> +
>> +              16:  compress_level (uint8_t)
> + 1, means you now have to pad the struct. I'd make the
> compress_format_name be only 15 bits (bytes 0-14, compress_level at 15),
> so that you have nice alignment without wasting padding.

Good point, I will change that.

>
>> +
>> +                   0 = default compress level (valid for all formats, default)
>> +
>> +                   Additional valid compression levels for zlib compression:
>> +
>> +                   All values between 1 and 9. 1 gives best speed, 9 gives best
>> +                   compression.
> Is there a particular value between 1 and 9 that matches the output you
> get when using 0?
>
Thats depending on what the macro Z_DEFAULT_COMPRESSION points to.

Its provided by libz. The zlib docs say it currently is set to level 6.


Peter
