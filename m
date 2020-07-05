Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C21C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 09:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AD320772
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 09:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMJgy7ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AD320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js1Pj-0005i9-I7
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 05:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1js1Oz-00052M-Ci
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 05:57:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1js1Ow-0003XZ-Qd
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 05:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593943053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+gUgX92JeD7WLhazOuEI6R4E6yaZ0C2n0lMzBRIGICM=;
 b=SMJgy7yeipSe9uyPIPsizMi/62fCrf/Ss7vqaOWzbi6RuOxITNyndGmvMraUIKdvwgSB/m
 p9CjmiMEEzweik7exumt2g2Ii/fqL6dG9RgOo4L5N0DIqApwAwX/lEzeuSjvkv4dcnABEu
 hcgw3ttIDQRmF7ieVFzl6PVKU33SvkU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-MwKvEpSANr2N2jxPYKyiww-1; Sun, 05 Jul 2020 05:57:31 -0400
X-MC-Unique: MwKvEpSANr2N2jxPYKyiww-1
Received: by mail-wm1-f69.google.com with SMTP id v11so22773404wmb.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 02:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+gUgX92JeD7WLhazOuEI6R4E6yaZ0C2n0lMzBRIGICM=;
 b=T/0aFu48Mz4mLi3h+M70Fu1qcon6P8LrztDY9P+3OK8rW1na8Dujmmj5n7up3HA/9X
 jh20B3vBV7EvGvnelclXkahUG7WBXSL9gepafnOb3zZBajJGf8C2fU1CpyaTulWZvmLF
 Xp/JqmUj0YgKsKo0tCgWoe/PDqrXANWJ7UDrPfsgdAiT+/XHsqYd5m48d93nJa5kASlg
 gTaBP9cR1TLP5oggRL4VXRZTDY8dUQA9xfMmIqtZwOuu683fTvQ4I2s1WWdqB4ol3Uz9
 mDFkgYMRYBMUTvtQbxXARD1We8BAZFrj41sthzlwFKCBJQYhfjRxt/wPdoHJgDfERIOP
 pSOg==
X-Gm-Message-State: AOAM5300oPTfqTWLSw9yNvzSSAbsvjrmB/HL90SpH78BJuQiVEP4PpJ7
 40c+iP9VbNLGil7SG9KXxOd1lP5ZRrTOdmnVqGMC6usUlYanAovQUPlGjQjmUi66ZGtOlOYSj2Y
 wtg+/OJYsqtxsa8A=
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr2692278wmb.53.1593943050541; 
 Sun, 05 Jul 2020 02:57:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxirFuQmtmWTsM9nGieBKS0Jk/VlohalmlCkiqhmr/qsz7u6D3jsAKhovtjwGvWv46inRbySg==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr2692258wmb.53.1593943050341; 
 Sun, 05 Jul 2020 02:57:30 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id i67sm17186873wma.12.2020.07.05.02.57.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2020 02:57:29 -0700 (PDT)
Subject: Re: [RFC PATCH 4/7] accel/kvm: Simplify kvm_set_sigmask_len()
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200623105052.1700-1-philmd@redhat.com>
 <20200623105052.1700-5-philmd@redhat.com>
 <cc7b7da2-fcf8-5c5c-5c3c-9e96368ddd22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <73417f60-edae-4a7d-4808-eb371e95044a@redhat.com>
Date: Sun, 5 Jul 2020 11:57:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cc7b7da2-fcf8-5c5c-5c3c-9e96368ddd22@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 05:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/20 9:12 AM, Paolo Bonzini wrote:
> On 23/06/20 12:50, Philippe Mathieu-Daudé wrote:
>> The sigmask_len is a property of the accelerator, not the VM.
>> Simplify by directly using the global kvm_state, remove the
>> unnecessary KVMState* argument.
> 
> This is not entirely true, if there were multiple KVMStates how would
> you know which one to read from?  So it would have to be a global variable.

Ah I guess I understand. Thanks for reviewing and queuing the rest!

> 
> Paolo
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  include/sysemu/kvm.h | 2 +-
>>  accel/kvm/kvm-all.c  | 4 ++--
>>  target/mips/kvm.c    | 2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>> index 3662641c99..44c1767a7f 100644
>> --- a/include/sysemu/kvm.h
>> +++ b/include/sysemu/kvm.h
>> @@ -469,7 +469,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
>>  uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
>>  
>>  
>> -void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>> +void kvm_set_sigmask_len(unsigned int sigmask_len);
>>  
>>  #if !defined(CONFIG_USER_ONLY)
>>  int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index afd14492a0..7b3f76f23d 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2240,9 +2240,9 @@ err:
>>      return ret;
>>  }
>>  
>> -void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len)
>> +void kvm_set_sigmask_len(unsigned int sigmask_len)
>>  {
>> -    s->sigmask_len = sigmask_len;
>> +    kvm_state->sigmask_len = sigmask_len;
>>  }
>>  
>>  static void kvm_handle_io(uint16_t port, MemTxAttrs attrs, void *data, int direction,
>> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
>> index 0adfa70210..cc3e09bdef 100644
>> --- a/target/mips/kvm.c
>> +++ b/target/mips/kvm.c
>> @@ -48,7 +48,7 @@ unsigned long kvm_arch_vcpu_id(CPUState *cs)
>>  int kvm_arch_init(MachineState *ms, KVMState *s)
>>  {
>>      /* MIPS has 128 signals */
>> -    kvm_set_sigmask_len(s, 16);
>> +    kvm_set_sigmask_len(16);
>>  
>>      kvm_mips_fpu_cap = kvm_check_extension(KVM_CAP_MIPS_FPU);
>>      kvm_mips_msa_cap = kvm_check_extension(KVM_CAP_MIPS_MSA);
>>
> 


