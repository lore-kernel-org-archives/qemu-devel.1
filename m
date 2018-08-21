Received: from eggs.gnu.org ([208.118.235.92]:52209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fs4Te-0000Yr-MG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fs4QC-0002GY-DV
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:02:06 -0400
References: <20180801133444.11269-1-david@redhat.com>
	<0875c7b5-7cf3-5190-2bc5-c5d05646b0f2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <de135bc3-472f-50c0-55ec-8c82b300cc69@redhat.com>
Date: Tue, 21 Aug 2018 13:01:47 +0200
MIME-Version: 1.0
In-Reply-To: <0875c7b5-7cf3-5190-2bc5-c5d05646b0f2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/4] pc-dimm: pre_plug "slot" and "addr"
 assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, Eric Auger <eric.auger@redhat.com>

On 20/08/2018 18:15, David Hildenbrand wrote:
> On 01.08.2018 15:34, David Hildenbrand wrote:
>> This is basically a resend of v3 with commit message changes.
>>
>> Paolo, if there are no further comments, can you please pick this up for
>> 3.1? Thanks!
> 
> Paolo,
> 
> can you please pick this up? Thanks!

Yup, queued now.

Thanks,

Paolo

>>
>> ---
>>
>> As requested by Igor, assign and verify "slot" and "addr" in the
>> pre_plug handler. Factor out the compatibility handling/configuration
>> for detecting the alignment to be used when searching for an address
>> in guest physical memory for a memory device.
>>
>> This is another part of the original series
>>     [PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers
>>
>> This refactoring is the last step before factoring out pre_plug, plug and
>> unplug logic of memory devices completely into memory-device.c
>>
>> v3 -> v4:
>> - Added rb/acks
>> - Fixed up patch description of last patch
>>
>> v2 -> v3:
>> - "util/oslib-win32: indicate alignment for qemu_anon_ram_alloc()"
>> -- take allocation granularity into account
>> -- drop comment
>> - "pc-dimm: assign and verify the "addr" property during pre_plug"
>> -- compat_align -> legacy_align
>> -- shortened align detection as proposed by Igor
>> -- trace address asignment in pre_plug
>>
>> v1 -> v2:
>> - dropped "machine: factor out enforce_aligned_dimm into memory_device_align"
>> - dropped "pc-dimm/memory-device: detect alignment internally"
>> - added "util/oslib-win32: indicate alignment for qemu_anon_ram_alloc()"
>> -- indicate the alignment and therefor simplify compat handling for
>>    Windows as we can ...
>> - added "pc: drop memory region alignment check for 0"
>> -- ... drop a check for memory_region_get_alignment(mr), allowing us to
>>    factor out compat handling for pc DIMM/NVDIMM alignment in a clean way.
>> - "pc-dimm: assign and verify the "addr" property during pre_plug"
>> -- Default to "memory_region_get_alignment(mr)" if no compat alignment
>>    has been specified.
>>
>> David Hildenbrand (4):
>>   pc-dimm: assign and verify the "slot" property during pre_plug
>>   util/oslib-win32: indicate alignment for qemu_anon_ram_alloc()
>>   pc: drop memory region alignment check for 0
>>   pc-dimm: assign and verify the "addr" property during pre_plug
>>
>>  hw/i386/pc.c             | 16 ++++-------
>>  hw/mem/pc-dimm.c         | 61 +++++++++++++++++++++-------------------
>>  hw/ppc/spapr.c           | 14 ++++++---
>>  include/hw/mem/pc-dimm.h |  5 ++--
>>  util/oslib-win32.c       | 15 ++++++++--
>>  5 files changed, 63 insertions(+), 48 deletions(-)
>>
> 
> 
