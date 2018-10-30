Received: from eggs.gnu.org ([2001:4830:134:3::10]:54225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHZ5C-00071P-W7
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHZ5B-00022r-84
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:49:43 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHZ59-00022I-UH
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:49:40 -0400
Received: by mail-ot1-x343.google.com with SMTP id g10so1082422otl.12
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 11:49:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
References: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 18:49:18 +0000
Message-ID: <CAFEAcA9czM5qCtj3F_QAhS8dP7yQog-9eD8dGP0qaSeOZ_hang@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/24] qemu-ga patch queue for soft-freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 October 2018 at 14:43, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> The following changes since commit 62b658db1df7c6fa574caae038144f24bf6ca495:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-10-29 17:03:27 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2018-10-30-tag
>
> for you to fetch changes up to 86f167a2326cebec947da6526dae0a356148bd8a:
>
>   qga-win: changing --retry-path option behavior (2018-10-30 09:06:28 -0500)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for soft-freeze
>
> * support for --retry-path option for recovering from communication
>   path failures
> * support for serial/device name in guest-get-fsinfo for linux/w32
> * support for freezing individual mount points in guest-fsfreeze-*
> * fixes for unicode paths on w32, not-present vcpus in guest-get-vcpus,
>   buffer overflow in guest-get-fsinfo for w32, and other minor fixes
>
> ----------------------------------------------------------------

I get a compile failure here for my Ubuntu x86-64 host
static build:

  LINK    qemu-ga
/usr/bin/ld: cannot find -ludev

This is probably because my system has libudev as a dynamic
library but not a static one. Googling suggests that libudev
upstream don't support providing a static library, so we
need to either make configure handle this case or declare
(and enforce?) that --static requires --disable-tools.

It seems to me that a statically linked guest agent might
be useful for some use cases? It would mean you didn't have
to depend on the exact libraries the guest had installed.

(As an aside, it's an ubuntu bug that
"pkg-config --static --libs libudev" doesn't correctly report
that it can't do static linking of this library, but this
is an extremely common bug in library pkg-config files.)

thanks
-- PMM
