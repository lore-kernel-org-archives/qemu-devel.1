Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E446C4727D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912EE2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFbKyreL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912EE2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlC7-00074I-E8
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPl69-0000Zw-2d
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPl66-0006wJ-VS
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601983534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0qaGIkAe4cnMlsGxKquCyr0lLG2e94yaVnamxvHAP2Q=;
 b=LFbKyreLIekM8IeXtKcTpy2V/YetFGABDzq2euat35W/T2ZxR8ufk57zrhOcZZKekvKtov
 O0KkINylCEx1/Q6K+i9oMH1cc2e/NOsfEuBKdcJym/f838os3qb0pBaupJ6pWHp7kZBofM
 ldIOUOq7ts3s8ncHPham/jOePmLqm5M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-xJpM_SW7PHe3eznkx5SL0w-1; Tue, 06 Oct 2020 07:25:32 -0400
X-MC-Unique: xJpM_SW7PHe3eznkx5SL0w-1
Received: by mail-wm1-f71.google.com with SMTP id p17so587364wmi.7
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0qaGIkAe4cnMlsGxKquCyr0lLG2e94yaVnamxvHAP2Q=;
 b=gaQs+Jfje35GJAYH8qORtsi+8EPTGWQsSJRpKf+ezp7K7OH00v/fZaCZ8eIYm0ZdEk
 c7V1EcsjNK6SuGahOL/52wF12eOF2ur3p2PQ4IZSKILE1J7vONn4K4bXSON94LQCEFjo
 ltfifH4fxXsXYwX4o6dBlIjZPAntO0xy909GkK48K6nf6DN8pQnfnx5FvUpTsTZAEAXn
 bPDBUDsatUgsln09cosuNBdkEeTVh7V/UfQEOqflIjKsPfk+kKRMjbaDYMJnS1V4aLq2
 mE3Jvc8PDt1ZW1s6C307fcpAC6oeFdra35LsYFb3xJZJqMiH9PYQr4BE2rvT/BL4VsB+
 +amg==
X-Gm-Message-State: AOAM533z3UF3TIf2gUAmmI/3ZGqQuxiUn1CTFhcOxDR19F97awzKGoRL
 /jGVli654m8CUdioMLFke/KlzGkZMjGhoVK9yxpUXIS6PyS1+J6T4jRXyriwdqCIbW3CbL10Jg0
 PD3kOdXWgkXxHIKc=
X-Received: by 2002:a7b:c148:: with SMTP id z8mr4179524wmi.135.1601983531705; 
 Tue, 06 Oct 2020 04:25:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwegbbmMtUKOFuR5zvcC6uegsyLGsJ0ed4D1C+oQ/31CiAGAE6sckEkSGq8dhY9WbYjok2Vgw==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr4179504wmi.135.1601983531456; 
 Tue, 06 Oct 2020 04:25:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e?
 ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id z191sm3657203wme.40.2020.10.06.04.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 04:25:30 -0700 (PDT)
Subject: Re: [RFC PATCH 01/10] migration: Only add migration files to the
 Meson sourceset
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201006111219.2300921-1-philmd@redhat.com>
 <20201006111219.2300921-2-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d3b004f6-2c21-461c-5455-76ae835547af@redhat.com>
Date: Tue, 6 Oct 2020 13:25:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006111219.2300921-2-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/20 13:12, Philippe Mathieu-Daudé wrote:
> I'm not sure how that works, but keep the use of Meson
> sourcesets consistent, only add source files.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  migration/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/meson.build b/migration/meson.build
> index b5b71c8060..55c9e1329f 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -14,7 +14,7 @@ libmigration = static_library('migration', sources: migration_files + genh,
>                                build_by_default: false)
>  migration = declare_dependency(link_with: libmigration,
>                                 dependencies: [zlib, qom, io])
> -softmmu_ss.add(migration)
> +softmmu_ss.add(migration_files)

This would compile the file twice.  You can just drop this change and
fixup patch 6 instead.

Paolo


