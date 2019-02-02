Received: from eggs.gnu.org ([209.51.188.92]:57622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gpjgv-0006iV-51
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 20:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gpjgq-000375-5o
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 20:01:50 -0500
References: <20190131010136.12007-1-jsnow@redhat.com>
	<bd72a7c8-e283-dd3a-66e8-ba50873a8717@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <67cd0ccf-a9ce-9a72-0676-1ab6a33a7e03@redhat.com>
Date: Fri, 1 Feb 2019 20:01:20 -0500
MIME-Version: 1.0
In-Reply-To: <bd72a7c8-e283-dd3a-66e8-ba50873a8717@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/dirty-bitmap: Documentation and
 Comment fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>



On 1/31/19 3:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> 
> About @frozen and @locked, we can also note that they can't be exported through NBD.
> We can summarize, that @frozen and @locked means that user can't use them in any
> command, and the only option is to list them. However even info->count information
> should not be considered as something meaningful, as bitmaps are under some operations.
> And we can also use same paragraph for @frozen and @locked, as a first step to @frozen
> deprecation.

There's a subtle difference in the two, namely that:

(1) Frozen may or may not record new writes, but they don't "show up"
until after the operation is over, because it's using a second bitmap as
a temporary buffer.

(2) Locked may or may not record new writes *immediately*.

Regardless, I'm realizing that for both Frozen and Locked bitmaps we
want to allow users to know if the bitmap is recording or not. (And
possibly if there is a temporary write cache or not, but maybe it's not
important.)

Maybe we want two new fields on query:

Recording/Enabled: [True | False]
Busy/Locked:       [True | False] (or "Locked)

which will then deprecate the status field. This doesn't manage to
communicate the write cache nuance, but maybe we don't need to.

(It also doesn't help elucidate whether or not the successor is
active/disabled, but even for migration once the guest has started, the
successors are always enabled, right?)

Thoughts?
