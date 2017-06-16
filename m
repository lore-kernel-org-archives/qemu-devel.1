Received: from eggs.gnu.org ([2001:4830:134:3::10]:33517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dLm8U-0001kG-LO
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 03:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dLm8Q-0000AV-Of
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 03:57:42 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:34019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dLm8Q-00008E-Iw
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 03:57:38 -0400
Received: by mail-it0-x243.google.com with SMTP id 201so4167601itu.1
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 00:57:36 -0700 (PDT)
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
	<4f1e9592-566f-b558-91e8-e39ac8691455@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <06ef9280-959a-82ca-7de6-b2c7a991093c@ozlabs.ru>
Date: Fri, 16 Jun 2017 17:57:29 +1000
MIME-Version: 1.0
In-Reply-To: <4f1e9592-566f-b558-91e8-e39ac8691455@redhat.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] spapr: DRC cleanups (part IV)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, mdroth@linux.vnet.ibm.com
Cc: sursingh@redhat.com, bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org

On 16/06/17 03:10, Laurent Vivier wrote:
> On 08/06/2017 07:09, David Gibson wrote:
>> This fourth isntallment of cleanups to the DRC code introduces the
>> first changes to the fundamental state handling.  We change the
>> initial states in the reset code and attach code for PCI devices, and
>> are able to remove the 'signalled' state variable with those fixes.
>>
>> There are also some more mechanical cleanups in preparation for
>> further cleanups and fixes to the state management.
>>
>> David Gibson (6):
>>   spapr: Start hotplugged PCI devices in ISOLATED state
>>   spapr: Eliminate DRC 'signalled' state variable
>>   spapr: Split DRC release from DRC detach
>>   spapr: Make DRC reset force DRC into known state
>>   spapr: Clean up DRC set_allocation_state path
>>   spapr: Clean up DRC set_isolation_state() path
>>
>>  hw/ppc/spapr.c             |  15 --
>>  hw/ppc/spapr_drc.c         | 363 +++++++++++++++++++++++----------------------
>>  hw/ppc/spapr_events.c      |  10 --
>>  include/hw/ppc/spapr_drc.h |  10 +-
>>  4 files changed, 188 insertions(+), 210 deletions(-)
>>
> 
> I've tested your series rebased on master.


I have tested git://github.com/dgibson/qemu.git drcIV branch with 2xXHCI
multifunction PCI hotplug, works fine.


> 
> - plugging a CPU while the OS is not started (stopped in SLOF/GRUB):
> 
>     The cpu can be hotplugged, but once the OS is started, the OS
>     doesn't detect it and it can't be unplugged.
> 
> - plugging a memory DIMM while the OS is not started:
> 
>     The first device_del does nothing, the second one crashes qemu
> 
> - migration with hotplugged cpu (with OS started):
> 
>      CPU cannot be unplugged on destination side
> 
> - migration with hotplugged memory DIMM (with OS started):
> 
>      The first device_del does nothing, the second one crashes qemu
> 
> As it's cleanup, I guess this is what is expected
> (the results are the same as before cleanup series).
> 
> Laurent
> 


-- 
Alexey
