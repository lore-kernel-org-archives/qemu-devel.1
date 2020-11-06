Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCBCC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A264208B3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLTeU/oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A264208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kay46-0002wX-Gf
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 04:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kay3K-0002T5-SR
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:29:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kay3H-00043D-0z
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604654934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X2qchwK8y28paYcXubRAN+PO5xtLodDmoCjR36h2JnY=;
 b=eLTeU/oel6+Er+j0aKRxIsuD20BCv87HAGEA14BxkKscTGlA02z4VaN4W5jr8frQ0jUSr3
 TMuwgNG4r5+wW9KACPKuSaSDxyCWiIgHh+5Yt4MydSIW5GNDvaHXYD+CNgHP5+MhBUAeS7
 kJ3Pzda9dWhXHbQThXj440eqbnPp5+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-1HAFNADJP_KLFW_Y7mAKRw-1; Fri, 06 Nov 2020 04:28:50 -0500
X-MC-Unique: 1HAFNADJP_KLFW_Y7mAKRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32662186DD3F;
 Fri,  6 Nov 2020 09:28:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E16E65C5FD;
 Fri,  6 Nov 2020 09:28:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1009216E31; Fri,  6 Nov 2020 10:28:48 +0100 (CET)
Date: Fri, 6 Nov 2020 10:28:48 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: lichun <lichun@ruijie.com.cn>
Subject: Re: [PATCH] console: avoid passing con=NULL to
 graphic_hw_update_done() In graphic_hw_update(), first select an existing
 console, a specific-console or active_console(if not specified), then
 updating the console.
Message-ID: <20201106092848.yqoajggs2pdqbhjm@sirius.home.kraxel.org>
References: <1604682219-114389-1-git-send-email-lichun@ruijie.com.cn>
MIME-Version: 1.0
In-Reply-To: <1604682219-114389-1-git-send-email-lichun@ruijie.com.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 02:41:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, 706701795@qq.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

If you have an long commit message put it into the body not the subject
please.

On Sat, Nov 07, 2020 at 01:03:39AM +0800, lichun wrote:
> Signed-off-by: lichun <lichun@ruijie.com.cn>
> ---
>  ui/console.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/ui/console.c b/ui/console.c
> index e8e5970..e07d2c3 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -270,10 +270,11 @@ void graphic_hw_update_done(QemuConsole *con)
>  void graphic_hw_update(QemuConsole *con)
>  {
>      bool async = false;
> +    con = con ? con : active_console;

con should not be NULL at this point.

Can you trigger a NULL pointer dereference here somehow?

thanks,
  Gerd


