Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E873C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FD02065F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="av1//PO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FD02065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD92f-0000eL-9A
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD90X-0005Z3-SQ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD90W-0006Wr-Bk
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598977179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqYFKI6ALYYQPdV7O7bgbxheoMt1ja4B8LvgJg2rW18=;
 b=av1//PO/qVYexGL6UFGNwC0avB8IkQbWu7VcZYTB5YyAwWR45+irifoNcSgt7ZE7Ku/R71
 plXu49RxQb1OJ4mMWqFYkc17cmTkds7aMrNv7B01ghFxm0ETN76sFvFOSrYrW0SmKeRUpG
 dMw7FZbX0J8zNh+KaDeMZaYB/DzLTio=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-Q1I1hJQ1PkybUepwG52Etw-1; Tue, 01 Sep 2020 12:19:37 -0400
X-MC-Unique: Q1I1hJQ1PkybUepwG52Etw-1
Received: by mail-wr1-f69.google.com with SMTP id v5so769749wrs.17
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 09:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hqYFKI6ALYYQPdV7O7bgbxheoMt1ja4B8LvgJg2rW18=;
 b=Np1YDdXpNsi2+RctMCeaSrr0N4LVz9MnIDXWkrHSb2ADiEGctLbsE6juOb6W6oamFv
 BAuZs6/x0QLWX4qbxS8sGyRjpXQF5BxdVe8AyElj+jMcbY2Cu3pNpy9Iu2wP9los5AnW
 FT2gpspQmnakxudxJR3txFUYOKqF+iDG+HjgqRJKNpQx+Ps1Lc3zniOBq25jJfcSk14S
 bc/DTuIxOOgn/tFQeeMV+y3I3Eng2fi/ePhwId5LuzO0jEKK2M0miyNeHftKmmMPj3Ii
 l5plz29gFoMj/U4sYYzzhl1PlMtHvmEhAUChlv2dAB2hzsuIvaFoixIYlULQO8qXhDNc
 +IUg==
X-Gm-Message-State: AOAM531XeuqzOu7WTib41EpXhcP8bdKFILGSQjf45eOhymCP8Jl8NwkT
 rFOlD+Fo6yAnZOYqtbBNBOY0hdjWLsV21k45IU5KbY3PgryY/PyL1EXfMLhXeCeKu2NdHX0GJPe
 AW8HpRvgnFywe5C8=
X-Received: by 2002:a7b:c4d9:: with SMTP id g25mr1977613wmk.15.1598977173772; 
 Tue, 01 Sep 2020 09:19:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCsUiNpfRrieRgIwkGy7NdVUmI3QhvcvmgxnyapX0zJgoQyJQ/qKlNq5SIbFysvy+7hFG1gw==
X-Received: by 2002:a7b:c4d9:: with SMTP id g25mr1977589wmk.15.1598977173539; 
 Tue, 01 Sep 2020 09:19:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7fbd:8007:1fa7:ed17?
 ([2001:b07:6468:f312:7fbd:8007:1fa7:ed17])
 by smtp.gmail.com with ESMTPSA id r15sm2451507wmn.24.2020.09.01.09.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 09:19:33 -0700 (PDT)
Subject: Re: [PULL 00/24] Meson changes for 2020-09-01
To: luoyonggang@gmail.com
References: <20200901091132.29601-1-pbonzini@redhat.com>
 <CAE2XoE_cO83H7ki8NXY=X+U0aWGbmPRBhyakzMk8dqmTOAmcFQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3009501d-04ea-1682-39d5-ac0a053f9a25@redhat.com>
Date: Tue, 1 Sep 2020 18:19:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_cO83H7ki8NXY=X+U0aWGbmPRBhyakzMk8dqmTOAmcFQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/09/20 15:19, 罗勇刚(Yonggang Luo) wrote:
> Seems forgot queue my undefsym.py patch

No it's just that I didn't have time to test it properly.

Paolo


