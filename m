Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADCAC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD925208B3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekaike70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD925208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDUzz-0007oM-RF
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 11:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDUxS-0006Uy-Vu
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDUxO-0004z8-0e
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599061553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXA6rZqg/WoItYJww4GPW/AeiPTAcoEqwDjLWEg70x8=;
 b=ekaike70HCqKLQ6SNum07iJT9YHc7cKOTtq4uQ2VQW6dSbnDmCUfe679vENfP36L/H1HUc
 UenyaBhiE+SNj6WRYAurM+l2RFTR4mgNoxhEAm7sePAMRep30DBP1lUJFnZqrKmaH6siRM
 zjxMYWwGJYRTk76nQrIhjM2Wvp2JdQo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-GfwimuGnMNGWUz9P0bSlfA-1; Wed, 02 Sep 2020 11:45:51 -0400
X-MC-Unique: GfwimuGnMNGWUz9P0bSlfA-1
Received: by mail-wr1-f69.google.com with SMTP id k11so2220026wrw.16
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 08:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wXA6rZqg/WoItYJww4GPW/AeiPTAcoEqwDjLWEg70x8=;
 b=bYD5akz0AJfYOUouTrqyyjy5y7sxaTa82lMy+PSamuBkyHm4f7Yb/apMSUdgydCsS2
 kweEsc3dAZma5nOHrBVc2sYzel0PLMzYaEqQ7kmCJ08YkLVqGAOQMxCnMd6OOCPOywap
 Rwuh2jV5Gz1w4yCfDy+P22u0gq7jjWk+hdMGzm2VV+G2T3wwZHmEc5z57GBEWm8auU9k
 2oMuSPdSkm3Yzn6VwOgupZmKblQUOEA+/wia/XPk6WHLKhr4VwUhJRhbfVIV+FEAyqxF
 wagaEnFixQIgjZ7eKaytrgRPZw+0Be/JlcfZm+HjQocAi/Irx0eSY71uVL2Esk4zO/F2
 w9Hg==
X-Gm-Message-State: AOAM533dpbN9ByF9GM4DJDFWliOJosu4CZx8H4cSvFEQNk5VorY23Rd/
 L25qhNZ2DZYtFILuG5EXwVEW24zlW3v9uSBqSQO28zzuobbTPklguJc5+Lf6K+DubROWtZ9HZMX
 7XVTocPAE/L8eBy8=
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr7681930wrm.120.1599061550642; 
 Wed, 02 Sep 2020 08:45:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6eZ5ASZ2HcQEUPs2j7PL6KI8oQGRzSJa5A6OAK5yRimpSu+FuLS0g4BBusnoQ/6YUMzaz1w==
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr7681914wrm.120.1599061550424; 
 Wed, 02 Sep 2020 08:45:50 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id b2sm50737wmh.47.2020.09.02.08.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 08:45:49 -0700 (PDT)
Subject: Re: [PATCH 1/3] meson: specify fuzz linker script as a project arg
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200902143800.124073-1-alxndr@bu.edu>
 <20200902143800.124073-2-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <715bb0c0-554d-e170-9561-50bedfdfbfe4@redhat.com>
Date: Wed, 2 Sep 2020 17:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902143800.124073-2-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, darren.kenny@oracle.com,
 bsd@redhat.com, Thomas Huth <thuth@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 16:37, Alexander Bulekov wrote:
> +# Specify linker-script with add_project_link_arguments so that it is not placed
> +# within a linker --start-group/--end-group pair
> +if 'CONFIG_FUZZ' in config_host
> +   config_host += {'QEMU_LDFLAGS': config_host['QEMU_LDFLAGS'] +
> +            ' -Wl,-T,' + (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')}
> +endif
> +
> +

Also -- sorry -- please use a separate add_project_link_arguments
invocation.

Paolo


