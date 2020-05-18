Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F75207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnDPH7e6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F75207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabXt-0005hW-PN
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 04:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabXM-0005AX-7P
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:54:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42885
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabXL-0002uo-D1
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589792054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jk8udbawUJA7EUXtcipV29D3lZX9AR0gbQa/u2nNBqk=;
 b=fnDPH7e6cKuHrdZKvjhLq3T9WbAw4uZgpEiMqrZ1walxe6RZU8MIBRM1DZj13kzFmH+OJt
 117Y1XQ0GwwlV+dLaIMmrjKJ0VuxhJE3WTwj2xRDq/1UU7A9JtTTkeRXDwrFdDiACsQ+y7
 2fIY8je999t9/JzUdGqOdzYaYYnF9k0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-Hpd0Ae5tNiu4gs8Y17zWNQ-1; Mon, 18 May 2020 04:54:12 -0400
X-MC-Unique: Hpd0Ae5tNiu4gs8Y17zWNQ-1
Received: by mail-wm1-f72.google.com with SMTP id u11so2793863wmc.7
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 01:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jk8udbawUJA7EUXtcipV29D3lZX9AR0gbQa/u2nNBqk=;
 b=G9LhgZJjm1/CVeYXb5WrMmkQyQLGIUq12uwCbNYNIzbV5ZDAU65IqvioNxFaKeKs4R
 oQcfuR4sMMrW2S3imguNCES0XbeMTPJqzyy60byo3lynmuiqMuWTMgaR79goWnY0A/1C
 C3Gbh4aFlxQYFBwA9AcXH4akjZF/98+huGbkXLwjna1lAVWv5OQnOBl0laLVwANZYgBM
 TZLy9x0LW6V33cc//hlsitqkiW/SnPRWz2gKDLS9B9SzczFbuq/KwSnqGBoUsk23q9z8
 fBm4wZBmowr4kJa98zTeyQxza9rq+jeOJ2gjm+PK+9xK8qPLXvn8osG9mq14pX3130RM
 tSdw==
X-Gm-Message-State: AOAM532/t/Ss/EAyNC8SXI3Anhwsna6ecqweRZZ6OUqWTSetZUC2wQ+5
 v8grXd38E55o/nAYprAm8ZjXPQ3uK1oLn1O6OIDXMOxlYVQ6q901m9APkqhu0fL7BiniyILUDtO
 p6NTeu65XPzqcPBg=
X-Received: by 2002:a7b:c948:: with SMTP id i8mr6964582wml.138.1589792051817; 
 Mon, 18 May 2020 01:54:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxekMNI1fxP0XiH9vgp79hpaQZqryGFthtuqXEpx3V84bNxFH5HFf0KFkztGHWEoo3bM6UMLg==
X-Received: by 2002:a7b:c948:: with SMTP id i8mr6964569wml.138.1589792051655; 
 Mon, 18 May 2020 01:54:11 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id k5sm14985401wrx.16.2020.05.18.01.54.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 01:54:11 -0700 (PDT)
Subject: Re: [PATCH 13/24] ppc4xx: Drop redundant device realization
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-14-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <39e01a98-9a0f-99db-65a0-8843f3e064f2@redhat.com>
Date: Mon, 18 May 2020 10:54:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518050408.4579-14-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 5/18/20 7:03 AM, Markus Armbruster wrote:
> object_property_set_bool(OBJECT(dev), true, "realized", ...) right
> after qdev_init_nofail(dev) does nothing, because qdev_init_nofail()
> already realizes.  Drop.
> 
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/ppc/ppc440_uc.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index b30e093cbb..dc318c7aa7 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -1370,12 +1370,10 @@ void ppc460ex_pcie_init(CPUPPCState *env)
>       dev = qdev_create(NULL, TYPE_PPC460EX_PCIE_HOST);
>       qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
>       qdev_init_nofail(dev);
> -    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
>       ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
>   
>       dev = qdev_create(NULL, TYPE_PPC460EX_PCIE_HOST);
>       qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
>       qdev_init_nofail(dev);
> -    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
>       ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
>   }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


