Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43862C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DBA20671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaUfk6WE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DBA20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmR2-0003hP-75
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmPo-0002DT-Gk
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:43:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28084
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmPn-0001ls-OW
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590072198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WmXD8mpcx/xob/1Vwzt4EY5LLHycZI6gZ7U2dbEkvlM=;
 b=JaUfk6WE6VBXttbthT7lh+jkMmU+3oMCtwZCx3GxOGPgR5ZQuIpfIDAl/eVi4Gimq04HS/
 2xfisR/UJCnUPiYBHjKeXZwekB210HGoFOC9zXb7l6VB4JbiutYV/4xxYSD15e7llqND98
 zaGxwXs4NVzLL8lBUD+af0pyDC/QaiU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491--V4brSobMAGceVagHRKCfg-1; Thu, 21 May 2020 10:43:17 -0400
X-MC-Unique: -V4brSobMAGceVagHRKCfg-1
Received: by mail-wr1-f71.google.com with SMTP id y7so3001661wrd.12
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WmXD8mpcx/xob/1Vwzt4EY5LLHycZI6gZ7U2dbEkvlM=;
 b=ZoBmkUYeD4IX8NaAO9vzCrVrGlUi13Ysfws5TrnyF6vqkSj/VzTeHYJCQBnvRQzG28
 2NShbgwSB1VfjekvUmehfEk4mymL7cB1AP+q4OXttMS0nNT1mVJFVkZmFjmaQLq/Suu+
 qd81c0cae2JNWqlxXjBivmbDS36dXNZ1DElMiDBLtOeZHuCZlVlqPN3KPEdZ8RICV3xJ
 fQ+uKoJ7AToPAbzeiMbMXdGBj2RnhJO0Lh0kBuDkfMbXYUzwCS0HzIToXjcfQfzkQhBn
 tO3k/N5YZZKqqatPfh11QIpVSsmrJLi39YpcG1lbM633IKWUnORFpqxZu2ID/18KpFFH
 OL1Q==
X-Gm-Message-State: AOAM5321EVP1GGHAf14ydWDLzyfg60MfazCzXQIYDmWWvWXz71rYvH0A
 0YzLG9sTNPecYWUzR7V4wc91c/LSu+SIbUifjCdCQ24fB2cpGgnrh/wJgcQ9Hy/gYpGHA5g8n9O
 2sI10Nw0rhjFUKh4=
X-Received: by 2002:a1c:9817:: with SMTP id a23mr2825207wme.133.1590072196081; 
 Thu, 21 May 2020 07:43:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsy+hKnIhr/Atm1AZtsabI5ffu+KibKd3ClWfEWop/Pm2eTu/N2wMxRqAG2wSVcBC5hCCl5w==
X-Received: by 2002:a1c:9817:: with SMTP id a23mr2825195wme.133.1590072195870; 
 Thu, 21 May 2020 07:43:15 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id v11sm6813739wrv.53.2020.05.21.07.43.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:43:15 -0700 (PDT)
Subject: Re: [PATCH] cpus: Fix botched configure_icount() error API violation
 fix
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200508104933.19051-1-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <28c289f3-eb3f-eb1a-f79b-b339437bef8a@redhat.com>
Date: Thu, 21 May 2020 16:43:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200508104933.19051-1-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/05/20 12:49, Markus Armbruster wrote:
> Fixes: abc9bf69a66a11499a801ff545b8fe7adbb3a04c
> Fixes: Coverity CID 1428754
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  cpus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 5670c96bcf..b9275c672d 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -813,7 +813,7 @@ void configure_icount(QemuOpts *opts, Error **errp)
>          return;
>      }
>  
> -    if (strcmp(option, "auto") != 0) {
> +    if (option && !strcmp(option, "auto")) {
>          if (qemu_strtol(option, NULL, 0, &time_shift) < 0
>              || time_shift < 0 || time_shift > MAX_ICOUNT_SHIFT) {
>              error_setg(errp, "icount: Invalid shift value");
> 

Queued, thanks.

Paolo


