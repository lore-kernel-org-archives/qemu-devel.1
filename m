Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFAAC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7511520656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLjIKoX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7511520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzLr-0001tt-JV
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jSzKh-0000fd-Ij
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jSzKg-0005Bt-V9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:41:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32136
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jSzKg-00057A-ES
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587976901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sy7w5Jwsr9jQ0vylfKVpMS8MyesxRA39G4yPvL0l8rw=;
 b=dLjIKoX1mXDUW4B/tDoEWsOIac35UWQeEE23OnXkgBjpUnbMAdmY+QCArylNCyaThXcFO1
 Y9ndknSjrnTEk82R+z33zZvs+cLoZRxqZsErQ4aoygOEf2ZPAhYrbjBymR0enhR/UbVzxZ
 qcPprhSFWIbG19kLl02cd80chtcbFV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-E4rNK0VgMGKQBADNnkqXUQ-1; Mon, 27 Apr 2020 04:41:37 -0400
X-MC-Unique: E4rNK0VgMGKQBADNnkqXUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E29545F;
 Mon, 27 Apr 2020 08:41:36 +0000 (UTC)
Received: from [10.72.12.205] (ovpn-12-205.pek2.redhat.com [10.72.12.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3425F60300;
 Mon, 27 Apr 2020 08:41:31 +0000 (UTC)
Subject: Re: VIRTIO_NET_HDR_F_RSC_INFO in virtio-net vs headers update
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20200427093345.4111acd9.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8a559698-fb15-1f38-2fad-ee5db27f81f4@redhat.com>
Date: Mon, 27 Apr 2020 16:41:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427093345.4111acd9.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------56E1879DFB55AF077C0137A5"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:32:35
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------56E1879DFB55AF077C0137A5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2020/4/27 =E4=B8=8B=E5=8D=883:33, Cornelia Huck wrote:
> Hi,
>
> I'm currently trying to prepare a linux-headers update to 5.7-rc3,
> which adds the definition of VIRTIO_NET_HDR_F_RSC_INFO.
>
> Unfortunately, this breaks the build of virtio-net, because now
> virtio_net_rsc_ext_num_{packets,dupacks} are undefined (they are
> guarded by existence of VIRTIO_NET_HDR_F_RSC_INFO).
>
> What is the right way to fix this? Remove the constants that are now
> provided by the header and keep the definitions of
> virtio_net_rsc_ext_num_{packets,dupacks}?


We probably need to add a version of the above function when=20
VIRTIO_NET_HDR_F_RSC_INFO is defined as attached.

But I fail to understand why we need a fallback when=20
VIRTIO_NET_HDR_F_RSC_INFO is not defined.

Thanks


>
> [I'd like to queue a headers update as soon as possible, as the whole
> s390 protected virt stuff depends on it...]
>
>

--------------56E1879DFB55AF077C0137A5
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-.patch"

From 915144149cfef1c056ae3b96dfb714a2bd483759 Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Apr 2020 16:38:51 +0800
Subject: [PATCH]

---
 hw/net/virtio-net.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e5bf670c3f..dd671bcc0d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -171,6 +171,20 @@ static inline __virtio16 *virtio_net_rsc_ext_num_dupacks(
     return &hdr->csum_offset;
 }
 
+#else
+
+static inline __virtio16 *virtio_net_rsc_ext_num_packets(
+    struct virtio_net_hdr *hdr)
+{
+    return &hdr->segments;
+}
+
+static inline __virtio16 *virtio_net_rsc_ext_num_dupacks(
+    struct virtio_net_hdr *hdr)
+{
+    return &hdr->dup_acks;
+}
+
 #endif
 
 static VirtIOFeature feature_sizes[] = {
-- 
2.20.1


--------------56E1879DFB55AF077C0137A5--


