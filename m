Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2178C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68FCC2064C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErKtggPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FCC2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPMAk-0001b6-IV
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPM8u-00085o-2A
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPM8m-00025w-RX
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601887599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGtB50YnsRxdtPcnxSKy9zziUsWLU+C2ClHiTUgK4HY=;
 b=ErKtggPNLAdxJRoMZM8qJ3tJKJHTvZWYTsN4iCtjzFaODiVfWiC16EcDUaMkNAT/qGsPPz
 MqouicTSxQBDFccK45irfQlqZ77GzLqO9HRq2oMajYgKWiaJq+doNFTBhWXpe5wEN8C36Z
 p3SEM/zYSZ22/sDVPFF+qgYmTr4iThA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-is83IHTdP7KS4NYI0XJv-g-1; Mon, 05 Oct 2020 04:46:38 -0400
X-MC-Unique: is83IHTdP7KS4NYI0XJv-g-1
Received: by mail-wm1-f70.google.com with SMTP id g125so1633146wme.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iGtB50YnsRxdtPcnxSKy9zziUsWLU+C2ClHiTUgK4HY=;
 b=Jje9s0XIlb1ypyNjDKWOQ+m1NLn0uRCsoMKxtw+SzOwpDMCjQC7m7jbMy1BcdfTJ7s
 5C1zEDOZ7fz0HLR3Xfwkwi0vDsvxHTiG38AZaD4nRBN55xd9HzyxqF7AJzQSbBF40Etq
 RwKCBKhgeSM5SXE+9C+ef6ulris2tibgEgP3d7VsOn8F0jf845Zezlt6sM1me+z2hgHf
 xUloR5E5bdOadxygjkSHAVhScLIjg2tr39AwgvMM4V/kUE6Nj47fQayRjkeniLF1HCCZ
 2217ZNlgsc2SvFrvL5CdiZC8uOM2NniC4wt31d9TgEZfa8XpT68tMGzz3ZBrhEUgZfrR
 Zkuw==
X-Gm-Message-State: AOAM530U1qrxJKXRTL7DE5FKyRKhFQ6J7IY8YBCmTzE3GNGFgB2neiwX
 GWGb5iCf9AySZso5HQXDLEu/Nfx5ZJi2gqTKzIg5+Nbdk/TnEUhdn3adcQECvam3J/Z1FEBkaP2
 WWeF/GPyKraiChR8=
X-Received: by 2002:adf:f508:: with SMTP id q8mr15628310wro.233.1601887596919; 
 Mon, 05 Oct 2020 01:46:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxh8gBdXjFPP6Fg5LpFJWyuWEnPq5OgT89WT+nnJI2qo5KAVzXdVErIty6ISrAJ1Uq7rNJfQ==
X-Received: by 2002:adf:f508:: with SMTP id q8mr15628293wro.233.1601887596747; 
 Mon, 05 Oct 2020 01:46:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2e86:3d8b:8b70:920c?
 ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id f63sm11027412wme.38.2020.10.05.01.46.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 01:46:36 -0700 (PDT)
Subject: Re: [PATCH] qom: Improve error message displayed with missing object
 properties
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200920155340.401482-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0263e47d-549e-8acb-a6cb-93a7436f5f6d@redhat.com>
Date: Mon, 5 Oct 2020 10:46:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200920155340.401482-1-f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/09/20 17:53, Philippe Mathieu-Daudé wrote:
> Instead of only displaying the property missing, also display
> the object name. This help developer to quickly figure out the
> mistake without opening a debugger.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  qom/object.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 387efb25ebe..257914b1fe3 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1259,7 +1259,8 @@ ObjectProperty *object_property_find(Object *obj, const char *name,
>          return prop;
>      }
>  
> -    error_setg(errp, "Property '.%s' not found", name);
> +    error_setg(errp, "Property '%s.%s' not found",
> +               object_get_typename(obj), name);
>      return NULL;
>  }
>  
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

I think it's okay for qemu-trivial.


