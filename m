Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32C9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD9E20897
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvCnlgfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD9E20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKNc-0005sJ-MJ
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeKMj-0004o8-Pk
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:22:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35111
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeKMh-0002iS-R8
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590679358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cjEcug7wUQa2vcS4uoYlJ3KiL7dTBqoWts006Kcra8g=;
 b=CvCnlgfoxSlheEsNRx5cOU6Fm7zwbSFrdhVIusFZKc03tJdxrM1oyXGYlHVD/xZ7MDL3X7
 t+figI9tG1qh8lSG1/zh3GpiCGhSWF3ARGxy+Lhmk0iFKp9hd71090CaV7E67J8R2RTf7v
 iv9ADVZ2Ip95O/l4aou53qxe66ZpQvM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-fmnE2On_Pgaku8HaHI277g-1; Thu, 28 May 2020 11:22:36 -0400
X-MC-Unique: fmnE2On_Pgaku8HaHI277g-1
Received: by mail-wm1-f70.google.com with SMTP id v23so861266wmj.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 08:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=cjEcug7wUQa2vcS4uoYlJ3KiL7dTBqoWts006Kcra8g=;
 b=GH0k4lUkihyYQHUBOD35Lh4CO8Cgv2SgqbxJ2//PTQP6cacUxm/Nvvfz21TIm6RzIL
 4BDHjGhDtgJwblNNVIC7NXso14Yl/AYgIXLPk0hozWk/HqziNQXuabV+PNj1L25M2aNI
 63I1Nk1oh6JCBgGG1pThhggxW2eyP6JLpqNMcyHlTck9HsPAmD8a8dGPeqtltfIDJ7EJ
 PbfKslvLOdblMBw9ooQBtpB1fb16W1DAc2o9UyDWy7JuVMHXjtHcvhH7oCIoMt2cWIHL
 jhxUlHYBN8kRH/xjC2DDVWuwLe10hpf42PBMzwAhnRqcVWkM/kTo+e1QVEux7VVlIJEt
 Kmfw==
X-Gm-Message-State: AOAM53093TzT2Ryiyonc0EwXyz/ZBEqPjLKRE8jSimDpjOGTZGacRTQq
 DL1IvqmIOzFo0pPjY0YvpCfx5Wd4o0krkMyqe36MND4wK5WTbfS0XmmW8/HBqH5/lNZkoACZZrh
 92rTrmMtWKi3U1WA=
X-Received: by 2002:a1c:5a0b:: with SMTP id o11mr3799797wmb.74.1590679355326; 
 Thu, 28 May 2020 08:22:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMVNMrxwyssKOTTlimR6qHlf0xCJUm3vZwHl21hIDHs9Mpy9SfBWlcLsKVhF/PpwwrZ3mA3g==
X-Received: by 2002:a1c:5a0b:: with SMTP id o11mr3799777wmb.74.1590679355066; 
 Thu, 28 May 2020 08:22:35 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id p10sm6332468wra.78.2020.05.28.08.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 08:22:34 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] virtio-scsi: introduce a constant for fixed
 virtqueues
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200527102925.128013-1-stefanha@redhat.com>
 <20200527102925.128013-3-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <97d47f1f-0751-b84b-57b4-4ed16ffeed6e@redhat.com>
