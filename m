Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC60BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF5E20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYeYQ9AG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF5E20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmSn-0007gU-QT
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmRi-0005VV-61
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:45:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53847
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmRg-00021V-Gg
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590072315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lOlsfYmUslMhUbLF3nhijuHjNJTGaqXVZ7QPuzxR5jI=;
 b=FYeYQ9AG2X2uZqQoWrXyXIeAOnnt0AXvxIcO64tEn4NXSx6L51481DcOFoFxIjJJrrMvUz
 UiRJP9hYdbOFM4s1o6OHPHRo+U07zcuasZt6FgmHwU8SBQ/WHjsbVvvXxmKzadEF3TiU92
 KjRvii+Pd564Ecfmqy+KiiFNHrUaj7E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-Q_AaVZ18NouQJsHkyd6Xpg-1; Thu, 21 May 2020 10:45:13 -0400
X-MC-Unique: Q_AaVZ18NouQJsHkyd6Xpg-1
Received: by mail-wm1-f72.google.com with SMTP id t82so1939070wmf.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lOlsfYmUslMhUbLF3nhijuHjNJTGaqXVZ7QPuzxR5jI=;
 b=RFIXng16AIEyKBToTz7TklhPEjmossaTgdRuOTM/PVBFRNt3s0vXV0HuwADphlEMQD
 rkn1qPjgKomI6YVgPFOlVfGUbG1uO7h/GD5fL6zJsISgxOiqLWDWtgXk+UYLc4wehXja
 nDEzwerX8C98Elh0V+FACGzDSwgAyT982YUhqRFQxcX7pqqwWEjjA7d/EG3EO9zWHb7C
 eW8jpAaD3jj/iBruwmdlRcPIN5aBtFMV02BPOeLIpC73u8Bw20e5vng/Ee1R0xRoh8x4
 II6pDhrLr4vfb7sZdO4ASPTpNDBvlKnzVCV3NlP4TGIs6DdkJKg77c0GFoav7NTCpIol
 XA0Q==
X-Gm-Message-State: AOAM531io8gtmVybTig5Me1Xp3UEef0fTLJ+Em0BIcmJQFkzp59NnBQ1
 UUXHM0KqcvZ3oZQLdadaAHHGhxIHebxrVGADN0kZxJA5cw3YckYsLx/P/+mPWYKkERRXrcfdZTT
 2HBbl78Hfk7WIVMQ=
X-Received: by 2002:a1c:790b:: with SMTP id l11mr8835781wme.2.1590072311834;
 Thu, 21 May 2020 07:45:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtxdgJ2whqt6BB0jT+76VfDrXqdCi3ar2R3083ZyqCsqeOQ9c7kDnpbBuZzkiGQWFQ26LO8w==
X-Received: by 2002:a1c:790b:: with SMTP id l11mr8835765wme.2.1590072311621;
 Thu, 21 May 2020 07:45:11 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id u7sm1050813wrm.23.2020.05.21.07.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:45:11 -0700 (PDT)
Subject: Re: [PATCH] qom/object: simplify type_initialize_interface()
To: Masahiro Yamada <masahiroy@kernel.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200512182501.2300530-1-masahiroy@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55eaf845-21bc-5d1a-0ece-7fc1a6389130@redhat.com>
Date: Thu, 21 May 2020 16:45:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200512182501.2300530-1-masahiroy@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/20 20:25, Masahiro Yamada wrote:
> iface_impl->class is the same as new_iface. Make it more readable.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  qom/object.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 9d1a918e42..75c628591d 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -262,8 +262,7 @@ static void type_initialize_interface(TypeImpl *ti, TypeImpl *interface_type,
>      new_iface->concrete_class = ti->class;
>      new_iface->interface_type = interface_type;
>  
> -    ti->class->interfaces = g_slist_append(ti->class->interfaces,
> -                                           iface_impl->class);
> +    ti->class->interfaces = g_slist_append(ti->class->interfaces, new_iface);
>  }
>  
>  static void object_property_free(gpointer data)
> 

Queued, thanks.

Paolo


