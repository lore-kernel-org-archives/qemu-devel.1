Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C41C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5957C2236F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiDfBJhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5957C2236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxIG-00054C-W8
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZxFs-0004AC-Cy
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:25:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZxFk-0003Mw-Iq
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604413539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G1ekMKiFFOFA3XZPdhRJ2cVSZfvCWpqL24l8RM2oTKw=;
 b=ZiDfBJhMSk2ZWDfV06vNhQBUQuRKcCgL0Br/kNrPWDKMr9AWM8aRTNXLeAgCoWHRkLBXAl
 gSV4uYttEsFJEAq9aecofChYG8fVt5tlhEhax92Od/bgUKBPdkHpmKUJO/ygljvSPgy+Gw
 USqtLp7WanheVGeliEi++ONckUOhu9Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-VLBUFroyPeeYFEqslXAqUw-1; Tue, 03 Nov 2020 09:25:38 -0500
X-MC-Unique: VLBUFroyPeeYFEqslXAqUw-1
Received: by mail-ed1-f70.google.com with SMTP id u12so7507814edi.17
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G1ekMKiFFOFA3XZPdhRJ2cVSZfvCWpqL24l8RM2oTKw=;
 b=OSiwzwCwPWKXDmtzIfLR16yNvBFDS7pH9mp5fzBhxC2yXHO/FLXjhU46PHcUyOzmfz
 yZV1pvmrLyaP4QHgroQw6teSrXZLNkLtYUBdV785K9IfQiq/uPhOHPMMucih68DCuaeJ
 v7bRxmkIiHYWQ0BScNqtECbEeltuC1RflwMM81ayijBh4Z4iWnZLNbJP5kTZNQAmTNZ4
 VD9bvvZZKJ8MxnaNTQzmMppo1wDCnoDf4pd0F43/WF2AfhqIuQ0pY75UvpLJOPSZmFnv
 Ya5QJmLzUribyaCaoLMB7mzEKf8UJ81sid3fSEhh6vd/7lH1unbPM21SFw/yl7XqWkAu
 pI2w==
X-Gm-Message-State: AOAM533Xdp2wzfkPY+VUviGp+XYA9Nn3WmM8uwNwTrK7QFB1TnAP7d+d
 LvLehiKjHth+wGexX3hYvIZTQguXYmLpi6bSSu+vKpNhokQ0OIiIAVQ/vaKr2KnUTGqejWCSAoX
 64RNy4yynQ11IVWw=
X-Received: by 2002:a05:6402:150:: with SMTP id
 s16mr21176439edu.304.1604413537069; 
 Tue, 03 Nov 2020 06:25:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9pmFBMfUU00H+TXLW6MjfdDGVlqnbnMfH4HZJrVBWfoTICICA4QvXOLsEt/ecwxrePj+A0w==
X-Received: by 2002:a05:6402:150:: with SMTP id
 s16mr21176427edu.304.1604413536861; 
 Tue, 03 Nov 2020 06:25:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id j3sm12204104edh.25.2020.11.03.06.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 06:25:36 -0800 (PST)
Subject: Re: [PULL v8 062/152] meson: infrastructure for building emulators
To: luoyonggang@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
 <20200821102329.29777-63-pbonzini@redhat.com>
 <f896a0d5-721e-2346-58c2-38e26c2c352e@redhat.com>
 <CAE2XoE9vwFNdJ4NAQXeNEDJkEEiLSXWqf8_dsKKx3FzKpsvFcQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c7568f79-2f5e-7f73-c9bb-87dcea7c4519@redhat.com>
Date: Tue, 3 Nov 2020 15:25:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAE2XoE9vwFNdJ4NAQXeNEDJkEEiLSXWqf8_dsKKx3FzKpsvFcQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/20 15:19, 罗勇刚(Yonggang Luo) wrote:
>> > +#include CONFIG_DEVICES
> Mybe add config-devices.h back and detecting the target_cpu and include
> it properly?

We could add a one-line config-devices.h that contains "#include
CONFIG_DEVICES" if desirable.

Paolo


