Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C48C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 22:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE2A20758
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 22:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/9+bLz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE2A20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8WZP-0005ac-5M
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 18:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8WYe-00058j-A7
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 18:27:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50704
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8WYb-0006vC-9v
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 18:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597876063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHOxQx0vydXF4YD60fhMLHkPLvxDrtwujHDE6RwiERk=;
 b=I/9+bLz3HZnsuUFeuhXyzChDqQcEbxcpTLH+JzrvUpJF0e09OffPs0FB6YNynAQufd7HX9
 D2ULhJVbBfhO0gN9n3KoHPppxlPHqb3M4Aw6czgjtyOhRy6QAclDiC/CLwB4geNFdTZGh8
 n32Ip/uv5n1pI82eF85OgKlfmI23PCw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-xvXKRJ1xPQydSeNCm-cXdw-1; Wed, 19 Aug 2020 18:27:35 -0400
X-MC-Unique: xvXKRJ1xPQydSeNCm-cXdw-1
Received: by mail-wr1-f70.google.com with SMTP id 89so9741814wrr.15
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 15:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eHOxQx0vydXF4YD60fhMLHkPLvxDrtwujHDE6RwiERk=;
 b=fgx+0wIjFrMPWXa+c5LI2Bc+T7vaMeB8ulpwUxQfpr2WyuMhRb1W9DpVDGfWefXEhp
 DVnn46TuVsyGhVeh2hYI3JoGJPHSyV+SVru1im//sH6uos5Hg5V3inA60ophGKUTDtNO
 5LmoqqfO0/VqMw03g9+493SGsOenX4vsQYRiYX5xyGsvVb+mnwy2G7wezRBjjzrMGVm2
 ZKoGV72CzsjtJCFdgaTEZtIC+IGQ7ZQy7Un77dkhhHRcw8QeH5PR4oSORLOhUIdVBpGR
 zXF5p7x8wEUFk8vDf6IZB1eFiZcYbLt4HV3drpIlkxXKxh8qc+/coEZrY9zg9/Axyvh1
 kkBw==
X-Gm-Message-State: AOAM530f+jsAUUMVRDee/9jNNcb++7nyYX4gm8xyB98J5KXFcA3RX5rm
 ddJnYFib8q9hudpQsgl7xOdg/izLSZuXk1/wbUZIcksP61dRCx7CPo9VEsSJldbO11B1CJoYPE3
 04TxjpYy2n+0+cP8=
X-Received: by 2002:a5d:6748:: with SMTP id l8mr186009wrw.358.1597876054380;
 Wed, 19 Aug 2020 15:27:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpuyeECH505wboPi9lkjPb18F3wzVSW8K2WEC28oILPpFcpKNXX4mLrkQ+lDIcfevlMp2dcA==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr185994wrw.358.1597876054103;
 Wed, 19 Aug 2020 15:27:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id j2sm388974wrp.46.2020.08.19.15.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 15:27:33 -0700 (PDT)
Subject: Re: [PULL v6 000/150] Meson-based build system
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200819143525.2175-1-pbonzini@redhat.com>
 <CAFEAcA_8VJecDyK8FR0ty=pknmo+Hc5s0OFj+-Y1Ah-OJ01FDQ@mail.gmail.com>
 <CAFEAcA9jt21RHiu1eqAzK_PJAj9i6Ej27jT2=gfjSRZVjJsDKw@mail.gmail.com>
 <2073e70d-f0c7-1831-b6c7-7ceaf8bd5599@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dcf36021-3a68-f361-8bed-9606d9413afd@redhat.com>
Date: Thu, 20 Aug 2020 00:27:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2073e70d-f0c7-1831-b6c7-7ceaf8bd5599@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 18:27:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/20 22:07, Philippe Mathieu-Daudé wrote:
> Probably not the cause, but I'm seeing now docker images are built in
> parallel (before it was sequential, I run make with -j8).

I think it's always been parallel, and in fact nothing at all is changed
by this series in that area.

In any case it's fixed by v7, it was a cut-and-paste error (the MIPS
invocations of syscallhdr.sh are different from the others).

Paolo

> This seems to flood the DNS which blacklist me then I get failures:
> 
> #5 47.62 Error: Failed to download metadata for repo 'fedora-modular':
> Cannot prepare internal mirrorlist: Curl error (6): Couldn't resolve
> host name for
> https://mirrors.fedoraproject.org/metalink?repo=fedora-modular-30&arch=x86_64
> [Could not resolve host: mirrors.fedoraproject.org]
> 
> 


