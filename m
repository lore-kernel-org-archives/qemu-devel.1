Received: from eggs.gnu.org ([2001:4830:134:3::10]:38175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn2ZE-0002m1-NP
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn2Z8-0002n1-RQ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:02:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55578 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fn2Z8-0002mq-MC
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:02:26 -0400
References: <CAB3eZftOpC9tj4SrRKX=s40md+UjSCC-X=+NC89aV=EVs_XbUw@mail.gmail.com>
	<20180807123431.GB4499@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b41f597-7d7b-8c19-51ee-274d5312395e@redhat.com>
Date: Tue, 7 Aug 2018 09:02:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180807123431.GB4499@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] How to discard one range which overlap with
 backing file and its children img?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, lampahome <pahome.chen@mirlab.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 08/07/2018 07:34 AM, Kevin Wolf wrote:
> Am 07.08.2018 um 09:06 hat lampahome geschrieben:
>> I have image A & B, and A is backing file of B.
>>
>> After I mount A to /dev/nbd0 and I write from position 0~999 in nbd0.
>>
>> Then create B and set A as backing file of B.
>>
>> I mount B on /dev/nbd1 and I can saw the data from pos:0~999 because A is
>> B's backing file. That's reasonable.
>>
>>
>> But I want to discard range 0~500 in B. I expect there's no data in 0~500
>> after discard and re-mount B next time.
>>
>> But the data is still in A.
>>
>> How can I discard range 0~500?
> 
> Note that discard simply means that you don't care about the content any
> more. This doesn't guarantee that the old data can't be read any more.
> If you want to make the data invisible, you need a zero write operation
> instead. For a Linux guest, have a look at the "fallocate -z" command
> line tool.

What's more, once you make A the backing file to B, then all actions you 
perform through qemu operate only on B (A is treated as read-only).  So, 
writing zeroes (or discarding) changes the contents of B, but does NOT 
change the content of A.

Furthermore, both discard and write zeroes tend to have alignment 
constraints. If you are actually working on bytes 0-999 (which is 
unaligned to sector boundaries of 512, let alone qcow2 cluster 
boundaries that default to 64k but can be even larger), the discard is 
likely to be a no-op (since discard tends to be a no-op if it does not 
meet larger alignment boundaries), while the write zeroes will work but 
will result in a slower read-modify-write if it is targetting a block 
device.  If you are instead working on sectors 0-999 (bytes 0-511999), 
you have more of a chance of seeing discard in action, as well as write 
zeroes being more efficient.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
