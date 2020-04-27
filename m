Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7361C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 03:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AFF206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 03:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfEJxssK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AFF206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSuWI-0007c4-II
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 23:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jSuVb-000737-7r
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jSuVa-00005Z-19
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:32:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jSuVZ-0008Qr-G7
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587958355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MT1H88k1QV0qWlkq+VScwZ+/zmrs60RU6iYPwkuhE+Y=;
 b=dfEJxssKgI0cJiwOpLe2hoSN0av4JbhIS0F80Ko1oY666PPRgEJAzdydH3qQVBP/nqENmq
 k6T0/JmjAAB5tqG+kVmMwBSQ5wICYxHa2+b0kMmbv8StAglwRzhdmcyUlDWH3w9R5HYIH/
 vUic2hi6iJppnc2ggrSSjcIxV6VDVBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-mCd2UhViMJ2FMUODFqSVDg-1; Sun, 26 Apr 2020 23:32:31 -0400
X-MC-Unique: mCd2UhViMJ2FMUODFqSVDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85E2945F;
 Mon, 27 Apr 2020 03:32:30 +0000 (UTC)
Received: from [10.72.12.205] (ovpn-12-205.pek2.redhat.com [10.72.12.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E41515C1D4;
 Mon, 27 Apr 2020 03:32:26 +0000 (UTC)
Subject: Re: [RFC PATCH 0/3] hw/net/tulip: Fix LP#1874539
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200423231644.15786-1-f4bug@amsat.org>
 <20200424152722.GA14573@ls3530.fritz.box>
 <1f04b513-eece-baa7-5556-4665afe1f637@redhat.com>
 <CAFEAcA-vJXRcjNPnyB5t4UOrmH5wnUoZsx-JAwDYNavQ_L64XQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <24b9c9a3-a0b6-2d9b-eade-dbc43bd71ff4@redhat.com>
Date: Mon, 27 Apr 2020 11:32:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-vJXRcjNPnyB5t4UOrmH5wnUoZsx-JAwDYNavQ_L64XQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/26 =E4=B8=8B=E5=8D=883:57, Peter Maydell wrote:
> On Sun, 26 Apr 2020 at 03:50, Jason Wang<jasowang@redhat.com>  wrote:
>
>> Looks good to me.
>>
>> Would you please send a formal patch and cc Peter.
>>
>> Consider we are about to release 5.0, it's better for him to apply the
>> patch directly.
> I am not applying any further patches for 5.0 unless they come
> with an attached rock-solid justification for why we should
> delay the release again for them.
>
> thanks
> -- PMM


Ok.

I will queue that patch for 5.1.

Thanks


>


