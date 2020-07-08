Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB37CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FB4206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGaJ9fHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FB4206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIhw-0003HC-O3
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtIJp-0001aV-BT
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:13:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28370
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtIJn-0008DL-Na
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zulN4Jz2hWDZbRnwe6dAoROTRMzAoaqFxZhJodPrzQs=;
 b=WGaJ9fHNEf7ARC5rfJw/ur0nxX+BqlpL0bb90SsMMZhX4qLK/rbin2r3l9Z4EXOUmSQEVy
 1MsT88YAP7mh3u8mdiC5Emjn0/AYoszZFeuxZyzWl2IIb/OytHSP5B1BGL4QvU9IV8L4gi
 Wn/r6pUqIcTDNKTdAFIFV1+PWTKvPC8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-jxZOY5gkPlCgI1PptRkkxQ-1; Wed, 08 Jul 2020 11:12:46 -0400
X-MC-Unique: jxZOY5gkPlCgI1PptRkkxQ-1
Received: by mail-wm1-f71.google.com with SMTP id w25so4598786wmc.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 08:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zulN4Jz2hWDZbRnwe6dAoROTRMzAoaqFxZhJodPrzQs=;
 b=tT+UPXGNUn8TwmzRpHy4sVJOOwDCR65Yl2w6ZdN2X/i89ErvuLmWTtSUWIqOiMG9vw
 aWFLaKMu6vcwu7OrqeIOE7zH32fcv+nPYNN5h8krGCgYqlg3wNBLpINr8WIqxlX0stRq
 fIgSq1BTcqZIOiTj5tk4cPjDY/SBXaCOeOd5aJU1ZZtcNZgJdcBls3ZQRY9pCElxqU6A
 Nwn4pWSyQhF3dT/504WRmrPJvdPF0J+foLRJQ8f2PLv/T1gMJVGFQgrvGnW+yfhq+UVI
 +9EnaDloeIGAb9yttEalfHvnylXj0vtq8nPNfUt79lMzfhVdTNQ0myS/WS18xfBJPQSf
 Opow==
X-Gm-Message-State: AOAM531HKVZJPKAKdia/c5f/mw7CZ6UBJ9pJmlw9U/rGecXunyld054N
 7871EaMWik8SJMfa3KGzWO1sTu1FtWEp/SUIn+rwqyGc0F4H5CjhFbwfomejYlZxCokaeXgOPJc
 9/mkkLzgJEQ7TWpQ=
X-Received: by 2002:a1c:f616:: with SMTP id w22mr9340827wmc.44.1594221165659; 
 Wed, 08 Jul 2020 08:12:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwygT8MVfZlzX1HuJU996GCeOysLulvLSJoNUVGqpye6RbeNuIQltSxTLAZB51Vf8UnrZGkGA==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr9340811wmc.44.1594221165465; 
 Wed, 08 Jul 2020 08:12:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id 22sm154847wmb.11.2020.07.08.08.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 08:12:44 -0700 (PDT)
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
To: Thomas Huth <thuth@redhat.com>, Claudio Fontana <cfontana@suse.de>,
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
 <d5bb7a17-1e49-2436-a11b-3b6775589490@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <afec1f63-166a-5c82-3bc6-e2afbb68f066@redhat.com>
Date: Wed, 8 Jul 2020 17:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d5bb7a17-1e49-2436-a11b-3b6775589490@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
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

On 08/07/20 17:07, Thomas Huth wrote:
>> Nope, unfortunately we don't have an s390 CI.  But if you can get your
>> hands on one, just "./configure --target-list=s390x-softmmu && make &&
>> make check-block" will show it.
>
> We've got a s390x builder on Travis ... or is this only about the s390x
> target?

It is about s390 host.  But Travis is not covering all submitted
patches, is it?

Paolo


