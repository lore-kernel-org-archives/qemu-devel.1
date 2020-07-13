Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091EFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8614A206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhoQTN5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8614A206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juz2y-0001Fy-IN
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1juz0Y-0006mi-DK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:00:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50437
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1juz0W-00051T-NM
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594648836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKiQWgy2ZAnYFVzwp2dDQBrmY5d0MO9o9eVteXV7EAc=;
 b=ZhoQTN5acmhnJRCKVWXUdCTygxGkeI/oOhNdgAP3BYDb1bsJzaG5nVLp0SFk0nX7nO75LD
 xyWlagGpdSwes+zdZRiYStCH8kcHFPSuancHlESsvcCxu/9qPAbm0n2H2IA0rXqgr45BXF
 p0mv6EyoJnvRSuq2u4x6cLgFgbw83yA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-Dmrb31YfOPGAVWzUV35Oyg-1; Mon, 13 Jul 2020 10:00:33 -0400
X-MC-Unique: Dmrb31YfOPGAVWzUV35Oyg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BEE8100A8E8
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 14:00:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFB6A72E46;
 Mon, 13 Jul 2020 14:00:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 21C263EBB7; Mon, 13 Jul 2020 16:00:28 +0200 (CEST)
Date: Mon, 13 Jul 2020 16:00:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] vfio: fix use-after-free in display
Message-ID: <20200713140028.yoxn77csag7cbbfh@sirius.home.kraxel.org>
References: <20200713124520.23266-1-kraxel@redhat.com>
 <efedf130-518d-fd3a-04b6-b501bf06cc8c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <efedf130-518d-fd3a-04b6-b501bf06cc8c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 02:51:05PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/13/20 2:45 PM, Gerd Hoffmann wrote:
> > Calling ramfb_display_update() might replace the DisplaySurface with the
> > boot display, which in turn will free the currently active
> > DisplaySurface.
> > 
> > So clear our DisplaySurface pinter (dpy->region.surface pointer) to (a)
> > avoid use-after-free and (b) force replacing the boot display with the
> > real display when switching back.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  hw/vfio/display.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> > index a57a22674d62..342054193b3c 100644
> > --- a/hw/vfio/display.c
> > +++ b/hw/vfio/display.c
> > @@ -405,6 +405,7 @@ static void vfio_display_region_update(void *opaque)
> >      if (!plane.drm_format || !plane.size) {
> >          if (dpy->ramfb) {
> >              ramfb_display_update(dpy->con, dpy->ramfb);
> > +            dpy->region.surface = NULL;
> >          }
> >          return;
> >      }
> > 
> 
> More generic fix:
> 
> -- >8 --
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1580,10 +1580,10 @@ void dpy_gfx_replace_surface(QemuConsole *con,
>                               DisplaySurface *surface)
>  {
>      DisplayState *s = con->ds;
> -    DisplaySurface *old_surface = con->surface;
> +    QemuConsole *old_con = con;
>      DisplayChangeListener *dcl;
> 
> -    assert(old_surface != surface || surface == NULL);
> +    assert(con->surface != surface || surface == NULL);
> 
>      con->surface = surface;
>      QLIST_FOREACH(dcl, &s->listeners, next) {
> @@ -1594,7 +1594,8 @@ void dpy_gfx_replace_surface(QemuConsole *con,
>              dcl->ops->dpy_gfx_switch(dcl, surface);
>          }
>      }
> -    qemu_free_displaysurface(old_surface);
> +    qemu_free_displaysurface(old_con->surface);
> +    old_con->surface = NULL;

No.

That doesn't clear VFIODisplay->region.surface, but it sets
QemuConsole->surface to NULL no matter what got passed to
dpy_gfx_replace_surface().

Guesswork based just on the patch chunk doesn't always work,
sometimes you have to consult the source code to see what the
patch actually does ;)

take care,
  Gerd


