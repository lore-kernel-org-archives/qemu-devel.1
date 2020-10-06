Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5948C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F72020760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iekspDLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F72020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPl6y-0001XR-W7
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPl5i-0000Ad-4U
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:25:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPl5g-0006ot-E8
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601983507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dukI4JsjMhkOT/xqZR6cdMXRaxlGjURUQIdXDAydaPk=;
 b=iekspDLrWY84I1hLPVrycdLjymOd1mDlTH+HX4fjNyskwNp2Mo+SZ1Cq/yZeoGmcfP6uPd
 pL7P0/5qEPRD2W+0OdqpmpCtvPF6i74HVCa7BAMFQJTylIGbQRXr/meUkjlQ86dDtqjRgs
 AHL0Nx3joSC3XsCakk3sumr2h7//XoE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-hGJsd2UMPy296Q60k24CjQ-1; Tue, 06 Oct 2020 07:25:06 -0400
X-MC-Unique: hGJsd2UMPy296Q60k24CjQ-1
Received: by mail-wm1-f69.google.com with SMTP id c204so995961wmd.5
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dukI4JsjMhkOT/xqZR6cdMXRaxlGjURUQIdXDAydaPk=;
 b=tRPw0ONZyQTzLCWHS1c+K/irlFB2+pqw3XcfWMmqYVUuABo4cWsFWuavzVt4IrXAce
 t490n1nx0o/Pzx7phFoUQYfO/l6KYZbZnHbn4ksgP56T66UcVz41x7TqCo/DJOGRpOJR
 BjS3+Bv4WcXmyuE2dN47G2faApBRyTvX+tttHxzWZRj2LSVG0p5qewVZgldhv58YyaaO
 QkYP4BFnh3B6achVr5UleVW1F7ac3q7PkZKjKdmQxtEggQnFaiKO9rPmswSJEIi4Jw7d
 EsrCpIHF8KrzRF/zavSTTxvcJCqgMCeZPlTILQX4VsJsQ7vPlXl2qKP/4740R0npOwS9
 Qn/Q==
X-Gm-Message-State: AOAM532n96FHWpPtoRTVmdW7NTyJE+10bUHcqTF8LXSe4TwNiAujYEmX
 DUo1GmSQDZkVTTxeL9vzr1eFtcSg0IercF/gVUCae/cEgf+UH6+B+TlR5AXEpKRYBQiAEQfEPUV
 3iO9aEzEmAEgsGkI=
X-Received: by 2002:a7b:cb07:: with SMTP id u7mr4115443wmj.57.1601983504907;
 Tue, 06 Oct 2020 04:25:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyikgxAm8JOW3jZPK+bjEck1vFaIlGLje00NKuH5Y44uLqRsnsWZLkC9fzHH1BuvxoOw85Tag==
X-Received: by 2002:a7b:cb07:: with SMTP id u7mr4115425wmj.57.1601983504687;
 Tue, 06 Oct 2020 04:25:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e?
 ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i11sm4066783wre.32.2020.10.06.04.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 04:25:04 -0700 (PDT)
Subject: Re: [PATCH 06/10] migration: Move the creation of the library to the
 main meson.build
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201006111219.2300921-1-philmd@redhat.com>
 <20201006111219.2300921-7-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b4e8c2a-652c-6a07-8591-852738290f37@redhat.com>
Date: Tue, 6 Oct 2020 13:25:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006111219.2300921-7-philmd@redhat.com>
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
> Be consistent creating all the libraries in the main meson.build file.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  meson.build           | 6 ++++++
>  migration/meson.build | 6 ------
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 6bec7a0994..55966c3b60 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1328,6 +1328,12 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
>  # Library dependencies #
>  ########################
>  
> +libmigration = static_library('migration', sources: migration_files + genh,
> +                              name_suffix: 'fa',
> +                              build_by_default: false)
> +migration = declare_dependency(link_with: libmigration,
> +                               dependencies: [zlib, qom, io])
> +
>  block_ss = block_ss.apply(config_host, strict: false)
>  libblock = static_library('block', block_ss.sources() + genh,
>                            dependencies: block_ss.dependencies(),
> diff --git a/migration/meson.build b/migration/meson.build
> index 55c9e1329f..980e37865c 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -8,12 +8,6 @@ migration_files = files(
>    'qemu-file.c',
>    'qjson.c',
>  )
> -
> -libmigration = static_library('migration', sources: migration_files + genh,
> -                              name_suffix: 'fa',
> -                              build_by_default: false)
> -migration = declare_dependency(link_with: libmigration,
> -                               dependencies: [zlib, qom, io])
>  softmmu_ss.add(migration_files)
>  
>  softmmu_ss.add(files(
> 

You can move add softmmu_ss.add(migration) to the toplevel meson.build
too, together with the other dependencies.

Paolo


