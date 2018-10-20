Received: from eggs.gnu.org ([2001:4830:134:3::10]:51505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDxFj-0000I0-AL
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 15:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDxFg-0004Jm-3D
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 15:49:39 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDxFf-0004Ix-MI
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 15:49:36 -0400
Received: by mail-pf1-x441.google.com with SMTP id j23-v6so18003455pfi.4
	for <qemu-devel@nongnu.org>; Sat, 20 Oct 2018 12:49:35 -0700 (PDT)
References: <20181019174958.26616-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a54dfbd-e1fc-b20b-249e-97a613fff1e7@linaro.org>
Date: Sat, 20 Oct 2018 12:49:31 -0700
MIME-Version: 1.0
In-Reply-To: <20181019174958.26616-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: Don't call gdb_handlesig
 unnecessarily
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marek Vasut <marex@denx.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Chris Wulff <crwulff@gmail.com>, patches@linaro.org

On 10/19/18 10:49 AM, Peter Maydell wrote:
> This patchset fixes a minor bug in our handling of SIGTRAP
> in linux-user.
> 
> The CPU main-loop routines for linux-user generally call
> gdb_handlesig() when they're about to queue a SIGTRAP signal.  This
> is wrong, because queue_signal() will cause us to pend a signal, and
> process_pending_signals() will then call gdb_handlesig() itself.  So
> the effect is that we notify gdb of the SIGTRAP, and then if gdb says
> "OK, continue with signal X" we will incorrectly notify gdb of the
> signal X as well.  We don't do this double-notify for anything else,
> only SIGTRAP.
> 
> This bug only manifests if the user responds to the reported SIGTRAP
> using "signal SIGFOO" rather than "continue"; since the latter is the
> overwhelmingly common thing to do after a breakpoint most people
> won't have hit this.
> 
> Patch 1 fixes this bug for every target except nios2, by
> deleting the incorrect code.
> 
> Patch 2 fixes nios2 separately, because it was doing some odd
> things with gdb_handlesig(). This also fixes in passing a Coverity
> issue.
> 
> Tested with "make check-tcg", and with some by-hand stepping
> around with an attached gdb. NB that the nios2 patch is only
> compile tested as I don't have a nios2 linux-user environment
> and check-tcg doesn't cover it.
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>   linux-user: Don't call gdb_handlesig() before queue_signal()
>   linux-user: Clean up nios2 main loop signal handling

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
