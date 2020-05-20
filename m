Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D70C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7C72065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vi5q14kY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7C72065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbMEC-0001Vu-Ii
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbMDV-0000mp-Gf
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:44:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31539
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbMDU-0003nr-4A
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589971491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3L+v3Vp0GPjBW7nYi8esFsNr9cDWxmrVsKlCqRyxyJE=;
 b=Vi5q14kYHlh/KhGuw/rGPlC7IW+dydiEK+p8EgtIckuO6mMIP5AwzKzREAhrLgcESiyxi5
 SFb4Np7KvBtul9oGnpDJ7tR4R3ODvOuliDTVgtH6L27SCo33OUN0Cvef3u/db9ml5QC57A
 YSvgELXpL0SbUuRhN9M0v3IVy15Ndus=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-DbnFuAo5PXatAy7CMRgNGw-1; Wed, 20 May 2020 06:44:49 -0400
X-MC-Unique: DbnFuAo5PXatAy7CMRgNGw-1
Received: by mail-wm1-f69.google.com with SMTP id g10so1082363wme.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 03:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3L+v3Vp0GPjBW7nYi8esFsNr9cDWxmrVsKlCqRyxyJE=;
 b=EIflLUSp7Qs45zi7yUC0tjFN6EGReidBv66LDziUTc0/Cd8L51djYACCIsJdgEMVi4
 2Rvgb1p82hwaCGh5raspmBRm42sQ54a01NaWUE+DimCXv8i3N9NE+fQp+38gaymFokRL
 zO9TOK9j2dgNR0W3XMIl89QEGeQmJpn9nlblOn2pEUMegb3+NJ5xo5m7fW8ON1KBAyUr
 BDNObh61iYIprzNL2blTZGZsRU7WZVRpupVSeCa/piwkPK5XedJo18dWcFmqLW9TF5Rz
 7SPOlmyW8YNtnUCoQMuE4oYVYAZ7BaPARmayRNzEK/AoK6pvrQIU2MjLvC6KBGLvg6bq
 X5dw==
X-Gm-Message-State: AOAM533Y3EgWAbE3EnT2SOSzMQYDsHcl6nUooiXd3L3BTgSPa/VhAOCV
 i5TExXhTNl7bqqYwD3/1nb6v6/a/0b47r1UCnXcYjardSJkhd0kNH1adMYo8Vozq9/KWDuP3y7E
 lLrDkZiDDL1p0JyE=
X-Received: by 2002:a1c:9a09:: with SMTP id c9mr3943733wme.159.1589971488524; 
 Wed, 20 May 2020 03:44:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNf6DxEso6LsVV0F8shnuyv24z6qs95Kak5HsbFfv3b7LIF6fDQQjPLRHBp5opiRJzdbSxzw==
X-Received: by 2002:a1c:9a09:: with SMTP id c9mr3943714wme.159.1589971488320; 
 Wed, 20 May 2020 03:44:48 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 q5sm2491000wra.36.2020.05.20.03.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 03:44:47 -0700 (PDT)
Date: Wed, 20 May 2020 06:44:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Roman Kagan <rvkagan@yandex-team.ru>
Subject: Re: [PATCH v4 1/3] virtio-blk: store opt_io_size with correct size
Message-ID: <20200520064125-mutt-send-email-mst@kernel.org>
References: <20200520080657.29080-1-rvkagan@yandex-team.ru>
 <20200520080657.29080-2-rvkagan@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200520080657.29080-2-rvkagan@yandex-team.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 11:06:55AM +0300, Roman Kagan wrote:
> The width of opt_io_size in virtio_blk_topology is 32bit.
> 
> Use the appropriate accessor to store it.
> 
> Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>


Thanks for the patch!
Could you add a bit of analysis - when does this cause
bugs? I'm guessing on BE systems with legacy virtio, right?

Also, should we convert virtio_stw_p and friends to get the
pointer to the correct value type, as opposed to void *?

This will catch bugs like this ...



> ---
> v4: new patch
> 
>  hw/block/virtio-blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index f5f6fc925e..413083e62f 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -918,7 +918,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>      virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
>      virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
>      virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
> -    virtio_stw_p(vdev, &blkcfg.opt_io_size, conf->opt_io_size / blk_size);
> +    virtio_stl_p(vdev, &blkcfg.opt_io_size, conf->opt_io_size / blk_size);
>      blkcfg.geometry.heads = conf->heads;
>      /*
>       * We must ensure that the block device capacity is a multiple of
> -- 
> 2.26.2


