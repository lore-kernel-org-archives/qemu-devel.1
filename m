Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1FCC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164C5206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBKI91N0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164C5206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTLuU-0007X6-3T
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 04:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jTLrb-0003ZV-ED
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jTLmm-0006wi-DQ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:41:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58672
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jTLSh-0004Pt-Ci
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588061966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZ/UUK5klKoP5DtXCXxRf3rW2Fvmtl16Iwp5ocV285A=;
 b=KBKI91N06mo2IV3pn0EsyasaFFg98II1+o0RAz6nQABKmpxflDimNxVL6MGLcqNWAnhoGU
 lrqSx5XA6c+7GgmFN4nb2Zb1xGR3H2ByAbM5dB0Sz4NzkepYusab1QOeNavTY8qsO6GCpx
 xUG9TAgMLd06dSahevFbAIpkmMxrvFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-gsolQS5HNcSigW0KQZiEIA-1; Tue, 28 Apr 2020 04:19:22 -0400
X-MC-Unique: gsolQS5HNcSigW0KQZiEIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FB5F1005510;
 Tue, 28 Apr 2020 08:19:21 +0000 (UTC)
Received: from [10.72.13.181] (ovpn-13-181.pek2.redhat.com [10.72.13.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A3561001DC2;
 Tue, 28 Apr 2020 08:19:16 +0000 (UTC)
Subject: Re: [PATCH 3/3] virtio-net: remove VIRTIO_NET_HDR_F_RSC_INFO compat
 handling
To: Cornelia Huck <cohuck@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200427102415.10915-1-cohuck@redhat.com>
 <20200427102415.10915-4-cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7f703bea-2cae-dcdc-71bd-9623c7db33ac@redhat.com>
Date: Tue, 28 Apr 2020 16:19:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427102415.10915-4-cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/27 =E4=B8=8B=E5=8D=886:24, Cornelia Huck wrote:
> VIRTIO_NET_HDR_F_RSC_INFO is available in the headers now.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/net/virtio-net.c | 8 --------
>   1 file changed, 8 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index e85d902588b3..7449570c7123 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -77,14 +77,6 @@
>      tso/gso/gro 'off'. */
>   #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
>  =20
> -/* temporary until standard header include it */
> -#if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
> -
> -#define VIRTIO_NET_HDR_F_RSC_INFO  4 /* rsc_ext data in csum_ fields */
> -#define VIRTIO_NET_F_RSC_EXT       61
> -
> -#endif
> -
>   static inline __virtio16 *virtio_net_rsc_ext_num_packets(
>       struct virtio_net_hdr *hdr)
>   {


I think we should not keep the those tricky num_packets/dup_acks.

Thanks


