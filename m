Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82420C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 03:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E264A21D43
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 03:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOwSNt/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E264A21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR59C-0001PU-Te
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 23:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kR58E-0000YA-VU
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 23:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kR589-00079c-Sl
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 23:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602298867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=coiDnr2j0+5r/bVcK9iEriuCq6hzJi0eXfVrwQbFAj4=;
 b=SOwSNt/BvO9p8DCPn72ShNR9EjVfLNF3NicaRD3caI3PK6hhiWBNporc4xwlRniHeEIojB
 4V1fAF5kU6XQNJ9Nf3q2wG5Fe/qfYLu/lWZn7M1cu4F6RfjlwmNa42lJPxelTVYUz4CZd9
 BvgbwWVGt+tLdzZwIAEa6qimrQ7H7g4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-PEzBcXldPL-FrrO4e73PHQ-1; Fri, 09 Oct 2020 23:01:05 -0400
X-MC-Unique: PEzBcXldPL-FrrO4e73PHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7599805F05;
 Sat, 10 Oct 2020 03:01:03 +0000 (UTC)
Received: from [10.72.13.27] (ovpn-13-27.pek2.redhat.com [10.72.13.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92E425D9FC;
 Sat, 10 Oct 2020 03:00:56 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] vhost: Don't call log_access_ok() when using IOTLB
To: Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <160171888144.284610.4628526949393013039.stgit@bahia.lan>
 <160171933385.284610.10189082586063280867.stgit@bahia.lan>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7c512087-639f-0b08-5d8d-6942528d2e06@redhat.com>
Date: Sat, 10 Oct 2020 11:00:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160171933385.284610.10189082586063280867.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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


Acked-by: Jason Wang <jasowang@redhat.com>

In the future, we may consider to deprecate log_guest_addr since in any 
case regardless of IOTLB ennoblement we can get GPA from either IOTLB or 
MEM table.

Thanks


> ---
>   drivers/vhost/vhost.c |   23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 9d2c225fb518..9ad45e1d27f0 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1370,6 +1370,20 @@ bool vhost_log_access_ok(struct vhost_dev *dev)
>   }
>   EXPORT_SYMBOL_GPL(vhost_log_access_ok);
>   
> +static bool vq_log_used_access_ok(struct vhost_virtqueue *vq,
> +				  void __user *log_base,
> +				  bool log_used,
> +				  u64 log_addr)
> +{
> +	/* If an IOTLB device is present, log_addr is a GIOVA that
> +	 * will never be logged by log_used(). */
> +	if (vq->iotlb)
> +		return true;
> +
> +	return !log_used || log_access_ok(log_base, log_addr,
> +					  vhost_get_used_size(vq, vq->num));
> +}
> +
>   /* Verify access for write logging. */
>   /* Caller should have vq mutex and device mutex */
>   static bool vq_log_access_ok(struct vhost_virtqueue *vq,
> @@ -1377,8 +1391,7 @@ static bool vq_log_access_ok(struct vhost_virtqueue *vq,
>   {
>   	return vq_memory_access_ok(log_base, vq->umem,
>   				   vhost_has_feature(vq, VHOST_F_LOG_ALL)) &&
> -		(!vq->log_used || log_access_ok(log_base, vq->log_addr,
> -				  vhost_get_used_size(vq, vq->num)));
> +		vq_log_used_access_ok(vq, log_base, vq->log_used, vq->log_addr);
>   }
>   
>   /* Can we start vq? */
> @@ -1517,9 +1530,9 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
>   			return -EINVAL;
>   
>   		/* Also validate log access for used ring if enabled. */
> -		if ((a.flags & (0x1 << VHOST_VRING_F_LOG)) &&
> -			!log_access_ok(vq->log_base, a.log_guest_addr,
> -				       vhost_get_used_size(vq, vq->num)))
> +		if (!vq_log_used_access_ok(vq, vq->log_base,
> +				a.flags & (0x1 << VHOST_VRING_F_LOG),
> +				a.log_guest_addr))
>   			return -EINVAL;
>   	}
>   
>
>


