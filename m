Received: from eggs.gnu.org ([2001:4830:134:3::10]:37087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etBiL-0004Im-A8
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etBiI-0004WT-50
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:29:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etBiI-0004Vz-0E
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:29:02 -0500
Date: Tue, 6 Mar 2018 13:29:00 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180306122900.znzogknnojhz7utm@sirius.home.kraxel.org>
References: <20180306083832.8144-1-kraxel@redhat.com>
	<20180306083832.8144-2-kraxel@redhat.com>
	<CAJ+F1CLUxMv6snmfg3jLYtd=JsOGJQMJgZinyd=BuCrJvsDuSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLUxMv6snmfg3jLYtd=JsOGJQMJgZinyd=BuCrJvsDuSg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] spice: drop dprint() debug logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

> > @@ -413,8 +392,10 @@ void qemu_spice_display_switch(SimpleSpiceDisplay *ssd,
> >          surface_height(surface) == pixman_image_get_height(ssd->surface) &&
> >          surface_format(surface) == pixman_image_get_format(ssd->surface)) {
> >          /* no-resize fast path: just swap backing store */
> > -        dprint(1, "%s/%d: fast (%dx%d)\n", __func__, ssd->qxl.id,
> > -               surface_width(surface), surface_height(surface));
> > +        trace_qemu_spice_display_surface(ssd->qxl.id,
> > +                                         surface_width(surface),
> > +                                         surface_height(surface),
> > +                                         true);
> >          qemu_mutex_lock(&ssd->lock);
> >          ssd->ds = surface;
> >          pixman_image_unref(ssd->surface);
> > @@ -427,11 +408,10 @@ void qemu_spice_display_switch(SimpleSpiceDisplay *ssd,
> >      }
> >
> >      /* full mode switch */
> > -    dprint(1, "%s/%d: full (%dx%d -> %dx%d)\n", __func__, ssd->qxl.id,
> > -           ssd->surface ? pixman_image_get_width(ssd->surface)  : 0,
> > -           ssd->surface ? pixman_image_get_height(ssd->surface) : 0,
> > -           surface ? surface_width(surface)  : 0,
> > -           surface ? surface_height(surface) : 0);
> > +    trace_qemu_spice_display_surface(ssd->qxl.id,
> > +                                     surface_width(surface),
> > +                                     surface_height(surface),
> > +                                     false);
> 
> You are now assuming surface is always != NULL, but
> dpy_gfx_replace_surface() for example, has assert( || surface == NULL)
> before calling dpy_gfx_switch().

Oops.  Wasn't intentional (cut & paste from above).  Will fix.

cheers,
  Gerd
