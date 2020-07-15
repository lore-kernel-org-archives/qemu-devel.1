Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10539C433F8
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D487520656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyBzR5OA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D487520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jveqZ-0006zj-5b
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 06:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jvepy-0006XB-Pu
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:40:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58755
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jvepv-00040A-Uw
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594809626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uaO4zcJ4VWew82BveMGbI/0dB0jgguSP32nmmGl2D/4=;
 b=AyBzR5OAdh+ZXDdjeuuol9AR7WupCeoNVB1NOe9axTWLa15kX7oJKEVZigKXZCJE1B4Yrs
 8pJ9ed6psRvJ2v9raPXxUpmcBXrQUDKSCzhwdgx6mxY16y0VdfsSgBwFLgQQ6OG0myAIty
 TWCzGRpA1Da3ZgTZYoU7c68CvwzOMpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-xOZGTS9tMCyRbJQntJnePw-1; Wed, 15 Jul 2020 06:40:24 -0400
X-MC-Unique: xOZGTS9tMCyRbJQntJnePw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 551C6100AA21
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 10:40:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC4BD5FC2E;
 Wed, 15 Jul 2020 10:40:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B4B4D9A81; Wed, 15 Jul 2020 12:40:18 +0200 (CEST)
Date: Wed, 15 Jul 2020 12:40:18 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio: fix use-after-free in display
Message-ID: <20200715104018.2f5og5mgikacxfp5@sirius.home.kraxel.org>
References: <20200713124520.23266-1-kraxel@redhat.com>
 <20200713145340.4886d664@x1.home>
MIME-Version: 1.0
In-Reply-To: <20200713145340.4886d664@x1.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:05
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

  Hi,

> Tricky, but I think I follow that dpy->region.surface is only ever
> allocated to replace dpy->con->surface, so when ramfb_display_update()
> then replaces and frees dpy->con->surface with dpy->ramfb->ds, that's
> where the object point to by dpy->region.surface was freed.  Right?

Correct.

> If so, looks ok to me.  If you're constructing a pull request, I'll
> give you an:
> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> 
> If you need me to send a pull, let me know.

I'll go create a pull req, I have one or two other patches pending
anyway.

take care,
  Gerd


