Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88209C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3BB206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvvmV11u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3BB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVv6N-0001tt-By
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVv5C-0000np-Nb
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:45:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVv5C-0003qX-0s
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:45:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id y24so1775403wma.4
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 03:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0faX7m1nnDSKM3e8pMwiYo4N+XiY/JMjDZuFiiNtkKc=;
 b=BvvmV11u4QEtG2REI/S7xG7FCW38jHrNATa5uNKP0A1Q8GyhmbMQ81vA2T1+KFqYII
 T+Ev4SwLRK/gubtTMJehlrDirMT6SLiUdPlJ30mLchtWc4Xb11sTQQCP5YQHJACybBX/
 ei5rpuhC1KlyZVD/RO6avGEi0q0QqXLpjFcytoSi9g323vzrmCqj3LjqsHK1MrINeZR5
 2ZKKzjoknqOhj5VDzr/k2cpdJq0DjHQ2O7/38xqYTwa4tHuStAcx0L0exOD8uOnR8sbk
 V3CAsQSC0j3fS65eMRgsn0NbN71BS9WruxSOm9vAu16J+rnhaa03xz8Pte1oMrza8cF9
 09gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0faX7m1nnDSKM3e8pMwiYo4N+XiY/JMjDZuFiiNtkKc=;
 b=gc9JykgL3Bi/KnpzlKPzNdF8E3PGrqx9xxZIinD5AohoL2fFtoMY9MzpMB30K7Os43
 Phyaou0Ayq8g4fvfhhz4MnKvfBm6dOV9JCPD4mpbjxkQh1svjcA9//UT6M3FWpP89OwK
 fI13wq/bjsz5TGh62GsFViI8gj6B3lc7AwQXMAwBVMzOzt37HO+YSZzGKpEhZnb8upGR
 Vv1e/KWV/dHRTU9hrJUIwQkNDKjsxQ40a7hr59IYslEUROtJnrVW6lWJX1j7qR3mUyeG
 GznOCI1R9fIOyVqfd+THO/ioTpYo+V8EkAcKQmr3RORseu39/5XhkLtdP7oPpOHohk7g
 L5Ug==
X-Gm-Message-State: AGi0PuYIzHsIbpOumXEa6YOyrHldLTQeKRPumH5Kp251LWOSCBI4GEeg
 VoH+ShuSJAKYnLcKWocwgX8=
X-Google-Smtp-Source: APiQypKDExyt6OBtcRN+nKI3uOUhuUK2KCmHSm0AHCeEprpEx7AVaVQjgIlHepPhcbprO2atg7WFnw==
X-Received: by 2002:a05:600c:2314:: with SMTP id
 20mr2732682wmo.35.1588675548447; 
 Tue, 05 May 2020 03:45:48 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id y3sm2741344wrm.64.2020.05.05.03.45.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 03:45:47 -0700 (PDT)
Subject: Re: [PATCH] hw/audio/gus: Use AUDIO_HOST_ENDIANNESS definition from
 'audio/audio.h'
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200505100750.27332-1-f4bug@amsat.org>
 <bc9f6295-9c1a-9617-ecd9-f38ea0ad5d79@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <79194c5a-ea10-3921-aeb4-1e0432b38c3d@amsat.org>
Date: Tue, 5 May 2020 12:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <bc9f6295-9c1a-9617-ecd9-f38ea0ad5d79@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 12:10 PM, Paolo Bonzini wrote:
> On 05/05/20 12:07, Philippe Mathieu-Daudé wrote:
>> Use the generic AUDIO_HOST_ENDIANNESS definition instead
>> of a custom one.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Who/what machine is using this device anyway?
> 
> PC, like all old ISA audio cards.

I imagined, but any particular project in mind? I'm wondering if we 
should add a test for it, and what kind of testing.

