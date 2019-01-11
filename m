Received: from eggs.gnu.org ([209.51.188.92]:38058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gi54V-00013H-6B
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gi54N-0002Yt-86
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:14:29 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:45627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gi54J-0002Wz-Fi
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:14:26 -0500
Received: by mail-yb1-xb41.google.com with SMTP id q2so6431016ybd.12
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 14:14:22 -0800 (PST)
MIME-Version: 1.0
References: <20190111220131.27153-1-jcmvbkbc@gmail.com>
	<2064503c-ed12-de29-59a9-46fa24d22f60@linaro.org>
In-Reply-To: <2064503c-ed12-de29-59a9-46fa24d22f60@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 11 Jan 2019 14:14:09 -0800
Message-ID: <CAMo8BfJaTbO0LSBWk7+WeFw7Oc6Sy2ykxaQcWTBeVGCdN9+aOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] target/xtensa: rework zero overhead
 loops implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Jan 11, 2019 at 2:09 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/12/19 9:01 AM, Max Filippov wrote:
> > Don't invalidate TB with the end of zero overhead loop when LBEG or LEND
> > change. Instead encode the distance from the start of the page where the
> > TB starts to the LEND in the TB cs_base and generate loopback code when
> > the next PC matches encoded LEND. Distance to a destination within the
> > same page and up to a maximum instruction length into the next page is
> > encoded literally, otherwise it's zero. The distance from LEND to LBEG
> > is also encoded in the cs_base: it's encoded literally when less than
> > 256 or as 0 otherwise. This allows for TB chaining for the loopback
> > branch at the end of a loop for the most common loop sizes.
> >
> > With this change the resulting emulation speed is about 10% higher in
> > softmmu mode on uClibc-ng and LTP tests. Emulation speed in linux
> > user mode is a few percent lower because there's no direct TB chaining
> > between different memory pages. Testing with lower limit on direct TB
> > chainig range shows gradual slowdown to ~15% for the block size of 64
> > bytes and ~50% for the block size of 32 bytes.
> >
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> > +        /*
> > +         * 0 in the csbase_lend field means that there may not be a loopback
> > +         * for any instruction that starts inside this page. Any other value
> > +         * means that an instruction that ends at this offset from the page
> > +         * start may loop back.
>
> Nit: s/may/will/g
>
> Using "may" makes it seem like we may have missed a case that should have
> looped back.

Using "will" makes it seem like it always loops back, but it doesn't do it
when LCOUNT is 0.

-- 
Thanks.
-- Max
