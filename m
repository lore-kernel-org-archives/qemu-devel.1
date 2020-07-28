Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A575C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8CA2074F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOC5miKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8CA2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Swe-0000dV-Ij
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0Svu-0008D9-Tn
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:58:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49610
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0Svt-00088L-5K
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595955507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=boTmbFwOx6jY1sJGsQU6oAsDMrcnfqRPBEOAdSH2vVo=;
 b=fOC5miKnD1en5N/Rqx5xXp1jUgDq35BHoySiN1e36fPgetrQlzsCFffXL0xYQakVWRtO8S
 7/581eGqUSCUtT0BXADm9bLcatlgb+EfY3wQ1uJffxy4l1EJWMy1xvoAIAoSFAlYpDU3Re
 QXriWUNY/OMW3nr1lltqYEpXhZNW8Ps=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-jjaMYpZcPJ6q3m9I1jzgAQ-1; Tue, 28 Jul 2020 12:58:25 -0400
X-MC-Unique: jjaMYpZcPJ6q3m9I1jzgAQ-1
Received: by mail-wm1-f70.google.com with SMTP id b13so56812wme.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=boTmbFwOx6jY1sJGsQU6oAsDMrcnfqRPBEOAdSH2vVo=;
 b=FxeepPAUPzhQw955ckQvaIbB1d2qmhgIBTTfqwH01Rqsi//S5VywJ5Di2tmlUJyFfc
 j4LJ4GFrjtmx+/nrRAVxZCv53pHydr/1e3XNbuBucemiVqK+e0WlGvQA9He8wvVSHwjK
 5lukCJFqvrLH+dpk/7LJZbeHOgRyzlvIUIacwtsouTFc+xllL/4pU45PPMhBETE9Luwa
 kl+of5phVvLiGKIpvpA98sNVaU26FlBs5VbrfnRNlRQUhDE07OsNLO+Ku3FJuxJT5KHx
 MyaA4QxpEwU5LYK6GXfpzdsWp6DcGa++cbGZnZtpwt0w0bAfkZtCUT98Bq0Xv2e0+IO+
 goMQ==
X-Gm-Message-State: AOAM533inR1lFewL8HNSP/sQtzK4wZkeYfBvLgvPmzrNeOR12M/j7x/y
 UkeNHurc7SZkrxXeMAhFKMcwyXmswWViDNMxtMW2q/Go1scfT4xM9kxGh9ZahstsSI/M/ZVw+kf
 ZVKkIFpg70ffjYKg=
X-Received: by 2002:a1c:9cd4:: with SMTP id f203mr5003357wme.155.1595955504234; 
 Tue, 28 Jul 2020 09:58:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0iZlTuVg7LvsZAhRsaOGQ/KgHhzfxFkZVAFhWTRTfFvyf24zdDNP2AxjPZ0BEukq0Tv3NGQ==
X-Received: by 2002:a1c:9cd4:: with SMTP id f203mr5003342wme.155.1595955503998; 
 Tue, 28 Jul 2020 09:58:23 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id m126sm5254928wmf.3.2020.07.28.09.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 09:58:23 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] qemu-timer: gracefully handle the end of time
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200728141005.28664-1-alex.bennee@linaro.org>
 <20200728141005.28664-2-alex.bennee@linaro.org>
 <f48c70d8-b506-e86c-e0dd-9e0ed2db3d91@redhat.com> <87o8nz39mt.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <859f63e1-684a-f8b8-22a5-770f6cbb150f@redhat.com>
Date: Tue, 28 Jul 2020 18:58:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87o8nz39mt.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 11:04:16
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
Cc: pavel.dovgaluk@ispras.ru, boost.lists@gmail.com, qemu-devel@nongnu.org,
 victor.clement@openwide.fr, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/07/20 18:08, Alex Bennée wrote:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 28/07/20 16:10, Alex Bennée wrote:
>>> +    /*
>>> +     * Check to see if we have run out of time. Most of our time
>>> +     * sources are nanoseconds since epoch (some time around the fall
>>> +     * of Babylon 5, the start of the Enterprises five year mission
>>> +     * and just before the arrival of the great evil ~ 2262CE).
>>> +     * Although icount based time is ns since the start of emulation
>>> +     * it is able to skip forward if the device is sleeping (think IoT
>>> +     * device with a very long heartbeat). Either way we don't really
>>> +     * handle running out of time so lets catch it and report it here.
>>> +     */
>>> +    if (current_time == INT64_MAX) {
>>> +        qemu_handle_outa_time();
>>> +        goto out;
>>> +    }
>>> +
>>
>> Doing this here is a bit dangerous, I'd rather do nothing here and
>> detect the situation in cpus.c where we can do
>> qemu_system_shutdown_request() (and also do nothing).
> 
> You mean in notify_aio_contexts()? Sure we can do that.

Yes, that would work.  I think qemu_clock_deadline_ns_all would already
return -1 so that you'd have a zero-instruction budget from
tcg_get_icount_limit.

Paolo


