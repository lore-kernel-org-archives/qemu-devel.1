Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB726C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68E0214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELGtSg5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68E0214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifCGo-0000dy-Sa
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 19:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifCG8-00004u-G5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifCG7-0003pU-5J
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:23:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49569)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifCG7-0003mv-1f
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576110189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EymNOX1NegcNNMtrmpakBYZhnf2kxB4QYRfKgyeUGI=;
 b=ELGtSg5rissvOPEnoKQLoiojS5WlOiTftFkdkHUHGZxoGVLKey2vhrHan9ZEtRax5Eh5xs
 OBf4RJjg+Z22NZ+/9JeKCLtlvIXwZb7L/dGwYahSl3l1Pg6tVDTDd7y+6LJepA7OxhHz7s
 S6FItijkqjIOgOFg7BjUwLZ1DYJTSRE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-24KhL1xCPfuXpEEtUsje_w-1; Wed, 11 Dec 2019 19:23:06 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so298446wrq.12
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 16:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2H/gWN4eszVbxFGkp/8hevIVOCaI4aQnjh5/iVFB6Sw=;
 b=TTjVDimt3ZsEeBlmaxfy8j+Hc1yHIxtageCPVS3Ci+WulAR33PA2Z8iU5VNx6fD56s
 otuYVjVcbTjqQM4Oz0DcvchXP1QtsTdD/Nj26skyEKCNk7qOQTxgiJ9eAdhwunMrWqtq
 68rez0A8BtfhHKjY6wRwuNy3UpvCXMSzDBBEwNRZ6pehPYBmJ3VgAycRB98h1QBdrpiR
 tLhM13LG5ZudeHrB1xKQVRf95e1AO/XsZ0rR6Xg/erj4v5ttyTVn6cPUSTmpGOpTAH9+
 qay692lK2Z/2OLYmhnhzU65vx5knY5xqVdHN1PBpxk6L7jHrwzlWi4z5O2AZoLjWv+fT
 r9rQ==
X-Gm-Message-State: APjAAAXtsDKa13DxspdMlcyldIfPOu93+KvsT3X7oE2uGl3L5M7TDOSX
 do91iR34kSh1eBLYTWKa4c11Rn4WjQjQQzq3FcGoNAadGjo3ko4u5GRqut+O2stEHrXrUzMjWGW
 6A/FNgnAAKhom5S4=
X-Received: by 2002:adf:fa50:: with SMTP id y16mr2784970wrr.183.1576110185173; 
 Wed, 11 Dec 2019 16:23:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxB3wC52eTFf5o7/Tmz8X1+KGruT5nzFJmGPB0CprDQxkNXd3iOhZbCSnBKHhKywavADzvzNQ==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr2784952wrr.183.1576110184884; 
 Wed, 11 Dec 2019 16:23:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id n3sm4212734wmc.27.2019.12.11.16.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 16:23:04 -0800 (PST)
Subject: Re: [PATCH] tests: fix test-qga on macosx
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1576074210-52834-8-git-send-email-pbonzini@redhat.com>
 <6738c39d-bab8-fcc8-7508-a9ce90f68d7d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70855d65-bafa-c349-c1f8-593a29829bc6@redhat.com>
Date: Thu, 12 Dec 2019 01:23:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <6738c39d-bab8-fcc8-7508-a9ce90f68d7d@redhat.com>
Content-Language: en-US
X-MC-Unique: 24KhL1xCPfuXpEEtUsje_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/19 20:12, Thomas Huth wrote:
> On 11/12/2019 15.23, Paolo Bonzini wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Fix Unix socket connection & skip commands that are not implemented.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  tests/test-qga.c | 25 ++++++++++++++++++-------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> Don't you also want to enable it in the tests/Makefile.include ?
> It's currently fenced with CONFIG_LINUX...

Hmm yeah, it was a hidden change done by the Meson conversion.  I'll
send v2.

Paolo


