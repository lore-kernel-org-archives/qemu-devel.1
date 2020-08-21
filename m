Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A11C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:17:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9626222CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgItejJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9626222CB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99jJ-0002jU-S4
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k99iN-0001c9-Q5
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:16:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31565
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k99iM-00058c-7J
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598026585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ejhXrNgEGhg6X8u1WS3IkAlnZQH2dsUUtTAmtVdqqWE=;
 b=LgItejJGKz/IV70xoKKrq8X51FVSo86kRYP3E6a9ALsW4QHwAcUgx2Xt1Ql0a114uLuXoS
 BEtgUAYH/yCUQbOVcASKM5ayN3BDh6coxsiw+4MZRxAon1MSlhmuVD+SKxODOf5cG/zta/
 iHrxHlJP7aZP0nicATAeiD2U8BWZo8Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-rRUNag_zNFeGNxW8LRbeQQ-1; Fri, 21 Aug 2020 12:16:23 -0400
X-MC-Unique: rRUNag_zNFeGNxW8LRbeQQ-1
Received: by mail-wr1-f70.google.com with SMTP id 5so687156wrc.17
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ejhXrNgEGhg6X8u1WS3IkAlnZQH2dsUUtTAmtVdqqWE=;
 b=Jr2lWnBeJcsKNpRXeM9FwmXWZhL8w0epVZS0TtxRI0fl4L0m4IaHgju4NSI3VfHQni
 /bHJ8j37GK5lWBINRSJ3XLEsUHeb9LyvULHPsT951IfU93A+DLACoC+/E/5InqWG6gNI
 fPK/RSKJfd/lojNO/l/HVychBVAj7jQA0PWBHVfm0NN2j3bVPZJf3Nz9+Jbvk5TDmPxz
 /mv2jdj+JhACHUyKOY1uXbx0pIw3dGiCeZy+x/W4yLiuVAAG3sgnd7DnJtz+JV9OFDIn
 NcXfWo8/3iOus86xG9A/klA1SOFHxkBweluoMYXZ4+OlzorzG299p+KUJol6A/MFEchN
 tF6A==
X-Gm-Message-State: AOAM533BW1S1se8kzHOzWCIWynwn98ASWHwKlZ6LACi5sF5u8SeZyX79
 C2gkRh+7Z+d2x2673S4WchWFGrZMbmVjmmT2xyiFeC39El9dNhc4lXuY/0zpF43amDYhoJM5hgY
 C9xZ0n4s78wvsncQ=
X-Received: by 2002:a5d:6910:: with SMTP id t16mr3610494wru.178.1598026579788; 
 Fri, 21 Aug 2020 09:16:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZw5Rkq4MQK6txYZtDNovyXMxxeB07IvN2emKuca7zou7Z15UVGWP6Q/YiQzKI19pOkgHY6A==
X-Received: by 2002:a5d:6910:: with SMTP id t16mr3610479wru.178.1598026579529; 
 Fri, 21 Aug 2020 09:16:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d51:8db6:e10d:b5ef?
 ([2001:b07:6468:f312:d51:8db6:e10d:b5ef])
 by smtp.gmail.com with ESMTPSA id k4sm5611218wrd.72.2020.08.21.09.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 09:16:19 -0700 (PDT)
Subject: Re: [PULL v7 000/151] Meson-based build system
To: Howard Spoelstra <hsp.cat7@gmail.com>
References: <20200819213203.17876-1-pbonzini@redhat.com>
 <CABLmASFno04tFBRTq=V8AO7dj1d67-SNpugUJMVVa4yzrPq03Q@mail.gmail.com>
 <CABLmASECM5tVVw3TMJn+0bCT7O4H_guy5TJd9YQKYYx+QUKBKQ@mail.gmail.com>
 <dd66cee7-c6d2-a81e-2e53-eca34ed78be8@redhat.com>
 <CABLmASG_VtxD6L=RWotVJZ+C6KxPwoYCQ-K=1TbL8XqF7S5piA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8e4ced4e-5532-9806-e6b3-31bedbdfb80b@redhat.com>
Date: Fri, 21 Aug 2020 18:16:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CABLmASG_VtxD6L=RWotVJZ+C6KxPwoYCQ-K=1TbL8XqF7S5piA@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/20 18:11, Howard Spoelstra wrote:
> 
> 
> Found ninjatool-1.8 at /home/hsp/src/qemu-master/build/ninjatool
> WARNING: custom_target 'shared QAPI source files' has more than one
> output! Using the first one.
> WARNING: custom_target 'QGA QAPI files' has more than one output! Using
> the first one.
> WARNING: custom_target 'QAPI files for qemu-storage-daemon' has more
> than one output! Using the first one.
> WARNING: custom_target 'QAPI doc' has more than one output! Using the
> first one.
> Command line for building ['libcommon.fa'] is long, using a response file
> [hsp@localhost build]$ make -j4
> ....
> [hsp@localhost build]$ ldd qemu-system-ppc.exe
> not a dynamic executable

ldd is a Linux tool, a Windows .exe is just a junk file to it.  "Not a
dynamic executable" does not mean "it's a static executable", it means
"I cannot do anything with it".

Paolo

> [hsp@localhost build]$ which ldd
> /usr/bin/ldd
> [hsp@localhost build]$


