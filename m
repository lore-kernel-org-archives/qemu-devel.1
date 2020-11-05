Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8144C55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20B820709
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mx9Dhgve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20B820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaktp-0001X2-Ve
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 14:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaks8-0000tJ-H7
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:24:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaks6-0007yZ-8Z
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604604273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2O2ruTJDKXNl/n9kvytmN9JsVNZAyj9m1mgEVXidQ9I=;
 b=Mx9DhgveZQcFk2/xuMKZVaT7AIuxkpAFh1MWtfKJTLWNfEoPMF0O/i+9XF+LBoT2as/cTg
 EylvYcbagVL3A5j+7JJZJGNBsAJkrT19psW5wEkR/yv9XpMotmDbWTh0fsesu71am8j4Q3
 XckH1Sq2zfnLu+z7W9g51uso0OG5io8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-CYzjNzJLODqz4KRV-cAWrw-1; Thu, 05 Nov 2020 14:24:31 -0500
X-MC-Unique: CYzjNzJLODqz4KRV-cAWrw-1
Received: by mail-wm1-f72.google.com with SMTP id f70so1004330wme.7
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 11:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2O2ruTJDKXNl/n9kvytmN9JsVNZAyj9m1mgEVXidQ9I=;
 b=aP3xYy4Uztp44CdXJ/oatMqZrSPrF/BHDfO2KxHGQfL+zDMoSw2Q9nk54+XhCtBiM5
 rmVJWiTK6+jYMA4OuKupx4xtMWga3beXUi44Uv6aMOyk2mUixEVovygC/N1F2tlZMi0f
 DAi6hY6MD9PZi1CiM4RB0KCjkRFA0YNjRz82qJNJJMU+aE1UtsjIX/xQZIr/oSEblGf/
 A0+f/uyefg9JjwGs9TeEA+0X49q9B6TE8dO++aUbKWw9P+ZBcahqpotIrFQgSQeAjLcv
 wVHwYW2gTCeNP3z/vVpjGZjf70DPiLvfKEvX0f0a2+/d1GpUcZHEHlIIGTUjxKURSrmf
 1BZQ==
X-Gm-Message-State: AOAM532ESyqH205pFF6ZKHS0GAeImXO/UqIXYhleI1u4ljBUVvOCpwPT
 yuMT3qGbR+XxZH4RW5QZrt8GUjaIU7fXjmCiWCQj7yhM7mH/4cQWG+ofM1H+uOlYjKToEMPC0Cu
 G/N32tlBEIxmYHCQ=
X-Received: by 2002:a5d:6147:: with SMTP id y7mr4598621wrt.382.1604604270102; 
 Thu, 05 Nov 2020 11:24:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEEnP9tYB2nupxw5lVul+64ZPOpvZsWLQPB8FD3CVf7xP4+XcUo5RP3z+3hObanYHXT7W9gg==
X-Received: by 2002:a5d:6147:: with SMTP id y7mr4598598wrt.382.1604604269974; 
 Thu, 05 Nov 2020 11:24:29 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id p4sm4321808wmc.46.2020.11.05.11.24.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 11:24:29 -0800 (PST)
Subject: Re: [RFC PATCH 02/15] hw/riscv: migrate fdt field to generic
 MachineState
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1a3f0af5-bc74-1f90-5900-c6c68d8bce21@redhat.com>
Date: Thu, 5 Nov 2020 20:24:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105175153.30489-3-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: julien@xen.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, stefano.stabellini@xilinx.com,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 6:51 PM, Alex Bennée wrote:
> This is a mechanical change to make the fdt available through
> MachineState.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-Id: <20201021170842.25762-3-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/hw/riscv/virt.h |  1 -
>  hw/riscv/virt.c         | 20 ++++++++++----------
>  2 files changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


