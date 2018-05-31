Received: from eggs.gnu.org ([2001:4830:134:3::10]:45655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <evgreen@chromium.org>) id 1fOUPk-0001yb-4A
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <evgreen@chromium.org>) id 1fOUPg-00036L-Vl
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:43:16 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <evgreen@chromium.org>)
	id 1fOUPg-00035o-QQ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:43:12 -0400
Received: by mail-ot0-x242.google.com with SMTP id 15-v6so26796894otn.12
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 13:43:12 -0700 (PDT)
Received: from mail-ot0-f171.google.com (mail-ot0-f171.google.com.
	[74.125.82.171]) by smtp.gmail.com with ESMTPSA id
	x4-v6sm26434422otx.54.2018.05.31.13.43.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 31 May 2018 13:43:10 -0700 (PDT)
Received: by mail-ot0-f171.google.com with SMTP id t1-v6so26798119ott.13
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 13:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180529234409.27023-1-evgreen@chromium.org>
	<a436fff7-76a3-976b-a5bc-492d1cf054fa@linaro.org>
	<CAFEAcA9mrAVLS-VEyqmdEzAm3jT5PqFrP=cGzbhbeMn-qwsowg@mail.gmail.com>
	<17f64b86-5237-b7c6-c5bb-e46cea636968@linaro.org>
	<CAFEAcA_u=-DvEvvZP3_UJ_rdS7AQ71GQG3uWY0OkoyJJOTC4cg@mail.gmail.com>
In-Reply-To: <CAFEAcA_u=-DvEvvZP3_UJ_rdS7AQ71GQG3uWY0OkoyJJOTC4cg@mail.gmail.com>
From: Evan Green <evgreen@chromium.org>
Date: Thu, 31 May 2018 13:42:28 -0700
Message-ID: <CAE=gft7Yu4mGm8jF+Dx9LxhPcQr7GsfbX2QeZs0aNy_dfURwuw@mail.gmail.com>
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
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, Laurent@vivier.eu, riku.voipio@iki.fi

On Thu, May 31, 2018 at 9:44 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On 31 May 2018 at 17:32, Richard Henderson <richard.henderson@linaro.org> wrote:
> > On 05/31/2018 08:26 AM, Peter Maydell wrote:
> >> On 30 May 2018 at 21:50, Richard Henderson <richard.henderson@linaro.org> wrote:
> >>> On 05/29/2018 04:44 PM, Evan Green wrote:
> >>>> When using -L with Linux app emulation, there is an issue in
> >>>> init_paths where Qemu will get lost exploring a directory tree
> >>>> with a symlink loop in it. This causes Qemu to hang, and
> >>>> eventually consume all memory in the system.
> >>>>
> >>>> Qemu's code for pre-exploring the entire directory tree is both
> >>>> error-prone and slow. Instead, this changes uses faccessat, which
> >>>> both avoids the symlink loop (since the entire directory space isn't
> >>>> being explored up front), and likely speeds things up a bit.
> >>>>
> >>>> Partial credit goes to Richard Henderson, as it was only after staring
> >>>> at his patch [1] that I wrote mine.
> >>>>
> >>>> [1] https://patchwork.kernel.org/patch/9512083/
> >>>>
> >>>> Signed-off-by: Evan Green <evgreen@chromium.org>
> >>>> ---
> >>>
> >>> I like this as an improvement on the current situation.
> >>> Perhaps folks do like this a bit better than my more invasive patch.
> >>
> >> It seems to me to have the same problem as your patch does,
> >> which is that we now have a file descriptor which belongs
> >> not to the guest but to QEMU, but we make no effort to
> >> hide it from the guest, and so for instance code like that
> >> xinetd "close every fd above 2" loop will break us.
> >
> > Yes.  I've thought about doing more explicit managing of guest fd's, but it's a
> > big job to re-organize that.
>
> I think my current opinion is that it's probably OK to have the
> "our internal fd is visible to the guest" problem for the case
> where the user specifies -L, at least for now. We're probably
> causing more problems by not allowing -L to point at trees with
> symlinks than by misbehaving if the application closes it.
> We should just leave ourselves a suitable TODO note or something.
>
> As I say, I prefer your patch to this one overall, if you
> wanted to address the minor issues from the last round of
> review and respin it.
>

That sounds good to me. Richard, would you mind CCing me on your next
spin of the patch? I'm not on the main list.
Thanks,
-Evan

> thanks
> -- PMM
