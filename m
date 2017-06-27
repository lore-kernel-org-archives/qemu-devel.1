Received: from eggs.gnu.org ([2001:4830:134:3::10]:52451)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dPtmA-000719-SA
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dPs9j-00078R-3j
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:11:58 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:46978 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dPs9i-00070S-JX
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:11:54 -0400
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
	<1498566850-7934-2-git-send-email-pl@kamp.de>
	<cfd60a29-6b27-7065-0fc7-30a82b01eadb@redhat.com>
	<560f62fb-f6fb-42ae-2fd9-b10c9c478350@kamp.de>
	<39f92e3c-5136-5bd1-b69a-338d637cb1d6@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <56907401-0e57-a642-5806-5c12219b3036@kamp.de>
Date: Tue, 27 Jun 2017 17:11:49 +0200
MIME-Version: 1.0
In-Reply-To: <39f92e3c-5136-5bd1-b69a-338d637cb1d6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] block/qcow2: add compression_algorithm
 create option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com

Am 27.06.2017 um 17:04 schrieb Eric Blake:
> On 06/27/2017 09:49 AM, Peter Lieven wrote:
>
>> Before I continue, can you please give feedback on the following spec
>> change:
>>
>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>> index 80cdfd0..f1428e9 100644
>> --- a/docs/interop/qcow2.txt
>> +++ b/docs/interop/qcow2.txt
>> @@ -85,7 +85,11 @@ in the description of a field.
>>                                   be written to (unless for regaining
>>                                   consistency).
>>
>> -                    Bits 2-63:  Reserved (set to 0)
>> +                    Bit 2:      Compression format bit.  Iff this bit
> I know what this means, but spelling it "If and only if" or "When" might
> make more sense to other readers, as "Iff" is not common in English.
>
>> is set then
>> +                                the compression format extension MUST
>> be present
>> +                                and MUST be parsed and checked for
>> compatibility.
>> +
>> +                    Bits 3-63:  Reserved (set to 0)
>>
>>            80 -  87:  compatible_features
>>                       Bitmask of compatible features. An implementation can
>> @@ -135,6 +139,7 @@ be stored. Each extension has a structure like the
>> following:
>>                           0xE2792ACA - Backing file format name
>>                           0x6803f857 - Feature name table
>>                           0x23852875 - Bitmaps extension
>> +                        0xC0318300 - Compression format extension
> Now that you aren't burning 256 magic numbers, it may make sense to have
> the last two hex digits be non-zero.
>
>
>> +== Compression format extension ==
>> +
>> +The compression format extension is an optional header extension. It
>> provides
> Inline pasting created interesting wrapping, but the actual patch will
> obviously read better.
>
>> +the ability to specify the compression algorithm and compression
>> parameters
>> +that are used for compressed clusters. This new header MUST be present if
>> +the incompatible-feature bit "compression format bit" is set and MUST
>> be absent
>> +otherwise.
>> +
>> +The fields of the compression format extension are:
>> +
>> +    Byte  0 - 15:  compression_format_name (padded with zeros, but not
>> +                   necessarily null terminated if it has full length)
> Do we really want arbitrary names of formats, or do we want to specify
> specific algorithms (gzip, lzo, zstd) as an enum?  Which way gives us
> maximum likelihood of interoperability?

At some point I have to parse the name and convert it into a number.
This could be the same routine for the parsing of the compress.format
parameter and the compression_format_name in the header field.
The idea was that an accidently change in the enum cannot break
anything as it is local to the qemu binary. But I am ok to have an enum
if the values for each format a fixed. In this case it might be sufficient
to have an uint8_t for the compression format + an uint8_t for the compression
level. Then 2 bytes reserved + an uint32_t for the extra data size. So currently (the extra
data is not necessary at the moment for any format) the header would
be limited to 8 bytes.

Anyway if we glue this into a QAPI scheme, I would appreciate to get
some help with it as I am not that familiar with it yet.

Thanks,
Peter
