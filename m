Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F60C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C124B20643
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ek/u2o0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C124B20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipB0r-0005lp-Rs
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ipAez-0000N3-54
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ipAey-0001VK-4n
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:42:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24340
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ipAey-0001V3-17
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578487323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5l1TtjfinJgnHCD8k5QPFZfXhXSKXrCDYP7wGC45PdU=;
 b=Ek/u2o0F3VYBrFL6WhddLXgZGZuREeEt0DCAhv/euttet48E2h4m9GOHIV+PWqeXFt3Bdi
 1nZlS4H9ZWCVvlLp5avtJuMDmE42YYa8rPlAZjOhtEonoeMVDlOppJwb/rBBcP0XsLpsuL
 OR8AuG0IBrwG0aLbWMblKJ9e+8QX9eo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-fNC1WEVSOFCY_bC4Rq0n_Q-1; Wed, 08 Jan 2020 07:42:02 -0500
Received: by mail-wr1-f71.google.com with SMTP id f17so1386657wrt.19
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5l1TtjfinJgnHCD8k5QPFZfXhXSKXrCDYP7wGC45PdU=;
 b=LcOsEG0p5BrISRUGGVbmIHziZIP0sgFMsl8PGm0nFqRJIUEpziKOJHTl8o9aYHe/vQ
 Jruj/f/b4ge1uV0A+6AVxAZQgGT5JZGqzbDa10tQdEik3oKfNFQ6eG+BGSNb6bDmjKc8
 K37YfGjJVq+paVcR5pxaSNut/S2csMkmlZgnBMq3QBAcYZib6sjcY0xOgMnZgA6B93ZU
 jTTWD1ixf49L53mowb0TnafmuQCqJTfOuoOgJDPElMu6AmUEpVKgYls5xN4elF4/CWDC
 TBB7bUPBVQWbZN69qQyJj2DxuVXgoRBV5NYW8c8vuWhFa0iIamXcmCXYi8A4uIfclipe
 J5oQ==
X-Gm-Message-State: APjAAAVco+lRzsgCwpWAq3LLdOuwoi1MJ8EHU4f4VeKUiZ5vgrt6j07V
 blNcP2WTgECCeldiMiN83wAuL671L/+KZ8GyFLnmt1HjG2s4AK0CL4fmVbzsX8+78ExsW4TDPnO
 Yp7+BduGP68znsqc=
X-Received: by 2002:a1c:a982:: with SMTP id s124mr3549165wme.132.1578487321248; 
 Wed, 08 Jan 2020 04:42:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1Obu7tJwz3U0qHlDYSPhBw/lJNy5zaiNV1qSScCFZGLGvqIBxxXLWdMy3fp6rLNwwx7+aow==
X-Received: by 2002:a1c:a982:: with SMTP id s124mr3549140wme.132.1578487321053; 
 Wed, 08 Jan 2020 04:42:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id m7sm3627160wma.39.2020.01.08.04.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:42:00 -0800 (PST)
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update tests
 to recent desugarized -accel option)
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
 <20200107125451.GL3368802@redhat.com>
 <3241dff4-6223-404f-55d4-846991763046@redhat.com> <87d0bujkpe.fsf@linaro.org>
 <da2111ee-0644-1d7c-a111-e4209025a1d8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <60ecc0ec-d8db-2cf6-b21a-799f4cb9ab71@redhat.com>
Date: Wed, 8 Jan 2020 13:41:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <da2111ee-0644-1d7c-a111-e4209025a1d8@redhat.com>
Content-Language: en-US
X-MC-Unique: fNC1WEVSOFCY_bC4Rq0n_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/01/20 11:58, Thomas Huth wrote:
>> "-accel default" could be considered to have vibes of Do The Right
>> Thing (tm) and could in time actually become so!
>
> "-accel default" sounds like the default behavior that you'd also get if
> you don't use this option at all ... what about "-accel auto" to say
> that QEMU should pick an accelerator automatically?

Questions to answer before thinking about the name: how would it
co-operate with other "-accel" options?  how would you pass sub-options
to the accelerators?

Paolo


