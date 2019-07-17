Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B77C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A9F20880
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A9F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hngSC-00033y-8Z
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 05:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40310)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hngS1-0002IG-C4
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hngRz-0001aW-D3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:42:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hngRz-0001aG-6F
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:42:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so24008876wrt.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 02:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1TzcnS+UXqdXJLiq/ir1G9+qN9TTnUPCIfu3LwRg2qY=;
 b=oUeeOJiaz8NM7REVl2ibs0rN0Y5PRssD/Qxezi5LwKB4Lb8GAwKH/hVwkGMvFG4D4j
 3BMTqcJkGjaykORkfIajZaK81yaXnYu8zHQOyDzrVBQOaIyf7IfVAw3U+LT9TYoMI8bH
 iflHXMJ62Xy0UxiPsedrvXQ2D8NSz9AvfwhJtEdi6Put7Q8sMUTkTDcZZMVs1aU3mUnj
 KuwkwVln0mVp+FTXYg0+hlKSi+BMIQ8Hd1NJuR3HeR58dpBB147Xh4YfNcUnYb0qQS3v
 tzBpUf1Klve0zCrlPj3A5vtcnWo2jfG3WT2uj8hbowEIiE23gBaO8YwWs0quga9X1M/a
 MWCA==
X-Gm-Message-State: APjAAAUv1Hj5vYmS4pyaBwtMkmwvyf47ZEaCfnWIPjb9dMJNlSkX9QWo
 ltLU9Xf/CVNbm9HWp6r5UFUTqjD7mxMaOg==
X-Google-Smtp-Source: APXvYqydXbMZrFvcSdNBO9uJFTP0yS5DghldRpBiHCVPwPk2HJ6QOghzNf5YnzLEqHRczhOqvjUMlQ==
X-Received: by 2002:a5d:4090:: with SMTP id o16mr43113003wrp.292.1563356534066; 
 Wed, 17 Jul 2019 02:42:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id 91sm48362041wrp.3.2019.07.17.02.42.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 02:42:13 -0700 (PDT)
To: elohimes@gmail.com, mst@redhat.com, stefanha@gmail.com, fam@euphon.net
References: <20190717004606.12444-1-xieyongji@baidu.com>
 <20190717004606.12444-2-xieyongji@baidu.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <40851745-e228-4837-63fc-afd68455fb55@redhat.com>
Date: Wed, 17 Jul 2019 11:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717004606.12444-2-xieyongji@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vhost-user-scsi: Call
 virtio_scsi_common_unrealize() when device realize failed
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
Cc: Xie Yongji <xieyongji@baidu.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/19 02:46, elohimes@gmail.com wrote:
> From: Xie Yongji <xieyongji@baidu.com>
> 
> This avoids memory leak when device hotplug is failed.
> 
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> ---
>  hw/scsi/vhost-user-scsi.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index a9fd8ea305..17826ef8e2 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -87,7 +87,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
>      }
>  
>      if (!vhost_user_init(&s->vhost_user, &vs->conf.chardev, errp)) {
> -        return;
> +        goto free_virtio;
>      }
>  
>      vsc->dev.nvqs = 2 + vs->conf.num_queues;
> @@ -101,15 +101,23 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
>      if (ret < 0) {
>          error_setg(errp, "vhost-user-scsi: vhost initialization failed: %s",
>                     strerror(-ret));
> -        vhost_user_cleanup(&s->vhost_user);
> -        g_free(vqs);
> -        return;
> +        goto free_vhost;
>      }
>  
>      /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
>      vsc->channel = 0;
>      vsc->lun = 0;
>      vsc->target = vs->conf.boot_tpgt;
> +
> +    return;
> +
> +free_vhost:
> +    vhost_user_cleanup(&s->vhost_user);
> +    g_free(vqs);
> +free_virtio:
> +    err = NULL;
> +    virtio_scsi_common_unrealize(dev, &err);
> +    error_propagate(errp, err);
>  }
>  
>  static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
> 

Queued both patches, thanks.

Paolo

