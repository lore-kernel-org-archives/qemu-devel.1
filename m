Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64408C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 10:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB63206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 10:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvdiXodQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB63206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChNJ-0005iH-DV
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 06:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kChLm-0004K9-Jy
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 06:47:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58726
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kChLk-0006KW-S9
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 06:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598870864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJS5bTag1lQG5YOHZC2F4MI9+X59z4vk5vYaeKYGi5w=;
 b=JvdiXodQzaPLc7QAvZvpQFRbZ9lYCaIB1SzesiRqpva8dlns8z3fjEuJ52f5wsJe8JLm9o
 glFbf57nHr51oOtrDsvqSV/S4pWrI1rMvTnTDM8GNu9PsNsoFblqE3bdWdVMuE1GER2nBm
 xrzPRMFP/GoTU2pxWNO43Yrl6iHzJpU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-7S6S_xxqNb-Tbtp03jZ3uQ-1; Mon, 31 Aug 2020 06:47:42 -0400
X-MC-Unique: 7S6S_xxqNb-Tbtp03jZ3uQ-1
Received: by mail-wr1-f70.google.com with SMTP id v12so87201wrm.9
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 03:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rJS5bTag1lQG5YOHZC2F4MI9+X59z4vk5vYaeKYGi5w=;
 b=uBMW9StGTCiDGEJZ58rHCq5Spx0vfnNBjV9FlptcMWsoKFvbuD6z8I5v5DI9woWRPB
 Ve0vDV2GNbAq5JDnxEflO+IU1+FPkpHLILuUJpgNjhPXlHQ7GNJio0TL3oPdwLP+GWTY
 PX8jxikdKjWz+D+LXpig61d4/c5AkFJiaVQRWYQrU5J8CxpCNLU/7zXnOc9B1GnjOaOn
 9/gSa5csoZ8ng+lQHzdxhCwph2CXXjxFbIIllb3EyXa8dbMp/BTBe/XiCf89YVqHjvj9
 i+KGtAM4YlRboLOhVkkYKM8VEYLq40W69yHUHiV7s7aC4YuBDWdm9ujph5lA+01FymT5
 B8KQ==
X-Gm-Message-State: AOAM531FeEvW0aYYev0v/JHAWHva0kCGriAobAljrj0jMYH/98F+S8RB
 A34ZdwjnwpYQAryhLazDHX3rvHoSmoQri/H8iMp2R7Rv1eMMYw7fIhMptMB1TnLmNeDo9NMIdl3
 j115vvRNGdoq1288=
X-Received: by 2002:a1c:964b:: with SMTP id y72mr818343wmd.69.1598870861352;
 Mon, 31 Aug 2020 03:47:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIwNXLvRZnIgiSFi1B//EJeHWSX7nMxpleO7SMuhxTWeye7nWKRmz/78ZYf/+bYDugKlYA8w==
X-Received: by 2002:a1c:964b:: with SMTP id y72mr818315wmd.69.1598870861095;
 Mon, 31 Aug 2020 03:47:41 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id k4sm2540559wrx.51.2020.08.31.03.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 03:47:40 -0700 (PDT)
Date: Mon, 31 Aug 2020 06:47:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH 06/11] hw/net/virtio-net:Remove redundant statement in
 virtio_net_rsc_tcp_ctrl_check()
Message-ID: <20200831064717-mutt-send-email-mst@kernel.org>
References: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
 <20200813073712.4001404-7-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200813073712.4001404-7-kuhn.chenqun@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, pannengyuan@huawei.com,
 qemu-devel@nongnu.org, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 03:37:07PM +0800, Chen Qun wrote:
> Clang static code analyzer show warning:
> hw/net/virtio-net.c:2077:5: warning: Value stored to 'tcp_flag' is never read
>     tcp_flag &= VIRTIO_NET_TCP_FLAG;
>     ^           ~~~~~~~~~~~~~~~~~~~
> 
> The 'VIRTIO_NET_TCP_FLAG' is '0x3F'. The last ‘tcp_flag’ assignment statement is
>  the same as that of the first two statements.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge through the trivial tree.

> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/virtio-net.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index a1fe9e9285..cb0d27084c 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2075,7 +2075,6 @@ static int virtio_net_rsc_tcp_ctrl_check(VirtioNetRscChain *chain,
>      tcp_flag = htons(tcp->th_offset_flags);
>      tcp_hdr = (tcp_flag & VIRTIO_NET_TCP_HDR_LENGTH) >> 10;
>      tcp_flag &= VIRTIO_NET_TCP_FLAG;
> -    tcp_flag = htons(tcp->th_offset_flags) & 0x3F;
>      if (tcp_flag & TH_SYN) {
>          chain->stat.tcp_syn++;
>          return RSC_BYPASS;
> -- 
> 2.23.0


