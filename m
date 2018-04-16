Received: from eggs.gnu.org ([2001:4830:134:3::10]:48623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f8A1J-0006dm-W8
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 15:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f8A1G-0008PX-Rt
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 15:42:34 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:39636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f8A1G-0008Og-LQ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 15:42:30 -0400
Received: by mail-pg0-x242.google.com with SMTP id b9so4295324pgf.6
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 12:42:30 -0700 (PDT)
References: <20180416151923.22588-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b0d166e4-b84d-e450-b46b-73b609c1185a@linaro.org>
Date: Mon, 16 Apr 2018 09:42:25 -1000
MIME-Version: 1.0
In-Reply-To: <20180416151923.22588-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

On 04/16/2018 05:19 AM, Peter Maydell wrote:
> In commit 8c5931de0ac7738809 we added support for SVE extended
> sigframe records.  These mean that the signal frame might now be
> larger than the size of the target_rt_sigframe record, so make sure
> we call lock_user on the entire frame size when we're creating it.
> (The code for restoring the signal frame already correctly handles
> the extended records by locking the 'extra' section separately to the
> main section.)
> 
> In particular, this fixes a bug even for non-SVE signal frames,
> because it extends the locked section to cover the
> target_rt_frame_record. Previously this was part of 'struct
> target_rt_sigframe', but in commit e1eecd1d9d4c1ade3 we pulled
> it out into its own struct, and so locking the target_rt_sigframe
> alone doesn't cover it. This bug would mean that we would fail
> to correctly handle the case where a signal was taken with
> SP pointing 16 bytes into an unwritable page, with the page
> immediately below it in memory being writable.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The requirements to trigger the bug sound implausible, except
> that the stack page might be unwritable because we just
> executed some trampoline code from it, so perhaps not so
> unlikely as it first seems? Not sure whether to put into 2.12
> or not...
> ---
>  linux-user/signal.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Yes, let's just go ahead and fix this all properly now.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
