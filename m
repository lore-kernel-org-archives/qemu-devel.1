Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96244C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988CB24747
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fzf2s4Hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988CB24747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXlP6-0006bB-FY
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 09:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXlO3-00061z-5t
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXlNx-0007Qa-M1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603891263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y4ovk9gT8cvismcR1zGM4VS/fHyqbXv8sGCpiPK5xcc=;
 b=Fzf2s4Hm63I/BBjKyJTx3UZ57zj+dO6p5wbkfoAdfCDJKXkmbk9dPDmsBJhhYBmLguk3N+
 NzPNpqX+3sazxx3271Rq9LVcUruAqqfz9rn9se7+HSmhmY+eI9RHUO5rCXJnE5EtD0D5KF
 vK2gZuEV2uSgDnThK0orfEoyev+9FQ4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-PIeK_ofMM9mANOAbPcXnKg-1; Wed, 28 Oct 2020 09:21:00 -0400
X-MC-Unique: PIeK_ofMM9mANOAbPcXnKg-1
Received: by mail-ej1-f72.google.com with SMTP id b17so2123421ejb.20
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 06:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y4ovk9gT8cvismcR1zGM4VS/fHyqbXv8sGCpiPK5xcc=;
 b=MluVLA2PcxFuB3c0RAp7iz/rvWWHSdRMnJVlWsj/pd5qWwqQtq72VgUvOVYn3TE3kJ
 j8KolninSfnmqfzoKynQqKLYGdLPEIzdNmL1KNEGriT4NXK/lBeHdxiZlDzkS228Xjkc
 6+SZeQC6Zffg/lKiAOs/bwhTdR5yLVLDlydpWDnWPgWrs9FxdUJyfQwZhkVBSkXCxDiF
 A+LkIRimv/LhQKKQ6wONaHQQqQ9B7aLrbucPyamBw7AvpIat+ir3p8QlVX+jdrbPMR0u
 pJiF+ugHpI2bDYpBV4+FJV1glfDaLPnT0jCZ/RjfP3bGkPAcgfD3COKMO1cYDM8tQAIs
 iGnw==
X-Gm-Message-State: AOAM532qEzdHVWhZGup402eJ2YBiVrCZQ/yQRIt5z1rqveqWQE32Pv0q
 B862OcNHgBBVLP936CSV65gUjVOq+TPZFr0FeRPd+RshnwngM7a6aNfxAKZYJezxZcWqfUjJfD7
 DZFJ5N8+Cse8KBlk=
X-Received: by 2002:a05:6402:1d8b:: with SMTP id
 dk11mr3688503edb.102.1603891259524; 
 Wed, 28 Oct 2020 06:20:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzDAiP3j7V1osvdE0xtPzb0R02Dc/sASqSviRhkenTeEbbwcJCfvbiyMUQbGDx0FQv4hiBJA==
X-Received: by 2002:a05:6402:1d8b:: with SMTP id
 dk11mr3688466edb.102.1603891259207; 
 Wed, 28 Oct 2020 06:20:59 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id se12sm2946823ejb.37.2020.10.28.06.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 06:20:58 -0700 (PDT)
Subject: Re: [PATCH 1/9] target/i386: silence the compiler warnings in
 gen_shiftd_rm_T1
To: Thomas Huth <thuth@redhat.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Nguyen <tony.nguyen@bt.com>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-2-kuhn.chenqun@huawei.com>
 <30ca9af0-dfc2-e236-5575-068cec679508@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b868a495-4c11-bf59-3ba5-9fa4bc6fe8a1@redhat.com>
Date: Wed, 28 Oct 2020 14:20:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <30ca9af0-dfc2-e236-5575-068cec679508@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, zhang.zhanghailiang@huawei.com,
 ganqixin@huawei.com, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Tony

On 10/28/20 1:57 PM, Thomas Huth wrote:
> On 28/10/2020 05.18, Chen Qun wrote:
>> The current "#ifdef TARGET_X86_64" statement affects
>> the compiler's determination of fall through.
>>
>> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
>> target/i386/translate.c: In function ‘gen_shiftd_rm_T1’:
>> target/i386/translate.c:1773:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>          if (is_right) {
>>             ^
>> target/i386/translate.c:1782:5: note: here
>>      case MO_32:
>>      ^~~~
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>> ---
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  target/i386/translate.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/translate.c b/target/i386/translate.c
>> index caea6f5fb1..4c353427d7 100644
>> --- a/target/i386/translate.c
>> +++ b/target/i386/translate.c
>> @@ -1777,9 +1777,9 @@ static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot, int op1,
>>          } else {
>>              tcg_gen_deposit_tl(s->T1, s->T0, s->T1, 16, 16);
>>          }
>> -        /* FALLTHRU */
>> -#ifdef TARGET_X86_64
>> +        /* fall through */
>>      case MO_32:
>> +#ifdef TARGET_X86_64
>>          /* Concatenate the two 32-bit values and use a 64-bit shift.  */
>>          tcg_gen_subi_tl(s->tmp0, count, 1);
>>          if (is_right) {
> 
> The whole code here looks a little bit fishy to me ... in case TARGET_X86_64
> is defined, the MO_16 code falls through to MO_32 ... but in case it is not
> defined, it falls through to the default case that comes after the #ifdef
> block? Is this really the right thing here? If so, I think there should be
> some additional comments explaining this behavior.
> 
> Richard, maybe you could help to judge what is right here...?

I think the previous discussion is this thread:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg632245.html


