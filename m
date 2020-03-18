Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834B5C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 02:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE9A206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 02:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhW33DG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE9A206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEOVe-00008j-HA
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 22:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jEOUv-0007zj-F5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jEOUu-0001fo-Ic
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:31:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52681)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jEOUu-0001Ta-ER
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584498714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d1yz3fGlh9xc1RnOSW7axmCUv4BC6vv7Mz7Bz5QMcG4=;
 b=FhW33DG4BVOxvwhD335CJE7165rkaUKFCL1BrAWxTx6yAFZ1pqlOHEyCMGkPQIYYzSSOHe
 gxbnQA5C5lK6VLWXPvicrTU4CD2shMWhclblxZGiO3IhODp2SV/FRmUklDk94lnMLP7I1W
 mLXHTaJdTOgY6pbHdWWHt8m2A5CHRuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-DrmtmbOFNLqyLvINA1HaDA-1; Tue, 17 Mar 2020 22:31:51 -0400
X-MC-Unique: DrmtmbOFNLqyLvINA1HaDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03FD18017CC;
 Wed, 18 Mar 2020 02:31:49 +0000 (UTC)
Received: from [10.72.13.166] (ovpn-13-166.pek2.redhat.com [10.72.13.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5792A1001DC2;
 Wed, 18 Mar 2020 02:31:39 +0000 (UTC)
Subject: Re: [PATCH 0/6] hw/net: Make Net/CanBus can_receive() handlers return
 a boolean
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200305175651.4563-1-philmd@redhat.com>
 <74bab3ca-fd8c-5c27-0376-2c3728cb18e4@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5e28cb8b-6f80-cec9-6915-1806573f7583@redhat.com>
Date: Wed, 18 Mar 2020 10:31:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <74bab3ca-fd8c-5c27-0376-2c3728cb18e4@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/17 =E4=B8=8B=E5=8D=886:47, Philippe Mathieu-Daud=C3=A9 wrote:
> Ping?
>
> This series is fully reviewed.=20


Sorry for the delay.

Applied.

Thanks



