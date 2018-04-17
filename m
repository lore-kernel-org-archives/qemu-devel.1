Received: from eggs.gnu.org ([2001:4830:134:3::10]:53700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8P9w-0007v7-L1
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 07:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8P9v-0007Gg-MN
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 07:52:28 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8P9v-0007GS-HY
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 07:52:27 -0400
Received: by mail-ot0-x243.google.com with SMTP id p33-v6so20995346otp.11
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 04:52:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b0d166e4-b84d-e450-b46b-73b609c1185a@linaro.org>
References: <20180416151923.22588-1-peter.maydell@linaro.org>
	<b0d166e4-b84d-e450-b46b-73b609c1185a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 12:52:06 +0100
Message-ID: <CAFEAcA8Q7bN28fPjHzAiBDAnFCDUp_w2bucT20DNsexzXhCx+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [prefix=PATCH for-2.12?] linux-user: check that
 all of AArch64 SVE extended sigframe is writable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, "patches@linaro.org" <patches@linaro.org>

On 16 April 2018 at 20:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 04/16/2018 05:19 AM, Peter Maydell wrote:
>> In commit 8c5931de0ac7738809 we added support for SVE extended
>> sigframe records.  These mean that the signal frame might now be
>> larger than the size of the target_rt_sigframe record, so make sure
>> we call lock_user on the entire frame size when we're creating it.
>> (The code for restoring the signal frame already correctly handles
>> the extended records by locking the 'extra' section separately to the
>> main section.)
>>
>> In particular, this fixes a bug even for non-SVE signal frames,
>> because it extends the locked section to cover the
>> target_rt_frame_record. Previously this was part of 'struct
>> target_rt_sigframe', but in commit e1eecd1d9d4c1ade3 we pulled
>> it out into its own struct, and so locking the target_rt_sigframe
>> alone doesn't cover it. This bug would mean that we would fail
>> to correctly handle the case where a signal was taken with
>> SP pointing 16 bytes into an unwritable page, with the page
>> immediately below it in memory being writable.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> The requirements to trigger the bug sound implausible, except
>> that the stack page might be unwritable because we just
>> executed some trampoline code from it, so perhaps not so
>> unlikely as it first seems? Not sure whether to put into 2.12
>> or not...
>> ---
>>  linux-user/signal.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> Yes, let's just go ahead and fix this all properly now.
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Applied, thanks.

-- PMM
