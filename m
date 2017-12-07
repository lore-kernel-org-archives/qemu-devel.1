Received: from eggs.gnu.org ([2001:4830:134:3::10]:41793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eN3aq-00089c-L5
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eN3an-0002wB-Dr
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:20:32 -0500
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com
	([104.47.41.71]:59760
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eN3an-0002ud-2w
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:20:29 -0500
References: <20171206200346.116537-1-brijesh.singh@amd.com>
	<20171206200346.116537-2-brijesh.singh@amd.com>
	<CAFEAcA8UvBopec1ammRML+fgh36YLfRyg2wsgmzesmAUFy8H3w@mail.gmail.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <7e7b6c05-68de-c4f8-6163-53588a6d545e@amd.com>
Date: Thu, 7 Dec 2017 15:20:14 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8UvBopec1ammRML+fgh36YLfRyg2wsgmzesmAUFy8H3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 01/23] memattrs: add debug attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: brijesh.singh@amd.com, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>


On 12/06/2017 04:03 PM, Peter Maydell wrote:
> On 6 December 2017 at 20:03, Brijesh Singh <brijesh.singh@amd.com> wrote:
>> The debug attribute will be set when qemu attempts to access the guest
>> memory for debug (e.g memory access from gdbstub, memory dump commands
>> etc).
>>
>> When guest memory is encrypted, the debug access will need to go through
>> the memory encryption APIs.
>>
>> Cc: Alistair Francis <alistair.francis@xilinx.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   include/exec/memattrs.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
>> index d4a16420984b..721362e06292 100644
>> --- a/include/exec/memattrs.h
>> +++ b/include/exec/memattrs.h
>> @@ -37,6 +37,8 @@ typedef struct MemTxAttrs {
>>       unsigned int user:1;
>>       /* Requester ID (for MSI for example) */
>>       unsigned int requester_id:16;
>> +    /* Debug memory access for encrypted guest */
>> +    unsigned int debug:1;
>>   } MemTxAttrs;
> 
> Can we have some more detailed semantics for this please?


Sure, I will add more details. The flag is mainly used to distinguish 
the debug vs non debug access when using address_space_read/write/rw().

If a debug=1 is set then flatview_read(), flatview_write(), 
flatview_rw() will use the encryption APIs when accessing the guest RAM 
case. Since the MMIO regions are not encrypted with guest-specific keys 
hence we don't need to do anything special for the MMIO cases.


> For instance, if a device gets a debug=1 transaction
> should it refuse to do things like read-clears-bits
> semantics or other side-effects you wouldn't expect
> of debugger accesses?
> 

Sorry I am not able to understand "if a device gets a debug=1 
transition" comment, Can you please explain me a bit more. If you give 
me example on how to trigger this type of request with debug=1 then I 
can look into the code and see what we can do when memory encryption is 
enabled. The things like read-clears-bits semantics will be tricky.


> thanks
> -- PMM
> 
