Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854F0C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C705206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3Aswcu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C705206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTMeh-0005LR-GH
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 05:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jTMXO-0005RK-Pl
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jTMUU-0006Rf-5S
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:28:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35107
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jTM4s-00040k-Gl
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588064333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rY/AUoJsmEGJliYsivZrDjA/22YsI3QNyqzGC/E+0NM=;
 b=h3Aswcu1fuWsuCJpcdzUnu87RmXrGnb0SDKAHnFDjeE+DP2Wp/gZi78yeyjs7aOnzzCFhS
 waO1q3cAfWsDnPTG3wu0diYYWWZoQELMkIHU2dra9vHYP3wtzZLQmDzYoa/u0TKGDxEFo5
 V+RMcaT+WBQQpmmoFrUCmZt/I8Xl1Kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-OkwyvY4EMHyjeQMuBB9Rdw-1; Tue, 28 Apr 2020 04:58:51 -0400
X-MC-Unique: OkwyvY4EMHyjeQMuBB9Rdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4F6480058A;
 Tue, 28 Apr 2020 08:58:50 +0000 (UTC)
Received: from [10.72.13.181] (ovpn-13-181.pek2.redhat.com [10.72.13.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E654B605E0;
 Tue, 28 Apr 2020 08:58:45 +0000 (UTC)
Subject: Re: [PATCH 3/3] virtio-net: remove VIRTIO_NET_HDR_F_RSC_INFO compat
 handling
To: Cornelia Huck <cohuck@redhat.com>
References: <20200427102415.10915-1-cohuck@redhat.com>
 <20200427102415.10915-4-cohuck@redhat.com>
 <7f703bea-2cae-dcdc-71bd-9623c7db33ac@redhat.com>
 <20200428103407.12612838.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <85367d20-e4f5-6869-319e-2f60d2510130@redhat.com>
Date: Tue, 28 Apr 2020 16:58:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428103407.12612838.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/28 =E4=B8=8B=E5=8D=884:34, Cornelia Huck wrote:
> On Tue, 28 Apr 2020 16:19:15 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> On 2020/4/27 =E4=B8=8B=E5=8D=886:24, Cornelia Huck wrote:
>>> VIRTIO_NET_HDR_F_RSC_INFO is available in the headers now.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>    hw/net/virtio-net.c | 8 --------
>>>    1 file changed, 8 deletions(-)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> index e85d902588b3..7449570c7123 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -77,14 +77,6 @@
>>>       tso/gso/gro 'off'. */
>>>    #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
>>>   =20
>>> -/* temporary until standard header include it */
>>> -#if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
>>> -
>>> -#define VIRTIO_NET_HDR_F_RSC_INFO  4 /* rsc_ext data in csum_ fields *=
/
>>> -#define VIRTIO_NET_F_RSC_EXT       61
>>> -
>>> -#endif
>>> -
>>>    static inline __virtio16 *virtio_net_rsc_ext_num_packets(
>>>        struct virtio_net_hdr *hdr)
>>>    {
>>
>> I think we should not keep the those tricky num_packets/dup_acks.
> No real opinion here, patch 3 is only a cleanup.
>
> The important one is patch 1, because without it I cannot do a headers
> update.


Yes, at least we should dereference segments/dup_acks instead of=20
csum_start/csum_offsets since the header has been synced.

Thanks


>


