Received: from eggs.gnu.org ([2001:4830:134:3::10]:52711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJKWn-0000bo-6P
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJKWh-0002yd-6S
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:36:57 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:41973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJKWg-0002y3-WC
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:36:51 -0500
Received: by mail-ot0-x231.google.com with SMTP id b54so24322655otd.8
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 06:36:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e247c73f-7390-1ce8-14d5-5aba2f1b36f8@comstyle.com>
References: <20171126211356.GA46174@humpty.home.comstyle.com>
	<CAFEAcA_m0KMfsUYWpdg2LL2y5U88d4-LoXZuUXkGUxtGCgD66g@mail.gmail.com>
	<e247c73f-7390-1ce8-14d5-5aba2f1b36f8@comstyle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Nov 2017 15:36:29 +0100
Message-ID: <CAFEAcA__P-1VafTXstnKT3vTHRg5RvQToUEUcd6amXQH40FcXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Fix curses probe for older
 ncurses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 November 2017 at 14:52, Brad Smith <brad@comstyle.com> wrote:
> On 11/27/2017 7:02 AM, Peter Maydell wrote:
>
>> On 26 November 2017 at 22:13, Brad Smith <brad@comstyle.com> wrote:
>>>
>>> Fix the curses probe with older ncurses (.e.g. 5.7, as used by OpenBSD).
>>>
>>> ncurses 5.7 requires _XOPEN_SOURCE_EXTENDED to be defined for WACS_*
>>> constants.
>>
>> ncurses 5.7 was released in 2008 and is now 9 years old. Why
>> is OpenBSD still using such an ancient version?

> Someone has to put the time and effort into updating it.

Yes, but staying up to date with the libraries you ship is
table stakes for being a serious OS. Having a sufficiently
large and active developer community that this can happen is
one of the things that separates "OS usable in production"
from "hobby project, research project or just defunct OS"
in my view.

>> I'm a bit wary of this because we've found in the past that
>> defining _XOPEN_* defines breaks compilation with some
>> C libraries which assume that if you define _XOPEN_whatever
>> it means "only that X/Open stuff and no OS-specific extras",
>> and we depend on the OS-specific extras.
>>
>> That said, I did a test compile on OSX, which was the
>> one that had trouble previously, so this may be OK. I think
>> I'd rather leave it until after 2.11 releases, though.

> The other option I was looking at was removing the add_wch() function
> call from the probe as the rest of the curses code within QEMU compiles
> Ok without _XOPEN_SOURCE_EXTENDED.

That would break the fix made in commit 7c7030029626 -- we want
to be sure we're actually getting a wide-character aware version
of the headers, on systems which might have both the non-widechar
and widechar headers in different places.

thanks
-- PMM
