Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030DBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C463720787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDm8IiQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C463720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaby7-0004oE-22
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabvc-0001wI-SL
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:19:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24819
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabvc-0000ya-31
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589793559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4nyW3nzQqovbIMv8MLQxB95c+7FnZClSinpymyvtg8=;
 b=EDm8IiQLHPfpfRnW7sIyD8r+KFiX4FT2FQLsvz2wy1d1ZvPIEnZp8Uy6y1ISqLq8NOQEh5
 bxmzqya9/E/r+g1w5v7gv3rs98r71B7Gr7YEPVHxpGEjSIhr+QcVZFW6egEtBOTdirELss
 exRif1zIg9jPHZ5dcn42s8GUrnrz6fI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-3QRPqR_xNd6UB2TFE4R02Q-1; Mon, 18 May 2020 05:19:17 -0400
X-MC-Unique: 3QRPqR_xNd6UB2TFE4R02Q-1
Received: by mail-wm1-f72.google.com with SMTP id t23so2828228wmi.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 02:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x4nyW3nzQqovbIMv8MLQxB95c+7FnZClSinpymyvtg8=;
 b=kHZPwu2DuZ9RYwkk1xf6hQGrwBad/Hj/4jbJ8EaAD2JCBpS2PYL2rGwpwXw195LMUf
 mWCxEpgsFGBG7jMRiD6UQ2yVfzp9A+eF8hWOA4jggPUIroc1H0GKZw2T0vDPWqkGiPdv
 X7pW8mLDVqiWQ/1MMwD+yrkJoIUHo1s33NZmJBdGvkfM7e89MeVY0ftkP4xW5vQZUAFO
 ooLRqtOuqNK+QomMTn8mSFbLjF/BvUv74O/AhsnAN96c10gnrYwMm6/KtJZTBfXbdWZ/
 +kM3vMBB4l/mpxkgd/4T1ks1q09dg5PAGEtq2UOTpNPFG/9/vixy6oL1nVhZoti77kiO
 MMzQ==
X-Gm-Message-State: AOAM532nxwnSr/s8EqKd/lb+hfs9YPPNs4TbMeyqW185bbTly3u3JQWE
 fG/W/lgjQcsWGFFwgtZeIgAYKBClNsejA9PnSGXmwBbS49o6O+8SExz12xoqwWO1SZ+nwu6Cxir
 KCEZ6l1F5n889drQ=
X-Received: by 2002:a05:6000:1106:: with SMTP id
 z6mr18693437wrw.336.1589793556550; 
 Mon, 18 May 2020 02:19:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJympWVjbfquP59o2tZ4EGURUk8YOfDrK9PtjT+hh3M9vKWQabpY3TJhr3jCsO26cYO8448/qA==
X-Received: by 2002:a05:6000:1106:: with SMTP id
 z6mr18693416wrw.336.1589793556344; 
 Mon, 18 May 2020 02:19:16 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t6sm16275751wma.4.2020.05.18.02.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 02:19:15 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] virtio-balloon: fix free page hinting check on
 unrealize
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200518083704.52646-1-david@redhat.com>
 <20200518083704.52646-3-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <adf0a499-541e-5786-e5d6-da69de98c71a@redhat.com>
Date: Mon, 18 May 2020 11:19:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518083704.52646-3-david@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Wei Wang <wei.w.wang@intel.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 10:37 AM, David Hildenbrand wrote:
> Checking against guest features is wrong. We allocated data structures
> based on host features. We can rely on "free_page_bh" as an indicator
> whether to un-do stuff instead.
> 
> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/virtio/virtio-balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index dc3b1067ab..a4fcf2d777 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -818,7 +818,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>       VirtIOBalloon *s = VIRTIO_BALLOON(dev);
>   
> -    if (virtio_balloon_free_page_support(s)) {
> +    if (s->free_page_bh) {
>           qemu_bh_delete(s->free_page_bh);
>           virtio_balloon_free_page_stop(s);
>           precopy_remove_notifier(&s->free_page_report_notify);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


