Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E7EC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 05:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355342067C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 05:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HltHPpB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355342067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix2Yt-0003HJ-9Z
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 00:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ix2YJ-0002sp-UF
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 00:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ix2YH-0003jy-1r
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 00:39:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46257
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ix2YG-0003iw-PZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 00:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580362779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIzwzoochCuq9vlTRoizoWw58Y17cDGkDBmCNIvbLUo=;
 b=HltHPpB4kvHOegr4+zK/zLqtTkx8x9qM/PQzod4N2lVdxaqsydYUvU28qllhdvzOc5cMdn
 8p6b/0VDckp7PYyHu9c32G3lqST5A/7YFYM/F/BNwZkrWbStVerpgoDs7FQ5Iud2ixKYXO
 IKlY3hnalMLDLDGFcji9JHQ7O4mcl7s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-xxsxpPWOMoCFVh-_k2dfMQ-1; Thu, 30 Jan 2020 00:39:37 -0500
Received: by mail-wm1-f69.google.com with SMTP id d4so657064wmd.7
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 21:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sJlE5eenXdtRfQHn/R4RwyXuZnhyac4pnWs5Dx3FiaQ=;
 b=hFLl39SiiS1d3yFi4h6Rlgp0+nVMd8dj9VmMu+mU0hgS6Rwb598kwqwPJ6HJ+dVgTc
 Nx2vf2Ps7ysmuTp2/X9dgDzdFYKo4c/mJi266tS0dSgXW8Lfl+cH2bP3ymmthSNDXbwY
 vr/arSvtn1+KPZBTzeqHSKpX3mqQp1gU6AvYYwax6PnfoZ9GuDNGlkkUoMRFZ7T+CYel
 iBApFLdlKRr4qDHAb37GZ6AEprv2qoO3nLICV9+ZPNIWl9xphArnq/VnlOik2yASupJu
 cEJbVZgp9h3QQ9ko4PRl1nr1folBpa10PfpiJ1EY4izxhSuzb18yAOE0eSIKDgM0yagE
 Asdg==
X-Gm-Message-State: APjAAAWibt3FDqsczKYvyV72SzRPpgmmxXqWwh/6FcCwsDePhbqvZPVy
 NUmeIHUi/pywioDmRf4GIIuLdKjSGd/fEbewFvFtSJ9V1W8rt6QCqLKtKYbw9w6v97L8Qzoswgk
 B2/IzCu0xAtgjYWc=
X-Received: by 2002:a05:6000:1142:: with SMTP id
 d2mr3005309wrx.253.1580362776531; 
 Wed, 29 Jan 2020 21:39:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqzNWTcUoLXt+qd1EZ4Nm61NW9zR50tzzPQtrnWI/hHcHqrQtppq2rEAPIaOjPqpMeT9HFpNgg==
X-Received: by 2002:a05:6000:1142:: with SMTP id
 d2mr3005278wrx.253.1580362776238; 
 Wed, 29 Jan 2020 21:39:36 -0800 (PST)
Received: from [10.1.251.141] ([80.188.125.198])
 by smtp.gmail.com with ESMTPSA id g21sm5039349wmh.17.2020.01.29.21.39.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 21:39:35 -0800 (PST)
Subject: Re: [PATCH 001/142] minikconf: accept alnum identifiers
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
 <20200128175342.9066-2-pbonzini@redhat.com>
 <81393799-e936-d5dc-1681-4317bfae510e@redhat.com>
 <CAMxuvayx55=JaVCgtZew70jeoRSzpzuLDSe2sth91yiLb_kAXA@mail.gmail.com>
 <f076136b-d118-b502-25fb-d72cbd194833@redhat.com>
 <CAJ+F1CLXQMTvc2VgvV6kfydrt80TqjrDsr9-4PJqq81X_Kgdug@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <16cce114-e89d-9dc9-8da7-09d72ab7a71e@redhat.com>
Date: Thu, 30 Jan 2020 06:39:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLXQMTvc2VgvV6kfydrt80TqjrDsr9-4PJqq81X_Kgdug@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: xxsxpPWOMoCFVh-_k2dfMQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/01/20 15:04, Marc-Andr=C3=A9 Lureau wrote:
>> Sure, but with a proper patch description, this patch here could even be
>> merged today already, shrinking this huge patch series by one at least..=
.
>=20
> Paolo has been merging many preliminary patches already. I am not sure
> why that one wasn't.

I'm no sure myself why I didn't pick up this one, probably because of
the lack of commit message. :)

Paolo


