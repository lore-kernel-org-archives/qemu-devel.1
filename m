Received: from eggs.gnu.org ([2001:4830:134:3::10]:47171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQ9DG-000352-Ov
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQ9DF-00034R-SU
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:24:42 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:34988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQ9DF-00033c-Kc
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:24:41 -0400
Received: by mail-wm0-x229.google.com with SMTP id w126so47243399wme.0
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 02:24:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1706271438090.24648@sstabellini-ThinkPad-X260>
References: <CAFEAcA-wYgWeYdFRAcW-DhqsFRsy_iKF+WU6qt7UbUKZ+EK1eg@mail.gmail.com>
	<alpine.DEB.2.10.1706271438090.24648@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Jun 2017 10:24:18 +0100
Message-ID: <CAFEAcA8yUHuBj2SUhL++7-NiBvHrcxRCH=Yq6TsNGrN4NXVV-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Getting rid of xen_init_display() (and its dubious
 call into main_loop_wait())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anthony PERARD <anthony.perard@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, xen-devel@lists.xenproject.org

On 28 June 2017 at 01:06, Stefano Stabellini <sstabellini@kernel.org> wrote:
> On Tue, 27 Jun 2017, Peter Maydell wrote:
>> So, there is exactly one caller of main_loop_wait() in the tree that
>> passes it 'true' as an argument. That caller is in xen_init_display()
>> in hw/dispaly/xenfb.c. The function was added in 2009 with the comment
>> "FIXME/TODO: Kill this. Temporary needed while DisplayState
>> reorganization is in flight."
>>
>> I'd like to think that we've now completed whatever reorg that was,
>> 8 years on, so can we now get rid of this function? It definitely
>> seems very dubious to have a display init function with a busy loop
>> and a call into main_loop_wait()...
>
> LOL, you gotta love "temporary fixes". I am happy to see it wasn't me
> that added it ;-)
>
> I think the following should do the trick.

Thanks!

> ---
>
> xenfb: remove xen_init_display "temporary" hack
>
> Initialize xenfb properly, as all other backends, from its own
> "initialise" function.
>
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
>
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index e76c0d8..873e51f 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
> @@ -71,7 +71,6 @@ struct XenFB {
>      int               fbpages;
>      int               feature_update;
>      int               bug_trigger;
> -    int               have_console;
>      int               do_resize;
>
>      struct {
> @@ -80,6 +79,7 @@ struct XenFB {
>      int               up_count;
>      int               up_fullscreen;
>  };
> +static const GraphicHwOps xenfb_ops;
>
>  /* -------------------------------------------------------------------- */
>
> @@ -855,6 +855,8 @@ static int fb_init(struct XenDevice *xendev)
>  static int fb_initialise(struct XenDevice *xendev)
>  {
>      struct XenFB *fb = container_of(xendev, struct XenFB, c.xendev);
> +    struct XenDevice *xin;
> +    struct XenInput *in;
>      struct xenfb_page *fb_page;
>      int videoram;
>      int rc;
> @@ -877,16 +879,12 @@ static int fb_initialise(struct XenDevice *xendev)
>      if (rc != 0)
>         return rc;
>
> -#if 0  /* handled in xen_init_display() for now */
> -    if (!fb->have_console) {
> -        fb->c.ds = graphic_console_init(xenfb_update,
> -                                        xenfb_invalidate,
> -                                        NULL,
> -                                        NULL,
> -                                        fb);
> -        fb->have_console = 1;
> -    }
> -#endif
> +    fb->c.con = graphic_console_init(NULL, 0, &xenfb_ops, fb);
> +
> +    xin = xen_pv_find_xendev("vkbd", xen_domid, 0);
> +    in = container_of(xin, struct XenInput, c.xendev);
> +    in->c.con = fb->c.con;

Won't this crash if xen_pv_find_xendev() returned NULL?
Or are we guaranteed that that can't happen here?

thanks
-- PMM
