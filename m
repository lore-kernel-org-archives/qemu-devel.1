Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92081C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0D5206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmk2VhL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0D5206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnd5o-0001eM-LD
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jnd5F-0001CI-KG
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 03:11:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53430
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jnd5C-000750-3p
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 03:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592896260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDM0L9lhQxd6UokRTAKTLB+u8ULZbu0di6SKr+0ofhY=;
 b=cmk2VhL+LFmvHKT555LYuWV4gbCHhyzP0ylhv6AWG6AFQBMJ55QrbGW9xhHzOjP7M/W8Ec
 jZG0l6ASINP7l1ccM6lt3FKM3Wrdq8i4Jao6kJEZEd4WVoMKXL5aOyCppVIxsOV1Ubarnu
 MMHYiCD0RDgdpA34Flqy4r0nxhq5d4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107--PdAmO9LO6iJwN1zlJymkg-1; Tue, 23 Jun 2020 03:10:59 -0400
X-MC-Unique: -PdAmO9LO6iJwN1zlJymkg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01F0F18A8220;
 Tue, 23 Jun 2020 07:10:57 +0000 (UTC)
Received: from [10.72.12.144] (ovpn-12-144.pek2.redhat.com [10.72.12.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14F0019D61;
 Tue, 23 Jun 2020 07:10:35 +0000 (UTC)
Subject: Re: [PATCH v1 01/10] net: introduce qemu_get_peer
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eae4f76b-99d5-d51e-e214-93078948040c@redhat.com>
Date: Tue, 23 Jun 2020 15:10:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622153756.19189-2-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com,
 jgg@mellanox.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, cunming.liang@intel.com,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, zhihong.wang@intel.com, aadam@redhat.com,
 rdunlap@infradead.org, maxime.coquelin@redhat.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/22 下午11:37, Cindy Lu wrote:
> This is a small function that can get the peer
> from given NetClientState and queue_index
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   include/net/net.h | 1 +
>   net/net.c         | 6 ++++++
>   2 files changed, 7 insertions(+)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index 39085d9444..e7ef42d62b 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -176,6 +176,7 @@ void hmp_info_network(Monitor *mon, const QDict *qdict);
>   void net_socket_rs_init(SocketReadState *rs,
>                           SocketReadStateFinalize *finalize,
>                           bool vnet_hdr);
> +NetClientState *qemu_get_peer(NetClientState *nc, int queue_index);
>   
>   /* NIC info */
>   
> diff --git a/net/net.c b/net/net.c
> index 38778e831d..599fb61028 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -324,6 +324,12 @@ void *qemu_get_nic_opaque(NetClientState *nc)
>   
>       return nic->opaque;
>   }


newline please.

Thanks


> +NetClientState *qemu_get_peer(NetClientState *nc, int queue_index)
> +{
> +    assert(nc != NULL);
> +    NetClientState *ncs = nc + queue_index;
> +    return ncs->peer;
> +}
>   
>   static void qemu_cleanup_net_client(NetClientState *nc)
>   {