Date: Thu, 28 May 2020 17:22:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200527102925.128013-3-stefanha@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 12:29 PM, Stefan Hajnoczi wrote:
> The event and control virtqueues are always present, regardless of the
> multi-queue configuration.  Define a constant so that virtqueue number
> calculations are easier to read.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/hw/virtio/virtio-scsi.h | 3 +++
>  hw/scsi/vhost-user-scsi.c       | 2 +-
>  hw/scsi/virtio-scsi.c           | 7 ++++---
>  hw/virtio/vhost-scsi-pci.c      | 3 ++-
>  hw/virtio/vhost-user-scsi-pci.c | 3 ++-
>  hw/virtio/virtio-scsi-pci.c     | 3 ++-
>  6 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
> index 24e768909d..9f293bcb80 100644
> --- a/include/hw/virtio/virtio-scsi.h
> +++ b/include/hw/virtio/virtio-scsi.h
> @@ -36,6 +36,9 @@
>  #define VIRTIO_SCSI_MAX_TARGET  255
>  #define VIRTIO_SCSI_MAX_LUN     16383
>  
> +/* Number of virtqueues that are always present */
> +#define VIRTIO_SCSI_VQ_NUM_FIXED    2
> +
>  typedef struct virtio_scsi_cmd_req VirtIOSCSICmdReq;
>  typedef struct virtio_scsi_cmd_resp VirtIOSCSICmdResp;
>  typedef struct virtio_scsi_ctrl_tmf_req VirtIOSCSICtrlTMFReq;
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index cbb5d97599..f8bd158c31 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -115,7 +115,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
>          goto free_virtio;
>      }
>  
> -    vsc->dev.nvqs = 2 + vs->conf.num_queues;
> +    vsc->dev.nvqs = VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
>      vsc->dev.vqs = g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
>      vsc->dev.vq_index = 0;
>      vsc->dev.backend_features = 0;
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 9b72094a61..f3d60683bd 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -191,7 +191,7 @@ static void virtio_scsi_save_request(QEMUFile *f, SCSIRequest *sreq)
>      VirtIOSCSIReq *req = sreq->hba_private;
>      VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(req->dev);
>      VirtIODevice *vdev = VIRTIO_DEVICE(req->dev);
> -    uint32_t n = virtio_get_queue_index(req->vq) - 2;
> +    uint32_t n = virtio_get_queue_index(req->vq) - VIRTIO_SCSI_VQ_NUM_FIXED;
>  
>      assert(n < vs->conf.num_queues);
>      qemu_put_be32s(f, &n);
> @@ -892,10 +892,11 @@ void virtio_scsi_common_realize(DeviceState *dev,
>                  sizeof(VirtIOSCSIConfig));
>  
>      if (s->conf.num_queues == 0 ||
> -            s->conf.num_queues > VIRTIO_QUEUE_MAX - 2) {
> +            s->conf.num_queues > VIRTIO_QUEUE_MAX - VIRTIO_SCSI_VQ_NUM_FIXED) {
>          error_setg(errp, "Invalid number of queues (= %" PRIu32 "), "
>                           "must be a positive integer less than %d.",
> -                   s->conf.num_queues, VIRTIO_QUEUE_MAX - 2);
> +                   s->conf.num_queues,
> +                   VIRTIO_QUEUE_MAX - VIRTIO_SCSI_VQ_NUM_FIXED);
>          virtio_cleanup(vdev);
>          return;
>      }
> diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
> index 5da6bb6449..2b25db9a3c 100644
> --- a/hw/virtio/vhost-scsi-pci.c
> +++ b/hw/virtio/vhost-scsi-pci.c
> @@ -50,7 +50,8 @@ static void vhost_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
>  
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> -        vpci_dev->nvectors = vs->conf.num_queues + 3;
> +        vpci_dev->nvectors = vs->conf.num_queues +
> +                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
>      }
>  
>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
> index 6f3375fe55..80710ab170 100644
> --- a/hw/virtio/vhost-user-scsi-pci.c
> +++ b/hw/virtio/vhost-user-scsi-pci.c
> @@ -56,7 +56,8 @@ static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
>  
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> -        vpci_dev->nvectors = vs->conf.num_queues + 3;
> +        vpci_dev->nvectors = vs->conf.num_queues +
> +                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
>      }
>  
>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
> index e82e7e5680..c52d68053a 100644
> --- a/hw/virtio/virtio-scsi-pci.c
> +++ b/hw/virtio/virtio-scsi-pci.c
> @@ -51,7 +51,8 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      char *bus_name;
>  
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> -        vpci_dev->nvectors = vs->conf.num_queues + 3;
> +        vpci_dev->nvectors = vs->conf.num_queues +
> +                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
>      }
>  
>      /*
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


