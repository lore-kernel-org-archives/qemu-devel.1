Received: from eggs.gnu.org ([2001:4830:134:3::10]:40302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXSYi-000696-5N
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXSYh-0005W5-0p
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:05:52 -0500
References: <DB6PR07MB33330E3562B0AF0ECC8307BCAEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<DB6PR07MB3333E95C513AF2EF14AAE615AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<14b32e39-a9f6-1a83-87e6-6e150954ddb7@redhat.com>
	<20181213144914.GH5427@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <db4f1763-e28f-387c-2652-ba71c29e97ff@redhat.com>
Date: Thu, 13 Dec 2018 09:05:43 -0600
MIME-Version: 1.0
In-Reply-To: <20181213144914.GH5427@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] Request for clarification on qemu-img
 convert behavior zeroing target host_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "De Backer, Fred (Nokia - BE/Antwerp)" <fred.de_backer@nokia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Nir Soffer <nsoffer@redhat.com>, qemu block <qemu-block@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, "Aamir T, Owais (Nokia - IN/Chennai)" <owais.aamir_t@nokia.com>

On 12/13/18 8:49 AM, Kevin Wolf wrote:

>>> We observe that in Fedora 29 the qemu-img, before imaging the disk, it fully zeroes it. Taking into account the disk size, the whole process now takes 35 minutes instead of 50 seconds. This causes the ironic-python-agent operation to time-out. The Fedora 27 qemu-img doesn't do that.
>>
>> Known issue; Nir and Rich have posted a previous thread on the topic, and
>> the conclusion is that we need to make qemu-img smarter about NOT requesting
>> pre-zeroing of devices where that is more expensive than just zeroing as we
>> go.
>> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg01182.html
> 
> Yes, we should be careful to avoid the fallback in this case.
> 
> However, how could this ever go from 50 seconds for writing the whole
> image to 35 minutes?! Even if you end up writing the whole image twice
> because you write zeros first and then overwrite them everywhere with
> data, shouldn't the maximum be doubling the time, i.e. 100 seconds?
> 
> Why is the write_zeroes fallback _that_ slow? It will also hit guests
> that request write_zeroes, so I feel this is worth investigating a bit
> more nevertheless.
> 
> Can you check with strace which operation actually succeeds writing
> zeros to /dev/sda? The first thing we try is fallocate with
> FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE. This should always be fast,
> so I suppose this fails in your case. The next thing is BLKZEROOUT,
> which I think can do a fallback in the kernel. Does this return success?
> Otherwise we have another fallback mechanism inside of QEMU, which would
> use normal pwrite calls with a zeroed buffer.

It may also be a case of poor lseek(SEEK_HOLE) performance on the source 
(a known issue with at least some versions of tmpfs). The way qemu-img 
queries for block status, it ends up repeatedly hammering on lseek(), 
and if lseek() is already O(n) instead of O(1) in behavior, that 
explodes into some O(n^2) scaling because qemu-img isn't caching the 
answers it got previously.

> 
> Once we know which mechanism is used, we can look into why it is so
> abysmally slow.

Indeed, performance traces are important for issues like this.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
