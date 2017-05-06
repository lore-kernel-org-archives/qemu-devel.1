Received: from eggs.gnu.org ([2001:4830:134:3::10]:53766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6v0m-0007ea-NV
	for qemu-devel@nongnu.org; Sat, 06 May 2017 04:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6v0j-0002Mi-I8
	for qemu-devel@nongnu.org; Sat, 06 May 2017 04:24:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6v0j-0002Ma-Bp
	for qemu-devel@nongnu.org; Sat, 06 May 2017 04:24:17 -0400
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
	<20170505074143.GB21435@lemon.lan>
	<298bd169-6f9f-e622-1b8b-85ef126d8d0c@linux.vnet.ibm.com>
	<ca23d2f5-1296-976b-fe98-35277eb632f9@redhat.com>
	<c50c12c0-93bb-bd40-9751-d4b716407c20@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eecd3b1f-a554-b64e-30ba-a45b053f5260@redhat.com>
Date: Sat, 6 May 2017 10:24:12 +0200
MIME-Version: 1.0
In-Reply-To: <c50c12c0-93bb-bd40-9751-d4b716407c20@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/5] Enable virtio-scsi boot from
 /dev/sgX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>, Fam Zheng <famz@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>



On 05/05/2017 18:12, Eric Farman wrote:
> 
> 
> On 05/05/2017 11:13 AM, Paolo Bonzini wrote:
>>
>>
>> On 05/05/2017 17:03, Eric Farman wrote:
>>> We get a value of x3fffff when sending that to a scsi-disk from bios
>>> code.  That's fully emulated though, in scsi_disk_emulate_inquiry.  And
>>> that's the scenario that already works.
>>>
>>> While there is indeed code in hw/scsi/scsi-generic.c to wire that in,
>>> that only happens after the I/O goes to the device itself.  The Block
>>> Limits page isn't supported [1] and thus it gets rejected with "invalid
>>> field in cdb".  We never get to that fixup code you reference, since the
>>> returned len is zero.
>>>
>>> Should I be refactoring this code to always patch in that block limit
>>> regardless of a response from the host/device?  (That is, when page xb0
>>> isn't supported by the hw.)
>>
>> What is the BLKSECTGET value you get?
> 
> x140000 bytes when using /dev/sg0 (xa00 sectors when using /dev/sda).
> 
>>  Is there a sensible default value
>> that you can use when page 0xb0 isn't supported by the hardware?
> 
> I was setting max_sectors to x800 with good success, which was the
> power-of-2 floor that BLKSECTGET gave us.  That kept us within the
> limits of the host biovec code.  But it's a long way from the
> virtio-scsi value of xFFFF when max_sectors isn't specified, so don't
> know what side effects that may cause.

It's just slower, but 0x800 is already a megabyte worth of data so it's
not going to be that much slower.

Paolo
