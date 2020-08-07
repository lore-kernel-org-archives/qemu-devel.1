Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C62CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5ED21744
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AK20/3+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5ED21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yQF-0007Fm-I4
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3yPW-0006pP-64
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:11:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38680
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3yPU-0000l1-AB
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596791491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/rPT8TthiaR/w8rKMpl9GV1UCZLpHSyy23SsCdPujhE=;
 b=AK20/3+9BlS0MXcD/ml9mEL3zI0SHWztEFyJgYAsnTMSqqaUL4i+tbwwrt7/ie3iYjkfYA
 +i6eI1NW9k5pWI7UlOhhihaF7z3KElyY4qmhIf3aBVLeiXoW0xfb3IGUOHpDj28+6Y3HOi
 nmjiYKCnPcnnr1A4doNvRqspsN6wab8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-oPoq9nGiPkSiC2QCNH50PQ-1; Fri, 07 Aug 2020 05:11:29 -0400
X-MC-Unique: oPoq9nGiPkSiC2QCNH50PQ-1
Received: by mail-wr1-f69.google.com with SMTP id e14so497543wrr.7
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/rPT8TthiaR/w8rKMpl9GV1UCZLpHSyy23SsCdPujhE=;
 b=hi8MAlHQmceSjJRq7dkLN4YX2b1ZC68+HOnU7R7RkA1HMws+rDPEspUQUeki2Kex8X
 O4wtoL08YQH0GrX1I2NyO5rx+DTwPEkYMA/Fa7GfIbt+X+8X3Zx/KN1FVGJfOilM+JRj
 r8DefGx8MCluaOyDSGhcHUWQx9Z2duh+zEcGHXk4UCvghaq483EEOy9k2iwdkN36CqjG
 IXwCh72qoihzK1DtX5Wyh2nBDNqlFpK2JkIGiiiY4pF5/wY4wtn4U1b76PlBx+a9Bjru
 5VXEx5Jeb3XhJSpLZ/XlzsqDafjwVOOTeZmzjrl0/Eq+mGenMo7VufXqZa0sNUCKgTwA
 OQXA==
X-Gm-Message-State: AOAM532CKDSn1nhWCoblpx0IiZv2lYEVHml7JmwG0ocaQ83cRvgw60jS
 uIzERFgSEzcM+qgKnxx1m2W8zAF1heYI5e9xZZfPsAE3uQhwSgeYhFSsoOyvfo6KMz2kPwjMMAk
 1DnnL4rWHdQnrJ1U=
X-Received: by 2002:a5d:4907:: with SMTP id x7mr12082900wrq.166.1596791488191; 
 Fri, 07 Aug 2020 02:11:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVPxoFHyDv9EzHNeCV7UY7Dak4S/BCRQfR/p2JdHeMuQCJd/eliCR7+19IqH09MmeNCIBNRg==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr12082873wrq.166.1596791487933; 
 Fri, 07 Aug 2020 02:11:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id x2sm10204565wrg.73.2020.08.07.02.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 02:11:27 -0700 (PDT)
Subject: Re: [PATCH 124/143] meson: target
To: Peter Maydell <peter.maydell@linaro.org>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-125-git-send-email-pbonzini@redhat.com>
 <CAFEAcA84DhPcZxa0yhRmZOMiSdPt8L_PBVQacgoOuznbJv7kFg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <91373a0d-5d83-5dce-7067-f83d6bda8ef2@redhat.com>
Date: Fri, 7 Aug 2020 11:11:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA84DhPcZxa0yhRmZOMiSdPt8L_PBVQacgoOuznbJv7kFg@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 11:04, Peter Maydell wrote:
> On Thu, 6 Aug 2020 at 21:09, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> 
> 
>> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
>> index 694757b..4cd1e10 100755
>> --- a/scripts/decodetree.py
>> +++ b/scripts/decodetree.py
>> @@ -1257,7 +1257,7 @@ def main():
>>      long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=',
>>                   'static-decode=', 'varinsnwidth=']
>>      try:
>> -        (opts, args) = getopt.getopt(sys.argv[1:], 'o:vw:', long_opts)
>> +        (opts, args) = getopt.gnu_getopt(sys.argv[1:], 'o:vw:', long_opts)
>>      except getopt.GetoptError as err:
>>          error(0, err)
>>      for o, a in opts:
> 
> This change to the decodetree script doesn't seem like it
> belongs in this patch ?

Marc-André did this, I'll check how/why it ended up here and document it
in the commit message.

> 
>> --- /dev/null
>> +++ b/target/arm/meson.build
>> @@ -0,0 +1,62 @@
>> +gen = [
>> +  decodetree.process('sve.decode', extra_args: '--decode=disas_sve'),
>> +  decodetree.process('neon-shared.decode', extra_args: '--static-decode=disas_neon_shared'),
>> +  decodetree.process('neon-dp.decode', extra_args: '--static-decode=disas_neon_dp'),
>> +  decodetree.process('neon-ls.decode', extra_args: '--static-decode=disas_neon_ls'),
>> +  decodetree.process('vfp.decode', extra_args: '--static-decode=disas_vfp'),
>> +  decodetree.process('vfp-uncond.decode', extra_args: '--static-decode=disas_vfp_uncond'),
>> +  decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
>> +  decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
>> +  decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
>> +  decodetree.process('t16.decode', extra_args: ['-w', '16', '--static-decode=disas_t16']),
>> +]
>> +
>> +arm_ss = ss.source_set()
>> +arm_ss.add(gen)
>> +arm_ss.add(files(
>> +  'cpu.c',
>> +  'crypto_helper.c',
>> +  'debug_helper.c',
>> +  'gdbstub.c',
>> +  'helper.c',
>> +  'iwmmxt_helper.c',
>> +  'm_helper.c',
>> +  'neon_helper.c',
>> +  'op_helper.c',
>> +  'tlb_helper.c',
>> +  'translate.c',
>> +  'vec_helper.c',
>> +  'vfp_helper.c',
>> +  'cpu_tcg.c',
>> +))
>> +arm_ss.add(zlib)
> 
> Just to check, does this get the underlying dependencies right?
> ie translate.o depends on translate.c and also eg translate-vfp.inc.c,
> which in turn depends on vfp.decode ?

Yes...

> It's not clear to me why all the decodetree lines ended up in a
> single "gen = []" block -- they're independent of each other.

... and I'll answer to this in the .inc.c patch because it's related.

Paolo


