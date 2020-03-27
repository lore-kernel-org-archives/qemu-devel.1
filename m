Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD41C2D0EE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 02:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B1A20774
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 02:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOyDMVlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B1A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHeg6-0002AU-2y
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 22:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jHefB-0001ju-UU
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jHefA-0005qh-GY
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:24:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32935)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jHef9-0005nU-5g
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585275837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCU1fxZ1FBuYB9JEtBNyS4mOKsUWs2FXq5XKSUCrggQ=;
 b=TOyDMVlkBw3z/dAomxR9lA7PDWySa7zDFSuQa0YfNcRC3W/Vbr/Sz1BHiH76bmbJB2KFlf
 5CjvlJgBBGaVffUcGYEogZNXnGwAlkU5DAcKMc5c5paUlIVdXdV3xVpb+QapnsAf0gOfG0
 1VBe2yeiDTORmpQITcXIX2sJsPc41kU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-fWR0d1XgNPOp18LXToJeHg-1; Thu, 26 Mar 2020 22:23:53 -0400
X-MC-Unique: fWR0d1XgNPOp18LXToJeHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17393100726D;
 Fri, 27 Mar 2020 02:23:52 +0000 (UTC)
Received: from [10.72.13.132] (ovpn-13-132.pek2.redhat.com [10.72.13.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C37660304;
 Fri, 27 Mar 2020 02:23:46 +0000 (UTC)
Subject: Re: [PATCH v6 0/7] reference implementation of RSS and hash report
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20200320115751.19446-1-yuri.benditovich@daynix.com>
 <20200326093217-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9433decc-668c-6d35-c788-74677db54ee8@redhat.com>
Date: Fri, 27 Mar 2020 10:23:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200326093217-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: yan@daynix.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/26 =E4=B8=8B=E5=8D=889:32, Michael S. Tsirkin wrote:
> On Fri, Mar 20, 2020 at 01:57:44PM +0200, Yuri Benditovich wrote:
>> Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
>> features in QEMU for reference purpose.
>> Implements Toeplitz hash calculation for incoming
>> packets according to configuration provided by driver.
>> Uses calculated hash for decision on receive virtqueue
>> and/or reports the hash in the virtio header
> Series:
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


Queued for 5.1.

Thanks


>
>> Changes from v5:
>> RSS migration state moved to subsection and migrated
>> only if enabled (patch 7)
>> Updated sign off (patch 6)
>>
>> Yuri Benditovich (7):
>>    virtio-net: introduce RSS and hash report features
>>    virtio-net: implement RSS configuration command
>>    virtio-net: implement RX RSS processing
>>    tap: allow extended virtio header with hash info
>>    virtio-net: reference implementation of hash report
>>    vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
>>    virtio-net: add migration support for RSS and hash report
>>
>>   hw/net/trace-events            |   3 +
>>   hw/net/virtio-net.c            | 448 +++++++++++++++++++++++++++++++--
>>   include/hw/virtio/virtio-net.h |  16 ++
>>   include/migration/vmstate.h    |  10 +
>>   net/tap.c                      |  11 +-
>>   5 files changed, 460 insertions(+), 28 deletions(-)
>>
>> --=20
>> 2.17.1


