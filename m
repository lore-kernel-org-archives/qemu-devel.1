Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3B5C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0C52063A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O63hrumJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0C52063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwMfV-0005PO-2y
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jwMej-0004yM-PG
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:27:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43060
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jwMei-000437-7C
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594978067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/qdTsqJP8cP1G8j6LPsFfq3aNNkK+XdqDMGDFiOrXBc=;
 b=O63hrumJCBndPQn5v7p7SPbmxcRugh/pqYMzP8u5GzoYQ/phsz1VtLuoiAFGArlYlQalYb
 j9UyAHn9GbZpRpVjeNF61Evn2mo0xmBvru4LEtPSS1V9wg4RUx5RzMl7ilq2XiOyhLbMiF
 OAI5bgJXViXkeAVS/PBeGzjX88b0rjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-htE_w1MZO2SG_H7hYw_LKA-1; Fri, 17 Jul 2020 05:27:44 -0400
X-MC-Unique: htE_w1MZO2SG_H7hYw_LKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FE4E6C2F0;
 Fri, 17 Jul 2020 09:27:37 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-237.ams2.redhat.com
 [10.36.114.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4542979508;
 Fri, 17 Jul 2020 09:27:32 +0000 (UTC)
Subject: Re: [PATCH] target/i386: floatx80: avoid compound literals in static
 initializers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200716144251.23004-1-lersek@redhat.com>
 <87y2njv2to.fsf@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d49ed94c-8095-2803-9fef-e7d0396f2ed6@redhat.com>
Date: Fri, 17 Jul 2020 11:27:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87y2njv2to.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joseph Myers <joseph@codesourcery.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/16/20 18:31, Alex Bennée wrote:
> 
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>> Quoting ISO C99 6.7.8p4, "All the expressions in an initializer for an
>> object that has static storage duration shall be constant expressions or
>> string literals".
>>
>> The compound literal produced by the make_floatx80() macro is not such a
>> constant expression, per 6.6p7-9. (An implementation may accept it,
>> according to 6.6p10, but is not required to.)
>>
>> Therefore using "floatx80_zero" and make_floatx80() for initializing
>> "f2xm1_table" and "fpatan_table" is not portable. And gcc-4.8 in RHEL-7.6
>> actually chokes on them:
>>
>>> target/i386/fpu_helper.c:871:5: error: initializer element is not constant
>>>      { make_floatx80(0xbfff, 0x8000000000000000ULL),
>>>      ^
>>
>> We've had the make_floatx80_init() macro for this purpose since commit
>> 3bf7e40ab914 ("softfloat: fix for C99", 2012-03-17), so let's use that
>> macro again.
>>
>> Fixes: eca30647fc07
>> Fixes: ff57bb7b6326
>> Link: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06566.html
>> Link: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04714.html
>> Cc: Alex Bennée <alex.bennee@linaro.org>
>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Joseph Myers <joseph@codesourcery.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>
>> Notes:
>>     I can see that there are test cases under "tests/tcg/i386", but I don't
>>     know how to run them.
> 
> You can run the TCG tests with:
> 
>   make check-tcg
> 
> or more specifically:
> 
>   make run-tcg-tests-i386-linux-user
> 
> there is also a:
> 
>   make check-softfloat
> 
> although in this case nothing is affected.
> 
> softfloat bits:
> 
> Acked-by: Alex Bennée <alex.bennee@linaro.org>

Thank you!
Laszlo


