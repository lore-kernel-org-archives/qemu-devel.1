Received: from eggs.gnu.org ([2001:4830:134:3::10]:59473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dnPcl-0002v3-88
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dnPci-0007tb-63
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:35:11 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:45881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dnPch-0007fd-PC
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:35:08 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <f44d823d-d7a6-1783-051f-9d754ada0475@huawei.com>
References: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51fuc98di8.fsf@maestria.local.igalia.com>
	<9b24c28f-f891-1046-f09f-bffded9e316f@huawei.com>
	<w51bmmx85so.fsf@maestria.local.igalia.com>
	<f6cdc881-39a4-92f6-c218-a57516ca0921@huawei.com>
	<w518ti1851v.fsf@maestria.local.igalia.com>
	<f44d823d-d7a6-1783-051f-9d754ada0475@huawei.com>
Date: Thu, 31 Aug 2017 15:34:16 +0200
Message-ID: <w51pobb509z.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Wed 30 Aug 2017 05:12:22 PM CEST, Pradeep Jagadeesh wrote:
> On 8/30/2017 5:10 PM, Alberto Garcia wrote:
>> On Wed 30 Aug 2017 05:07:29 PM CEST, Pradeep Jagadeesh wrote:
>>
>>> Thanks for the steps, I did reproduce the issue easily. Looking into
>>> the code, may be we also need to try the same with the block devices.
>>
>> I did some tests and it was working fine, so I'd suspect of the fsdev
>> code first.
>>
> OK, thanks for the clarification. I will look into fsdev code.

I just took a quick look at the code, the problem is almost certainly in
fsdev_set_io_throttle(): that doesn't simply update the config, it also
reinitializes the FsThrottle structure completely, creates new timers
and new throttled_reqs queues. If there were pending requests there
they're probably lost forever.

Take a look at blk_set_io_limits() and see how it is done for block
devices.

Berto
