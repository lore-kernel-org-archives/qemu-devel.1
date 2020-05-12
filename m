Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E57CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BFF20720
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ie961t9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BFF20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZUg-0002In-Qv
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYZT6-00016n-Ow
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:17:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42004
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYZT4-0003Hl-CC
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589307444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5v8ULgxae1jVRuxyE6GlVo+BzXMlq/2WlJuMyk3EleQ=;
 b=Ie961t9V4CIByy2faQ5O3vddmOZBRh8rbRRn2ZDDXPSmTFRGwAsmlEDDZVUfZCW4RmeVf2
 tZdbsmPkebJKdAmxvcQZJC+2XfuM0US5gTuMChqfdXz4OmMNSC7aEH7Uw+JrjY3capXvDq
 mIgG57Ev6DajV8DCwhQzZ4yCt8V4q0M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-rZAVZum1PmGqBsjR1VDbjw-1; Tue, 12 May 2020 14:17:22 -0400
X-MC-Unique: rZAVZum1PmGqBsjR1VDbjw-1
Received: by mail-wr1-f71.google.com with SMTP id u5so5441193wrt.22
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 11:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5v8ULgxae1jVRuxyE6GlVo+BzXMlq/2WlJuMyk3EleQ=;
 b=WH/g9qsr5ut+cYTj6e7k4ieVlrq+TmYJFDT3E49rQ2LpIasTDg0Wp6RyA7ISlWvGTI
 mYhgEgQwoILUL6PCOBM/hvh7IwkHODEn5AUG6u8GilG5YIN1C+AXPS97mT6n6pRNU+cv
 3oZH32z2KW/7dz0uLT12nKLp++rlk3RPIwFj+oXwmZyPb5GF1vxq+w//KjX+Nu9IFpea
 HV/RYtarDh6/8y1q4FmjyuHsvQ6kxtg6ZeLDNDRa1xu/zQTGSRt9/uRz1LUgHaTm93cG
 ZTEmiZtdiQOg61k+PyvGhDm/9BweF3Wsu0sNZ0UrA3aq4Ybr7L+NSHAUFmK0iYA9xOhR
 v7vw==
X-Gm-Message-State: AGi0PuZ9JxkB2Lel5FJS/1+OKhC/deJaD5Cl8/nt1/xjYKzblNFo5uWy
 3R35zVmLpyKsXoLugWeCZkxhiwEjumU4HzCk7+tTmRSTrXafR3Jm2n4E73kSKNRvNLOKplWmM/I
 Zrapx5V+sT1lYdLc=
X-Received: by 2002:adf:a151:: with SMTP id r17mr25565355wrr.161.1589307441545; 
 Tue, 12 May 2020 11:17:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypJzVGHrzpYntJVw7niUjtUvLVoTjOMh8+qmZ9HCO9/FfKwH1WgDmYUJJ5BFlWjhQXPJwqmK1A==
X-Received: by 2002:adf:a151:: with SMTP id r17mr25565334wrr.161.1589307441334; 
 Tue, 12 May 2020 11:17:21 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q14sm24917195wrc.66.2020.05.12.11.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 11:17:20 -0700 (PDT)
Subject: Re: [PATCH] qom/object: pass (Object *) to
 object_initialize_with_type()
To: Masahiro Yamada <masahiroy@kernel.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200512173104.2293073-1-masahiroy@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8f3abc47-30d0-612e-4d8a-9a861d5c2a48@redhat.com>
Date: Tue, 12 May 2020 20:17:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512173104.2293073-1-masahiroy@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 14:17:24
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 7:31 PM, Masahiro Yamada wrote:
> object_new_with_type() already passes (Object *) pointer.
> Avoid casting back and forth.

But object_initialize() doesn't...

> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>   qom/object.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index e4085d8ae2..9d1a918e42 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -495,10 +495,8 @@ static void object_class_property_init_all(Object *obj)
>       }
>   }
>   
> -static void object_initialize_with_type(void *data, size_t size, TypeImpl *type)
> +static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type)
>   {
> -    Object *obj = data;
> -
>       type_initialize(type);
>   
>       g_assert(type->instance_size >= sizeof(Object));
> 


