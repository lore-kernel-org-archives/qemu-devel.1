Received: from eggs.gnu.org ([2001:4830:134:3::10]:43619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyWYh-0004xx-6J
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 01:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyWYg-000272-FT
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 01:45:11 -0400
References: <20180223152640.11459-1-pbonzini@redhat.com>
	<20180223152640.11459-5-pbonzini@redhat.com>
	<2464c1eb-2ada-7105-3029-2ff28dc5bfa0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d696a0fc-543b-69e5-cc65-f97c412124af@redhat.com>
Date: Wed, 21 Mar 2018 06:44:52 +0100
MIME-Version: 1.0
In-Reply-To: <2464c1eb-2ada-7105-3029-2ff28dc5bfa0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] atapi: call ide_set_irq before
 ide_transfer_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org

On 21/03/2018 01:35, John Snow wrote:
>> The ATAPI_INT_REASON_IO interrupt is raised when I/O starts, but in the
>> AHCI case ide_set_irq was actually called at the end of a mutual recursion.
>> Move it early, with the side effect that ide_transfer_start becomes a tail
>> call in ide_atapi_cmd_reply_end.
>>
> Do you know in which spec it specifies that we should interrupt?
> 
> Seems okay, but I wanted to double check the wording in the spec (was
> looking in scsi MMC and ATA8) and couldn't find it quickly.

I have an "Interrupt Reason" field in my copy of the ATA/ATAPI spec:

---
6.4.3 Input/Output (I/O) bit
The Input/Output bit shall be cleared to zero if the transfer is to the
device. The Input/Output bit shall be set to one if the transfer is to
the host. In ATA/ATAPI-7 this bit was documented as the I/O bit.
---

I suppose the commit message needs some improvement---the point is that
since this is a READ, the I/O bit must be set before we start the
transfer.  It can be done after the disk I/O starts, but it must be done
before the PIO transfer starts; in other words, the bug is only there
for AHCI.

Paolo
