Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE82C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A64207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIZHomal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A64207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiXa-0003Uz-Qp
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jaiWj-0002dK-4A
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:22:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jaiWh-0008H0-F1
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589818921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98ZpnwHAx2gFbTHwDFEFfv30HBGfx3r1A/dVzSn7Vko=;
 b=AIZHomalYmVUdnyIIitekjgQ72QJjP3MjO0eutKKMPNuO0EcYSgAgxYFAMMuTPbEpyq8Xq
 7l/wLpYdZ3+4sjQK0FKKE/zM+r/wFSqib+cxa/OuE4yxBavWo8j/Wzffx3UMca5lrBTNKv
 cPuM/fKWyCTr62E6tTEnm5P7OFs/7Og=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-SWBbLHPeOzyaOX59V99TwQ-1; Mon, 18 May 2020 12:21:57 -0400
X-MC-Unique: SWBbLHPeOzyaOX59V99TwQ-1
Received: by mail-wr1-f71.google.com with SMTP id p8so5876961wrj.5
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=98ZpnwHAx2gFbTHwDFEFfv30HBGfx3r1A/dVzSn7Vko=;
 b=VYavCk9VRhilRwjR+q7eksjh9kk1TD/2uFDjvaZfx1vGUClFJPqjKpECLbOmukSaD0
 x65YaczzbXOvR/Y6lUkJuxs6ALccz2yNigdlpTpewNegJlYDQ3yZiHEXmGPSEy695Q09
 YopLgZ2ucrq1ojhZp4czb6NtmECIRH1hL+sBzVbBqB5hD9yAb1NAzPW0l3Ttan7nCcmt
 u2h+EF2YGtRQHgaWQGj7K0CLf+zBysYLt0uen9OIZCG68xAAUlgy0RDKFmLcCz2CTRiP
 8Mu7AKDgK9U4JHmAiZJ0JLd/S6Qj4har8TVH9t3j6qgja8p486J6einVNqBHePsR8jKb
 aQ/A==
X-Gm-Message-State: AOAM530ak6Jw1GzSd+ZTTtfPpqsYfa7OpnGmizP22Gfzv7d9vXmoqdPP
 cgDboMsFw5P3wXzY1/69Fymf2cqyUOui/lCu+KYqTPjDtC86jpYBaa1eJXcKHn2h29+cp3yrxSv
 x7EID1mOpJNMASZA=
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr20425775wrw.256.1589818916459; 
 Mon, 18 May 2020 09:21:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNLpin204qLIT/3CoZ4qali1DTnEcMIdk0nKim3vnvtnA0qpBpc+ZafDtFysGupxsVNwrq6Q==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr20425739wrw.256.1589818916248; 
 Mon, 18 May 2020 09:21:56 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d4sm11139955wre.22.2020.05.18.09.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 09:21:55 -0700 (PDT)
Subject: Re: KVM call for agenda for 2020-05-19
To: quintela@redhat.com, kvm-devel <kvm@vger.kernel.org>,
 qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Bin Meng <bin.meng@windriver.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Erik Skultety
 <eskultet@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Bin Meng <bmeng.cn@gmail.com>
References: <87o8r24p2a.fsf@secure.mitica>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <133d4900-c852-f45d-ab19-a9253013fd20@redhat.com>
Date: Mon, 18 May 2020 18:21:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87o8r24p2a.fsf@secure.mitica>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 1:08 PM, Juan Quintela wrote:
> 
> 
> Hi
> 
> Please, send any topic that you are interested in covering.

Last minute suggestion after recent IRC chat with Alex Bennée and Thomas 
Huth:

"Move some of the build/CI infrastructure to GitLab."

Pro/Con?

  - GitLab does not offer s390x/ppc64el => keep Travis for these?

How to coordinate efforts?

What we want to improve? Priorities?

Who can do which task / is motivated.

What has bugged us recently:
- Cross-build images (currently rebuilt all the time on Shippable)

Long term interests:

- Collect quality metrics
   . build time
   . test duration
   . performances
   . binary size
   . runtime memory used

- Collect code coverage

Note, this is orthogonal to the "Gating CI" task Cleber is working on:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg688150.html

> 
> At the end of Monday I will send an email with the agenda or the
> cancellation of the call, so hurry up.
> 
> After discussions on the QEMU Summit, we are going to have always open a
> KVM call where you can add topics.
> 
>   Call details:
> 
> By popular demand, a google calendar public entry with it
> 
>    https://www.google.com/calendar/embed?src=dG9iMXRqcXAzN3Y4ZXZwNzRoMHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ
> 
> (Let me know if you have any problems with the calendar entry.  I just
> gave up about getting right at the same time CEST, CET, EDT and DST).
> 
> If you need phone number details,  contact me privately
> 
> Thanks, Juan.
> 
> 


