Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0A7C2BC11
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26614221E7
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pztbp4B6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26614221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmjT-0000yR-VD
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 13:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGmhd-0007jE-Fb
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:19:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23387
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGmha-0007jm-Og
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599844749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwyKjKzbTygO9gtanrqevWwEso4LTqHz5XJxU7J5OB4=;
 b=Pztbp4B6dZH7npDe6UlVVTYs5axOb+2CaE0LJ9FNrAeSVDDQ9stkz5VaHM1r8YKZxkwpuI
 RxxT2S/qSCZo6nyI/NcAmhs2OG3kzi7WTwE3nFrjLTCCP2HS5PzC57zX9oTS5FPn3aqg2d
 dYxRPeM7iu8S49lXule9IS2KZLiuOqc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-wu5cbGLBPwKk_PQSs0yc4A-1; Fri, 11 Sep 2020 13:19:08 -0400
X-MC-Unique: wu5cbGLBPwKk_PQSs0yc4A-1
Received: by mail-wm1-f71.google.com with SMTP id p20so67746wmg.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 10:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kwyKjKzbTygO9gtanrqevWwEso4LTqHz5XJxU7J5OB4=;
 b=DvcobpSGn75KsHyhhIRP+CCSw5Z8sn4xRk95t9Y9RQkaoILg7YPWd4tygTkJuU3si0
 bUbNbVZQpLDPZevypctofrqAZGWvj62/MMAQDqRqtoVKpIp+AUWCwvh2xaRxqBfuxWmF
 OUxjB2q/yvu7KbBkwp1anzxuNzOI71KhSJGXfjf18J9un3fWA2rqhHVLjz/u8xUi82SE
 oqXym246WyMo0Nzs467xg5XVm18J6dTSzAuzv7FokgDjFdhR985TDInQpUbmC96YDTS+
 lXTQOgpYVu/W9eN69A9c6OHTrlR/FZJZrRf1hlNrOGiEmhjTSVkU22023bQ9LZ/mYYis
 PrKg==
X-Gm-Message-State: AOAM530a1XY8+iXq7FxKQ1JNmH4Ss9Nl2oPt4sOFCvjKgJfZCP5Lagpp
 jPYrIBHJrlV4QRIoSLf+hUy9iBZZGvQqZ0D/M+7kjmtJ4xM6eg/MaCHbb/RM30ozSLI36tKd8O3
 hnEbi2hrEhuQ2Rj4=
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr3124393wme.140.1599844746985; 
 Fri, 11 Sep 2020 10:19:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmeLfjTx7lCyGSU8h2kncEC32vPdp1yBfYCCJnw88Ucd+1ITtaivUq1FxI9J1UQYpiL7m0Pg==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr3124374wme.140.1599844746732; 
 Fri, 11 Sep 2020 10:19:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5568:7f99:4893:a5b6?
 ([2001:b07:6468:f312:5568:7f99:4893:a5b6])
 by smtp.gmail.com with ESMTPSA id p11sm5479649wma.11.2020.09.11.10.19.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 10:19:05 -0700 (PDT)
Subject: Re: [RFC] QEMU as Xcode project on macOS
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <2764135.D4k31Gy3CM@silver> <4878996.4JzhbN1UZ4@silver>
 <CAFEAcA_CPNppKwwJSu4O6U6qF-rfHR2NtG=hWBFatZmD4aiMdg@mail.gmail.com>
 <5694401.8H58FrkmUv@silver>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b0b02e9-7925-b112-4056-c17e067a5278@redhat.com>
Date: Fri, 11 Sep 2020 19:19:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5694401.8H58FrkmUv@silver>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/20 16:40, Christian Schoenebeck wrote:
> If it turns out to work fine, then maybe I just push a branch of QEMU for Mac 
> developers somewhere for a while, as I think it would lower the entry level 
> for new developers on Mac tremendously. Apparently there is still more changes 
> with Meson ahead anyway (getting rid of the Makefiles or whatever else is 
> planned). So we'll see ...

If there are no submodule dependencies (capstone/libfdt/slirp),
effectively you can already behave as if the Makefiles did not exist and
build QEMU with ninja and "meson test".  So you could build your scripts
from there.

Paolo


