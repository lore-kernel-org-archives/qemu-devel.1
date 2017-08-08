Received: from eggs.gnu.org ([2001:4830:134:3::10]:43813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df5sh-0002E7-DU
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df5se-00041u-9E
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:53:15 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170808134544.paekftiounmirhbo@postretch>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-6-el13635@mail.ntua.gr>
	<w51valyjj7j.fsf@maestria.local.igalia.com>
	<20170808134544.paekftiounmirhbo@postretch>
Date: Tue, 08 Aug 2017 16:53:08 +0200
Message-ID: <w51poc6jeln.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

On Tue 08 Aug 2017 03:45:44 PM CEST, Manos Pitsidianakis wrote:
> On Tue, Aug 08, 2017 at 03:13:36PM +0200, Alberto Garcia wrote:
>>On Mon 31 Jul 2017 11:54:41 AM CEST, Manos Pitsidianakis wrote:
>>> block/throttle.c uses existing I/O throttle infrastructure inside a
>>> block filter driver. I/O operations are intercepted in the filter's
>>> read/write coroutines, and referred to block/throttle-groups.c
>>>
>>> The driver can be used with the syntax
>>> -drive driver=throttle,file.filename=foo.qcow2, \
>>>         limits.iops-total=...,throttle-group=bar
>>
>>Sorry for not having noticed this earlier, but can't you define the
>>throttling group (and its limits) using -object throttle-group ... as
>>shown in the previous patch, and simply reference it here? Or would we
>>have two alternative ways of setting the throttling limits?
>>
>>What happens if you have many -drive lines each one with a different set
>>of limits but with the same throttling group?
>
> The limits of the last one to be processed will win.

That's what the current throttling API does, and I tend to agree that
it's not completely straightforward (a few people have asked me the same
question since this feature is available).

If we're going to add a new API we could eliminate this ambiguity. After
all the previous -drive throttling.iops-total=... would still be
available, wouldn't it?

> So basically if we have anonymous groups, we accept limits in the
> driver options but only without a group-name.

In the commit message you do however have limits and a group name, is
that a mistake?

    -drive driver=throttle,file.filename=foo.qcow2, \
           limits.iops-total=...,throttle-group=bar

Berto
