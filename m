Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AFDC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1ED6214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9G5Tkuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1ED6214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifCxY-0006sS-W5
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 20:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifCwY-00066e-RF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifCwW-0006zE-AP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:07:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47129
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifCwV-0006vw-Lp
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576112818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXJKZz5IsL95cyHTFXpZXRIU3W8hP875CCGZBLk77i8=;
 b=P9G5Tkuf6pHoJH6W6BUh0eYO/DZit7ZOdHn28zfQ++mTynFLFIbkLzg4Pzg2/HMq63/xnf
 YYpMGgGQAYUp2sCI1Xmt+O/Y11Q3onuzkBgrkqKCQM2RdZChwEAuHHGAY3myCuc6zDf75o
 TbaDZj+1VvBCvsn+ErNzBHeHEyiOuPo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-6L2MRmZCPkuMOaY26k2Xag-1; Wed, 11 Dec 2019 20:06:55 -0500
Received: by mail-wm1-f71.google.com with SMTP id m133so117160wmf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 17:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TXJKZz5IsL95cyHTFXpZXRIU3W8hP875CCGZBLk77i8=;
 b=M39a0aRFhOFH2jmlroF3SYlbrZKPihdo0jhtpYtcDUAW+4OY1kajgp/qLnlg6wWXVt
 R4RFHP+fXDWS04l8RKGwVJoU0TPYLQx9EOGZZzkBUBlbF/qq8YaOH3HwwnpgvTcJTwSU
 sXWHQbTtvKKxZm+cXuN+P/6BQHRs960Fw8YbMS1qN5uM0kQQJUKONZd5yOi4fFrQxz04
 kICgk/TwHXq1AJqLpkpjPhcBiQzFweToUFIcbB9sHlNns1bIR7PIqqP5SCfwsgKsZEso
 u9CK2nAkm4qP7CrX79EE9BgVF6ANNrD1krAqkAORsMlxS9at2r3Iqt9tskJeX6bARPpo
 H3uw==
X-Gm-Message-State: APjAAAVdGNgWtMIzRxr9HnIbIv8ia3rIkgiF3ocZW1oGXblMbWXZDt0i
 PbsD0mKijNO3UL3IOp8G0GBsGvBNDA43L/dzpKnB+O/7ClIxO9UV9M7NFvqJFq4JamAicdZx8JE
 ECKHPN5sdeoixV/4=
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr3248009wmi.15.1576112814326; 
 Wed, 11 Dec 2019 17:06:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1foYlnLzY1o69NXI2yoGk2Zq3N0QqKKpGV1L1WLv6gjpTXaAkmrH+RDRPxdaZEDEsF4zmTg==
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr3247990wmi.15.1576112814058; 
 Wed, 11 Dec 2019 17:06:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id t12sm4118804wrs.96.2019.12.11.17.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 17:06:53 -0800 (PST)
Subject: Re: [PATCH] migration: fix stringop-truncation warning
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <1576074210-52834-3-git-send-email-pbonzini@redhat.com>
 <ce08ed58-78f0-83c8-404c-4caa76d38569@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d3de9def-b922-7469-8534-a448bf3384cc@redhat.com>
Date: Thu, 12 Dec 2019 02:06:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ce08ed58-78f0-83c8-404c-4caa76d38569@linaro.org>
Content-Language: en-US
X-MC-Unique: 6L2MRmZCPkuMOaY26k2Xag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 01:55, Richard Henderson wrote:
> On 12/11/19 6:23 AM, Paolo Bonzini wrote:
>> @@ -44,8 +44,7 @@ void global_state_store_running(void)
>>  {
>>      const char *state = RunState_str(RUN_STATE_RUNNING);
>>      assert(strlen(state) < sizeof(global_state.runstate));
>> -    strncpy((char *)global_state.runstate,
>> -           state, sizeof(global_state.runstate));
>> +    memcpy(global_state.runstate, state, strlen(state) + 1);
> 
> We should assign the strlen result to a local variable rather than compute it
> twice.

We could even strcpy since the assertion ensures it's valid, but perhaps
it's better to do nothing, since the best alternative would be
memset+strcpy, i.e. back to strncpy.

We generally are quite mindful about our uses of strncpy, but maybe we
could fold the assertion and strncpy into a qemu_strncpy function,
and/or qemu_strncpy_nonul for when you're copying into an array that
does _not_ need to be nul-terminated (so the assertion can become <=
rather than <).  I'll add it to BiteSizedTasks.

Paolo


