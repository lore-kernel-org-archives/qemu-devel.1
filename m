Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFFAC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F02206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIdDq2gK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F02206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYTNa-0003BW-0B
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 07:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYTMj-0002h9-TK
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:46:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25096
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYTMi-0000Kz-EA
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589283986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hgjr7c4fIzm6JWc7Rf4nLWjkIt7PYd4YlTYt9Ya/XoM=;
 b=MIdDq2gKn549hCHZWvnn6eBDw06dfTXvDr/yWsDLUkbfMg7xdLJA9VNbxUIXTRI73WoyGn
 om66MJV4Bg5vRTKYmgr7vOfHYyZ6UM3eO0357Tyx0lN8/aUklkKyxD1/P2ItgJGb9RqS9S
 DRVaO9xxf5Sf0+eFLHEoznA4CulqHh0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-nry1RCOTNOSlwo6BcYlffA-1; Tue, 12 May 2020 07:46:25 -0400
X-MC-Unique: nry1RCOTNOSlwo6BcYlffA-1
Received: by mail-wm1-f71.google.com with SMTP id q5so9831268wmc.9
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 04:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hgjr7c4fIzm6JWc7Rf4nLWjkIt7PYd4YlTYt9Ya/XoM=;
 b=dpcsqoE65zzFKIiYugl+frOkJV63V5miqWjfIue0lfxAFrqPMpH23rweanptBj8HUt
 6PxlHvsbSpYmKP2wKKQli9dTy5y9UIAhUvyFzsPKVm8KW0GJk7Q0YCBuMJzUSEzeMVpe
 UtUoNSP3mfBuFvcVlOM7JhBRkeMYpjBLTiLBXf5WFMnP0mpTEg1eiBeOb1rulxT6SbHE
 P3ZfZetnxWa0KbUX8DwodlEe2+hDasZEWuzqJ0/M2N8ZWNBf1DHtHejMs0/Ku2dNKATx
 cUWKuhLTYIHriLal4FlDJ/CHFhKZw9caTySL/k5nsPu9tH3zi3LHr3bfADHa4dci4hSo
 AXlQ==
X-Gm-Message-State: AGi0PuYXMQramb3vID9PDdXy4hFL11+VWIMZfK80HunFUcYKS2gYWOZ7
 F6UI3nkG+Ex2yP9FwUrMdjL7FlCKtlfFI+l6klDXObMJdc2JdMBFIJhWVYCmTVkXlzGBqi0ZfdA
 u9cuQhnNnRCyuyZ4=
X-Received: by 2002:adf:f852:: with SMTP id d18mr20082977wrq.341.1589283983542; 
 Tue, 12 May 2020 04:46:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypLmiJEZY6f7mf/OWu8LW8aC3lOat/s/4aklfyFypqylvFSeknX79mNjzp0c2o8c5Hd9o10YGw==
X-Received: by 2002:adf:f852:: with SMTP id d18mr20082933wrq.341.1589283983014; 
 Tue, 12 May 2020 04:46:23 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z11sm9636520wrr.32.2020.05.12.04.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 04:46:22 -0700 (PDT)
Subject: Re: [PATCH 04/10] ui/gtk: remove unused code
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
 <20200510184304.9267-4-vr_qemu@t-online.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <233896d9-de89-fa07-6709-96894f263945@redhat.com>
Date: Tue, 12 May 2020 13:46:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200510184304.9267-4-vr_qemu@t-online.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/10/20 8:42 PM, Volker Rümelin wrote:
> This code was last used before commit 2ec78706d1 "ui: convert
> GTK and SDL1 frontends to keycodemapdb".
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> ---
>   ui/gtk.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 5de2a75691..c70bfc2be4 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -112,15 +112,6 @@
>   # define VTE_CHECK_VERSION(a, b, c) 0
>   #endif
>   
> -/* Some older mingw versions lack this constant or have
> - * it conditionally defined */
> -#ifdef _WIN32
> -# ifndef MAPVK_VK_TO_VSC
> -#  define MAPVK_VK_TO_VSC 0
> -# endif
> -#endif
> -
> -
>   #define HOTKEY_MODIFIERS        (GDK_CONTROL_MASK | GDK_MOD1_MASK)
>   
>   static const guint16 *keycode_map;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


