Received: from eggs.gnu.org ([2001:4830:134:3::10]:43221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1f3LTb-0002EY-Vv
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1f3LTY-0004ez-PN
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:55:52 -0400
Received: from mail-eopbgr40104.outbound.protection.outlook.com
	([40.107.4.104]:53432
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1f3LTY-0004cs-3w
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:55:48 -0400
References: <41b63d9b-c551-4e22-28f5-1144724dff2e@virtuozzo.com>
	<b446d661-f0f1-2fcb-ada1-b08af58a9c27@redhat.com>
	<618a6c6e-ab1a-1c55-d44d-847c0e3729f4@virtuozzo.com>
	<20180403122714.GB4467@stefanha-x1.localdomain>
From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Message-ID: <1ca2b599-0a26-ae7d-bee5-e0e2e6385f42@virtuozzo.com>
Date: Tue, 3 Apr 2018 15:55:39 +0300
MIME-Version: 1.0
In-Reply-To: <20180403122714.GB4467@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Some thoughts about per-queue iothreads in
 VirtIOBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>


On 4/3/18 3:27 PM, Stefan Hajnoczi wrote:
> On Tue, Mar 20, 2018 at 07:30:04PM +0300, Edgar Kaziakhmedov wrote:
>> On 3/20/18 6:34 PM, Paolo Bonzini wrote:
>>> On 20/03/2018 15:45, Edgar Kaziakhmedov wrote:
>>>
>>>> As I understood from
>>>> Stefan description, it is expected to change significantly
>>>> the approach we use to interact with BlockDriverState.
>>> I don't think the change is very large actually, at least for on-disk
>>> devices.  I haven't yet considered network devices such as libiscsi or ceph.
>> Well, in that case, I will keep working on per-queue iothreads with an
>> existing interface.
>> I asked because it might be reasonable to create BlockBackend device for
>> each queue context and
>> use them independently to avoid some additional locks and synchronization.
>> On the other hand, it can lead to multiple
>> opening of the same image, but as I said it doesn't seem to be a problem for
>> the simplest formats such as raw.
> The special case for raw approach is not suitable for upstream QEMU.
> It's what we started with in -device virtio-blk,x-data-plane=on (see the
> old dataplane implementation in QEMU v1.4).


Yes, definitely. I went through the whole development path and analyzed 
all your patches. Moreover,
it is clear that this approach is not suitable for the upstream, but I 
am considering it like the first step toward
per-queue iothread implementation, for now the work seems to be almost 
done, may be it might take one more week to
refine and debug.

>
> It took a lot of work to make the IOThread use the QEMU block layer
> instead of a special case code path for raw.
>
> Currently QEMU is not that far away from being able to use
> BlockDriverState from multiple threads for multiqueue.
>
> Paolo, can you share your current progress and pointers to what needs to
> be done next?  Maybe Edgar can help complete the work.
>
> Stefan
