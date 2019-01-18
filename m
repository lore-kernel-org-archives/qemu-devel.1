Received: from eggs.gnu.org ([209.51.188.92]:39654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkX4U-0006jG-VQ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkX4T-000436-JG
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:32:42 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkX4R-0003wU-NM
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:32:41 -0500
Received: by mail-ot1-x341.google.com with SMTP id a11so14854572otr.10
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 08:32:37 -0800 (PST)
MIME-Version: 1.0
References: <20190118132750.25932-1-peter.maydell@linaro.org>
	<64316a28-affa-11ca-2d25-5a34a7787a4a@redhat.com>
	<CAFEAcA_SQ_zMeGxoTb4sYchv_7K=eNTV5XCUTjSp1mz7-igzng@mail.gmail.com>
	<d1ea9ac6-37b3-5c74-fb54-16ad12e1582e@redhat.com>
In-Reply-To: <d1ea9ac6-37b3-5c74-fb54-16ad12e1582e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 16:32:24 +0000
Message-ID: <CAFEAcA_FgHB_JyKkvk0HS6fV9CXs8h9MzPz52VAZgrfRu4rbPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Don't spuriously warn about
 /** comment starters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Reported-by : Thomas Huth" <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On Fri, 18 Jan 2019 at 16:26, Eric Blake <eblake@redhat.com> wrote:
>
> On 1/18/19 10:08 AM, Peter Maydell wrote:
>
> >>> The sequence "/\*\*?" was intended to match either "/*" or "/**",
> >>> but Perl's semantics for '?' allow it to backtrack and try the
> >>> "matches 0 chars" option if the "matches 1 char" choice leads to
> >>> a failure of the rest of the regex to match.  Switch to "/\*\*?+"
> >>> which uses what perlre(1) calls the "possessive" quantifier form:
> >>> this means that if it matches the "/**" string it will not later
> >>> backtrack to matching just the "/*" prefix.
> >>
> >> Just wondering if "/\*{1,2}" would also work (it may have to be spelled
> >> "/\*\{1,2}" - I never remember which flavors of regex have which
> >> extensions without rereading docs)
> >
> > Oh yes, that would probably be the less perl-specific way
> > to write it.
>
> Except it would probably fail in the same way as the non-greedy \*? -
> when \*{2} can't satisfy the regex, the engine will retry with \*{1} and
> then see the second * as noise.

OK, so the patch is good as it is, though it doesn't address
the possible incorrect warnings with trailing whitespace.

> > I'm not sure exactly what I was aiming for with that
> > part of the regex when I wrote it. The comment suggests
> > that I was looking for "non-blank", ie I didn't want to
> > fire on /* or /** followed by just trailing whitespace.
> > The regex as written is clearly not actually doing that,
> > though...
>
> Trailing whitespace is generally a problem anyways, though :)

Yes, but checkpatch already checks for that, so we don't want
to report an incorrect "wrong blockquote" warning as well as
the "trailing whitespace" error, which is what the current
code does:

ERROR: trailing whitespace
#159: FILE: hw/arm/mps2-tz.c:391:
+    /* $

WARNING: Block comments use a leading /* on a separate line
#159: FILE: hw/arm/mps2-tz.c:391:
+    /*

total: 1 errors, 1 warnings, 165 lines checked

thanks
-- PMM
