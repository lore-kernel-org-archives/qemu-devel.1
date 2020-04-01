Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5632DC2D0F2
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA24208FE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggklT40H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA24208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJgWj-0006Zk-85
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 12:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jJgVG-0005GB-6O
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jJgVE-0006Ld-Tc
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:46:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27229
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jJgVE-0006L4-P9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585759567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HkhII9tNKFDfsz5Qtq1hjfgPrJXhcYUSWPyUqpxsBGM=;
 b=ggklT40Htfd6t1XIWGIDlZ/6FsLewImJ1hau615UthweLNwCPk9LqE+oyb0J3oCts+/OFs
 sC/061XmaMEYomlt7Pr5+9NQmnM/ZoqMQV8S0oeak8Cu7weWZ3xTRV8U2oOWBuEyYcKI4D
 jtbgcAJTbgLcAvLP9m8K5VPiDOzZqlM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-4h1msyHqO-K8pfqsB8bUeQ-1; Wed, 01 Apr 2020 12:46:06 -0400
X-MC-Unique: 4h1msyHqO-K8pfqsB8bUeQ-1
Received: by mail-wr1-f70.google.com with SMTP id c8so97650wru.20
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 09:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=odRhbTKrDc2m+vbCKmDnpGdfBHEWXOh2VX1ULBxZ80w=;
 b=OqvLHoB2XS+l9mTaBtNS/z8Yh6Z2p5tO/mSVZ0VDvnrbXvRSOmaf9Ngh9ULAxAq8Aj
 WlXgxYpuOGcShno1Kwu1jYXNeHb+w+7g2Tzca0NRV2F/uuxZFWlfPQlg761vovLzs3kS
 By7Imr4Qns4ZZI9D67fGpPIjcvXPyVkxsBjew9eRjxUpKAsqAfJ/zLsJCCW/4wODeJX8
 xNv+hIgKQbZec1umRYznQ84l3I5gbI3YkDk5wbap+H4LxdBJWejzZc1PSFcmhfJ2tlHp
 iC3LMWqG2yCs3CdkgU57CYM7PmU/gqfG3pL6US/nSyhTd7ahIqb2o7FfrK42qy175d8f
 pDmw==
X-Gm-Message-State: ANhLgQ1zAQm+EkXp7CGwRMw7MAVRJ8yNXqDOlvXksxw0PKTA9qvik4fY
 F6YScfnaQWgozRhOywgNCLERT1OKGjQ7N61uNqozxJOObU2uIfljVGQUwM5AqBPLxptI1Rk1xuA
 70/n6f+wUqF6lEc4=
X-Received: by 2002:adf:f74f:: with SMTP id z15mr26540906wrp.354.1585759564961; 
 Wed, 01 Apr 2020 09:46:04 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvznq4gfeLWe5D3z5pmlWhVG/sGvVeoKtXnHY8WpuMabJoAAO5GZ6KZKIRpQmt9cWKcrTiqIw==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr26540886wrp.354.1585759564675; 
 Wed, 01 Apr 2020 09:46:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b83b:7ec7:7b6d:d969?
 ([2001:b07:6468:f312:b83b:7ec7:7b6d:d969])
 by smtp.gmail.com with ESMTPSA id c6sm894593wrm.85.2020.04.01.09.46.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2020 09:46:04 -0700 (PDT)
Subject: Re: QEMU participation to Google Season of Docs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>
References: <de92e66d-c474-dd1b-ddab-194b2f92d1dd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36614289-5498-7a78-5f8e-1b4da84261ad@redhat.com>
Date: Wed, 1 Apr 2020 18:46:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <de92e66d-c474-dd1b-ddab-194b2f92d1dd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/04/20 18:37, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> * Refactor the open source project's existing documentation to
> =C2=A0 provide an improved user experience or a more accessible
> =C2=A0 information architecture.

This kind of project would be indeed very suitable to QEMU.  Stefan,
perhaps you could help by providing the text for our Summer of Code
submission?

Thanks,

Paolo


