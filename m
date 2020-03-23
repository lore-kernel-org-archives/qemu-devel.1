Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D85C1975A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C184206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgcgXK3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C184206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGE0v-0001wS-Iw
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 23:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jGE0K-0001Wg-ID
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jGE0I-0006yJ-Tf
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:43:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26895)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jGE0I-0006y5-PV
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584935033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2WpPVaKny0v/UrSQrZ6l+fWnUSOyfhht+b8kwmk5/AQ=;
 b=GgcgXK3RXs5sRsAl9Co4YITPQgpMQv++zd2anVtDG+ruXfMljIQtwHUW2wkd97UFjNjxoB
 febjt7GdnMKqd6J/wfJO5aSQRgSG+/Ifjp3przZHYvB36IZi3NFPsjypaGDzRFx+Tp0htX
 ZDjR1CLqvPMmfCGES7xzfZB42Uju6o8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-NhM3dKoNPEqTnnyxPM2Nmw-1; Sun, 22 Mar 2020 23:43:49 -0400
X-MC-Unique: NhM3dKoNPEqTnnyxPM2Nmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9954F100550E;
 Mon, 23 Mar 2020 03:43:47 +0000 (UTC)
Received: from [10.72.12.74] (ovpn-12-74.pek2.redhat.com [10.72.12.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2ADC460BFB;
 Mon, 23 Mar 2020 03:43:43 +0000 (UTC)
Subject: Re: [PATCH v5 0/3] net: tulip: add checks to avoid OOB access
To: P J P <ppandit@redhat.com>, Li Qiang <pangpei.lq@antfin.com>
References: <20200319174050.759794-1-ppandit@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <20f29d89-6d52-2edc-ef7e-13124908256a@redhat.com>
Date: Mon, 23 Mar 2020 11:43:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200319174050.759794-1-ppandit@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/20 =E4=B8=8A=E5=8D=881:40, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Hello,
>
> * This series adds checks to avoid potential OOB access and infinite loop
>    issues while processing rx/tx data.
>
> * Tulip tx descriptors are capped at 128 to avoid infinite loop in
>    tulip_xmit_list_update(), wrt Tulip kernel driver
>    -> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/net/ethernet/dec/tulip/tulip.h#n319
>
> * Update v3: add .can_receive routine
>    -> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html
>
> * Update v4: flush queued packets once they are received
>    -> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg05868.html
>
> * Update v5: fixed a typo in patch commit message
>    -> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06209.html
>
> Thank you.


Looks good to me.

Qiang, any change to give a test with your reproducer?

Thanks


> --
> Prasad J Pandit (3):
>    net: tulip: check frame size and r/w data length
>    net: tulip: add .can_receive routine
>    net: tulip: flush queued packets post receive
>
>   hw/net/tulip.c | 51 +++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 42 insertions(+), 9 deletions(-)
>
> --
> 2.25.1
>
>


