Received: from eggs.gnu.org ([2001:4830:134:3::10]:48203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cGpAf-00070U-Ud
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cGpAd-0005qr-Bn
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:39:14 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <7f400f89-3a21-bae1-cd16-d23bfa65d973@redhat.com>
References: <cover.1481290956.git.berto@igalia.com>
	<468dbeb8-5b1b-669f-f7e5-0d24a4308da8@redhat.com>
	<w51bmwhck1c.fsf@maestria.local.igalia.com>
	<756cfb05-61e1-7ee3-435b-93759438a52d@redhat.com>
	<w51k2b4htu1.fsf@maestria.local.igalia.com>
	<7f400f89-3a21-bae1-cd16-d23bfa65d973@redhat.com>
Date: Tue, 13 Dec 2016 16:38:02 +0100
Message-ID: <w51h967j0v9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 0/1] Allow storing the qcow2 L2 cache
 in disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Tue 13 Dec 2016 02:44:26 PM CET, Max Reitz wrote:

>>>> But leaving that aside, would that improve anything? I don't think
>>>> the cache itself adds any significant overhead here, IIRC even in
>>>> your presentation at KVM Forum 2015 qcow2 was comparable to raw as
>>>> long as all L2 tables were cached in memory.
>>>
>>> I haven't compared CPU usage, though. That may have gone up quite a
>>> bit, I don't know. For large enough images, it may even become a
>>> bottleneck.
>>
>> I don't know, I don't have any data to suggest that there's a problem
>> there, particularly after the rewrite from last year I think the
>> cache is reasonably fast (as long as the cache is big enough; and if
>> it's not big enough the problem is going to be in the extra I/O).
>
> So the remaining question is whether we want a cache for the cache. If
> the cache is stored directly on an SSD, any access to it has to go
> there and back, and that seems like we may still want to have the
> option of having an in-RAM cache on top of it.

That would be indeed possible... but I wouldn't have any without data
showing that it's worth it.

> If we don't want to split the qcow2 file into separate metadata and
> data files, then we could still create a sparse temporary file at
> runtime which contains all L2 tables. Reading an L2 table then
> wouldn't go through the qcow2 file but through that temporary file and
> our existing metadata cache would work on top of it.

And if you modify a table you have to do it in both places.

The basic idea is the same, anyway. I just started with the assumption
that the L2 cache structures don't add significant overhead and went for
the simplest solution (that's why it's an RFC after all).

But implementation details aside, the main question is whether the best
way to go is to keep the existing metadata and store it in a faster disk
or, as Stefan suggested, think about replacing the current structures
with something else that scales better. I think that's at least worth
exploring.

Berto
