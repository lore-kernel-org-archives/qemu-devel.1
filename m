Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558F3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 03:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DA22073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 03:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYSCosrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DA22073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd3qZ-000566-AD
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 23:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jd3pw-0004cg-UP
 for qemu-devel@nongnu.org; Sun, 24 May 2020 23:31:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31760
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jd3pv-00052A-CR
 for qemu-devel@nongnu.org; Sun, 24 May 2020 23:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590377494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95v/6yI/zAA7KNaR6LAVKVo7JrXK8WMm5E1jlsOwZ0M=;
 b=QYSCosrn/0hFtWZj/scN7HDrEIpR8FMbeHLgMmPbyYnW8ePejhQT0W8T4PGylmEBr33/60
 2pvHSGC8CieYtMqCuH2/hDNqT8VBoruBDUSiB8XzJ54NgOdOgAD8TMjogWFsvRDk9ZMoX7
 tHrL3Aj/G2akPoQFLU1OhzbfZGz74zQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-dFYOJTG1MnGaj0EcR6bM3g-1; Sun, 24 May 2020 23:31:32 -0400
X-MC-Unique: dFYOJTG1MnGaj0EcR6bM3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F5171855A04;
 Mon, 25 May 2020 03:31:31 +0000 (UTC)
Received: from [10.72.13.226] (ovpn-13-226.pek2.redhat.com [10.72.13.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC00B60E1C;
 Mon, 25 May 2020 03:31:18 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] vhost-user-blk: delay vhost_user_blk_disconnect
To: Dima Stepanov <dimastep@yandex-team.ru>, qemu-devel@nongnu.org
References: <cover.1589989075.git.dimastep@yandex-team.ru>
 <0dfb37f8728aba26c8d6c117018332a5b7dc9b56.1589989075.git.dimastep@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6621f54b-45c1-c4da-04ef-42379a4f33c0@redhat.com>
Date: Mon, 25 May 2020 11:31:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0dfb37f8728aba26c8d6c117018332a5b7dc9b56.1589989075.git.dimastep@yandex-team.ru>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 23:31:34
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 dgilbert@redhat.com, raphael.norwitz@nutanix.com, fengli@smartx.com,
 yc-core@yandex-team.ru, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/20 下午11:53, Dima Stepanov wrote:
> A socket write during vhost-user communication may trigger a disconnect
> event, calling vhost_user_blk_disconnect() and clearing all the
> vhost_dev structures holding data that vhost-user functions expect to
> remain valid to roll back initialization correctly. Delay the cleanup to
> keep vhost_dev structure valid.
> There are two possible states to handle:
> 1. RUN_STATE_PRELAUNCH: skip bh oneshot call and perform disconnect in
> the caller routine.
> 2. RUN_STATE_RUNNING: delay by using bh
>
> BH changes are based on the similar changes for the vhost-user-net
> device:
>    commit e7c83a885f865128ae3cf1946f8cb538b63cbfba
>    "vhost-user: delay vhost_user_stop"


It's better to explain why we don't need to deal with case 1 in the 
vhost-user-net case.

And do we still need patch 1 if we had this patch??

Thanks


>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>   hw/block/vhost-user-blk.c | 49 +++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 9d8c0b3..447fc9c 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -337,11 +337,6 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>       VHostUserBlk *s = VHOST_USER_BLK(vdev);
>   
> -    if (!s->connected) {
> -        return;
> -    }
> -    s->connected = false;
> -
>       if (s->dev.started) {
>           vhost_user_blk_stop(vdev);
>       }
> @@ -349,6 +344,19 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
>       vhost_dev_cleanup(&s->dev);
>   }
>   
> +static void vhost_user_blk_event(void *opaque, QEMUChrEvent event);
> +
> +static void vhost_user_blk_chr_closed_bh(void *opaque)
> +{
> +    DeviceState *dev = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +
> +    vhost_user_blk_disconnect(dev);
> +    qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, vhost_user_blk_event,
> +            NULL, opaque, NULL, true);
> +}
> +
>   static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
>   {
>       DeviceState *dev = opaque;
> @@ -363,7 +371,28 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
>           }
>           break;
>       case CHR_EVENT_CLOSED:
> -        vhost_user_blk_disconnect(dev);
> +        /*
> +         * A close event may happen during a read/write, but vhost
> +         * code assumes the vhost_dev remains setup, so delay the
> +         * stop & clear. There are two possible paths to hit this
> +         * disconnect event:
> +         * 1. When VM is in the RUN_STATE_PRELAUNCH state. The
> +         * vhost_user_blk_device_realize() is a caller.
> +         * 2. In tha main loop phase after VM start.
> +         *
> +         * For p2 the disconnect event will be delayed. We can't
> +         * do the same for p1, because we are not running the loop
> +         * at this moment. So just skip this step and perform
> +         * disconnect in the caller function.
> +         */
> +        if (s->connected && runstate_is_running()) {
> +            AioContext *ctx = qemu_get_current_aio_context();
> +
> +            qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, NULL, NULL,
> +                    NULL, NULL, false);
> +            aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, opaque);
> +        }
> +        s->connected = false;
>           break;
>       case CHR_EVENT_BREAK:
>       case CHR_EVENT_MUX_IN:
> @@ -428,6 +457,14 @@ reconnect:
>   
>       ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
>                                  sizeof(struct virtio_blk_config));
> +    if (!s->connected) {
> +        /*
> +         * Perform disconnect before making reconnect. More detailed
> +         * comment why it was delayed is in the vhost_user_blk_event()
> +         * routine.
> +         */
> +        vhost_user_blk_disconnect(dev);
> +    }
>       if (ret < 0) {
>           error_report("vhost-user-blk: get block config failed");
>           goto reconnect;


