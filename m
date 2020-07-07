Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F391DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0361206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A83ZG8BM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0361206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsjYy-0007aH-3x
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 05:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsjYL-0007Al-Bu
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:06:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48680
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsjYJ-00071d-Pn
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594112770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUeXvp1eovrKYcCR02rMI/ZHlaZR8BHNCVOuQemGiaE=;
 b=A83ZG8BMPno+LncxPprRw9CvSNmDDsFag468P9FTgMp+NKR0XzwAHJEBEDQ67iZVFNfqGu
 P6RrWQZh0B3X1dBKrpqskCOnir+pexERfUHPgqzekZaXykOC/ZcSc/qLzlvknim0TLG/vW
 1blRbbTM8psY95OhXat+hwJz8Toztok=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-DEuZG1YoPOaKsUavr22OuQ-1; Tue, 07 Jul 2020 05:06:07 -0400
X-MC-Unique: DEuZG1YoPOaKsUavr22OuQ-1
Received: by mail-wm1-f71.google.com with SMTP id g138so42989749wme.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 02:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TUeXvp1eovrKYcCR02rMI/ZHlaZR8BHNCVOuQemGiaE=;
 b=lKfw1lb44RMIFog8QCCGvjJq4H6vQ8DvTvaw0IO6kcs1JUzuD5aHELnFPlgvQuK+GY
 p11BYkzmN3jBGH6VKiJ5SvWcxWC7V8u52eEJ6PonkxqgGdv8Gk+scTkUHtoP352oX95O
 8R0YoGjplnuaUWxMaambU46Yro+BQCbI3N0bI1Dg1/c/WF+b2FWTInExT/g5uL3JH4pS
 UxnyotBlSDsAlXeZrV+CP9KFQfWxNw+ToN/UCd9dWTXLqDiFDcR0NsOvXPK5iY0dUSpE
 8/wvhjYhKnhgEJZTFDT2drzMXKrGBuYQYG5waoJcK5/dNCRDk/NTB88LkDMRF+83Rfrb
 L0bQ==
X-Gm-Message-State: AOAM533WS/GqIiLVjICS1UQUK6NsDobf0PPNtiAxha2qQCXE6ybCfMwm
 VudHtA1CPeh0abcaBs2MVTj1T19mLNeIZ1SBJNznoEvxbqUFutG0CqjlZqKb2Csrrqz0MymYmhM
 61eZ+92p0bp6mPUQ=
X-Received: by 2002:a05:600c:4109:: with SMTP id
 j9mr3028155wmi.157.1594112766211; 
 Tue, 07 Jul 2020 02:06:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOM/cCz32YsicqdKc64oV/xh3q61mwLpSSrZWMerGKE2a9wwTq/0nArGrMZOlfC00JanLfQA==
X-Received: by 2002:a05:600c:4109:: with SMTP id
 j9mr3028132wmi.157.1594112765965; 
 Tue, 07 Jul 2020 02:06:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46?
 ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
 by smtp.gmail.com with ESMTPSA id 65sm159782wma.48.2020.07.07.02.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 02:06:05 -0700 (PDT)
Subject: Re: Slow down with: 'Make "info qom-tree" show children sorted'
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
 <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
 <20200707084647.GB2649462@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95768b3f-e5fe-6278-0b42-806ca7a7b3ef@redhat.com>
Date: Tue, 7 Jul 2020 11:06:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707084647.GB2649462@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, ehabkost@redhat.com, philmd@redhat.com,
 mark.cave-ayland@ilande.co.uk, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <dgibson@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/20 10:46, Daniel P. Berrangé wrote:
> On Tue, Jul 07, 2020 at 06:45:57AM +0200, Thomas Huth wrote:
>> Sure, we can work around that problem in the CI (Alex has already a
>> patch queued), but still, is there something you could do about this
>> massive slowdown?
> 
> I think the answer is to stop using q_queue_insert_sorted(). The impl of
> it looks like it is quadratic in complexity. Instead store the objects
> in a plain array and then use qsort() at the end.

g_list_sort uses a mergesort, so it's a good choice as well.  But yeah
GPtrArray is another possibility.

Paolo


