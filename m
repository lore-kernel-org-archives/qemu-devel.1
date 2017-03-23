Received: from eggs.gnu.org ([2001:4830:134:3::10]:41105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1cr7Up-0002sX-95
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1cr7Ul-0005Fb-7Z
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:30:03 -0400
Received: from mail-dm3nam03on0054.outbound.protection.outlook.com
	([104.47.41.54]:46928
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1cr7Uk-0005Et-U2
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:29:59 -0400
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900628810.27090.3461280348833651824.stgit@brijesh-build-machine>
	<20170323112922.GB12560@stefanha-x1.localdomain>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <b3cc6807-9cac-968a-0759-60a203102751@amd.com>
Date: Thu, 23 Mar 2017 13:14:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170323112922.GB12560@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 02/20] memattrs: add debug attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: brijesh.singh@amd.com, ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com

Hi Stefan,


On 03/23/2017 06:29 AM, Stefan Hajnoczi wrote:
> On Wed, Mar 08, 2017 at 03:51:28PM -0500, Brijesh Singh wrote:
>> Add a new debug attribute, the attribute should be set when guest memory
>> accesses are performed for debug purposes.
>> The attribute will be used in SEV guest, where we need to distinguish normal
>> vs debug access to guest memory. In debug mode, we need to use SEV commands
>> to access the guest memory.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  include/exec/memattrs.h |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
>> index e601061..b802073 100644
>> --- a/include/exec/memattrs.h
>> +++ b/include/exec/memattrs.h
>> @@ -37,6 +37,8 @@ typedef struct MemTxAttrs {
>>      unsigned int user:1;
>>      /* Requester ID (for MSI for example) */
>>      unsigned int requester_id:16;
>> +    /* Memory access for debug purposes */
>
> What does "debug purposes" mean?  gdbstub?  Can the guest initiate debug
> memory accesses or is the purely QEMU-internal?
>

What I mean by that is, any access to the guest memory within Qemu internal functions
(e.g gdbstub, qemu monitor's memory dump, info mem, info tlb etc). I have also introduced
debug version of ldl_phys, ldq_phys, cpu_physical_memory_* [1] and have updated hmp monitor
code to use the debug version api's when accessing the guest memory [2].

[1] http://marc.info/?l=qemu-devel&m=148900832814697&w=2
[2] http://marc.info/?l=qemu-devel&m=148900831414693&w=2


Note: SEV debug API's are meant to be used by hypervisor to decrypt/encrypt guest memory.
But when you are inside the guest, the  guest will have access to decrypted data and does
not need to call down to hypervisor for debug access.


>> +    unsigned int debug:1;
>>  } MemTxAttrs;
>>
>>  /* Bus masters which don't specify any attributes will get this,
>> @@ -46,4 +48,6 @@ typedef struct MemTxAttrs {
>>   */
>>  #define MEMTXATTRS_UNSPECIFIED ((MemTxAttrs) { .unspecified = 1 })
>>
>> +/* Access the guest memory for debug purposes */
>> +#define MEMTXATTRS_DEBUG ((MemTxAttrs) { .debug = 1 })
>>  #endif
>>
>>
