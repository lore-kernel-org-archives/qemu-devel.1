Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E32C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36997207D8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2b6kFUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36997207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdvnB-0006ht-Ey
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 09:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdvlW-00056f-Kh
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:06:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdvlV-0007lJ-92
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590584794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSQ9aLU+CTjat/xQaiqFb9+CerChARO6r7px+C53s2A=;
 b=G2b6kFUO46k5MzoYZxXpdoSbUdxKskf/anQc3LmYCa2M1sPn/2vy6qk0Zms3BUjje5r+4j
 Roh39nDb+N1SYVepkf9Rras11+SMhRueNnGXPjjhNp54d8XBeeqZktiB6rn7iuDv9Nc4+7
 XgYSO+JKBkG8BuBh4oVt6Vc4XrYNmpo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-JWOqIkHOOWW9DvSYrCypVg-1; Wed, 27 May 2020 09:06:33 -0400
X-MC-Unique: JWOqIkHOOWW9DvSYrCypVg-1
Received: by mail-ed1-f72.google.com with SMTP id g10so10091334edt.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 06:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fSQ9aLU+CTjat/xQaiqFb9+CerChARO6r7px+C53s2A=;
 b=QlKg0xoU9KmFUx+5j7XljuRPJzE3IXxagR8ON3CtDNtoqgRawwhSSJvIPvG8nn3UBt
 GgO/4wy7lTW6MNQCzvLVqczEbp+3d1gXyrV66Fpr8cN6ywDWoGl98CK78Hh1aR5Owqcq
 Ot7msgMh4//SWRLCUd2X0WlZEta7i9H8fe2Tjqxa3KYCNyC0V33SRUDOcUdPS2UxLyKp
 HBx7F9aL4beZDeepxQL88lSwo1fUNxGepjcPL4lNKsp+VldwhSMhRNCwV5LF5z0YrXbQ
 fFoQr+F/w82j4bEwsGRsSiH+SKF9Eo9QQMWtEwrw2hCrXqTO1Fs5H55cghLS3miNTXup
 NMOQ==
X-Gm-Message-State: AOAM531L67RuGSdkLKuQ26lbaxD8rawhZk14WMhQx5DUEDXq1tu1Kp4S
 BJ5YLqVSx2HmrtrU5vFpjceDEQncqtyftFWxEUel4U3RRbdRSQvdjARsiMiHZlLOcv8d51q43g5
 UPU3J9ONejbVXBws=
X-Received: by 2002:a05:6402:2058:: with SMTP id
 bc24mr24228909edb.134.1590584792033; 
 Wed, 27 May 2020 06:06:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+n/ORCA863gWjMu14EBDAzyboB3tAwwXzod4GcTKYP7LzPfokoGKfsisBqYZl+PHMFdjyRA==
X-Received: by 2002:a05:6402:2058:: with SMTP id
 bc24mr24228870edb.134.1590584791701; 
 Wed, 27 May 2020 06:06:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id b16sm2927189ejg.43.2020.05.27.06.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 06:06:31 -0700 (PDT)
Subject: Re: [PATCH v3 14/22] microvm: use 2G split unconditionally
To: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-15-kraxel@redhat.com>
 <20200521112921.641f12bb@redhat.com>
 <20200525114508.hhvyzjiqja6knz6l@sirius.home.kraxel.org>
 <20200525183615.5f8e67d3@redhat.com>
 <20200526044839.bncj6iltugnzgfmy@sirius.home.kraxel.org>
 <20200527142545.32e91049@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <58ced517-1ad4-c895-afe6-fec690791f4f@redhat.com>
Date: Wed, 27 May 2020 15:06:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200527142545.32e91049@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/20 14:25, Igor Mammedov wrote:
>>   (2) we loose a gigabyte page.
>           I'm not sure waht exactly we loose in this case.
>           Lets assume we allocating guest 5G of continuous RAM using 1G huge pages,
>           in this case I'd think that on host side MMIO overlay won't affect RAM blob
>           on guest side pagetables will be fragmented due to MMIO holes, but guest still
>           could use huge pages smaller ones in fragmented area and 1G where there is no fragmentation.

Access to the 3G-4G area would not be able to use 1G EPT pages.

But why use 2G split instead of 3G?  There's only very little MMIO and
no PCI hole (including no huge MMCONFIG BAR) on microvm.

Paolo


