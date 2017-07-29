Received: from eggs.gnu.org ([2001:4830:134:3::10]:42562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dbNyh-0000G8-Im
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 05:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dbNyg-0005XM-8A
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 05:24:07 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dbNyg-0005Ut-1N
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 05:24:06 -0400
Received: by mail-wm0-x22d.google.com with SMTP id m85so38651015wma.0
	for <qemu-devel@nongnu.org>; Sat, 29 Jul 2017 02:24:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170729003327.GA16954@flamenco>
References: <20170729003327.GA16954@flamenco>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 29 Jul 2017 10:23:42 +0100
Message-ID: <CAFEAcA9M88wdV+pR5pSCRbt=NT=OKL+Z88hOjsb_v3q-AcL4fA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] tb_invalidate_phys_range and
 tb_invalidate_phys_page_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

On 29 July 2017 at 01:33, Emilio G. Cota <cota@braap.org> wrote:
> While working on the removal of tb_lock, I stumbled upon the following.
>
> Commit 77a8f1a51 ("linux-user: Fix stale tbs after mmap") introduced
> tb_invalidate_phys_range(), which we now have in accel/tcg/translate-all.c
> [ patchwork thread here: https://patchwork.ozlabs.org/patch/158556/ ]
>
> This function calls
> tb_invalidate_phys_page_range(). As the name suggests, the latter
> function expects the range to be within the same page.
> The former does not have this requirement, as stated in the comment
> above the function (which I confirmed running some linux-user code):
>
> +/*
> + * invalidate all TBs which intersect with the target physical pages
> + * starting in range [start;end[. NOTE: start and end may refer to
> + * different physical pages. 'is_cpu_write_access' should be true if called
> + * from a real cpu write access: the virtual CPU will exit the current
> + * TB if code is modified inside this TB.
> + */
> +void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end,
> +                              int is_cpu_write_access)
> +{
> +    while (start < end) {
> +        tb_invalidate_phys_page_range(start, end, is_cpu_write_access);
> +        start &= TARGET_PAGE_MASK;
> +        start += TARGET_PAGE_SIZE;
> +    }
> +}
>
> What I find puzzling is that here we pass 'end' unmodified, instead of
> making sure the range passed is within a page.
>
> Is this a bug, or am I missing something?

It's a bit odd, but looking at the code I think it doesn't matter.
The only thing that tb_invalidate_phys_page_range() uses 'end'
for is when it does the "does this TB I've found overlap the
range we're flushing" check with
 if (!(tb_end <= start || tb_start >= end))

If we pass an 'end' value that's larger than it would be if
we confined it to the page, this is safe because at worst
we'll invalidate more TBs than we needed to (and in practice
if the TB we've found is within the full range that
tb_invalidate_phys_range() is checking we need to invalidate
it anyway). I haven't quite worked it through but I rather
suspect that you can't have a TB that's in the list for
the PageDesc for 'start' and which overlaps in the
"full" [start-end) range but which wouldn't overlap
in a truncated [start-(end rounded down to end of page))
range.

Basically the reason for the "same page" restriction
is that tb_invalidate_phys_page_range() only does
a single page_find() for the 'start' address. So
as long as we call it once per page in the range
it doesn't matter that we pass an overly pessimistic
end. This is kind of bordering on "happens to work"
territory though, so maybe we could improve it...

thanks
-- PMM
