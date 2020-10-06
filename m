Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED4BC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484E72083B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHcwVciz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484E72083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlAh-00050O-76
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPl4y-0007fg-JK
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPl4w-0006gm-Qe
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601983461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UL5vFfMkn2QUfgjwb3pXPmts+GWRxaYcY07Haqd8G/s=;
 b=MHcwVciz0M95ViVLnC+foQEPzjEZ6AyayUXUElKTSsxeuF23QxHdQOHjboP9c7RcvqpJ6u
 lTt/kAJRh77uRHkZlwLRNDJwv6PBcUW0MvzkJMyIe5m8ZdP/JySOEBGBj6bX7qJZwOgJRI
 4ZlAhOk6rlTmmQzbvYHGJW92j4VIKXY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-wQ4-xjB1MrSeQuKrPKDNyA-1; Tue, 06 Oct 2020 07:24:20 -0400
X-MC-Unique: wQ4-xjB1MrSeQuKrPKDNyA-1
Received: by mail-wm1-f69.google.com with SMTP id g125so1003511wme.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UL5vFfMkn2QUfgjwb3pXPmts+GWRxaYcY07Haqd8G/s=;
 b=o0dt+pLBaJPCnzJnGF8FaiqcPCQeoLbII+Yp838ij6N6rf4qRrXCp468Fk8hL1Ezkl
 T6dzynOuBFyOZXtUl1Zs9KtA9WBtl3bs/0JY72wqV5jGeX42Hd2+O2Cx3cuRuvYpMA6v
 cYo35X0gLDcUZ1RSGhSI71oYFBK7q3bqgmjzFSGykJZycYhhEHcOyKuE0+LZ6ZNi3Dto
 DjhaJwXiEMmLqGvxDQSyL4hR+OjPFQm5tz+NrT82lfbHot7PGwxxTcRSN03g4VMUDLcc
 9LYy+Ia2OspXaezcwvS7zIjC8OqYmn3eROjTyYctyE1TehIXeH9m8zAlO1y/G/7RIG/Y
 rRqg==
X-Gm-Message-State: AOAM532+hlRhqcXFKcVHYrEyguudUZaNLm7UpebyviB/iNWUs/ofd/7t
 mmLT3JJdwuaLxf5DfxpLhhyFWvezYWMb13zb9zbkk60PP8WXSiq6YiVE6folMkQzGcTJV1hzEeq
 40jSuid8PqHSRMJA=
X-Received: by 2002:adf:e690:: with SMTP id r16mr4298682wrm.15.1601983458975; 
 Tue, 06 Oct 2020 04:24:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUVo6Q3oS/g8xLWRUigoq6SItam+NRVuketLFEl1SR2FX+ME+28QFkol/MbK1MKQa/CV2YLQ==
X-Received: by 2002:adf:e690:: with SMTP id r16mr4298656wrm.15.1601983458714; 
 Tue, 06 Oct 2020 04:24:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e?
 ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id s6sm3997254wrg.92.2020.10.06.04.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 04:24:18 -0700 (PDT)
Subject: Re: [PATCH 02/10] meson.build: Add comments to clarify code
 organization
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201006111219.2300921-1-philmd@redhat.com>
 <20201006111219.2300921-3-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85c401bd-6e83-2d08-a924-3bd86443ac95@redhat.com>
Date: Tue, 6 Oct 2020 13:24:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006111219.2300921-3-philmd@redhat.com>
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  meson.build | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index a02c743794..eaff16d482 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1323,6 +1323,10 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
>                               capture: true,
>                               command: [undefsym, nm, '@INPUT@'])
>  
> +########################
> +# Library dependencies #
> +########################
> +
>  block_ss = block_ss.apply(config_host, strict: false)
>  libblock = static_library('block', block_ss.sources() + genh,
>                            dependencies: block_ss.dependencies(),
> @@ -1363,6 +1367,10 @@ common_all = static_library('common',
>                              dependencies: common_all.dependencies(),
>                              name_suffix: 'fa')
>  
> +###########
> +# Targets #
> +###########
> +
>  feature_to_c = find_program('scripts/feature_to_c.sh')
>  
>  emulators = {}
> 

Much appreciated. :)

Paolo


