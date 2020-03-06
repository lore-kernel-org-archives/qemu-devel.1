Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEE1C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95292070A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5rEZPoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95292070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9HS-0000ih-5g
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jA9Gm-0000JL-Ue
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jA9Gl-0000wp-L8
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:27:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58499
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jA9Gl-0000ts-Gu
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583486866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIvf/kCDcxbJMS8aC+86+4jZzorPBE27js08Ok92MX8=;
 b=i5rEZPoMZfomr2bDkpNsaL2BXt0OzqdAvh5lJhVKwIU7Y51lzBm0RX7XA7ApV5Sw4Y4svU
 5xXNbHi6yRv3+eatSBrCbqHtyTzWHtc+865dYk/QD9DwB1vVxqdT37eT6Q5HULdScdhoZx
 HIML4InpdUk8wI9esAkLC47n3fpcdLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-EA-b7yPyOvKgw_hO0amXXQ-1; Fri, 06 Mar 2020 04:27:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14A0618FF686;
 Fri,  6 Mar 2020 09:27:42 +0000 (UTC)
Received: from [10.72.13.58] (ovpn-13-58.pek2.redhat.com [10.72.13.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 201A85DDA9;
 Fri,  6 Mar 2020 09:27:35 +0000 (UTC)
Subject: Re: [PATCH 0/3] reference implementation of RSS
To: Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org,
 mst@redhat.com
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <87242152-5823-59a0-b0ce-2aa555559391@redhat.com>
Date: Fri, 6 Mar 2020 17:27:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226174809.9675-1-yuri.benditovich@daynix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: EA-b7yPyOvKgw_hO0amXXQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/27 =E4=B8=8A=E5=8D=881:48, Yuri Benditovich wrote:
> Support for VIRTIO_NET_F_RSS feature in QEMU for reference
> purpose. Implements Toeplitz hash calculation for incoming
> packets according to configuration provided by driver.
>
> This series requires previously submitted and accepted
> patch to be applied:
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06448.html
>
> Yuri Benditovich (3):
>    virtio-net: introduce RSS RX steering feature
>    virtio-net: implement RSS configuration command
>    virtio-net: implement RX RSS processing
>
>   hw/net/trace-events                         |   3 +
>   hw/net/virtio-net.c                         | 234 +++++++++++++++++++-V=
IRTIO_NET_F_RSS
>   include/hw/virtio/virtio-net.h              |  12 +
>   include/standard-headers/linux/virtio_net.h |  37 +++-
>   4 files changed, 273 insertions(+), 13 deletions(-)
>

One question before the reviewing.

Do we need to deal with migration (which I think yes)?

Thanks


