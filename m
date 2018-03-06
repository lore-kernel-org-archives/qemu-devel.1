Received: from eggs.gnu.org ([2001:4830:134:3::10]:60720)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1etFEe-0007CO-Hn
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1etFEb-0007uB-Qj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:14:40 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:36951 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1etFEb-0007t1-Gy
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:14:37 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Tue, 6 Mar 2018 17:14:31 +0100
References: <c0d7b993-b3b8-a753-21f5-e2257de27caf@kamp.de>
	<20180305114533.GI7910@stefanha-x1.localdomain>
	<0f1ec3c7-1157-e618-62f8-ffd5e08eb342@kamp.de>
	<20180305145215.GM3131@work-vm>
From: Peter Lieven <pl@kamp.de>
Message-ID: <b8bdd9c6-43bc-04cd-8600-d664cbbf2abb@kamp.de>
Date: Tue, 6 Mar 2018 17:14:32 +0100
MIME-Version: 1.0
In-Reply-To: <20180305145215.GM3131@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] block migration and MAX_IN_FLIGHT_IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, wency@cn.fujitsu.com, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Am 05.03.2018 um 15:52 schrieb Dr. David Alan Gilbert:
> * Peter Lieven (pl@kamp.de) wrote:
>> Am 05.03.2018 um 12:45 schrieb Stefan Hajnoczi:
>>> On Thu, Feb 22, 2018 at 12:13:50PM +0100, Peter Lieven wrote:
>>>> I stumbled across the MAX_INFLIGHT_IO field that was introduced in 2015 and was curious what was the reason
>>>> to choose 512MB as readahead? The question is that I found that the source VM gets very unresponsive I/O wise
>>>> while the initial 512MB are read and furthermore seems to stay unreasponsive if we choose a high migration speed
>>>> and have a fast storage on the destination VM.
>>>>
>>>> In our environment I modified this value to 16MB which seems to work much smoother. I wonder if we should make
>>>> this a user configurable value or define a different rate limit for the block transfer in bulk stage at least?
>>> I don't know if benchmarks were run when choosing the value.  From the
>>> commit description it sounds like the main purpose was to limit the
>>> amount of memory that can be consumed.
>>>
>>> 16 MB also fulfills that criteria :), but why is the source VM more
>>> responsive with a lower value?
>>>
>>> Perhaps the issue is queue depth on the storage device - the block
>>> migration code enqueues up to 512 MB worth of reads, and guest I/O has
>>> to wait?
>> That is my guess. Especially if the destination storage is faster we basically alsways have
>> 512 I/Os in flight on the source storage.
>>
>> Does anyone mind if the reduce that value to 16MB or do we need a better mechanism?
> We've got migration-parameters these days; you could connect it to one
> of those fairly easily I think.
> Try: grep -i 'cpu[-_]throttle[-_]initial'  for an example of one that's
> already there.
> Then you can set it to whatever you like.

I will have a look at this.

Thank you,
Peter

>
> Dave
>
>> Peter
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
