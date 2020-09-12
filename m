Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0402EC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59435206B5
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbPXbuqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59435206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGyyt-0003Sr-AB
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 02:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGyxk-00031x-QO
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:24:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46593
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGyxi-00047Y-Ii
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599891877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bWSE7ir/HeJTg7ybxB/z+nS+ssHZ8k5PLcjrrrHUwsI=;
 b=cbPXbuqmTSC1goKC08RPRCfVFdVyfKBvg7LUNFBiHIaQ5OWYYpOw+QwnZXg3+FVIyRMXQq
 q07mrJjgEKDYIcMKN2lgqadL2yh1lJuPfyi3C7LC1e0K4yRvPM86VmsYxgeA25PNS6JNvx
 f4sXRMDHz9Tw2Ga1HYus4IGZcrAoSUk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-kkDhk30vOcaFwYCelIYkiQ-1; Sat, 12 Sep 2020 02:24:35 -0400
X-MC-Unique: kkDhk30vOcaFwYCelIYkiQ-1
Received: by mail-wm1-f72.google.com with SMTP id l26so2293972wmg.7
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 23:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bWSE7ir/HeJTg7ybxB/z+nS+ssHZ8k5PLcjrrrHUwsI=;
 b=JE5jo1b44mf18UeDyTE+qA+Uf/utD8s0idFCfNzjv0fcsfXqxPZ6rxCJN2NIFaTpte
 6IZZKB6IaDmhxZLPMvWHltmzcxmcr2rviy3gd3z5IMe2p9KtsjaqBeVSIFiguTqTcQtK
 SO5F25ERv2adYI2SmbQCfqmh2BAV1WdCL6sofXWbtvVJTEfeiw2cr2rFyXKisJo9mZZW
 RhtgfytO8SJHsrbq8YU5AfW5RsN3jfXnbZb9/9NOq4bxDN16AQEfgrtYsXUranFpMgG7
 DlbDJegw15XSFbwz+B0pXQfGbKD4Zca9PcvCjMmuHGOmGETFJJqCvBrIP73ASiG5+wwG
 URow==
X-Gm-Message-State: AOAM532+ug/TZoFjYBBGHJo9Gog8HGRJVKGALBFdS7bbRV2QVOR4utbo
 +jZJa6Oi/sHPSpVIlv9Ve+46zTm/zPGrhgDG+giQbi/uMwJga+BfRFxLadTZT6yFvr3pGy/aBCt
 XPiLAGjRCLy4opa8=
X-Received: by 2002:a1c:f619:: with SMTP id w25mr5375212wmc.62.1599891874202; 
 Fri, 11 Sep 2020 23:24:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrhIDUBMC5NFWxKNqa2PaFN/DzyykTJuC029YxGPtqIpKcjOmFJTOEJrrmgIEDikJlQmC6sA==
X-Received: by 2002:a1c:f619:: with SMTP id w25mr5375197wmc.62.1599891873922; 
 Fri, 11 Sep 2020 23:24:33 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id l15sm8476088wrt.81.2020.09.11.23.24.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 23:24:33 -0700 (PDT)
Subject: Re: [PATCH] vhost-scsi: support inflight io track
To: Li Feng <fengli@smartx.com>, lifeng1519@gmail.com,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20200909122021.1055174-1-fengli@smartx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <283d21bb-4fa1-268b-ba27-3237135f28cd@redhat.com>
Date: Sat, 12 Sep 2020 08:24:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909122021.1055174-1-fengli@smartx.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 02:18:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/20 14:20, Li Feng wrote:
> Qemu will send GET_INFLIGHT_FD and SET_INFLIGH_FD to backend, and
> the backend setup the inflight memory to track the io.
> 
> Change-Id: I805d6189996f7a1b44c65f0b12ef7473b1789510
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  hw/scsi/vhost-scsi-common.c           | 27 +++++++++++++++++++++++++++
>  include/hw/virtio/vhost-scsi-common.h |  2 ++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> index 8ec49d7fef..767f827e55 100644
> --- a/hw/scsi/vhost-scsi-common.c
> +++ b/hw/scsi/vhost-scsi-common.c
> @@ -32,6 +32,8 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>      BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
>      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>  
> +    VirtIOSCSICommon *vs = (VirtIOSCSICommon *)vsc;
> +
>      if (!k->set_guest_notifiers) {
>          error_report("binding does not support guest notifiers");
>          return -ENOSYS;
> @@ -49,6 +51,23 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>      }
>  
>      vsc->dev.acked_features = vdev->guest_features;
> +
> +    assert(vsc->inflight == NULL);
> +    vsc->inflight = g_new0(struct vhost_inflight, 1);
> +    ret = vhost_dev_get_inflight(&vsc->dev,
> +                                 vs->conf.virtqueue_size,
> +                                 vsc->inflight);
> +    if (ret < 0) {
> +        error_report("Error get inflight: %d", -ret);
> +        goto err_guest_notifiers;
> +    }
> +
> +    ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
> +    if (ret < 0) {
> +        error_report("Error set inflight: %d", -ret);
> +        goto err_guest_notifiers;
> +    }
> +
>      ret = vhost_dev_start(&vsc->dev, vdev);
>      if (ret < 0) {
>          error_report("Error start vhost dev");
> @@ -66,6 +85,9 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>      return ret;
>  
>  err_guest_notifiers:
> +    g_free(vsc->inflight);
> +    vsc->inflight = NULL;
> +
>      k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
>  err_host_notifiers:
>      vhost_dev_disable_notifiers(&vsc->dev, vdev);
> @@ -89,6 +111,11 @@ void vhost_scsi_common_stop(VHostSCSICommon *vsc)
>      }
>      assert(ret >= 0);
>  
> +    if (vsc->inflight) {
> +        vhost_dev_free_inflight(vsc->inflight);
> +        vsc->inflight = NULL;
> +    }
> +
>      vhost_dev_disable_notifiers(&vsc->dev, vdev);
>  }
>  
> diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
> index 16bf1a73c1..6cd6431d67 100644
> --- a/include/hw/virtio/vhost-scsi-common.h
> +++ b/include/hw/virtio/vhost-scsi-common.h
> @@ -35,6 +35,8 @@ typedef struct VHostSCSICommon {
>      int lun;
>      uint64_t host_features;
>      bool migratable;
> +
> +    struct vhost_inflight *inflight;
>  } VHostSCSICommon;
>  
>  int vhost_scsi_common_start(VHostSCSICommon *vsc);
> 

Queued, thanks.

Paolo


