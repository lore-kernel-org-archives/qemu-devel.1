Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DE9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A0C206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAXz6h3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A0C206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Cr5-00068V-IM
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 09:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1k6Cpu-0005XP-LM
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 09:00:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44828
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1k6Cps-0007Hv-Hi
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 09:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597323599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8ck8p+i7coNhCZM/6/HU1txGACnhKc8kCydEG/6LLc=;
 b=hAXz6h3so9OvLraJdDzo686DJbkPPSv7orlRW50jUTufdc3nOujezyfetPwgycj1HolA6k
 Pq0EX3RZMhyXEc8li2QOEv7pifx5Cuk8Znu3W7EGA/kkB4cATdM8e79tPxbrpuk0yr+Wf5
 Y7oMqbE6tyCdwHjAAOrcIrBpeNabZl0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-CwYZaE58On6H8iG03HIoqQ-1; Thu, 13 Aug 2020 08:59:58 -0400
X-MC-Unique: CwYZaE58On6H8iG03HIoqQ-1
Received: by mail-qk1-f200.google.com with SMTP id x18so3830435qkb.16
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 05:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p8ck8p+i7coNhCZM/6/HU1txGACnhKc8kCydEG/6LLc=;
 b=SP1i+Oq9qltkFTw7JpZ1B5Vletuel45hYmjyiRdwPwpcPAyacdJMR6S2kNXZ7SJP40
 /k47pPEwO/N6Ed3IrrvECDmSQ6ZXzwhATGQkWwNazJkSX/dk4zHbaVnhCUU9tcl8Pq3K
 KI6GxxCQVyvnQiPR3VdXgF9gWY8x+P16an8B+xn/qsZHw7co8+RzzcptT6TRv+EajoeS
 gSbQjFSSe5OdeIhaWZRVHTX0dMhntW3PS/O7VHcsZnunWaqdLVt3ay0i/imMH6lM3JJU
 2j+SpqNOijc1y0ZZ/5xdpLEr4ptrqBbgfExlwSidGT0UcTKZfB0795h2OaUqVHoXOr/T
 kOaw==
X-Gm-Message-State: AOAM533Aq8/JYgJHbAuyo5bvwyG2wUXa0G6tiTD6DQbsOVoRFtxqCLCc
 RiKUl1N6Vj76e/A5AnQ4H7ALFnA70qD3Sgmoe+gApDFLpPcKsUQvJkGnw1zO4yUYiJWLF2lwon3
 EnMINBJauB0CmmbE=
X-Received: by 2002:ac8:6a07:: with SMTP id t7mr5084900qtr.1.1597323597407;
 Thu, 13 Aug 2020 05:59:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj26Y+8NrLklJlKhRsPWhbyAmuG+oUiZ59Kc+IY52u03rHoXz6A41jrNFLkAtMN9//PMTR7w==
X-Received: by 2002:ac8:6a07:: with SMTP id t7mr5084882qtr.1.1597323597208;
 Thu, 13 Aug 2020 05:59:57 -0700 (PDT)
Received: from [192.168.0.112] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 p4sm5163296qkj.135.2020.08.13.05.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 05:59:56 -0700 (PDT)
Subject: Re: [PATCH v2] block: Raise an error when backing file parameter is
 an empty string
To: Kevin Wolf <kwolf@redhat.com>
References: <20200811212318.708290-1-ckuehl@redhat.com>
 <20200812065806.GA6587@linux.fritz.box>
From: Connor Kuehl <ckuehl@redhat.com>
Message-ID: <5c132353-886e-b818-bd04-58991ebe27f9@redhat.com>
Date: Thu, 13 Aug 2020 07:59:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812065806.GA6587@linux.fritz.box>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 08:00:46
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 1:58 AM, Kevin Wolf wrote:
> This looks like a test case that would be better served by not using
> QMPTestCase, but just printing the qemu-img output and having the
> message compared against the reference output.
> 
> In fact, there is already 049 for testing some qemu-img create options
> and we could just add a line there (or multiple lines to cover other
> backing file related error cases, too).
> 
> Putting it there would both simplify the test code and keep 298 free for
> the other series.
> 
> None of the above is really a reason to reject the patch. I guess this
> is more of a "are you sure? (y/n)" before I apply it. :-)

Hi Kevin! Thanks for the review :-)

I think it'd be best for my own edification to address your comments 
here instead of applying this now. I'll send a v3.

Connor

> 
> Kevin
> 


