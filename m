Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7267CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 22:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2A42078E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 22:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dD5EsRU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2A42078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS6Ke-0007AQ-Ni
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 18:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS6Jo-0006jO-DL
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 18:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS6Jm-000883-Be
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 18:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602541761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDm2RVIEmJKiZ0QHTD8eSO1M/is16F/0kpgeqGx4P4U=;
 b=dD5EsRU8tVuyFbF6f2l7Qhcluc8uH9GY3Lo1UNhF1RBT3as4hcJmaeGOhjXRwqyEnge4bM
 Yi6G3Wmo70vxgbzqcMNcrowi75OsEq7ui6CJBghnKmhH8SlnphcjbcEXDw6Hcdhnviqfbz
 MVpy30CMYunX/fANMIcWgsMDLps6FfI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-0QjgKP5-Pri9aLmdtpRSbA-1; Mon, 12 Oct 2020 18:29:20 -0400
X-MC-Unique: 0QjgKP5-Pri9aLmdtpRSbA-1
Received: by mail-wm1-f71.google.com with SMTP id u5so5476147wme.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 15:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cDm2RVIEmJKiZ0QHTD8eSO1M/is16F/0kpgeqGx4P4U=;
 b=BknLblwppt7Wb+Ra58U/u3f6WceLhejgudvh6QBuCoxOqHaa8zPmpNuoJy/xnZlA7k
 ZHEct6wmBgGLYHMwJWRYSAVPjNdqxJGN55d5eF8jpLQhGeGUaCqXtWeb2EcX7m69jzmd
 Bva9u5/FKfT/Knp40E3f8GNaOPThaIeS4JgQX2PInkN5l7TgJ8O6j07+d7EkdkXYwRO5
 Ij93uM2GHZzbzufrVt1eOOybO+Bfn3mZ2JQyGfXMdHMyyxPmHLPfWPSIKPitUtpumgAU
 atW11EsZrFZlp1yhlx1q0/upk85y5aNNNxZW6ysq5aLzDkEA2Wv8zI3v+CkEfGl2vf/c
 Mmqw==
X-Gm-Message-State: AOAM532k+3O2wAb1nrKSCHxsN8maLxrpmFQ7mAG85VcX3LnTMdo7BDnF
 95SkraCiH+NFosC6KRRhOM9TR3mqIq7NukfShyGrzNUV32CqvC5bpXwNQDhxfguxLWnhjqby5/q
 8mx7aDFDPYTfzk7c=
X-Received: by 2002:adf:c50c:: with SMTP id q12mr31511370wrf.17.1602541758815; 
 Mon, 12 Oct 2020 15:29:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUxfMl4pDLLyAJCtOXjmnPm77/N4BF+PLmWXVcbnm313GMLQLHs9a4rsceKwD33Zr6z2rqBA==
X-Received: by 2002:adf:c50c:: with SMTP id q12mr31511355wrf.17.1602541758625; 
 Mon, 12 Oct 2020 15:29:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5a47:91d0:18ce:e295?
 ([2001:b07:6468:f312:5a47:91d0:18ce:e295])
 by smtp.gmail.com with ESMTPSA id y66sm8117300wmd.14.2020.10.12.15.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 15:29:18 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] replay: do not build if TCG is not available
To: Claudio Fontana <cfontana@suse.de>
References: <20201012214527.1780-1-cfontana@suse.de>
 <20201012214527.1780-4-cfontana@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <22f05da9-311b-d8e7-0052-2163f9e6c1e8@redhat.com>
Date: Tue, 13 Oct 2020 00:29:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201012214527.1780-4-cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/20 23:45, Claudio Fontana wrote:
> +    ctx = blk_get_aio_context(blk);
> +    if (!replay_bh_schedule_oneshot_event(ctx, error_callback_bh, acb)) {
> +        /* regular case without replay */
> +        aio_bh_schedule_oneshot(ctx, error_callback_bh, acb);
> +    }

Why can't the stub just call aio_bh_schedule_oneshot?  This makes the
API even more complicated.

I think you are doing this in order to avoid link errors in tools, but
it's not necessary. you can have more than one stub file:

- replay/replay-stub.c for functions needed by emulators (added with
"if_false:", it also includes the monitor commands);

- stubs/replay.c for functions needed by tools (including
replay_bh_schedule_oneshot_event which is currently in
stubs/replay-user.c for some reason).

Paolo


