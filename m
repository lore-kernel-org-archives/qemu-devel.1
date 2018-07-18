Received: from eggs.gnu.org ([2001:4830:134:3::10]:57520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ffhFk-0004qH-HZ
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ffhFh-0000ut-EB
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:52:04 -0400
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-15-git-send-email-jjherne@linux.ibm.com>
	<a00e445e-f8f5-b098-bccb-7fcaf1260402@redhat.com>
	<20180718094039.3271a216.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <708ac2f0-7198-8e52-5a6d-eac7a7123d49@redhat.com>
Date: Wed, 18 Jul 2018 09:51:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180718094039.3271a216.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 14/15] s390-bios: Support
 booting from real dasd device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On 18.07.2018 09:40, Cornelia Huck wrote:
> On Tue, 17 Jul 2018 22:43:27 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 05.07.2018 19:25, Jason J. Herne wrote:
> 
>>> +*****************************************
>>> +***** How this all pertains to Qemu *****
>>> +*****************************************
>>> +
>>> +In theory we should merely have to do the following to IPL/boot a guest
>>> +operating system from a DASD device:
>>> +
>>> +1. Place a "Read IPL" ccw into memory location 0x0 with chaining bit on.
>>> +2. Execute channel program at 0x0.
>>> +3. LPSW 0x0.
>>> +
>>> +However, our emulation of the machine's channel program logic is missing one key
>>> +feature that is required for this process to work: non-prefetch of ccw data.
>>> +
>>> +When we start a channel program we pass the channel subsystem parameters via an
>>> +ORB (Operation Request Block). One of those parameters is a prefetch bit. If the
>>> +bit is on then Qemu is allowed to read the entire channel program from guest
>>> +memory before it starts executing it. This means that any channel commands that
>>> +read additional channel commands will not work as expected because the newly
>>> +read commands will only exist in guest memory and NOT within Qemu's channel
>>> +subsystem memory. Qemu's channel subsystem's implementation currently requires
>>> +this bit to be on for all channel programs. This is a problem because the IPL
>>> +process consists of transferring control from the "Read IPL" ccw immediately to
>>> +the IPL1 channel program that was read by "Read IPL".
>>> ++  
>>
>> I have way too little insight into channel devices and how QEMU
>> implements them, however I wonder what hinders us from implementing
>> support for !prefetch in QEMU?
>>
>> What you tailored here seems impressive :) Just want to know what the
>> technical background of this prefetch thingy in QEMU is.
> 
> This has to do with how vfio-ccw processes and translates channel
> programs.
> 

Ah, okay, I thought this was *QEMUs* fault, but it actually is
vfio-ccw's fault, and QEMU can't do anything about it.

> Currently, we hand over the chain of channel commands to the kernel to
> be translated (guest->host addresses) and to execute ssch on the real
> subchannel. However, this requires sending the channel program over in
> one go, which makes it impossible for the guest to modify an in-flight
> channel program (there are tricks like putting a suspend marker on a
> channel command and moving that marker forward as you go which make it
> possible to know that a channel command has not yet been processed;
> IIRC the lcs driver in Linux does that, or at least used to do that).
> Our implementation currently does not accommodate that (the Linux dasd
> driver does not use that feature). It's not impossible to implement it,
> but it would require some effort (and I don't think anybody currently
> has spare time for that...)

Spare time, what's that? :)

Thanks for the background info!


-- 

Thanks,

David / dhildenb
