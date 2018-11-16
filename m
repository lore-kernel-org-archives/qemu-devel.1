Received: from eggs.gnu.org ([2001:4830:134:3::10]:44859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNhJX-0007cY-5v
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNhJW-0008Oj-A8
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:49:51 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNhJU-0008Mw-9a
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:49:50 -0500
Received: by mail-oi1-x243.google.com with SMTP id x202so8750397oif.13
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 08:49:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <eeb95dc4-f1ee-4224-4efe-c4a33ffbae25@redhat.com>
References: <20181016132018.5054-1-vsementsov@virtuozzo.com>
	<20181017095128.GK22755@stefanha-x1.localdomain>
	<CAFEAcA_h8pWjNokWQqUXqLDS=WrtKz-zKQ4QjhjV5UR2Yb8MbQ@mail.gmail.com>
	<97c6b0f3-da95-7c99-c478-303544c2990b@redhat.com>
	<CAFEAcA8B5Ki=qmVGrLvWH4oO6Zaf43_NUAsgwwmCqGqcgj3RAQ@mail.gmail.com>
	<eeb95dc4-f1ee-4224-4efe-c4a33ffbae25@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 16:49:25 +0000
Message-ID: <CAFEAcA8teKsLNvr_xrh5ru=ANC-Wi_mHnULViEc1qpKsC+Ok0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] migration/block-dirty-bitmap:
 fix Coverity CID1390625
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On 16 November 2018 at 16:16, John Snow <jsnow@redhat.com> wrote:
> On 11/16/18 5:04 AM, Peter Maydell wrote:
>> Personally I think the main benefit of this sort of Coverity
>> warning is that it nudges you to work through and figure out
>> whether something really can be NULL or not. Stefan's fix
>> will satisfy Coverity, because what it's complaining about
>> is that the code in one place assumes a pointer can't be NULL
>> but in another place does have handling for NULL: it is the
>> inconsistency that triggers the warning. If backing_bs()
>> can't return NULL (ie if you would be happy in theory to put
>> an assert() in after the call) then I think Stefan's fix is
>> better. If it can return NULL ever then Vladimir's fix is
>> what you want.

> I really don't think it can, but I don't actually know how to verify it
> or to convince Coverity of the same. Stefan's suggestion seems most
> appropriate if it actually does calm Coverity down.

I think it will quieten Coverity; if it doesn't, then at that point
we can happily mark the issue a false-positive. But as I say what
Coverity is really identifying here is "you checked whether
this pointer was NULL, but then there's a code path forward
to a place where you used it without checking" -- so removing
the unnecessary check will make it happy.

> (Is it mechanically possible to violate this? That's very hard to audit
> and promise for you. There are always bugs lurking somewhere else.)

If you believe by design that it can't be NULL, then we're OK:
if it ever turns out that it isn't, then we will get a nice
easy-to-debug SEGV when we dereference the NULL pointer,
and we can find out then what bug resulted in our design
assumption being broken.

> Stefan's suggestion is probably most appropriate, *if* it actually
> shushes Coverity. I'll send you a small patch and you can find out? I
> don't want to task offload but I also genuinely don't know if that will
> hint to coverity strongly enough that this is a false positive.

Coverity runs only on git master, so fixes have to go into
master to be tested, unfortunately.

thanks
-- PMM
