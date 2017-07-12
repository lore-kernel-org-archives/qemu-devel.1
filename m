Received: from eggs.gnu.org ([2001:4830:134:3::10]:42724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVCHj-0004bX-0w
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVCHi-0006pv-9z
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:42:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
	<20170711163748.17817-3-el13635@mail.ntua.gr>
	<b8bcff15-2d6c-bca9-cd44-b03ddf7d7812@redhat.com>
Date: Wed, 12 Jul 2017 09:41:57 +0200
In-Reply-To: <b8bcff15-2d6c-bca9-cd44-b03ddf7d7812@redhat.com> (Eric Blake's
	message of "Tue, 11 Jul 2017 12:09:03 -0500")
Message-ID: <87y3ruaypm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 2/4] block: remove bdrv_media_changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 07/11/2017 11:37 AM, Manos Pitsidianakis wrote:
>> This function is not used anywhere, so remove it.
>> 
>
> Might be interesting to figure out when it WAS last used.

Yes.  When I see "remove X because it's unused" during patch review, I
immediately ask "why is it unused now, and what was it used for
previously?"  Ideally, the commit message answers these questions
preemptively.

>                                                            If I grepped
> correctly, it was commit 21fcf360 back in May 2012?

Yes.  "fdc: simplify media change handling".  I suspect that commit
broke media change for passed-through host floppy.

Its only implementation went away in commit f709623 "block: Remove host
floppy support".

Suggest

    block: bdrv_media_changed() is unused, remove

    The i82078 floppy device model used to call bdrv_media_changed() to
    implement its media change bit when backed by a host floppy.  This
    went away in 21fcf36 "fdc: simplify media change handling".
    Probably broke host floppy media change.  Host floppy pass-through
    was dropped in commit f709623.  bdrv_media_changed() has never been
    used for anything else.  Remove it.
