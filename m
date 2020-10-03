Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1C3C4363C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 01:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F0820719
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 01:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVY87Tvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F0820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOWio-0001v0-3K
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 21:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kOWiD-0001Uz-P5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 21:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kOWiB-000586-3J
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 21:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601689904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Okln2Ce1dgJBE2STQ2+G5bbJ8bSdiX6gXYLv/23VM+w=;
 b=RVY87Tvsb7beg0zMgfU8MaRVDN5Medj/3CSnlbeBbCsgA61JTevfJMmfxBbYBsSkpwjQKA
 JSDIaG+ovBXHNkW1boGJq48QvROKCs5LtgsgcJjcz2igwcRJczKhX/7iaT4CJy+yWfdY+d
 4YKvQvGrbhCXQEZr7R06X9HqT/6iSTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-zBLUNamSNNWStPKaKi7Jtg-1; Fri, 02 Oct 2020 21:51:42 -0400
X-MC-Unique: zBLUNamSNNWStPKaKi7Jtg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56E64803F5C;
 Sat,  3 Oct 2020 01:51:41 +0000 (UTC)
Received: from [10.72.12.21] (ovpn-12-21.pek2.redhat.com [10.72.12.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44D7F5D9D3;
 Sat,  3 Oct 2020 01:51:34 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] vhost: Don't call access_ok() when using IOTLB
To: Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <160139701999.162128.2399875915342200263.stgit@bahia.lan>
 <160139703153.162128.16860679176471296230.stgit@bahia.lan>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <21349052-fefc-4437-4233-f803caceeb38@redhat.com>
Date: Sat, 3 Oct 2020 09:51:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160139703153.162128.16860679176471296230.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 21:51:44
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
> When the IOTLB device is enabled, the vring addresses we get
> from userspace are GIOVAs. It is thus wrong to pass them down
> to access_ok() which only takes HVAs.
>
> Access validation is done at prefetch time with IOTLB. Teach
> vq_access_ok() about that by moving the (vq->iotlb) check
> from vhost_vq_access_ok() to vq_access_ok(). This prevents
> vhost_vring_set_addr() to fail when verifying the accesses.
> No behavior change for vhost_vq_access_ok().
>
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1883084
> Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> Cc: jasowang@redhat.com
> CC: stable@vger.kernel.org # 4.14+
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   drivers/vhost/vhost.c |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index b45519ca66a7..c3b49975dc28 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1290,6 +1290,11 @@ static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
>   			 vring_used_t __user *used)
>   
>   {
> +	/* If an IOTLB device is present, the vring addresses are
> +	 * GIOVAs. Access validation occurs at prefetch time. */
> +	if (vq->iotlb)
> +		return true;
> +
>   	return access_ok(desc, vhost_get_desc_size(vq, num)) &&
>   	       access_ok(avail, vhost_get_avail_size(vq, num)) &&
>   	       access_ok(used, vhost_get_used_size(vq, num));
> @@ -1383,10 +1388,6 @@ bool vhost_vq_access_ok(struct vhost_virtqueue *vq)
>   	if (!vq_log_access_ok(vq, vq->log_base))
>   		return false;
>   
> -	/* Access validation occurs at prefetch time with IOTLB */
> -	if (vq->iotlb)
> -		return true;
> -
>   	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used);
>   }
>   EXPORT_SYMBOL_GPL(vhost_vq_access_ok);
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



