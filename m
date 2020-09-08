Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217AAC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B046521532
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0qUANNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B046521532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFXCI-0005Em-TV
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 02:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFXBi-0004Tw-TZ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:33:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58121
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFXBh-00061E-CU
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599546784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Mx+i/CAEmHQD9/6990BPPTRz7WSPGtUccLUMYl1Oys=;
 b=e0qUANNRsxutDdt1Oq5aWDSsqYq3wPvJMy6aarrdkS9rvzZfFaN1nKiMDvpbz/+7hfV2XQ
 hgaH5C/ywRLGYTl61xmThqi+NJMVnLoLwHh2w/iyQ09BvYVCvcGhkRpIf88I9Sg+2OWD2U
 huFOTDA0z8KAYKc92HWaZC/yzbIKZmo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-hNE6Jd0oMniB0rIHjardiw-1; Tue, 08 Sep 2020 02:33:02 -0400
X-MC-Unique: hNE6Jd0oMniB0rIHjardiw-1
Received: by mail-ed1-f72.google.com with SMTP id m88so5811828ede.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 23:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Mx+i/CAEmHQD9/6990BPPTRz7WSPGtUccLUMYl1Oys=;
 b=GeF37/zZ/Th4b+SbD/EJ8ws1oiw7uyTHFZNW2Ei+tbr3Q4TCvMQvWaws5Mriare2fW
 EjXqSWEk+BRlCOTuzvg9WWXKFndNkJCuO50k18WYSsIRv40gJ4qPpgm3S2c1hpXYacgd
 hEFbYqbgqF6Rv074VX9PV18cheyOPBVdqEfgIyTy2bEuceBuPND0jm1IEOdYRcM4/JO4
 6IFGFFRr1BhV+eNOhKqNmj8o1/ftKo9BePkCndb7pk01iLc6VIrMWhQVwKl2LRXV/anm
 cI71mu+1gGNaL2uA5UHo4K1+NDGY3VoFfv5jcVTl87D3VJqtZkVt7MFnc/18GpkFBwJ7
 33Zw==
X-Gm-Message-State: AOAM5323Gn/XAPCzzlah5FX/FQ+BL1K9AgeWyVydyIimpZ8CDnHP9vZH
 WfVYlnKy4OOA+IekLw7twfnq+/HikwUdupVa+RNVSHfTSrX8wKdTSzqLA7y6HKCIm9G35/fatWA
 d5QQDA944xIb7RzE=
X-Received: by 2002:a05:6402:176c:: with SMTP id
 da12mr26145956edb.386.1599546781492; 
 Mon, 07 Sep 2020 23:33:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvHt+5itYUZWg9DT5CwKoNfRsH2ONtTqIQNuVprTOHII/YK0d3ivdMZ32mJ7xct8fJAy0j4w==
X-Received: by 2002:a05:6402:176c:: with SMTP id
 da12mr26145939edb.386.1599546781327; 
 Mon, 07 Sep 2020 23:33:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11f8:efae:c014:c93e?
 ([2001:b07:6468:f312:11f8:efae:c014:c93e])
 by smtp.gmail.com with ESMTPSA id v2sm5258827ejh.57.2020.09.07.23.33.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 23:33:00 -0700 (PDT)
Subject: Re: [RFC PATCH] cpus: Initialize current_cpu with the first vCPU
 created
To: Alexander Bulekov <alxndr@bu.edu>, Peter Maydell <peter.maydell@linaro.org>
References: <20200701182100.26930-1-philmd@redhat.com>
 <CAFEAcA8ZKEVySwDAQ+x9xA9bosOs5q20CZLZjBvkXj_d6ZVBuA@mail.gmail.com>
 <20200907203505.hpq5v32gayc5o5yd@mozz.bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dfac2489-3c4a-aa44-c38b-435db5b0fd2c@redhat.com>
Date: Tue, 8 Sep 2020 08:33:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907203505.hpq5v32gayc5o5yd@mozz.bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/09/20 22:35, Alexander Bulekov wrote:
>>> RFC because I believe the correct fix is to NOT use current_cpu
>>> out of cpus.c, at least use qemu_get_cpu(0) to get the first vCPU.
>> Yes, I agree -- I don't think this is the correct fix.
>> current_cpu is documented as "only valid inside cpu_exec()",
>> ie if you're actually on a vcpu thread you can use it, but if
>> you're not on a CPU thread, like the monitor, you need to
>> say which vCPU you want to affect. For the monitor, that
> Following up on this old thread.. Does qtest count as a pseudo-vCPU?
> Since qtest already uses first_cpu for all of its address_space calls,
> would it be appropriate to set current_cpu to first_cpu in qtest's
> initialization? 

No, current_cpu should never be set on non-vCPU threads.

Paolo


