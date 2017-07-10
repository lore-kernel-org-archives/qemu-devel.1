Received: from eggs.gnu.org ([2001:4830:134:3::10]:44233)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dUYjK-0002ZR-43
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dUYjG-0000XI-4F
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:28:02 -0400
Received: from mx01.kamp.de ([82.141.2.16]:45828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dUYjF-0000Wd-Rm
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:27:58 -0400
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
	<1498733831-15254-2-git-send-email-pl@kamp.de>
	<20170710125857.GD5772@noname.redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <11427303-a0cd-ee7b-edb4-1cdf9b90c0af@kamp.de>
Date: Mon, 10 Jul 2017 15:27:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170710125857.GD5772@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 1/8] docs: add compress format extension
 to qcow2 spec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com

Am 10.07.2017 um 14:58 schrieb Kevin Wolf:
> Am 29.06.2017 um 12:57 hat Peter Lieven geschrieben:
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>   docs/interop/qcow2.txt | 43 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>> index 80cdfd0..c01daf3 100644
>> --- a/docs/interop/qcow2.txt
>> +++ b/docs/interop/qcow2.txt
>> @@ -85,7 +85,12 @@ in the description of a field.
>>                                   be written to (unless for regaining
>>                                   consistency).
>>   
>> -                    Bits 2-63:  Reserved (set to 0)
>> +                    Bit 2:      Compress format bit.  If and only if this bit
>> +                                is set then the compress format extension
>> +                                MUST be present and MUST be parsed and checked
>> +                                for compatibility.
>> +
>> +                    Bits 3-63:  Reserved (set to 0)
>>   
>>            80 -  87:  compatible_features
>>                       Bitmask of compatible features. An implementation can
>> @@ -135,6 +140,7 @@ be stored. Each extension has a structure like the following:
>>                           0xE2792ACA - Backing file format name
>>                           0x6803f857 - Feature name table
>>                           0x23852875 - Bitmaps extension
>> +                        0xC03183A3 - Compress format extension
>>                           other      - Unknown header extension, can be safely
>>                                        ignored
>>   
>> @@ -208,6 +214,41 @@ The fields of the bitmaps extension are:
>>                      starts. Must be aligned to a cluster boundary.
>>   
>>   
>> +== Compress format extension ==
>> +
>> +The compress format extension is an optional header extension. It provides
>> +the ability to specify the compress algorithm and compress parameters
>> +that are used for compressed clusters. This new header MUST be present if
>> +the incompatible-feature bit "compress format bit" is set and MUST be absent
>> +otherwise.
> Okay. Only one header extension type for all compression formats. I
> think this does work because we have a variable header extension size.
>
>> +The fields of the compress format extension are:
>> +
>> +    Byte  0 - 15:  compress_format_name (padded with zeros, but not
>> +                   necessarily null terminated if it has full length)
> We absolutely need to define the valid names and their meaning here.
>
>> +              16:  compress_level (uint8_t)
>> +                   0 = default compress level
>> +                   1 = lowest compress level
>> +                   x = highest compress level (the highest compress
>> +                       level may vary for different compress formats)
> Let's be explicit about the compression formats that this field is valid
> for (i.e. make this already part of the format specific fields).
>
> Then we can also be specific instead of writing "may vary", which is not
> a very good thing to have in a specification.

The idea to keep it in the common header was that most formats will
only need a compression level and nothing more. So it is not necessary
to add specific headers for a setting that is quite common among
compression formats.


>
>> +         17 - 19:  Reserved for future use, must be zero.
> We don't need this for now because byte 16 will be the final one in this
> struct.
>
>> +         20 - 23:  extra_data_size
>> +                   Size of compress format specific extra data.
>> +                   For now, as no format specifies extra data,
>> +                   extra_data_size is reserved and should be zero.
>> +
>> +        variable:  extra_data
>> +                   Extra data with additional parameters for the compress
>> +                   format, occupying extra_data_size bytes.
> extra_data_size isn't necessary because we already have the length of
> the header extension, so we know how long the whole thing is.
> extra_data isn't necessary because we'll just add new fields at the end
> if we want to add something.

I was asked to add it altough it is redundant.


>
>> +        variable:  Padding to round up the size of compress format extension
>> +                   to the next multiple of 8. All bytes of the padding must be
>> +                   zero.
> This is already contained in the description of header extensions in
> general, so we don't have to repeat it here.

Its also in the bitmap extension...

Peter
