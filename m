Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD23C4363C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 02:00:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1186720719
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 02:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8kRsPg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1186720719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOWqS-0003Us-MJ
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 22:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kOWpO-00031m-SV
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 21:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kOWpN-0005jD-7f
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 21:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601690352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YeOAtvvMPwaNHz/wYRORgCGMK3Ts1ggRda1sMGxGQFA=;
 b=V8kRsPg73mY1aqPTpDBNpne+w39tFhduFJHfFgXNot4K0HeIbJMSkXzY9C7HASfBjATxky
 kd2zArMfpU0lxSwHWQHum36FgTWSW5HwA2O43dXoG63Qf5gpBiRTPiYui9WdztAHnK5lm2
 k3XKZ/sQ/JOVM6DqXUZHOu88pPmbGvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-1nU4H7_uOzuVqsTeKAiepQ-1; Fri, 02 Oct 2020 21:59:08 -0400
X-MC-Unique: 1nU4H7_uOzuVqsTeKAiepQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5F4E107464A;
 Sat,  3 Oct 2020 01:59:06 +0000 (UTC)
Received: from [10.72.12.21] (ovpn-12-21.pek2.redhat.com [10.72.12.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3FDA5577C;
 Sat,  3 Oct 2020 01:59:00 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] vhost: Don't call log_access_ok() when using IOTLB
To: Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <160139701999.162128.2399875915342200263.stgit@bahia.lan>
 <160139704424.162128.7839027287942194310.stgit@bahia.lan>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d9dae1ed-49a4-909a-6840-ae46a4ffdffc@redhat.com>
Date: Sat, 3 Oct 2020 09:58:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160139704424.162128.7839027287942194310.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 21:59:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/30 上午12:30, Greg Kurz wrote:
> When the IOTLB device is enabled, the log_guest_addr that is passed by
> userspace to the VHOST_SET_VRING_ADDR ioctl, and which is then written
> to vq->log_addr, is a GIOVA. All writes to this address are translated
> by log_user() to writes to an HVA, and then ultimately logged through
> the corresponding GPAs in log_write_hva(). No logging will ever occur
> with vq->log_addr in this case. It is thus wrong to pass vq->log_addr
> and log_guest_addr to log_access_vq() which assumes they are actual
> GPAs.
>
> Introduce a new vq_log_used_access_ok() helper that only checks accesses
> to the log for the used structure when there isn't an IOTLB device around.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   drivers/vhost/vhost.c |   23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c3b49975dc28..5996e32fa818 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1370,6 +1370,20 @@ bool vhost_log_access_ok(struct vhost_dev *dev)
>   }
>   EXPORT_SYMBOL_GPL(vhost_log_access_ok);
>   
> +static bool vq_log_used_access_ok(struct vhost_virtqueue *vq,
> +				  void __user *log_base,
> +				  bool log_used,
> +				  u64 log_addr,
> +				  size_t log_size)
> +{
> +	/* If an IOTLB device is present, log_addr is a GIOVA that
> +	 * will never be logged by log_used(). */
> +	if (vq->iotlb)
> +		return true;
> +
> +	return !log_used || log_access_ok(log_base, log_addr, log_size);
> +}
> +
>   /* Verify access for write logging. */
>   /* Caller should have vq mutex and device mutex */
>   static bool vq_log_access_ok(struct vhost_virtqueue *vq,
> @@ -1377,8 +1391,8 @@ static bool vq_log_access_ok(struct vhost_virtqueue *vq,
>   {
>   	return vq_memory_access_ok(log_base, vq->umem,
>   				   vhost_has_feature(vq, VHOST_F_LOG_ALL)) &&
> -		(!vq->log_used || log_access_ok(log_base, vq->log_addr,
> -				  vhost_get_used_size(vq, vq->num)));
> +		vq_log_used_access_ok(vq, log_base, vq->log_used, vq->log_addr,
> +				      vhost_get_used_size(vq, vq->num));
>   }
>   
>   /* Can we start vq? */
> @@ -1517,8 +1531,9 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
>   			return -EINVAL;
>   
>   		/* Also validate log access for used ring if enabled. */
> -		if ((a.flags & (0x1 << VHOST_VRING_F_LOG)) &&
> -			!log_access_ok(vq->log_base, a.log_guest_addr,
> +		if (!vq_log_used_access_ok(vq, vq->log_base,
> +				a.flags & (0x1 << VHOST_VRING_F_LOG),
> +				a.log_guest_addr,
>   				sizeof *vq->used +
>   				vq->num * sizeof *vq->used->ring))


It looks to me that we should use vhost_get_used_size() which takes 
event into account.

Any reason that we can't reuse vq_log_access_ok() here?

Thanks


>   			return -EINVAL;
>
>


