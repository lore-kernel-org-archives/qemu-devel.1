Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3CDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67BD20885
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czq6v85R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67BD20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CvJ-00027e-Pp
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5CuT-0000qC-IL
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 14:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5CuR-000725-TY
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 14:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597085554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mljwdzpkvZXFk3jxQyVSbOazrNPmNdkdAsfneQ0PHG8=;
 b=czq6v85Rpp/3kIF9/kDYlSXWLhLz8yILwDcKlmIONoryXN0sOwY3RhtDn3v/W+Gmau3iam
 H8+zBFt6cZdUog9SL020LDNEncm0RrrMXBLNYs6YQxFuhbltqmnwZ5A+jRmdlInlw/cDeH
 6KJjDh3RtMW+EloDNmF5HIl78gu8X6o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-M1gAQlXyMt-nJBpSXng8Hw-1; Mon, 10 Aug 2020 14:52:32 -0400
X-MC-Unique: M1gAQlXyMt-nJBpSXng8Hw-1
Received: by mail-wm1-f70.google.com with SMTP id c186so90560wmd.9
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 11:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mljwdzpkvZXFk3jxQyVSbOazrNPmNdkdAsfneQ0PHG8=;
 b=gjhxYT3SJ6gKsvIGQcoz04sipFi2zKPqdo5f019pMfzrBOrYk7cCnJG3lYrPU0mkbT
 ljDceAK6Tbv00ElnAN3Rv2+ymmDeLQWf2t69kihaPTyPkA0bL+f1TgIPvlkuaa9ib9+G
 27Nv5mThchcAibXVbSBuReShBPGmgNF8Bt5BQl68oMST1TvPa2nUXG04w1Pdt1EyH2S8
 9k/FYlQkeJoXFT0pTcrOxv0A2vjEBU+XTzL8JYjhe3J3PJQmrnfp4oFHpGHnami7bTSh
 zjB0bjsR3+ATcTyGbSxdDwnz4WEdPT2kKZu50PHwPE0qXlKgtl/kF9SwC8Bxo4dubyvk
 rP2g==
X-Gm-Message-State: AOAM5309mp2WL5b8Z/GrOvQmiPWTHbzjvziP3fzhWHLmKcoglvLunWRL
 VgocHYvzTMj0117uLDwfB0Bap/FYxrcA3aoS13uxcogJDT63khN7mdbxHueCcwAenL4C9OeukGI
 ZNk9Xdlj5LZwbAAY=
X-Received: by 2002:a1c:65d6:: with SMTP id z205mr587089wmb.2.1597085551538;
 Mon, 10 Aug 2020 11:52:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylR9zFsglb20XkESE2NlMJ8gcPPo09llJICXwF/ypn/OVZnaDb9YPWihLo6dRYFX3hfICfaQ==
X-Received: by 2002:a1c:65d6:: with SMTP id z205mr587075wmb.2.1597085551284;
 Mon, 10 Aug 2020 11:52:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103?
 ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id g145sm1079715wmg.23.2020.08.10.11.52.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 11:52:30 -0700 (PDT)
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Peter Maydell <peter.maydell@linaro.org>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
 <CAFEAcA-RULUBoTtkr3JWUhujfXYbcaj9+v-UBjdTAMcda7FDAA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f98dcf94-6b95-5b71-2eff-f777e34becf0@redhat.com>
Date: Mon, 10 Aug 2020 20:52:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-RULUBoTtkr3JWUhujfXYbcaj9+v-UBjdTAMcda7FDAA@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:11:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/20 20:14, Peter Maydell wrote:
> Linux x86-64 succeeded but produced a bunch of warnings:
> 
> ../../meson.build:9: WARNING: Module unstable-keyval has no backwards
> or forwards compatibility and might not exist in future releases.

This is unavoidable (it's fixed in 0.56.0 but will warn in 0.55.0).

> WARNING: custom_target 'shared QAPI source files' has more than one
> output! Using the first one.
> WARNING: custom_target 'QGA QAPI files' has more than one output!
> Using the first one.
> WARNING: custom_target 'QAPI files for qemu-storage-daemon' has more
> than one output! Using the first one.
> WARNING: custom_target 'dbus-vmstate description' has more than one
> output! Using the first one.
> WARNING: custom_target 'tools man pages' has more than one output!
> Using the first one.
> WARNING: custom_target 'system man pages' has more than one output!
> Using the first one.

These will be fixed in 0.55.1.

Paolo


