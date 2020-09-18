Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EC0C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54BA207D3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijTnhoOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54BA207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJFzA-0006fd-Pd
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 08:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJFy4-0005NO-IV
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJFy2-0006ty-Cz
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600433901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRNhctPjqxIgqDfIkCvmmU6WMNnePBcEW5qKAbcHpD4=;
 b=ijTnhoOddzD/l1DPGE2dY7o3VrOKGb8ahA/Keznv7lN/eUW9qZo35+1lE+A5DyXDtcv5Ez
 gpzvTHnMxXeRXkAVx6RkFJfMgFcbXA72GGKDyOCU+90N3MhWy2Ohh/18VBOiF/R8A9yIri
 OnAnB5bA+pBz6oXQaNxXJoiN4A/K+/I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-wBIEFlKnMtayUZhDf1nv-w-1; Fri, 18 Sep 2020 08:58:17 -0400
X-MC-Unique: wBIEFlKnMtayUZhDf1nv-w-1
Received: by mail-wm1-f71.google.com with SMTP id p20so1446566wmg.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 05:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LRNhctPjqxIgqDfIkCvmmU6WMNnePBcEW5qKAbcHpD4=;
 b=gZ6IKM+/KSEXNml1qfsi+MQ0gcaoomugGDJmKE9gjMoHObRKffXgDjnztXnuo5he/o
 6y8ieOAF4K5ftuLp+pRyeijUB3QSK/2e8vgzzI7cfxDI1ocMsVMjw2pFmV4QMcwqk/d5
 B0bzgUYRlE6v4XaF8boq58VL4lIANNKtxAbOs+00nBemH2lgzQrldnVN0vnk5RfszJtI
 8jCemsM1hdnQIEydj6TqR6SCXW3ibgMJNkNiM1ghC/XLPqq6R42oSMx7xhvVewKIeI1O
 FKG5NYSWacubgPArpzhvUqmt1+9YUW5kT7hjcc3OuZvkHf8xfkJ169rh4oF9Z3PpJmXQ
 pXpw==
X-Gm-Message-State: AOAM5314NGomuCqqlvF3ZwuKJtPQTO42DizzFhnZe4ILmoeBhbuGytHq
 W/LRMUklvioahYDgCDG74VepwYvi78ui390RXVQX/Fk7Il4GZRnu4xC2dJK7xT5QhwSl1kR3440
 8Ginw0FjsRFhXRog=
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr15176450wmh.53.1600433895760; 
 Fri, 18 Sep 2020 05:58:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7dPwDfkFAVvJQyj/aNRiHWd2NjHUpsc49gCZF9phDDyP8eN7kBGi043//rp4cVZ6kNe1IHg==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr15176435wmh.53.1600433895489; 
 Fri, 18 Sep 2020 05:58:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:69b4:4715:609f:385f?
 ([2001:b07:6468:f312:69b4:4715:609f:385f])
 by smtp.gmail.com with ESMTPSA id h4sm5925399wrm.54.2020.09.18.05.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 05:58:14 -0700 (PDT)
Subject: Re: How to convert fowlloing code from configure to meson.build
To: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>
References: <CAE2XoE-xcBTt-eRgj1U-NMcGewpSV0Vk8Y3_9wnZ++K7qCgLtw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21694c97-0443-683b-fdd4-f640d616d0db@redhat.com>
Date: Fri, 18 Sep 2020 14:58:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE-xcBTt-eRgj1U-NMcGewpSV0Vk8Y3_9wnZ++K7qCgLtw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/20 10:47, 罗勇刚(Yonggang Luo) wrote:
> 
> seems that need compile a program, but I didn't found a demo

You need "cc.compiles()" or "cc.links()".

Paolo


