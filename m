Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08936C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9644207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDsUvWw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9644207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKQJ-0007Jr-20
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbKPI-0005Uq-TB
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:48:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36443
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbKPH-0007HG-L2
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589964534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AdZa47xHNV0N6x6+HGPcGk2fbhVvxIrT2pBgo5q4fS4=;
 b=cDsUvWw2l2EQ6f2Z+RzctZfwlmbOXuYwkD5XcwuUKUssmzwoamgzs6uBoK67mZqLuiTPV7
 zpVwYoOc2Qiaw2DH4zZtBk4Ln8vFrAD8/pfoT0vBZlpmTg5yJq5hfpE/brTgb9rUZcIcRq
 qF5xpMX7SgMUicBE4TTU9Ztv8W5N8uk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-ioLpGT5zMeCB_NmDP0dQnw-1; Wed, 20 May 2020 04:48:53 -0400
X-MC-Unique: ioLpGT5zMeCB_NmDP0dQnw-1
Received: by mail-wm1-f71.google.com with SMTP id v23so654275wmj.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 01:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AdZa47xHNV0N6x6+HGPcGk2fbhVvxIrT2pBgo5q4fS4=;
 b=XIdV+SSeZB2Qgcm/QfS2lNU82OvbZw+x1igXUVQG5ZCYBvGRMDSj/IlXCR6oeSx+TF
 HPXKuG5cHXrz9g82xGiFdL3NihVBYqK/BZowYuALzcnrmHhUnCwWXcBX96h3A2VOk1b3
 mGC+KjsdaxXPKWlFvtKEs4Y5zSUUn4U/gug1Amvl7Z7PgYeLPCDG/vOlp2rXSrXbA4mB
 PRmh6yvu0PQd7UpH5bwZzb7x8SKBvunnaThPEBkCU2r6Sycg0TsDFO5Jx4+T2zHER/5z
 65b1K0rNaLkENDPfZumucSjubNZ+3tgo00O5no5gJYAEgwnY3D69vwkxHzpZ4/T4zk8K
 KbLw==
X-Gm-Message-State: AOAM533NdpANt/0uZ73nwdJ3jyCJdd/E9XqGaS1fGTjziadb+8+jhdNU
 xf2lV9CVW0ST4qggZKsb/PEwIOzylDcq7XDcVBXG0+Ih7ELulIusT1j1CaIe+t3FZ+uYClYB20Q
 +pgMCT7huKljbOCQ=
X-Received: by 2002:a1c:2846:: with SMTP id o67mr3480950wmo.23.1589964531939; 
 Wed, 20 May 2020 01:48:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMrC1A/DIw6T4Pfba+vhpFSw00N4e9koD57mRtiqIFA9tYrvmv4lYqOGyQUZIAjUGZ7bm5bw==
X-Received: by 2002:a1c:2846:: with SMTP id o67mr3480935wmo.23.1589964531740; 
 Wed, 20 May 2020 01:48:51 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id f5sm2113595wrp.70.2020.05.20.01.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 01:48:51 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] virtio-blk: store opt_io_size with correct size
To: Roman Kagan <rvkagan@yandex-team.ru>, qemu-devel@nongnu.org
References: <20200520080657.29080-1-rvkagan@yandex-team.ru>
 <20200520080657.29080-2-rvkagan@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f2dcebc2-3b31-c99c-c106-93c3c1fcd2a8@redhat.com>
Date: Wed, 20 May 2020 10:48:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200520080657.29080-2-rvkagan@yandex-team.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 10:06 AM, Roman Kagan wrote:
> The width of opt_io_size in virtio_blk_topology is 32bit.
> 
> Use the appropriate accessor to store it.
> 
> Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> ---
> v4: new patch
> 
>   hw/block/virtio-blk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index f5f6fc925e..413083e62f 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -918,7 +918,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>       virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
>       virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
>       virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
> -    virtio_stw_p(vdev, &blkcfg.opt_io_size, conf->opt_io_size / blk_size);
> +    virtio_stl_p(vdev, &blkcfg.opt_io_size, conf->opt_io_size / blk_size);
>       blkcfg.geometry.heads = conf->heads;
>       /*
>        * We must ensure that the block device capacity is a multiple of
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


