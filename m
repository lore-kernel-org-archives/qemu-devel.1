Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F62C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2702067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4TrF2M9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2702067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv5T0-0007o9-2e
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jv5SR-0007CJ-De
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:53:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59184
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jv5SO-0006TD-Us
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594673626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9sSQBsMylQlw6uYqoH4gAamVXWlGupiUhylxryIbps=;
 b=a4TrF2M9nt5hsSAuJ8uuEJnX+CSXKPlQJF5xtH6fclvY4P/JrjJWARHXoydCsA3lhd4U/V
 kTkVNivUbcUF2cR/veVG07uo/qa+8pjAtgU3h84xmCzjmvgxVspi35+kwUTfl21x+AQkJ6
 WYsxJpWQ21ysGAroXfG7fxa4+dtqfAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-GBAld-d1OKKh44buPY6mkQ-1; Mon, 13 Jul 2020 16:53:44 -0400
X-MC-Unique: GBAld-d1OKKh44buPY6mkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10C6A800597
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 20:53:44 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA5845D9DC;
 Mon, 13 Jul 2020 20:53:40 +0000 (UTC)
Date: Mon, 13 Jul 2020 14:53:40 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] vfio: fix use-after-free in display
Message-ID: <20200713145340.4886d664@x1.home>
In-Reply-To: <20200713124520.23266-1-kraxel@redhat.com>
References: <20200713124520.23266-1-kraxel@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 14:45:20 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Calling ramfb_display_update() might replace the DisplaySurface with the
> boot display, which in turn will free the currently active
> DisplaySurface.
> 
> So clear our DisplaySurface pinter (dpy->region.surface pointer) to (a)
                               ^o

> avoid use-after-free and (b) force replacing the boot display with the
> real display when switching back.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/vfio/display.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index a57a22674d62..342054193b3c 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -405,6 +405,7 @@ static void vfio_display_region_update(void *opaque)
>      if (!plane.drm_format || !plane.size) {
>          if (dpy->ramfb) {
>              ramfb_display_update(dpy->con, dpy->ramfb);
> +            dpy->region.surface = NULL;
>          }
>          return;
>      }

Tricky, but I think I follow that dpy->region.surface is only ever
allocated to replace dpy->con->surface, so when ramfb_display_update()
then replaces and frees dpy->con->surface with dpy->ramfb->ds, that's
where the object point to by dpy->region.surface was freed.  Right?

If so, looks ok to me.  If you're constructing a pull request, I'll
give you an:

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

If you need me to send a pull, let me know.  Thanks,

Alex


