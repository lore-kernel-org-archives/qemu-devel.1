Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD64C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 12:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DE0206D9
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 12:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imvZlZZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DE0206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juEUi-0004S5-NX
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 08:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1juETm-0003xU-VQ
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 08:19:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59164
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1juETk-0005gz-Nd
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 08:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594469979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJZtRYqdkWRocN9BmUHg5yuJyxIHFzdEmtK8c8HET3Y=;
 b=imvZlZZSEd0bJ9GQyZXrW6mtbpXTUcuoppO3v17HUzHvE4R+HW/U/IIuiF91tlhRcW6rWE
 oB15bEZ9qqjW+Rc+UbWK1xPsUPj0/b8cGXB/0MbP0mrwatnkeJxUw4KFMRqrFWgh0g7Imu
 UuGGSk/KGg4MdUjeCGRrmCARGZC5Das=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-74PCk5Q5P7-prfEvDCK4fg-1; Sat, 11 Jul 2020 08:19:15 -0400
X-MC-Unique: 74PCk5Q5P7-prfEvDCK4fg-1
Received: by mail-wm1-f71.google.com with SMTP id g6so10694826wmk.4
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 05:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RJZtRYqdkWRocN9BmUHg5yuJyxIHFzdEmtK8c8HET3Y=;
 b=XDLomndm9cAQuIAA+2ns0Es4ze6kAZ5+eWxWbpDqGactQCGzwd3o8MZ3uBPP5X9Vhf
 mMHFqzI30LLF94BOvuYxueO/WZngx9oG+ATOEQq2G0Qq66uwLNABkmbGAS3rGOJwIIKP
 URdlYLnZoZwTRyUhUhqI/XyqvsQA3RhBzR7gvQu485eRe9X8/xzLw6ueevK8WTDdzxhQ
 sST+kH86PKbN87wWcMP5ivRAjMHE7cAaEsl7eajG1xwIBimZNFmOlqWtgP70gmxpJtv+
 Vi/YjSQLtIom8kGyryNwV/6XlBmKj9NdOuNAGgVwvCgVU2b2bfpZ9xzPa+0z3B3lhFvK
 790Q==
X-Gm-Message-State: AOAM531wzggCVjyXdYHGWT/+OtQ4Aj0rmLfVPI9/qiXRorNFhHRAYGqB
 3WMb7GrbgB8Z3HlOGVgSuXjsoA8rb7n4GCHTE8v/RybAy74wZzoZGUFYifdk2sJ+h4mkhUjOgSG
 RECi7gSsUDGcz3Tc=
X-Received: by 2002:a7b:cf10:: with SMTP id l16mr9834060wmg.93.1594469954109; 
 Sat, 11 Jul 2020 05:19:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGXqsH2Js+wLcGifY2tBjw7eS/iBaRx9GpqqC+YkEvlKLnYpFIuhZ1TpjfrTuWT1+g7vzjUw==
X-Received: by 2002:a7b:cf10:: with SMTP id l16mr9834035wmg.93.1594469953853; 
 Sat, 11 Jul 2020 05:19:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ef:39d9:1ecb:6054?
 ([2001:b07:6468:f312:ef:39d9:1ecb:6054])
 by smtp.gmail.com with ESMTPSA id w17sm14226127wra.42.2020.07.11.05.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2020 05:19:12 -0700 (PDT)
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-4-cfontana@suse.de>
 <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
 <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
 <ecf5f26b-ce86-3e13-5c5c-567919433acb@redhat.com>
 <e9dca3d1-f52d-13ce-2d7d-66958bc15765@suse.de>
 <996dc455-548e-5964-9c87-f4abe5b63907@redhat.com>
 <146b0cf2-509b-6a48-e82b-b93740e4c60d@redhat.com>
 <e3cc11a4-8ba7-917a-844b-4f6ec69d140a@suse.de>
 <76aac4ac-40f5-4870-ed2b-bab8b68b0a64@redhat.com>
 <9630c685-0a37-a1e7-4614-9d692988a799@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <22228280-f3b4-3f64-d2ba-30cfc47c8b0d@redhat.com>
Date: Sat, 11 Jul 2020 14:19:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <9630c685-0a37-a1e7-4614-9d692988a799@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 08:19:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/07/20 13:49, Claudio Fontana wrote:
>> Apart from the name, icount is more like deterministic execution than
> 
> Maybe we should start choosing names more carefully in a way to express what we mean?

I don't disagree.  For icount in particular however we're about 12 years
too late.

>>  qtests need to be deterministic and
>> describe which qtest instructions run before a given timer fires and
>> which run after.
>>
>> And in both cases, determinism is achieved by controlling the
>> advancement of QEMU_CLOCK_VIRTUAL.  It's only this central component of
>> icount that is shared by qtest and TCG, and I think the problem is that
>> this patch conflates all of them together:
> 
> I think that the existing code in master conflates them together actually.
> Qtest can have its own counter, it does not need to be the icount
> instruction counter.

If you want you can add to your accelerator ops series one for
qemu_get_clock_ns(QEMU_CLOCK_VIRTUAL), cpu_get_ticks() and
qemu_start_warp_timer(), that would certainly work for me; those three
are the only non-TCG-specific functions that read use_icount, as far as
I can see.  qemu_start_warp_timer() does have an "if (qtest_enabled())"
even, so it's clearly fishy.

It may even be a good idea for TCG to have three sets of accelerator ops
for respectively multi-threaded, round-robin and icount.

My point is that this patch is not the right way to start the
refactoring because *for now* it's wrong to treat icount as a TCG-only
concept.  Having more separation between accelerators, as well as a
clear interface between core and accelerators is certainly a laudable
goal though.

>> - the basic "is QEMU_CLOCK_VIRTUAL software-driven" part is embedded in
>> qemu-timer and should not be carved out into a separate module.  This
>> includes the use_icount variable, which should be kept in core QEMU code.
> 
> I don't see how this follows, how is using a global use_icount variable better than having this checked using icount_enabled()?

If you can get rid of use_icount using a new accelerator ops member, it
would be even better. :)

> I will come back to this later on, this patch seems to have uncovered an underlying issue, which shows on s390.
> 
> I'd rather now continue investigating that, choosing to try to
> actually understand the issue, rather than hiding it under the
> carpet.

Thanks.  But I don't think it's sweeping anything under the carpet; it's
great if we find a currently latent s390 bug, but it is orthogonal to
the design of that core<->accelerator interface.

(And by the way, my suggested patch to icount_enabled() was completely
wrong!).

Paolo


