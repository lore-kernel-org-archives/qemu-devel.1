Received: from eggs.gnu.org ([2001:4830:134:3::10]:52954)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dProX-0004pu-IC
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dProT-0001SP-Ck
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:50:01 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:51177 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dProT-0001M3-3C
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:49:57 -0400
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
	<1498566850-7934-2-git-send-email-pl@kamp.de>
	<cfd60a29-6b27-7065-0fc7-30a82b01eadb@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <560f62fb-f6fb-42ae-2fd9-b10c9c478350@kamp.de>
Date: Tue, 27 Jun 2017 16:49:53 +0200
MIME-Version: 1.0
In-Reply-To: <cfd60a29-6b27-7065-0fc7-30a82b01eadb@redhat.com>
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

Am 27.06.2017 um 14:49 schrieb Eric Blake:
> On 06/27/2017 07:34 AM, Peter Lieven wrote:
>> this patch adds a new compression_algorithm option when creating qcow2 images.
>> The current default for the compresison algorithm is zlib and zlib will be
> s/compresison/compression/
>
>> used when this option is omitted (like before).
>>
>> If the option is specified e.g. with:
>>
>>   qemu-img create -f qcow2 -o compression_algorithm=zlib image.qcow2 1G
>>
>> then a new compression algorithm header extension is added and an incompatible
>> feature bit is set. This means that if the header is present it must be parsed
>> by Qemu on qcow2_open and it must be validated if the specified compression
>> algorithm is supported by the current build of Qemu.
>>
>> This means if the compression_algorithm option is specified Qemu prior to this
>> commit will not be able to open the created image.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>   block/qcow2.c             | 93 ++++++++++++++++++++++++++++++++++++++++++++---
>>   block/qcow2.h             | 20 +++++++---
>>   docs/interop/qcow2.txt    |  8 +++-
> Focusing on just the spec change first:
>
>> +++ b/docs/interop/qcow2.txt
>> @@ -85,7 +85,11 @@ in the description of a field.
>>                                   be written to (unless for regaining
>>                                   consistency).
>>   
>> -                    Bits 2-63:  Reserved (set to 0)
>> +                    Bit 2:      Compress algorithm bit.  If this bit is set then
>> +                                the compress algorithm extension must be parsed
>> +                                and checked for compatiblity.
> s/compatiblity/compatibility/
>
>> +
>> +                    Bits 3-63:  Reserved (set to 0)
>>   
>>            80 -  87:  compatible_features
>>                       Bitmask of compatible features. An implementation can
>> @@ -135,6 +139,8 @@ be stored. Each extension has a structure like the following:
>>                           0xE2792ACA - Backing file format name
>>                           0x6803f857 - Feature name table
>>                           0x23852875 - Bitmaps extension
>> +                        0xC0318300 - Compression Algorithm
>> +                        0xC03183xx - Reserved for compression algorithm params
> s/params/parameters/
>
> You have now introduced 256 different reserved headers, without
> documenting any of their formats.  You absolutely MUST include a
> documentation of how the new 0xC0318300 header is laid out (see, for
> example, our section on "Bitmaps extension"), along with text mentioning
> that the new header MUST be present if incompatible-feature bit is set
> and MUST be absent otherwise.  But I also think that with a bit of
> proper design work, you only need ONE header for all possible algorithm
> parameters, rather than burning an additional 255 unspecified
> reservations.  That is, make sure your new header includes a common
> prefix including a length field and the algorightm in use, and then the
> length covers a variable-length suffix that can be parsed in a
> per-algorithm-specific manner for whatever additional parameters are
> needed for that algorithm.
>

Before I continue, can you please give feedback on the following spec change:

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 80cdfd0..f1428e9 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -85,7 +85,11 @@ in the description of a field.
                                  be written to (unless for regaining
                                  consistency).

-                    Bits 2-63:  Reserved (set to 0)
+                    Bit 2:      Compression format bit.  Iff this bit is set then
+                                the compression format extension MUST be present
+                                and MUST be parsed and checked for compatibility.
+
+                    Bits 3-63:  Reserved (set to 0)

           80 -  87:  compatible_features
                      Bitmask of compatible features. An implementation can
@@ -135,6 +139,7 @@ be stored. Each extension has a structure like the following:
                          0xE2792ACA - Backing file format name
                          0x6803f857 - Feature name table
                          0x23852875 - Bitmaps extension
+                        0xC0318300 - Compression format extension
                          other      - Unknown header extension, can be safely
                                       ignored

@@ -208,6 +213,28 @@ The fields of the bitmaps extension are:
                     starts. Must be aligned to a cluster boundary.


+== Compression format extension ==
+
+The compression format extension is an optional header extension. It provides
+the ability to specify the compression algorithm and compression parameters
+that are used for compressed clusters. This new header MUST be present if
+the incompatible-feature bit "compression format bit" is set and MUST be absent
+otherwise.
+
+The fields of the compression format extension are:
+
+    Byte  0 - 15:  compression_format_name (padded with zeros, but not
+                   necessarily null terminated if it has full length)
+
+              16:  compression_level (uint8_t)
+                   0 = default compression level
+                   1 = lowest compression level
+                   x = highest compression level (the highest compression
+                       level may vary for different compression formats)
+
+         17 - 23:  Reserved for future use, must be zero.
+
+
  == Host cluster management ==

  qcow2 manages the allocation of host clusters by maintaining a reference count

Thanks,
Peter
