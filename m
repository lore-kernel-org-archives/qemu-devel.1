Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C91CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 02:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6CE206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 02:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVkUnxlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6CE206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR4hT-00054O-4Q
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 22:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kR4gT-0004da-62
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 22:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kR4gQ-0006fw-Fo
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 22:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602297148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0+yMqB5qWuc0BoeYtvqmNWdzEX4ZInq9BnlDhYqt00=;
 b=iVkUnxlRq4YnQwMXU6gysjZAk1SyGpefN3GTQksDL3/q4iu6OPcyXItSPjPfHxU5JSCf3Z
 xSwgih/lpGVOuoMplTH1DWJTU5vHikybYFxFvoyJDtO2txARXkaQcO19xU9qvDP+D9I8Ea
 7lvyv/4hbvtTVm0U3cMT480DQth34Tk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-55hpNga7MaCPTcKGrULuZw-1; Fri, 09 Oct 2020 22:32:24 -0400
X-MC-Unique: 55hpNga7MaCPTcKGrULuZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71949879514;
 Sat, 10 Oct 2020 02:32:22 +0000 (UTC)
Received: from [10.72.13.27] (ovpn-13-27.pek2.redhat.com [10.72.13.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D59260BE2;
 Sat, 10 Oct 2020 02:32:15 +0000 (UTC)
Subject: Re: [PATCH v3 2/3] vhost: Use vhost_get_used_size() in
 vhost_vring_set_addr()
To: Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <160171888144.284610.4628526949393013039.stgit@bahia.lan>
 <160171932300.284610.11846106312938909461.stgit@bahia.lan>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5fc896c6-e60d-db0b-f7b0-5b6806d70b8e@redhat.com>
Date: Sat, 10 Oct 2020 10:32:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160171932300.284610.11846106312938909461.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 22:04:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/10/3 下午6:02, Greg Kurz wrote:
> The open-coded computation of the used size doesn't take the event
> into account when the VIRTIO_RING_F_EVENT_IDX feature is present.
> Fix that by using vhost_get_used_size().
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   drivers/vhost/vhost.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c3b49975dc28..9d2c225fb518 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1519,8 +1519,7 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
>   		/* Also validate log access for used ring if enabled. */
>   		if ((a.flags & (0x1 << VHOST_VRING_F_LOG)) &&
>   			!log_access_ok(vq->log_base, a.log_guest_addr,
> -				sizeof *vq->used +
> -				vq->num * sizeof *vq->used->ring))
> +				       vhost_get_used_size(vq, vq->num)))
>   			return -EINVAL;
>   	}
>   
>
>

Acked-by: Jason Wang <jasowang@redhat.com>



