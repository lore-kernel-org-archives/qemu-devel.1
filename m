Received: from eggs.gnu.org ([2001:4830:134:3::10]:40278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDpeb-0000Yc-VS
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDpeX-0004Y6-Uo
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:10:33 -0400
References: <20180427120515.24067-1-david@redhat.com>
	<1ecc2dc7-be06-c680-5f97-df0c8d6d4be0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ebb3e2e0-5fe7-f059-1de6-f77ca9a6040c@redhat.com>
Date: Wed, 2 May 2018 13:10:08 +0200
MIME-Version: 1.0
In-Reply-To: <1ecc2dc7-be06-c680-5f97-df0c8d6d4be0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] pc-dimm: fix error messages
 if no slots were defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 27/04/2018 18:25, Thomas Huth wrote:
> On 27.04.2018 14:05, David Hildenbrand wrote:
>> If no slots were defined we try to allocate an empty bitmap, which
>> fails.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> v1 -> v2: more detailed error message
>>
>>  hw/mem/pc-dimm.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
>> index 0119c68e01..12da89d562 100644
>> --- a/hw/mem/pc-dimm.c
>> +++ b/hw/mem/pc-dimm.c
>> @@ -118,9 +118,16 @@ static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
>>  
>>  int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp)
>>  {
>> -    unsigned long *bitmap = bitmap_new(max_slots);
>> +    unsigned long *bitmap;
>>      int slot = 0;
>>  
>> +    if (max_slots <= 0) {
>> +        error_setg(errp, "no slots where allocated, please specify "
>> +                   "the 'slots' option");
>> +        return slot;
> 
> In case you respin, I'd maybe rather return -1 here.
> 
> But since this is not used by the caller anyway in case of errors:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Queued, thanks all.

Paolo
