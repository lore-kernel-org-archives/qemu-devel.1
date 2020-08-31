Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF7FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 12:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9A120866
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 12:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj2gB+ER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9A120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCihk-0006TK-OP
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 08:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCih2-0005vQ-10
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 08:13:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24322
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCigz-0000oX-G0
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 08:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598876023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eRdrB28weBqEWloafMomxpw5+YDL/p+xmQlKH05XN0E=;
 b=Oj2gB+ERq1bVb6iDocQn6JcDPxgSqiGSIuZFoZayfL/cIuUMExqAGYRLmENuzt7rdwOp0t
 AK2iW50YF1BYMVzuBuNSpwRebLd/MxVAWjnaG6c4/HigZP0g1nEDyqULnbHGckhP9HkO9y
 dQelT7CcwjJ7PghndMljIO/2SNcIFHk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-pAHH1vifPG2wefk7Y4rG5A-1; Mon, 31 Aug 2020 08:13:41 -0400
X-MC-Unique: pAHH1vifPG2wefk7Y4rG5A-1
Received: by mail-wm1-f72.google.com with SMTP id f189so934867wmf.8
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 05:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eRdrB28weBqEWloafMomxpw5+YDL/p+xmQlKH05XN0E=;
 b=hYAjygnRuMUfPZbk+yEOL7aI8Mrt5uWB6IIvX9gqDJ3yKe/RQpfjNpVfseR5R3mFQ8
 zdmFrI523/xf4/QhuEr/cYDlLO1VusmoHw89xOQpyi1mHy89QuSpZtU7hbhUWhbAnjET
 EisT2fkyJEVnWMB7qz7922ulIiXJV58jRyvhgZ5Luh3RfG7duKx5H6HHb2iP1qCd9esd
 07yt13Cwmc8OpJwK1YPwAg51vzBa6KIucQVMcPYGf1a2hXdTqJAPINjdn/WtW/OJSzKF
 7LFhbZnEL+QMGnff8ctBzg5XK9Awx+lLVdUJnDOJOFOr2p6P5H0oGJ8vJzoCElfL7crQ
 2TGQ==
X-Gm-Message-State: AOAM530464sCJwiQSUQKOK+KMjTxrHqlHlTd/ayx9pQY5E/uVpJA+3Bq
 b0LCeTeMD7+k3qLm1vc64RaK+tsOJfMtBA2QVWz7d6Wh8cZ79MECD6Iei38pukAcWE0K/fdvc0E
 BTxUTgK2qAGDAahM=
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr1202755wmh.4.1598876020402;
 Mon, 31 Aug 2020 05:13:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYj7wjU/PkFRvQ4P2Z9QZtsCim7wK4HCDbh0HOMAeX8Yf1fsv6ifU2aO/nhIfBQok3h0PzVQ==
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr1202738wmh.4.1598876020185;
 Mon, 31 Aug 2020 05:13:40 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.203])
 by smtp.gmail.com with ESMTPSA id r3sm12243917wro.1.2020.08.31.05.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 05:13:39 -0700 (PDT)
Subject: Re: some mason warnings during latest master build
To: Claudio Fontana <cfontana@suse.de>
References: <ff4e5f09-fb36-8ab6-1c40-210193e2676b@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac653cb5-516b-d3bf-aa63-5d4480b85dbb@redhat.com>
Date: Mon, 31 Aug 2020 14:13:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ff4e5f09-fb36-8ab6-1c40-210193e2676b@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:56:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/08/20 13:46, Claudio Fontana wrote:
> 
> Hello Paolo,
> 
> just FYI I am getting a few WARNINGS on latest master with mason, not sure if you get them as well:
> 
> ./configure --enable-tcg --disable-kvm --disable-hax
> 
> [...]
> 
> Found ninja-1.10.0 at /usr/bin/ninja
> WARNING: custom_target 'shared QAPI source files' has more than one output! Using the first one.
> WARNING: custom_target 'QGA QAPI files' has more than one output! Using the first one.
> WARNING: custom_target 'QAPI files for qemu-storage-daemon' has more than one output! Using the first one.
> WARNING: custom_target 'QAPI doc' has more than one output! Using the first one.
> WARNING: custom_target 'dbus-vmstate description' has more than one output! Using the first one.
> WARNING: custom_target 'tools man pages' has more than one output! Using the first one.
> WARNING: custom_target 'system man pages' has more than one output! Using the first one.

Yes, these are harmless and will go away with Meson 0.55.1 (from either
distro or submodule).

Paolo

> Command line for building ['libcommon.fa'] is long, using a response file
> Command line for building ['libqemu-aarch64-softmmu.fa'] is long, using a response file
> Command line for building ['qemu-system-aarch64'] is long, using a response file


