Received: from eggs.gnu.org ([2001:4830:134:3::10]:52057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gM9Ql-0000xC-Ct
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gM9Qh-0003r5-DG
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:26:55 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <62cb7e48-9120-ace4-cd84-f462b3100251@redhat.com>
References: <cover.1541595424.git.berto@igalia.com>
	<d213fb4eb326353eccde0ea1c5a05bba2da706e0.1541595424.git.berto@igalia.com>
	<62cb7e48-9120-ace4-cd84-f462b3100251@redhat.com>
Date: Mon, 12 Nov 2018 11:26:11 +0100
Message-ID: <w51muqebni4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 14/15] block: Remove assertions from
 update_flags_from_options()
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

On Sun 11 Nov 2018 10:01:05 PM CET, Max Reitz wrote:
> On 07.11.18 13:59, Alberto Garcia wrote:
>> This function takes three options (cache.direct, cache.no-flush and
>> read-only) from a QemuOpts object and updates the flags accordingly.
>
> and auto-read-only now

Oops, will update.

> Hm, seems like one way to solve it and I can't really find issue with
> it.  So, let's first give a
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>
> However, I wonder why you dropped your patch from v1 for this.  It
> seemed more reasonable to me.  You're basically trading half-updating
> the flags for just not touching them at all (and the latter seems
> better, even though it's all an error in the end anyway).

The main reason why I'm doing this is because if we keep the assertions
then we're forced to have these four options always set, and I don't see
any reason why they would need to be.

It's not a problem now but it will be later on. Have a look at this
early implementation of qmp_x_blockdev_reopen():

   https://lists.gnu.org/archive/html/qemu-block/2018-06/msg00795.html

Here we need to explicitly set those options to false if they're
unset. 'false' is already the default value of all of them, so this
shouldn't be necessary, but if we don't do it we'd hit the assertions
that I'm removing in this patch.

Berto
