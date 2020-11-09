Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FE0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D80206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXm0tI5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D80206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcCO3-0005Rn-C1
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcCMt-0004qq-Kn
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:58:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcCMr-0003e9-T8
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604948296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVdbivzgaWIbzSbqc1t6fsUsry9AIMdLeNAUIuhh6lQ=;
 b=TXm0tI5ICqM3DwA7ZoEBY+Y3DbTPqK6pyjhmRs/1KJ/ZgooPwnG5QEs4O32LpUHULcuOQQ
 WEFp6CnP5C+q9ne+Hy7PJ+lkC7Y16oTLWgmS7PheP47MpcynkpSMpslI2600Kv/uPUK1Yj
 yWFinBz00OclZpLjkEfhiXNiZRxW7Zw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-fiQnf5eXNymgGjMva-o6IA-1; Mon, 09 Nov 2020 13:58:14 -0500
X-MC-Unique: fiQnf5eXNymgGjMva-o6IA-1
Received: by mail-wr1-f72.google.com with SMTP id x16so4665734wrg.7
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 10:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zVdbivzgaWIbzSbqc1t6fsUsry9AIMdLeNAUIuhh6lQ=;
 b=NoNF1joEydhM0oLOq5aHS+dDTDzZTZ2hEnV7hSw9skqn0LQhl3CVQC2YLln7uPk+V7
 wWjBVFSUGJ/wCdAm41Mam9KcnBDfMEFQWiiSrmLD3NdzazUItgT/N1qR3vUc1L6EIhrC
 6nQhSo+x4R5V0WCMQuHjaf+yzdYy2QA718ViWGYtTEz04DAR02+KQHvkg0YJ+9peuhJB
 g9l8NfYHjQftFMT8PFL3m/1/NF8okO+85Zl3atOMAgbmcn7eCdhaBtj5U8MlA9SPI5En
 GHqrojxOT/s9unRzsGhiWLgHJGws4c2ssJRVcJK8vARCTUfv33Y8aJGzAIdhqkuAikvH
 70vQ==
X-Gm-Message-State: AOAM530gcFtshptCzeCiWMt2crk+zBzbqbyP7P0JURN05mK3qucgzwaS
 xbqkOs6kQr2bvNHhvG3tZAtEUWjXG+Cp6UL/9M51oarNyNcogasZ2J2L79zKnOjpcaQv/0V6LMK
 eAJcD0Q5rto2uwFA=
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr580901wma.75.1604948292889; 
 Mon, 09 Nov 2020 10:58:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMRf6MGROqT4lrwYMCHUEjtinupownNdjlO7stMrMhBUpoCpyJTVLVn6H9OY/BwSRQszdOmQ==
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr580890wma.75.1604948292699; 
 Mon, 09 Nov 2020 10:58:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id n10sm14761802wrx.9.2020.11.09.10.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 10:58:12 -0800 (PST)
Subject: Re: [PATCH v2 3/6] qemu-option: restrict qemu_opts_set to merge-lists
 QemuOpts
To: Markus Armbruster <armbru@redhat.com>
References: <20201109133931.979563-1-pbonzini@redhat.com>
 <20201109133931.979563-4-pbonzini@redhat.com>
 <87eel25xud.fsf@dusky.pond.sub.org>
 <0defd899-184d-549e-a799-7000f7b9c92d@redhat.com>
 <874kly4b24.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <484f3625-e5b6-fc3c-ded7-97076557e0a2@redhat.com>
Date: Mon, 9 Nov 2020 19:58:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <874kly4b24.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 19:52, Markus Armbruster wrote:
> Do you think working (some of) this into commit message would be worth
> your while?

Easy and does not require a respin, so yes.

>> Improve the testcase, though I should have mentioned it in the commit
>> message.  Basically emulating "-kernel bc -kernel def".
> Worth testing.  But the case "-kernel bc" is also worth testing.
> test_qemu_opts_get() tests both:
> 
>      /* haven't set anything to str2 yet */
>      opt = qemu_opt_get(opts, "str2");
>      g_assert(opt == NULL);
> 
>      qemu_opt_set(opts, "str2", "value", &error_abort);
> 
>      /* now we have set str2, should know about it */
>      opt = qemu_opt_get(opts, "str2");
>      g_assert_cmpstr(opt, ==, "value");
> 
>      qemu_opt_set(opts, "str2", "value2", &error_abort);
> 
>      /* having reset the value, the returned should be the reset one */
>      opt = qemu_opt_get(opts, "str2");
>      g_assert_cmpstr(opt, ==, "value2");

Note opt_set vs. opts_set though.

> I'm okay with not improving the test in this patch, or with strictly
> extending coverage, preferably in a separate patch that goes before this
> one.
> 

Ok, I'll just drop the testcase change for now.

Paolo


