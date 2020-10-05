Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB253C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E3720774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECdcuue4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E3720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQqg-0001jh-Gc
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 09:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPQoS-0008OQ-D2
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPQoN-0007VL-74
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601905553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EhFLUjFWmLlcIWDT5lF+PadW9JdqVHX2cRu8rDbA5Co=;
 b=ECdcuue4Zrg+e0Pstw5A4fTO3tAzkja0unlIvEro3TQM8gl9zjHShZYqmopzHePN3MpiZE
 gK/IFoiDutV+/YsqtPwXfBcscJh5SICnu0JpWVog1/H8AE8OMNUEq34CXslbe0esHoGOpY
 6vgw3FRrbiJCMVE77u74JDdh1B4zkJ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-lRN2DLLCMy-QZxOkZACjuQ-1; Mon, 05 Oct 2020 09:45:52 -0400
X-MC-Unique: lRN2DLLCMy-QZxOkZACjuQ-1
Received: by mail-wm1-f71.google.com with SMTP id z7so1317861wmi.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 06:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EhFLUjFWmLlcIWDT5lF+PadW9JdqVHX2cRu8rDbA5Co=;
 b=hdre4SYAYwmXZ3OvaDvvONLltYKXmnZ91/3kc9ka0uKCg+byJAMHl/4Uz2by99pwkE
 rzyryqW9rX475ZVqZ6aMKlYyQrEKrhU6CLizywb/T2uqPU5GQRvAgQ4CckCzOPQcH8d5
 dy+gLaaX2YpnkW4DkH21wOH/zjkaH1L4NE26LIMG87VxpE63NLe+fUy4bv8SnmAJgtXu
 EnWSZZc3JQUOe6AncoPNAknap3E+31a8Vk3mj1y/3pMfi090DZDTEtofRzBgz2h2ET74
 fB3TEVJ5CQts/s4PpskrwHOUTTbtGdgE0nNa5Fs6egSxp5zhjqJR9jNEH9Ju4Hftg4m/
 z8zg==
X-Gm-Message-State: AOAM5325RhX2j4MjD3GstK3q8R2Q3bZzd5XPtIdo8W6/pz6mnpkRa8Hg
 ax7xok36kg9qcpvldNlqqktpAZHZr6pkZSbBm5CXSYkkOOMlA/AnNv0m32Nj96J8Zt2/HxSZIsh
 S5B2Gb+zbJyeAzL4=
X-Received: by 2002:a5d:5146:: with SMTP id u6mr18775107wrt.255.1601905550685; 
 Mon, 05 Oct 2020 06:45:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb4q0FrPd3u1j1WeL614rDLe9cO1hvhyOzJSds1gpf8tw1GrpwCES5nhzuBwGUSUp0kqOrxg==
X-Received: by 2002:a5d:5146:: with SMTP id u6mr18775092wrt.255.1601905550464; 
 Mon, 05 Oct 2020 06:45:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2e86:3d8b:8b70:920c?
 ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id o129sm13508586wmb.25.2020.10.05.06.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 06:45:49 -0700 (PDT)
Subject: Re: [PATCH] configure: don't enable ASLR for --enable-debug Windows
 builds
To: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20201005133434.12614-1-mark.cave-ayland@ilande.co.uk>
 <0d82444f-9032-1278-ba6f-c495cacf5a94@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <68167409-1f35-c47d-5f83-40d8cbc27fe4@redhat.com>
Date: Mon, 5 Oct 2020 15:45:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0d82444f-9032-1278-ba6f-c495cacf5a94@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/10/20 15:42, Richard Henderson wrote:
> On 10/5/20 8:34 AM, Mark Cave-Ayland wrote:
>> Unlike other OSs it is not possible for gdb to temporarily disable ASLR when
>> debugging executables on Windows which causes gdb to fail with memory access
>> errors when trying to debug QEMU.
>>
>> Keep ASLR enabled by default on Windows via the --dynamicbase compiler flag
>> except for --enable-debug builds when there is a clear expectation that a
>> functioning gdb is expected at the cost of slightly less security.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  configure | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued, thanks.

Paolo


