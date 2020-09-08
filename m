Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB233C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6428F221F0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DknuiYUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6428F221F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcfu-0004Pe-97
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFcVr-0006H8-Rn
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:14:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39266
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFcVq-00062H-0f
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599567253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbkRDxYHdi2K64cKa97OStO1qZW4ePACBjuuM40qK5U=;
 b=DknuiYUl9nKfD4vQYrOL9hGuKBiizd/E92J8Hqo8xdrZ4jB1DLsR6Yo+8G3x/cD4MIPATI
 kqgjbzth5EnjpFzjyIvvZeN8MjOn9buunFC5LeISwkN3U4P2+9qYwPf2xo5kONne3kesLl
 Dh2QEuJziijUNO31BITRr9/0eLRCyoE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-58_JryLzPNKqFmgfKvOhSQ-1; Tue, 08 Sep 2020 08:14:10 -0400
X-MC-Unique: 58_JryLzPNKqFmgfKvOhSQ-1
Received: by mail-ej1-f72.google.com with SMTP id ce9so6567353ejb.7
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 05:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mbkRDxYHdi2K64cKa97OStO1qZW4ePACBjuuM40qK5U=;
 b=G08/xRvOJTWV7zgoylRkHs1g0smK+0Ikjb8LlrM+XETN9jXRMrWT4NQwe3bu3wv2KG
 T3xAQlUbVcEajcV+vw8Gay81TXosnpbYk5LbPfWe8bmT6ObBYZ/POV4MwdCZLtZa6zQb
 eBkpoNSMuH3ceHckH1Fhhq+nqenUR80Rezbi2d2+c5UsdrJBFnEoN6UaivU7NNEzVgrs
 DFsuikdhzRFbsar4UeMdk0v6Bo0FZX6FxBW3zSH/us8uskUXurZ2AmHoS/v0v462iZMe
 /C0Vd0MlEnkUmIapC02ImIX+C7YoVhlj3/86g2Yo4BokcznzAphV7jrX9Is2FQtbgh1j
 3MEA==
X-Gm-Message-State: AOAM533vwraaeuI6eNwwqp7+TjSpzxpVlHOSadx9aD4/eT5yq0ouaucE
 fMrHRjubnJMywTqMZBM1CZRc1slCeBl4G8UuAa2JolRkMw5DdQjbDIxhb6E7n7ZUI1K6CJNtVvQ
 1V0LM4bSxquI06xE=
X-Received: by 2002:a17:906:6b0b:: with SMTP id
 q11mr26486242ejr.412.1599567249763; 
 Tue, 08 Sep 2020 05:14:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmGsyNMYpQe5GR+6M+1kHHkDVGamwgfzzfjMyoY//6GfWZK32NnIFRViKFSlyOYi59flRmsA==
X-Received: by 2002:a17:906:6b0b:: with SMTP id
 q11mr26486224ejr.412.1599567249580; 
 Tue, 08 Sep 2020 05:14:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5f70:b94c:ca5f:28f2?
 ([2001:b07:6468:f312:5f70:b94c:ca5f:28f2])
 by smtp.gmail.com with ESMTPSA id t4sm9514037ejj.6.2020.09.08.05.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 05:14:09 -0700 (PDT)
Subject: Re: [PATCH v7 00/16] QEMU cpus.c refactoring part2
To: Claudio Fontana <cfontana@suse.de>
References: <20200903105614.17772-1-cfontana@suse.de>
 <13e066b4-03dd-e8f6-4420-25e25e404c72@suse.de>
 <CABgObfZBARDX=tFb03xEnSVMGAiG8TPn4TAKUpGEi=_iRChmWA@mail.gmail.com>
 <7e518674-b2a4-d6fb-f9f0-20a19765b995@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74e99c7f-5eb0-f34a-e2a2-c2b590027e7a@redhat.com>
Date: Tue, 8 Sep 2020 14:14:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7e518674-b2a4-d6fb-f9f0-20a19765b995@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/20 13:58, Claudio Fontana wrote:
> Thanks Paolo,
> 
> if it can help I try to keep a rebased functioning version at
> 
> https://github.com/hw-claudio/qemu.git "cpus-refactoring"
> 
> some of the CI complains about:
> 
> check: qemu-img not found
> Makefile.mtest:1229: recipe for target 'check-block' failed

This will be fixed by the next pull request (the issue appears with
--enable-system --disable-tools builds).

Paolo


