Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A226C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 19:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C51207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 19:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsIWD0nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C51207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8U1P-0006AG-S1
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 15:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8U0r-0005jT-1K
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 15:44:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56116
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8U0o-0002jq-12
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 15:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597866280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODRa/K1hafftc+Zlxl/3ZDVWfsdzKrx0gDG4S2lrm/c=;
 b=NsIWD0nwimtAim0N1vIeCUsNaXXhba1Lpj98l4P9ijgIFykoZWNLAFXSDvubSVQN7L78q1
 vJTzpTEmQEHYtyWM06bJr8L1tNm/HlfjEgG0waIpiawdJotQXboT6uJS6TT0J9Gsf0RXzT
 oJ0vveX4Z/urIlb0msig88nWY2Sc7fA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-4Fo-kKfiO66-pHqVw5zU6A-1; Wed, 19 Aug 2020 15:44:38 -0400
X-MC-Unique: 4Fo-kKfiO66-pHqVw5zU6A-1
Received: by mail-wm1-f69.google.com with SMTP id h7so1296811wmm.7
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 12:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ODRa/K1hafftc+Zlxl/3ZDVWfsdzKrx0gDG4S2lrm/c=;
 b=CqbhUcbnQBdOhvMKsCpjWWNgHAcv1xCSMbFrmZ1qudVAmaKdTchOoPkI2gY7r4pdbE
 H+sb1DFMzyhIq686nIDRVNphcz6uUvZCotkjzmotVF9SP3wV3Jb/PwMiSYUaCtLRr/QS
 4fjOrKTVilYEvxhx8zzOmUfR57eetNo1z9wPbG99RJEw3j256k4q1T71Ro2T5sSn+rL8
 T2Xdpwc43+WeNgvcdjPNRW1Ab6iatBZzVcG+OISlnT1cvHxN/b/1Z0zoaLxnH2OS5Uf6
 pgJc+sjpnbtxne6trPsJ1kX+Lv6AIu79h2pRmyjg+qUe3AR3MkuXNESXXfZBHoCrZZ+o
 snBA==
X-Gm-Message-State: AOAM532kh6IQjVCMEZ9eKKxGxsXvjHRYqKPttwYgYuwqhm6yY09lTaqa
 gRSoz3byYp0g2KzqEjy9R8+TCb7iX5Xl9HuyeWRxS3lbDo0p7sm1Zd0UDmDTkyj/QLbjT1lrTab
 LqozRR3N/JIQMGI0=
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr6668309wmh.118.1597866277151; 
 Wed, 19 Aug 2020 12:44:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFL88Pkp8aaRk5VlLLSXiWPokPFXpJsprBvybgggHfvLpgTdpJ/IdDI79gFzYLl/9Ma2osQA==
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr6668286wmh.118.1597866276941; 
 Wed, 19 Aug 2020 12:44:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id o124sm7177638wmb.2.2020.08.19.12.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 12:44:36 -0700 (PDT)
Subject: Re: [PULL v6 000/150] Meson-based build system
To: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
References: <20200819143525.2175-1-pbonzini@redhat.com>
 <CAFEAcA_8VJecDyK8FR0ty=pknmo+Hc5s0OFj+-Y1Ah-OJ01FDQ@mail.gmail.com>
 <5d247082-4928-b47c-76c4-c366a9421e1a@msgid.tls.msk.ru>
 <CAFEAcA_YU8QY_VRNdXmBV=YKuBFaX=scT0Pnk1F8JBWrrbsbJA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <72597e7a-6ee2-9875-536d-c5cd2d81950d@redhat.com>
Date: Wed, 19 Aug 2020 21:44:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_YU8QY_VRNdXmBV=YKuBFaX=scT0Pnk1F8JBWrrbsbJA@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/20 21:04, Peter Maydell wrote:
>> is it really that important? We've changed single target build
>> rules already (from subdir-x86_64-softmmu to x86_64-softmmu/all
>> for one), which broke quite some mostly automatic build
>> systems which needed some fixing. Moving executables isn't a
>> big deal after that, methinks..
> It breaks my setups and also my muscle memory for where
> executables live. So this is the limit of how much I'm
> willing to allow Meson to mess us around, I think.

It's totally possible to accomodate this and I appreciate the help and
effort you're putting into something that you (understandably) are not
too confident in.

However, this change was already in the first series that was posted
like a year ago...

Paolo


