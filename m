Received: from eggs.gnu.org ([2001:4830:134:3::10]:45112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWnih-00079Y-9L
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWnig-0005cy-Iz
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:29:27 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWnig-0005cV-CH
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:29:26 -0500
Received: by mail-ot1-x342.google.com with SMTP id f18so15177096otl.11
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 11:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20181210165636.28366-1-peter.maydell@linaro.org>
	<0a32d286-7961-c9cd-2643-cf9cd3c95de8@ilande.co.uk>
In-Reply-To: <0a32d286-7961-c9cd-2643-cf9cd3c95de8@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Dec 2018 19:29:13 +0000
Message-ID: <CAFEAcA8Ubkqgp3jTk1k+xuLUetaQU_mCOEJ95WOUR8hawV7tSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 0/3] target/m68k: convert to
 transaction_failed hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, "patches@linaro.org" <patches@linaro.org>

On Tue, 11 Dec 2018 at 19:13, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 10/12/2018 16:56, Peter Maydell wrote:
> > Anyway, I send it out as a skeleton for comments, because
> > it would be nice to get rid of the old unassigned_access
> > hook, which is fundamentally broken (it's still used by m68k,
> > microblaze, mips and sparc).
>
> Laurent is really the expert here (my work on the q800 was purely on the device
> side), however is this also a nudge to see if the unassigned_access hook can be
> eliminated from sparc too? ;)

It would certainly be great to convert sparc too;
it and mips are a little more complicated than these
ones, but the principle is the same:
 * helper functions in target/sparc which call
   cpu_unassigned_access() should be changed to call
   some sparc-internal function to raise the right
   exception
 * callsites in target/sparc which do loads or stores
   by physical address should be checked to ensure they
   do the right thing when a bus error is detected;
   this usually means changing them to use address_space_*
   functions and check they return MEMTX_OK. (With the
   old unassigned_access hook these would result in calls
   to the hook, which was often the wrong thing anyway.
   The transaction_failed hook is called only for accesses
   via the TCG MMU.) The docs/devel/loads-stores.rst docs
   have some handy regexes for use with 'git grep'; for sparc
   these catch everything:
     git grep '\<ldu\?[bwlq]\(_[bl]e\)\?_phys\>' target/sparc/
     git grep '\<st[bwlq]\(_[bl]e\)\?_phys\>' target/sparc/
 * convert the hook itself: this requires a little fiddling
   of parameters, and the addition of the cpu_restore_state()
   call

(MIPS has some odd board-specific handling on top of that
which will need to be fixed too.)

thanks
-- PMM
