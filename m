Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C5CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C14E208A7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uwm4HJV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C14E208A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFFQ-00069h-K7
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jeFEk-0005kK-BA
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:54:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38443
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jeFEi-0001Z7-LU
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590659643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9EhBGT4+5ipafdewncMZax30zc6j2ShLZl35uX1rO4=;
 b=Uwm4HJV+lzZVuzJE9+Xp4NIDJIubi7ZOW1cxOWh09luHLwMwMpB9rOaY2RQhmDNgO5q0Ep
 NwDuazPfOZaDn1RR1P3wdpPuinpXMmUFLCYtxacpu5yKmlwcSGj7a5Pu3r0pqR/XTrpFbH
 xLDH2JzBTXO7SioZyT5JmkaY+qoAA9k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-xf4PkTbHPr2Rib_wmEnZ3Q-1; Thu, 28 May 2020 05:52:41 -0400
X-MC-Unique: xf4PkTbHPr2Rib_wmEnZ3Q-1
Received: by mail-wm1-f72.google.com with SMTP id k185so767975wme.8
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 02:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=lr3BpYBwKEMwlVZgzydt6HGEpnU/q8yA1AgjzuixH6Q=;
 b=si67BztQl57685aIUswZAa6gH6SgeciXbHr4mcZnG1bRGxu8s9AALFpPrtKkIl+wMp
 3kMJaTlllA+F8QB+Sde9E12PNLzB0b/Rk9s56PerMKUxB2K4LHOhlZDWeev4k7y5aB8V
 yUrXJg/7UXmvZW0062Hn2buoJk8UV2fKnI1oR/ByvSzqCfhDnUCUsdKNzWjB8+48uto8
 En5hcW3jEwB3T94Bg1DE9xMtO5tGNHbVrbITkqpSUiuFmQ+jEDExAgPDCO7gq24yGsY5
 9TntHmb+1EUKSZgrneK04jNrBeH0Gs7Jxt1HHBL4HFWlZ4Xj9EF+MnvAkrDL07m8Wg9i
 JUtg==
X-Gm-Message-State: AOAM530Nbhox0O7VGCXoq+Xjvd88r57N4l3m3rvUZuvw2hdlAvTgiiPC
 I8WiFkbsoVt0oVOFOs4b4l/4c1MFXpBc+i7b2TaHPs16rnS8dumICYd1BUJq5KstVwdy09koDSg
 mQenoOArb0+SMs6g=
X-Received: by 2002:adf:e883:: with SMTP id d3mr2693254wrm.274.1590659560209; 
 Thu, 28 May 2020 02:52:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJ165GU9VC1n3JXt87Qondpzpjqdv189iSBZrCKulwGBQ81hGT4DNuESOpuyZo0q4Vuf9/Cg==
X-Received: by 2002:adf:e883:: with SMTP id d3mr2693228wrm.274.1590659559938; 
 Thu, 28 May 2020 02:52:39 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:466:71c0:ddaf:6c29:e163:80f1?
 ([2a01:e0a:466:71c0:ddaf:6c29:e163:80f1])
 by smtp.gmail.com with ESMTPSA id 1sm6160905wmz.13.2020.05.28.02.52.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 May 2020 02:52:39 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: How to fuzz devices that use timers?
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <93600c7c-ccd5-01b9-36d1-5631bfb63b7e@amsat.org>
Date: Thu, 28 May 2020 11:52:34 +0200
Message-Id: <A624C443-3525-43A6-A221-BD29BE67B891@redhat.com>
References: <93600c7c-ccd5-01b9-36d1-5631bfb63b7e@amsat.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Artem Pisarenko <artem.k.pisarenko@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Oleinik, Alexander" <alxndr@bu.edu>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 28 May 2020, at 11:26, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
>=20
> Hi,
>=20
> Some devices use timers (QEMUTimer) to emulate hardware precise timings.
> i.e. with a flash device, the guest orders erasing it, the physical
> erasure takes some time - let say 200ms - and upon completion a bit is
> set in a register, and an interruption is eventually raised.
> When not multi-tasking, a guest usually poll the register until bit set.
>=20
> While fuzzing, a payload schedule triggers an erase, then (if we don't
> reset the device) thousands of payloads are tested in vain until the
> device is ready to process further requests. It is then hard to
> understand the patterns used (in 200ms libFuzzer tried ~5000 I/O
> other accesses). Even if we can reproduce the pattern with proper
> timings, it is also hard to reproduce.
>=20
> Since we run the fuzzer with the QTest accelerator, my first idea was to
> check for 'if (qtest_enabled())' in the timer code, and directly expire
> a timer instead of scheduling it. This way we can test reproducers.
> However various tests require/verify precise timing, so this would break
> various qtests.
>=20
> Second idea was to add a fuzzer_enabled() method, and check it. But then
> I noticed some devices use timers the other way, they start a timer and
> wait an event to happen in a correct amount of time, else the timer kick
> and error bit is set (this is the watchdog style). If I modify the
> timers to directly expire checking fuzzer_enabled(), then these devices
> enter failure mode directly without processing further requests.
>=20
> So I guess I have to go thru each device and check for fuzzer_enabled()
> where appropriate...
> Any clever ideas?

Would it make sense to introduce the idea of device reservation / exclusivi=
ty
in the tests? In other words, if you have an =E2=80=9Cerase=E2=80=9D, then =
you add some
=E2=80=9Cqtest_reserve_device(device, timeout, =E2=80=A6)=E2=80=9D and then=
 modify the payload
scheduling to avoid reserved devices.

If there are less of these cases than general watchdogs, this may be a
win in the end, and also clarify the intent.

>=20
> Thanks
>=20
> Phil.
>=20


