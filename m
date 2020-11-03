Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613A3C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA8622264
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9TGRA+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA8622264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlzC-0005YJ-Hc
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZlpP-0006p6-AN
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:13:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZlpN-0004HN-63
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604369620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2uhxatJpu1OagIjqsClnDPiw5oxNIW109bQJVj/nybo=;
 b=e9TGRA+WTUbqe1jcf4XbEa+jonnPTMffoIgO9uI/UENLGt1QFX2jukP5j8eelJXrNfhGSY
 8rnVrK9lLZQoL6WfKtrsWnDZYwXjT7OCDiV41DkwzTaChbaHKnrN9sNg0r0G1b3Ee89+2+
 bBw5lfPG8GUPI1Owqa6n18TF8reHOxI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-ciEY69Q1PSCG2cz15cCfhw-1; Mon, 02 Nov 2020 21:13:38 -0500
X-MC-Unique: ciEY69Q1PSCG2cz15cCfhw-1
Received: by mail-wr1-f71.google.com with SMTP id i1so7187214wrb.18
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 18:13:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2uhxatJpu1OagIjqsClnDPiw5oxNIW109bQJVj/nybo=;
 b=bADOmN+EHgilnS/H0UXkIe3hHJ2U//M3fxQWBLYpa0ANNxS1NSS6KJhG+Lyl+LKj8r
 2Giu55wz7OCC2gMURQ37ddAlY3RVyPvIVJwOHAUwo1CQ1FW+vWQFZ9mF35d7RaKvp0u7
 Ellhh6HoEfJvvy8fVBvEBoRBY3ehiQQmCnISrKbHwR0dPFNO9Yg39TMjTcr44n0lMdIb
 1V6PKmumDKSn8/oA++HEBdX2dtAvJBm4CgigijNOYGlmmxTLVBE3UIOo64CEEVEOzWG+
 gCkVZlC4pv+PrVD7ySaSZ+fcAWZNR8I8zdbMdQT5iBqlJdOIPf3qUd8PYvDsxqa3jpkk
 k7Qw==
X-Gm-Message-State: AOAM532HRojpVVFycG4vS8akfZ73N299BsFalTNrYW8q3DuY5ukLxbvl
 nQ29vVZfHot6NNpZN/ucmwd/Bpx1jOdkLPmMU4g8hvONtgmGobh1ZjVUaTs/Kka01kXTmMST5Jx
 S5viKcIKEpwlqXC8=
X-Received: by 2002:a1c:9916:: with SMTP id b22mr992150wme.105.1604369617317; 
 Mon, 02 Nov 2020 18:13:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxtVGs5GWJcuEwd5W2DlyX/BauNPqfTL7BAuB/5luYXHIblrbohUFLZrfwcsngLQAm9CONRg==
X-Received: by 2002:a1c:9916:: with SMTP id b22mr992129wme.105.1604369617141; 
 Mon, 02 Nov 2020 18:13:37 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t23sm1274051wmn.13.2020.11.02.18.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 18:13:36 -0800 (PST)
Subject: Re: [PATCH 3/6] util/qemu-timer: fix uninitialized variable warning
 in timer_mod_anticipate_ns()
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201103015228.2250547-1-kuhn.chenqun@huawei.com>
 <20201103015228.2250547-4-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <37670ee4-d758-0da7-5e2d-b3429e856360@redhat.com>
Date: Tue, 3 Nov 2020 03:13:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103015228.2250547-4-kuhn.chenqun@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:52:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhang.zhanghailiang@huawei.com,
 ganqixin@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 2:52 AM, Chen Qun wrote:
> After the WITH_QEMU_LOCK_GUARD macro is added, the compiler cannot identify
>  that the statements in the macro must be executed. As a result, some variables
>  assignment statements in the macro may be considered as unexecuted by the compiler.
> 
> The compiler showed warning:
> util/qemu-timer.c: In function ‘timer_mod_anticipate_ns’:
> util/qemu-timer.c:474:8: warning: ‘rearm’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   474 |     if (rearm) {
>       |        ^
> 
> Change the default value assignment place to prevented the warning.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/qemu-timer.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


