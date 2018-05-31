Received: from eggs.gnu.org ([2001:4830:134:3::10]:59081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOPTR-0006DB-UU
	for qemu-devel@nongnu.org; Thu, 31 May 2018 11:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOPTN-0001sx-T3
	for qemu-devel@nongnu.org; Thu, 31 May 2018 11:26:45 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOPTN-0001sX-Mw
	for qemu-devel@nongnu.org; Thu, 31 May 2018 11:26:41 -0400
Received: by mail-ot0-x241.google.com with SMTP id i5-v6so25749201otf.1
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 08:26:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a436fff7-76a3-976b-a5bc-492d1cf054fa@linaro.org>
References: <20180529234409.27023-1-evgreen@chromium.org>
	<a436fff7-76a3-976b-a5bc-492d1cf054fa@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 16:26:20 +0100
Message-ID: <CAFEAcA9mrAVLS-VEyqmdEzAm3jT5PqFrP=cGzbhbeMn-qwsowg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Fix hang with -L and symlink loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Evan Green <evgreen@chromium.org>, QEMU Developers <qemu-devel@nongnu.org>

On 30 May 2018 at 21:50, Richard Henderson <richard.henderson@linaro.org> wrote:
> On 05/29/2018 04:44 PM, Evan Green wrote:
>> When using -L with Linux app emulation, there is an issue in
>> init_paths where Qemu will get lost exploring a directory tree
>> with a symlink loop in it. This causes Qemu to hang, and
>> eventually consume all memory in the system.
>>
>> Qemu's code for pre-exploring the entire directory tree is both
>> error-prone and slow. Instead, this changes uses faccessat, which
>> both avoids the symlink loop (since the entire directory space isn't
>> being explored up front), and likely speeds things up a bit.
>>
>> Partial credit goes to Richard Henderson, as it was only after staring
>> at his patch [1] that I wrote mine.
>>
>> [1] https://patchwork.kernel.org/patch/9512083/
>>
>> Signed-off-by: Evan Green <evgreen@chromium.org>
>> ---
>
> I like this as an improvement on the current situation.
> Perhaps folks do like this a bit better than my more invasive patch.

It seems to me to have the same problem as your patch does,
which is that we now have a file descriptor which belongs
not to the guest but to QEMU, but we make no effort to
hide it from the guest, and so for instance code like that
xinetd "close every fd above 2" loop will break us.

This probably is overall better than the current situation,
though, since it will only kick in if you use -L. But if we're
going to fix this, I think I preferred your patch.

thanks
-- PMM
