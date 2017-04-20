Received: from eggs.gnu.org ([2001:4830:134:3::10]:33711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d17Bx-0004rl-CK
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 04:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d17Bw-0003TQ-3s
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 04:11:53 -0400
Date: Thu, 20 Apr 2017 16:11:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170420081142.GE24486@lemon.lan>
References: <1492661065-18510-1-git-send-email-lidongchen@tencent.com>
	<20170420075128.GD24486@lemon.lan>
	<CAOGPPbcTyHVT3RAqGjaRaNno0HP2bQ3Mpn=8kqb9LVt5GbSyfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGPPbcTyHVT3RAqGjaRaNno0HP2bQ3Mpn=8kqb9LVt5GbSyfA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: check bs_n when use old style
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Lidong Chen <lidongchen@tencent.com>, qemu block <qemu-block@nongnu.org>, mreitz@redhat.com

On Thu, 04/20 15:59, 858585 jemmy wrote:
> On Thu, Apr 20, 2017 at 3:51 PM, Fam Zheng <famz@redhat.com> wrote:
> > On Thu, 04/20 12:04, jemmy858585@gmail.com wrote:
> >> From: Lidong Chen <lidongchen@tencent.com>
> >>
> >> When use old style option like -o backing_file, img_convert
> >> continue run when bs_n > 1, this patch fix this bug.
> >>
> >> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> >> ---
> >>  qemu-img.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/qemu-img.c b/qemu-img.c
> >> index b220cf7..c673aef 100644
> >> --- a/qemu-img.c
> >> +++ b/qemu-img.c
> >> @@ -2225,6 +2225,13 @@ static int img_convert(int argc, char **argv)
> >>          out_baseimg = out_baseimg_param;
> >>      }
> >>
> >> +    if (bs_n > 1 && out_baseimg) {
> >> +        error_report("-B makes no sense when concatenating multiple input "
> >> +                     "images");
> >> +        ret = -1;
> >> +        goto out;
> >> +    }
> >> +
> >>      /* Check if compression is supported */
> >>      if (compress) {
> >>          bool encryption =
> >> --
> >> 1.8.3.1
> >>
> >>
> >
> > Is this essentially the same as the check a few lines above:
> >
> >     ...
> >     if (bs_n < 1) {
> >         error_exit("Must specify image file name");
> >     }
> >
> >
> >     if (bs_n > 1 && out_baseimg) {
> >         error_report("-B makes no sense when concatenating multiple input "
> >                      "images");
> >         ret = -1;
> >         goto out;
> >     }
> >
> >     src_flags = 0;
> >     ret = bdrv_parse_cache_mode(src_cache, &src_flags, &src_writethrough);
> >     if (ret < 0) {
> >         error_report("Invalid source cache option: %s", src_cache);
> >         goto out;
> >     }
> >     ...
> >
> > How about moving that down?
> moving that down is ok.
> but will exit later if use -B option.
> which way do you think better?

Exiting later is not a problem, I assume? And it's better to avoid duplicating
code if possible.

BTW if you do that way, it's better to "s/-B/Specifying backing image/" in the
error message (to be compatible with -o backing_file syntax).

Fam
