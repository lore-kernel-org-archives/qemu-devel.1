Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8100C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FB0207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/eY+37n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FB0207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbNR9-0001DL-Mk
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 08:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbNQO-0000BX-5U
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:02:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33639
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbNQN-0001jc-Dp
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589976134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwBtcn924wQ25kRgO0xP9s5Kc1Yqu1KL4tR1NnbJeiY=;
 b=K/eY+37nuSr2+V9QgGhSs6uz7++5hi7Zj7SjKvjaHKPz+WggTHSmYKDiNPyaQFg4yYx923
 DM65rYdSayPr0b/WMWMcJ/RvYUFocYb0NNOmHh1GxhgDnXjBKTO0Zwmxs8XmdNmBZ3yUgZ
 LL2PPDG1t3yYo+3kDZPHi7ID6b3MXGU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-UFKBAYfPO9CxemB2y33vfA-1; Wed, 20 May 2020 08:02:12 -0400
X-MC-Unique: UFKBAYfPO9CxemB2y33vfA-1
Received: by mail-wm1-f70.google.com with SMTP id n66so1154222wme.4
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 05:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mwBtcn924wQ25kRgO0xP9s5Kc1Yqu1KL4tR1NnbJeiY=;
 b=jEH3lbIzbEpwxPQZyNX5snxudGEDSSJXXflGDqy9nup/+d2BHgcBxzfVxaOyhU8LJQ
 PVyk1ntEjd5Qi508qR7JIny5TKxLcdJZurHnmWr7bYm+ECJp2auc5zadBE75ozt6MJQ7
 98EqE7bxnYKHU8X6u9hrLj7RzFgxRakD1y9ASFOUlCuVgmKqdZInUl4IpFWQqq4B5CSB
 Z1MJjK2Wth2nA97WIzza6NP4V+1/99LGEanK362dtvSIWo8G3dGc7k7q5YxNRFf7FOUT
 XBp0OzauV8nxGkGZM3+mofql6ES3xZSCHToAtA6AfEPD7kSraHR1YAC6ezBslPvxvp3m
 wKvw==
X-Gm-Message-State: AOAM533cdHtG6BACNNbI4HKcclIT1rj/IVd9IaUF9jHelBCDHZV82WPw
 7dujuERUPtXOwDulGfSgF43eFujjETxmVciqirlt6miO88gKsZkAO1uKIW39dVzuDOPfHpenwX7
 ctFP7yo3mio3V214=
X-Received: by 2002:a5d:6584:: with SMTP id q4mr4170455wru.12.1589976131439;
 Wed, 20 May 2020 05:02:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypEwOxlIXtnok90IPiLKbVwAAnOqmsDhUPkY+PR7rcTNZT7o5FUu/3c+uJhJoaqZGA1LyBWQ==
X-Received: by 2002:a5d:6584:: with SMTP id q4mr4170361wru.12.1589976130294;
 Wed, 20 May 2020 05:02:10 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r11sm898403wre.25.2020.05.20.05.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 05:02:09 -0700 (PDT)
Subject: Re: [PATCH 37/55] sysbus: Drop useless OBJECT() in
 sysbus_init_child_obj() calls
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-38-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a7115fd6-27de-8702-0890-731c5e17c380@redhat.com>
Date: Wed, 20 May 2020 14:02:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519145551.22836-38-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 4:55 PM, Markus Armbruster wrote:
> OBJECT(child) expands to ((Object *)(child)).  sysbus_init_child_obj()
> parameter @child is void *.  Pass child instead of OBJECT(child).
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/arm/allwinner-a10.c  |  4 ++--
>   hw/arm/aspeed_ast2600.c | 40 +++++++++++++++++-----------------------
>   hw/arm/aspeed_soc.c     | 35 +++++++++++++++--------------------
>   hw/arm/nrf51_soc.c      |  2 +-
>   hw/mips/boston.c        |  4 ++--
>   hw/mips/mips_malta.c    |  2 +-
>   6 files changed, 38 insertions(+), 49 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


