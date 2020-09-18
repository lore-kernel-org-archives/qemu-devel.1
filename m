Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562DFC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6EF72100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnS4BBgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EF72100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBSB-0007q2-Om
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJBPV-0006hl-UN
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJBPP-00031X-Nd
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600416377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZnqw1/KKXZjsaF2mD517QLmYFDIZSWV2QJ3kGg7WlQ=;
 b=GnS4BBgfq0COJywgdfubGm0U20ncrYlwV9AwhElDF9KWzv46QhPOpYisELYYmdY+K0UH+G
 wpEBkp9mOFDTI8EuP6Nkd6GmCLCQNXzyIJ6YLQn3gfAijNm03isktxHPTj3Y//iUsml6t0
 hKXzaKCdgEBKkaY8EJadbNY32zAAWuM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-i9FWf7YKOp2fgDbOn3XwLw-1; Fri, 18 Sep 2020 04:06:16 -0400
X-MC-Unique: i9FWf7YKOp2fgDbOn3XwLw-1
Received: by mail-wr1-f70.google.com with SMTP id r16so1824830wrm.18
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OZnqw1/KKXZjsaF2mD517QLmYFDIZSWV2QJ3kGg7WlQ=;
 b=Vi7R7pLuQ5/kLRm6+ptPi21vtrOXRQgA180TMU205Fn+kInERtG4Rb/a3o7GVWIyxE
 bsI11z5AsDfGh4Atgxh4ncxcaC+tgV5vT8p08Zwmg78yGxh7/1HigaF2fvb8HkOadJbE
 kYh9ZR1StTJpBXZUH7sjJkO9PgL3W53fE2FdfRuKF4sveDpkD0PDEyzK9rEjeL+ZR6r4
 pP8WiWIeIezoZ22B7Qtx2rhJcsDcnl4qCDA72MA1s/hxPgNM08ojmMxAMIkW6iJAPNGV
 Ws9iGhau3TbbPwtXCA1zQPWJdvKa12HAh8r+VDROEaALfQagKXgXUN4diGIMuUWq4pS0
 rqCQ==
X-Gm-Message-State: AOAM532ZdfeF5Ly7bXK1PdcGgRCRdX0Uj6hLGmyEW9ddLkzjcs4LZ5QK
 SO+SL82aSiXwfPI0Js6uG2Ohs7zxSwuWDiVwk8lkPxTkBrkCgbODxqOrmNlVnxVgjMs9iNdICHp
 3apG2GRda0llAH0w=
X-Received: by 2002:a5d:60c6:: with SMTP id x6mr3043063wrt.157.1600416374698; 
 Fri, 18 Sep 2020 01:06:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR1MooCbvmuyGHwmxB9It3mUbdRfGze36mp/Gh+54Vc4aW9cmI7Vp0PlHooYIXP2R+ggITqA==
X-Received: by 2002:a5d:60c6:: with SMTP id x6mr3043006wrt.157.1600416374218; 
 Fri, 18 Sep 2020 01:06:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:69b4:4715:609f:385f?
 ([2001:b07:6468:f312:69b4:4715:609f:385f])
 by smtp.gmail.com with ESMTPSA id u17sm3998596wri.45.2020.09.18.01.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 01:06:13 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: avoid error on cover letter files
To: Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200917170212.92672-1-sgarzare@redhat.com>
 <d5a967e3-ab0d-621f-45fc-d2d4a2bc116b@redhat.com>
 <20200918070524.kc7y4rbtkuzw2ccl@steredhat>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <29551205-9aff-07c3-cd13-2b01169029ac@redhat.com>
Date: Fri, 18 Sep 2020 10:06:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918070524.kc7y4rbtkuzw2ccl@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/20 09:05, Stefano Garzarella wrote:
> On Thu, Sep 17, 2020 at 07:44:21PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
>> On 9/17/20 7:02 PM, Stefano Garzarella wrote:
>>> Running checkpatch on a directory that contains a cover letter reports
>>> this error:
>>>
>>>     Checking /tmp/tmpbnngauy3/0000-cover-letter.patch...
>>>     ERROR: Does not appear to be a unified-diff format patch
>>>
>>>     total: 1 errors, 0 warnings, 0 lines checked
>>>
>>> Let's skip cover letter as it is already done in the Linux kernel.
>>
>> .. "commits 06330fc40e3f ("checkpatch: avoid NOT_UNIFIED_DIFF errors
>>  on cover-letter.patch files") and a08ffbef4ab7 ("checkpatch: fix
>> ignoring cover-letter logic")."
>>
>> Maybe complete with that ^^^ ?
> 
> Yes, it's better ;-)
> 
> Should I send a v2 or can be updated when queueing?
> 
>>
>> Regardless:
>> Reviewed-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
> 
> Thanks!
> 
> Stefano
> 

Queued with the fixed message, thanks.

Paolo


