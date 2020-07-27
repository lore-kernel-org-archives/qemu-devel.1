Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD7EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE862078A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ES/c8H2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE862078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03E5-0007Qi-R4
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03CZ-0005UM-9L
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:29:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20843
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03CX-0007MM-PH
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595856597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wzf13BJUu1ZlcIrjsxkfi9efQk9jb2Oyad6wX9R17H4=;
 b=ES/c8H2aJc7PKY+iYndO48ZC6COSQO7Ue0BJEMIZD/9gPoiA0RzYKesX26+qh5QOCKm9sk
 KvBKwP8Gp/L10rnA7slST+hpPPM2A97dIb41WlW/U47Fn8TANz5aQu/8YialFbzx8hFM6L
 10Wd0e+bK3LmBMmt4KQVayIr/EPSwPs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-QmsPgRg9Mx-cVbe_5Peymg-1; Mon, 27 Jul 2020 09:29:53 -0400
X-MC-Unique: QmsPgRg9Mx-cVbe_5Peymg-1
Received: by mail-wr1-f69.google.com with SMTP id w1so1918947wro.4
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Wzf13BJUu1ZlcIrjsxkfi9efQk9jb2Oyad6wX9R17H4=;
 b=Ce/ZpUMM5ffoET/eDwyRHwQZscP4/pxwvOt3+yENrN0BmUnr6dInzhtRX+3/onXjGb
 KtJcAtl3HlOI8IRTP2kUB4Ud7SZtLyVcZbhKc31JRgMM51/M38BWCTPGMRDp1EeC47Zs
 Vo1TIn6u/7QaJ9iP8NV6lKKikKnN8npWh093xYmV1GCI56qB/jYD16apam0f/YxoedMa
 oleeAwQMHtWfNaiQmfMLhwuHwrFayXZIIYyN2t7r3TKi7DOAQ/CwjvCIIZFmVSGWm5Mv
 rnGLTGikzx7HvnkgkGdWG/R8QqF7m4ZIJFo5O5RFxckY2P28URHwSnXkQ9k708xehpd2
 tHuw==
X-Gm-Message-State: AOAM530Lq/ZMFyQKe6hA38Vshy1oMF1I+PIu+7sV4AfQ6HodjnvBGBMX
 ax3gGhHXiLqldDADmzIS4xFH6v8qsVUM6iGBNSjtnaZ4vOB3eY8uZrZM7PYP5tR6QvLmA80cPzg
 S/UPMjmUFFaCY1Hc=
X-Received: by 2002:a7b:ca4b:: with SMTP id m11mr6613256wml.120.1595856592114; 
 Mon, 27 Jul 2020 06:29:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOYg1M8rkmOV9lMWzs7PgeZdkMb+/PmeVPrRT0c1YdlUmJNY3Z5XdUnBGfMeaPfVzbogopNg==
X-Received: by 2002:a7b:ca4b:: with SMTP id m11mr6613245wml.120.1595856591934; 
 Mon, 27 Jul 2020 06:29:51 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id c10sm12889018wro.84.2020.07.27.06.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:29:51 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:29:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] vhost-vdpa :Fix Coverity CID 1430270 / CID 1420267
Message-ID: <20200727092942-mutt-send-email-mst@kernel.org>
References: <20200710064642.24505-1-lulu@redhat.com>
 <CAFEAcA_dhusPWdObGznvh_Ox0ntwk-fE67f26iFfLkRbbx0K1Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_dhusPWdObGznvh_Ox0ntwk-fE67f26iFfLkRbbx0K1Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 06:55:08PM +0100, Peter Maydell wrote:
> (trimming down the rather exuberant CC list)
> 
> On Fri, 10 Jul 2020 at 07:47, Cindy Lu <lulu@redhat.com> wrote:
> >
> > In the function vhost_vdpa_dma_map/unmap, The struct msg was not initialized all its fields.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/virtio/vhost-vdpa.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Michael, I guess this should go via your tree ?
> 
> thanks
> -- PMM
Queues, thanks!


