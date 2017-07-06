Received: from eggs.gnu.org ([2001:4830:134:3::10]:39323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT2Qf-0003Et-Bf
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT2QY-0007qt-Az
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:46:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dT2QY-0007qA-11
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:46:22 -0400
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<1499187763-8211-2-git-send-email-peter.maydell@linaro.org>
	<f4a09c28-8907-0181-741c-ca33aa3bb3f2@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b5577ce2-67d4-512f-696e-ea8f67ad8b31@redhat.com>
Date: Thu, 6 Jul 2017 10:46:12 +0200
MIME-Version: 1.0
In-Reply-To: <f4a09c28-8907-0181-741c-ca33aa3bb3f2@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] include/hw/boards.h: Document
 memory_region_allocate_system_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, patches@linaro.org



On 06/07/2017 05:18, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Peter, Paolo,
>=20
> On 07/04/2017 02:02 PM, Peter Maydell wrote:
>> Add a documentation comment for memory_region_allocate_system_memory()=
.
>>
>> In particular, the reason for this function's existence and the
>> requirement on board code to call it exactly once are non-obvious.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   include/hw/boards.h | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 76ce021..1bc5389 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -9,6 +9,34 @@
>>   #include "qom/object.h"
>>   #include "qom/cpu.h"
>>   +/**
>> + * memory_region_allocate_system_memory - Allocate a board's main mem=
ory
>> + * @mr: the #MemoryRegion to be initialized
>> + * @owner: the object that tracks the region's reference count
>> + * @name: name of the memory region
>> + * @ram_size: size of the region in bytes
>> + *
>> + * This function allocates the main memory for a board model, and
>> + * initializes @mr appropriately. It also arranges for the memory
>> + * to be migrated (by calling vmstate_register_ram_global()).
>> + *
>> + * Memory allocated via this function will be backed with the memory
>> + * backend the user provided using -mem-path if appropriate; this
>> + * is typically used to cause host huge pages to be used.
>> + * This function should therefore be called by a board exactly once,
>=20
> Using memory-backend-file objects one can use different mem-path.
>=20
> Maybe removing the global mem_path used by vl.c for "main memory" (whic=
h
> is a memory-backend-file without naming it) this "exactly once" case ca=
n
> be avoided.

It's already the case that you can use different mem-paths and different
host node bindings, though you still have to associate one memory
backend to each "-numa node" option (via "-numa node,memdev=3D...").

The function has to be called only once because it consumes all the "-m"
and "-numa node,memdev=3D..." options.

Paolo

>> + * for the primary or largest RAM area it implements.
>> + *
>> + * For boards where the major RAM is split into two parts in the memo=
ry
>> + * map, you can deal with this by calling
>> memory_region_allocate_system_memory()
>> + * once to get a MemoryRegion with enough RAM for both parts, and the=
n
>> + * creating alias MemoryRegions via memory_region_init_alias() which
>> + * alias into different parts of the RAM MemoryRegion and can be mapp=
ed
>> + * into the memory map in the appropriate places.
>> + *
>> + * Smaller pieces of memory (display RAM, static RAMs, etc) don't nee=
d
>> + * to be backed via the -mem-path memory backend and can simply
>> + * be created via memory_region_init_ram().
>> + */
>>   void memory_region_allocate_system_memory(MemoryRegion *mr, Object
>> *owner,
>>                                             const char *name,
>>                                             uint64_t ram_size);
>>
