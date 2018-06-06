Received: from eggs.gnu.org ([2001:4830:134:3::10]:37060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQYjp-0001S5-SY
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQYjo-00016X-RW
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:44:33 -0400
References: <20180417153945.20737-1-pbonzini@redhat.com>
	<20180417153945.20737-2-pbonzini@redhat.com>
	<8e293555-d8f0-3a00-00d1-2aac514eb1f2@redhat.com>
	<897e242b-ef3b-7eec-8d32-fade89eaf5a9@redhat.com>
	<21dce199-daac-1ac4-ba19-5b20f5898825@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d33d6f3-d30c-08c0-4f77-18cd81050354@redhat.com>
Date: Wed, 6 Jun 2018 15:44:21 +0200
MIME-Version: 1.0
In-Reply-To: <21dce199-daac-1ac4-ba19-5b20f5898825@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] ahci: move PIO Setup FIS before
 transfer, fix it for ATAPI commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

On 05/06/2018 01:27, John Snow wrote:
> 
> 
> On 06/04/2018 11:50 AM, Paolo Bonzini wrote:
>> On 02/06/2018 03:22, John Snow wrote:
>>> - Status: Should be the status register after receiving the H2D Register
>>>   update FIS, but prior to the data transfer, I think. "New value of the
>>>   Status register of the Command Block for initiation of host data
>>>   transfer."
>>>   I think this is being set correctly after this patch.
>>>
>>> - Error: "Contains the new value of the Error register of the Command
>>>   Block at the conclusion of all subsequent Data to Device frames."
>>>
>>>   This is why we were sending out post-hoc PIO Setup FIS frames before,
>>>   how would I know what the error register *will* be...? What?
>>
>> You don't, I guess.  Zero?
>>
> 
> Yeah, I don't mean to hold it up based on other arcane stuff, I was just
> briefly hoping that maybe you actually understood it so I could fix it
> once and for all...
> 
>>> - LBA: Presumably unimportant for the purposes of receiving a command
>>>   PACKET, as we won't be writing it to disk, but a buffer. The values
>>>   can be reported dutifully.
>>>
>>> - Device: Just report the register value dutifully.
>>>
>>> - Count: Likely just relays 0, as the H2D REG FIS should have updated
>>>   that to zero as part of the PACKET command, as per ATA8 ACS3 7.21.3.
>>>   In any case, just report the register value dutifully.
>>>
>>> - E_Status: "Contains the new value of the Status register of the
>>>   Command Block at the conclusion of the subsequent Data FIS."
>>>
>>>   Again, how would I know...?
>>>
>>> - Transfer Count: Should be 12, as per what we specified in 0xA1
>>>   IDENTIFY PACKET DEVICE, see core.c line 234. Your patch gets this
>>>   correct, as we'll actually report the PIO FIS for the packet itself.
>>>
>>>
>>> What this patch does do, though, is change the context of the Status,
>>> Error and E_Status registers to something different. Everything else
>>> should be the same, but I'd feel better about taking this patch if I
>>> understood what exactly this FIS packet was supposed to convey, but I don't.
>>
>> At least Status and Transfer Count are correct after this patch. :/
>>
>> Paolo
>>
> 
> How about ...
> 
> https://github.com/jnsnow/qemu/commit/0657390a2639b7cb533ca8b514c49c0edd3f4483

Yes, it's sane.

Paolo
