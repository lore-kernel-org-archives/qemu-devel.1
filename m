Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AEBC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8922087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6E4FFdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8922087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqa5-0000Uo-JB
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iopzL-0003SE-Bx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iopzK-0003Nb-A8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:37:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iopzK-0003NS-7I
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578407861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1FTLW3Zp5gX0A4iNXsFVhBrrmq6NCyBZRPGdpqE/Q+Q=;
 b=M6E4FFdmuKyFrUUTlygSxBbC7XZc5RiEfUNerTzFsheVUkGzOYqTMVkdm3FekuQw9/FarQ
 65so9gc/tYUs1NkQF2Ks9EtY5L12oL9GN7u7MmxDxhVjES7nhQ5hjt8ghW8jXmN+BBiAHw
 boOqhWX+RIxpPv+Dfea6Epw1Y8OTbwA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-TAiMYrsYMaOAW6gf_hPQ_w-1; Tue, 07 Jan 2020 09:37:38 -0500
Received: by mail-wm1-f69.google.com with SMTP id z2so2005782wmf.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 06:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xKF1VCupVeoKj3nHzdMo2mtF6nZWlGED4GuKBt2xg5o=;
 b=GF5oEDkxHT6b/KsCVOHpEahyIicK22+yaLr0DtRXOJbh42mAjALfPxzTxPSoTOoiP4
 ESlBEgIBAbnUzRr7ckwGmK+bg0GDEAi8r7ZHhFVNDHq+++7L8ip9UijQ/nsPgx5X6oer
 tpZryYD8MHeXOOq/qms//VI43JbBKo8u4iKmOuFikAw961xiUAZSrxiTEGmGN/LJWFxq
 YvYO1mkGkfzTbC2t1+HYQ/HHRlmpROt7KG7ydY84gT/trQhLVFDUkK/XFzmVzcWRhDAo
 BqbzOPVbpLUurcZkNAe5yAKXgj9GqVNm1eEXkBxiOhsNuif9ILifAyW4uOrBztx01+cG
 Dyaw==
X-Gm-Message-State: APjAAAWtGxj+s10najxBzlBXRLZnbcNAd2WGdGiq7tzxWkD+B3AUNQqI
 O1+f1+L37+EQg9l6R6EBNU/yvkt+laPNsGTQLOrhI+nTW+yJoGcyMMlWeYBF65JSRZf0x5PfhLd
 K+D+67Jt1bAzYsXk=
X-Received: by 2002:a5d:534d:: with SMTP id t13mr33441520wrv.77.1578407857239; 
 Tue, 07 Jan 2020 06:37:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIu3C4juhf4qTiEihrOsNkTCY3tePN3HrXjby+cLnB4kjNKwAqKhJpkV+pK9NApwz2jztiyA==
X-Received: by 2002:a5d:534d:: with SMTP id t13mr33441501wrv.77.1578407857041; 
 Tue, 07 Jan 2020 06:37:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id s15sm60543wrp.4.2020.01.07.06.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 06:37:36 -0800 (PST)
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update tests
 to recent desugarized -accel option)
To: Christophe de Dinechin <dinechin@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <1A5859EA-4403-4921-B527-DFD07C59C702@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <360fa010-ba80-b02b-3a35-19c2b48a462d@redhat.com>
Date: Tue, 7 Jan 2020 15:37:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1A5859EA-4403-4921-B527-DFD07C59C702@redhat.com>
Content-Language: en-US
X-MC-Unique: TAiMYrsYMaOAW6gf_hPQ_w-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel Berrange <berrange@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/20 14:55, Christophe de Dinechin wrote:
> So what about ranking the accelerators, so that all combinaisons
> -accel=3Dkvm:tcg, -accel=3Dtcg:kvm, -accel kvm -accel tcg, etc would

(I assume you mean "-machine accel=3Dkvm:tcg" and "-machine accel=3Dtcg:kvm=
"
for the first two.  This is the "older" way which has now become sugar
for "-accel kvm -accel tcg").

> all pickup kvm if available, and tcg as a fallback? Implementation-wise,
> it would simply mean ranking the accelerators and updating the accelerato=
r
> only if it=E2=80=99s available and better.

This is an interesting idea.  I like this better than "-accel best",
because "-accel best" has the problem that you can't add suboptions to
it (the suboptions for the various accelerators are disjoint).

It would break backwards compatibility for "-machine accel=3Dtcg:kvm",
which so far meant "use TCG if compiled in, otherwise use KVM".  This is
not something I would have a problem with... except that "tcg:kvm" is
the default if no -accel option is provided!

Paolo


