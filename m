Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2848AC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9112083B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+nX6xbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9112083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWYn-0005PC-Gn
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYWVS-0001rr-Vm
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYWVR-00023C-4V
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604072396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uu5DQQvJShOF0xj3IpLFPuNZHpZaLCV+2VcB1NqWaMo=;
 b=C+nX6xbiR+AwVuXV6cfajQWyIZZtItR3SUeU8MHkjKBbO3iSDLnUTO5bdQs5mzaPItfpo4
 3UgQSQTmRK3YJKoJ1J2O6NSVshU7xdi3ocbRUggErxE+GqnJke919QS/ZpS2UiFKUoo55D
 M3+ebs4UYy6k7zbfcYtuwKOmQL7gdY0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-csngwEksOLONGBgvCYmJGQ-1; Fri, 30 Oct 2020 11:39:54 -0400
X-MC-Unique: csngwEksOLONGBgvCYmJGQ-1
Received: by mail-wm1-f72.google.com with SMTP id r19so1373340wmh.9
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 08:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uu5DQQvJShOF0xj3IpLFPuNZHpZaLCV+2VcB1NqWaMo=;
 b=h5XHvS7AKd803ZuVDF7vrEUH9lgXc+l+AYoGYRgTQN9qrSG0xv7MNTNB8o0q5PFBcL
 4Cok2CXelIUwHoXjxkQuv69AQIk2UbTZTXzom33Xv1+GWwR/p4U03Pi5wBSjfXvQeTau
 A+dcPc3WDEsYsUxk6fDxgs9hWPzIYr4Pltcf7mIuAUrlj9tx56oA5zmEFxrA33xgYyMy
 HsrJoXcBAx0SUP2o4VkShayReFPUyj1W7vMmz94CHVRIa+24TVv1oK038VUl8es+u9Ea
 he/hJceQqYgVDSC1hEPVbuxJ0Yy82l1Y37cDpxVSkxR6PjIoH6gFZM+981jp5MFXRvHp
 cxoA==
X-Gm-Message-State: AOAM533bSX/N3qZjGWbn5X1aBrxVaVuqqwq2/cJxWcpurV9fAdOaI72u
 LVGjSOKtxyYE2952uLdaZQgKzT6elKYXbb+AJYg4QeJBZFsr9aFb+ILqtB7WSddgvDVfmORk+cq
 mmhG8JNhuq7+t6eI=
X-Received: by 2002:a1c:9d08:: with SMTP id g8mr3333048wme.171.1604072393131; 
 Fri, 30 Oct 2020 08:39:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW8WbQDz2GuNeB0U2pRsr8vn8scPEuFKdEk4Lx7A9QMBe3NaXihvxU2qVeE+ymO5iygRS0Fw==
X-Received: by 2002:a1c:9d08:: with SMTP id g8mr3333033wme.171.1604072392915; 
 Fri, 30 Oct 2020 08:39:52 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y200sm564139wmc.23.2020.10.30.08.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 08:39:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] MAINTAINERS: Make status spellings consistent
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201030153416.429791-1-jsnow@redhat.com>
 <20201030153416.429791-3-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <626897c7-2c2b-898d-88e6-11a256a24583@redhat.com>
Date: Fri, 30 Oct 2020 16:39:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030153416.429791-3-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 4:34 PM, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  MAINTAINERS | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


