Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D044C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7CDE2080C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIiq669m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CDE2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydUO-0001QP-0M
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iydTn-0000zA-N3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iydTl-0008Lr-Hf
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:17:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53131
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iydTl-0008LR-DX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580743056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijUnaA88XZmeieqXuxE4nS5+BigBFEtPIwxCebnqcPM=;
 b=CIiq669mkO0/TNkdg3SKHF7dg0SE48c/Axy7iUsO/ia89RBlHxFsXeN2ZLvoVMdscJQqup
 gCBf5SyVaErR66O1UnN07i2RiN/JVZYJIAa8WHO8Bllf8g2jDlcqlM8kyv0DdXST42sxxV
 uXj3SfF/P+Hoqc1iVUdqWGFKsiUlv4Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-v3rI4GAzNQ2lOdFrpXwzYg-1; Mon, 03 Feb 2020 10:17:33 -0500
Received: by mail-wr1-f72.google.com with SMTP id w6so8410028wrm.16
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 07:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ijUnaA88XZmeieqXuxE4nS5+BigBFEtPIwxCebnqcPM=;
 b=Jzxrfc3sgp0T6XVMv9NWKokD0nfmEUnoJaOeMg91eR7xGSxz7O98PQ6OBwZwG/E2o1
 yPXOnj+8puLIgD1tsJSLtegUR7XqQvxo8Lfc1c+UCPLUh7uc01PW6vp8YRY/Vnqwe/qY
 2xFrYN3d6Nr8+NAaLPpJPrTuhbtlEE5jZxBEpdqUxwn2hlQyIs/xnCcNLr/PBKKuue+f
 4AuboJLjmradaO1KaETzJ8g0p663/MrlZItPjGfql4hvxu+Ak0tIwmAIThzi4+sHrqrD
 YWCUv4leeLrF/KCM+zvAyxMS2wdSL2Gzs4PN6r2wlHcOH2pxZpiWxVG8P8oQsgritSXi
 es2w==
X-Gm-Message-State: APjAAAVTTOMJIFRAYgLff56iEUxeH2mb9ULnPmAcq610cmi1jkpyr3Y2
 BJ4BXLf2qB0nrvTcitqCnWGfSnxTtudotkz6TuPF4l0Boiagr+3F6m8MKYIbEKbmz0dr7BUg80Z
 Kp8lglcVCESt6CRM=
X-Received: by 2002:adf:f10a:: with SMTP id r10mr16183551wro.202.1580743051854; 
 Mon, 03 Feb 2020 07:17:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFGh2jlzxlQbnYTRPxbWA3mE5iCax9adpBZzADX4/g626ajHTpG5DgThBwCnte1XoSpBbr1A==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr16183528wro.202.1580743051641; 
 Mon, 03 Feb 2020 07:17:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56?
 ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
 by smtp.gmail.com with ESMTPSA id n12sm24289384wmi.18.2020.02.03.07.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 07:17:31 -0800 (PST)
Subject: Re: [PULL 00/13] qtests, kconfig and misc patches
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20200203123811.8651-1-thuth@redhat.com>
 <CAFEAcA_1KYRA=87k34zCRLqCf1tWHrULGZPcHeKwJZhDUx0=kw@mail.gmail.com>
 <2fd63018-b9f9-ab88-2d65-009c54bb6cf2@redhat.com>
 <CAFEAcA_XKAeT10p+XNRjQeOjoGYX1Q-D+kj9E0kFx2AxtktACg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fedbec35-51c7-cf1b-ef55-e2a582620781@redhat.com>
Date: Mon, 3 Feb 2020 16:17:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_XKAeT10p+XNRjQeOjoGYX1Q-D+kj9E0kFx2AxtktACg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: v3rI4GAzNQ2lOdFrpXwzYg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 03/02/20 15:50, Peter Maydell wrote:
> 
> An extremely cheesy workaround would be if the commit which
> removes the hw/bt/Kconfig also touches configure; then Make
> will know it needs to rerun configure, which will (among
> other things) blow away all the config-devices.mak.d and
> force rerunning of minikconf.
> 
> I don't know what the correct additional makefile magic
> would be that would cause us to automatically get deletion
> of a Kconfig file right; maybe Paolo does?

Nope, sorry. :(

Paolo


