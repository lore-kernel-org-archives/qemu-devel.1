Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBE2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81FB20866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXrUxjyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81FB20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xJf-0000Xl-OU
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3xIN-000803-BK
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:00:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33006
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3xIK-0008Th-Os
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596787203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSCI9jIdtk1xMgj1+n9x4n4soq+4Tizy9wMVUrrTBhA=;
 b=YXrUxjyOux25ske9bEAfcB8Kaa6l0bb+rseEq1E5JMHVEj8BN9lj8zOSjBOe0/KgjVnFYJ
 PQn1vaN80YWnJcsGshOlOipbBp4XKapfdu5S7ao0cI4f/vLfXIzIyWz/0Wa7ftFpZF6PR4
 aijAfBp5qO+4UveS7qfLixLlTAAspig=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-38YXCX3IPmuIx0V09yVfyA-1; Fri, 07 Aug 2020 04:00:02 -0400
X-MC-Unique: 38YXCX3IPmuIx0V09yVfyA-1
Received: by mail-wr1-f70.google.com with SMTP id e14so423162wrr.7
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VSCI9jIdtk1xMgj1+n9x4n4soq+4Tizy9wMVUrrTBhA=;
 b=Qe0VpEUtMa9ah6b7iDjkeZ5ruemCUidZYrqcgbMYUDNQHc4bMZ5JH+73x/D9T739jE
 izIlphZsz+n67mGVgNgvYMS6ojqx6UWSOWRBUCMZghQD4A32uD1JAfpVJH499/IKsOfE
 +m4IYJ6d3cGllD/vn+Ji1q4SPwsBbPdwd3tzKbiGyh3Ffi6n54PWHrCk+3mb4uItVN9v
 EUvUVpSgoPsiwjk8G7EYeqzqk9OrotOleaVdrfHCgIAGuHtnQwr8bsL32vMJda14hNyx
 VqV9PHRJigOpPejaYUILiSNS/XMiGbHamK/vR4A+f5er5/GEYSXAtr9LUAR/HDfO9uqc
 oIZw==
X-Gm-Message-State: AOAM533orZTtQPJ7EbDPVGQgdWJt0cVSHFIkHlQwTdtB0KOa00NNHzZV
 KxJdNo/VKFiakxyvlZXAVjBH5z2oXoh93Ug4VarbvA2472mLdgczapooSzImTj86kC4YEaX6uCK
 unY9El9XmRP6IlWc=
X-Received: by 2002:adf:d84c:: with SMTP id k12mr10778106wrl.250.1596787200523; 
 Fri, 07 Aug 2020 01:00:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzliGO7eemecFmZc+IvhZPDJxrieJTF37AvFs4H6WU7JN9xQgli6ldwA8THvIh01WUQXpeJkg==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr10778089wrl.250.1596787200268; 
 Fri, 07 Aug 2020 01:00:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id g126sm9425014wme.16.2020.08.07.00.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 00:59:59 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Cornelia Huck <cohuck@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <20200807085302.7d7616df.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <499b18ae-b15d-abbb-faf5-d9bdd5262fa4@redhat.com>
Date: Fri, 7 Aug 2020 09:59:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200807085302.7d7616df.cohuck@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, alex.bennee@linaro.org,
 stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 08:53, Cornelia Huck wrote:
> So, I was planning to give it a go on s390, but I cannot even build it
> on x86 (fails configure):
> 
> Build started at 2020-08-07T08:43:43.873638
> Main binary: /usr/bin/python3
> Build Options: -Doptimization=2 -Ddebug=true -Dwerror=true -Dstrip=true -Db_pie=true -Db_coverage=false -Dsdl=auto -Dsdl_image=auto -Dvnc=enabled -Dvnc_sasl=auto -Dvnc_jpeg=auto -Dvnc_png=auto -Dprefix=/usr/local -Dbindir=/usr/local/bin -Ddatadir=/usr/local/share -Dincludedir=/usr/local/include -Dlibdir=/usr/local/lib -Dlibexecdir=/usr/local/libexec -Dlocalstatedir=/usr/local/var -Dmandir=/usr/local/share/man -Dsysconfdir=/usr/local/etc
> Python system: Linux
> The Meson build system
> Version: 0.52.0
> Source dir: /home/cohuck/git/qemu
> Build dir: /home/cohuck/git/qemu/build
> Build type: native build
> 
> meson.build:438:22: ERROR: Key must be a string.
>   config_target_h += {target: configure_file(output: target + '-config-target.h',
>                       ^
> (Fedora 31, version from your github branch)
> 
> Is there anything special I need to install beyond meson?

You probably need to do "git submodule init"/"git submodule update" so
that it picks up the in-tree meson (0.55.0).

If you want to test on s390, just testing the boot ROM would be great
(patch 3).  That one does not need Meson at all; the purpose of the
patch is just to decouple the boot ROM makefile from rules.mak, which
allows to drop some of the contents of rules.mak.

Paolo


