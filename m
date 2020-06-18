Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4641DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01BE820732
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rb1XKHx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BE820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlrcX-00039r-9I
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlrbc-0002b5-50
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:17:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60225
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlrbY-0003hw-LS
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592475428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eNFXTpNvHnrhxlT8XD+sb340Pnr62pBIW7mnW3KtYjg=;
 b=Rb1XKHx+B1Qd01TTCPWCP2ibSsSVCr9iUef7ohrpUAk0mlFCSJzHzgXobQ3jqbQOMjVll/
 iQJo66kqKnqb+QIbEBNFUchXxSze4kDyYxcUw7o/V4xd4K2eh1iS/YhbRBUqAGBsPOBhIW
 mOt6w+BUioaKvfcUTzMBtT5w451RJZI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-gnn_eXolMb-oOAbB3UWIZg-1; Thu, 18 Jun 2020 06:17:04 -0400
X-MC-Unique: gnn_eXolMb-oOAbB3UWIZg-1
Received: by mail-wm1-f69.google.com with SMTP id p24so2390419wmc.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 03:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=eNFXTpNvHnrhxlT8XD+sb340Pnr62pBIW7mnW3KtYjg=;
 b=m4WEijYLDRP5+6ew/lsiXrxwpNPZOFM4h7/SHLDtz1PKwj4YMjtI6v6ZvtCofNkX51
 uMqrH8AJuX2qVnDBN+IxI5vwhGHs8PQnaS0Otu7l4A+ickH1idZb5NcygWszanoztZl8
 DULBgIf1CpT7ioVsYwxI1p1AUVUWc7IpuwfB3FqZELe3Sp+FXZEn9KiCbb2mP7uvsqy7
 OzECEEzaW5L32dqpAoUxywDODEfYV2rUmv1C8i59PKHrecehsOwKzQ3IYUS87hyXzWkB
 FAddp80VmNNvsNRFRUdJBx7/v8jtcZCcf7vUc67V7ETeEx3octlz53rnsReD67xhtIBR
 S+pg==
X-Gm-Message-State: AOAM530y8t/VLnWVUsW/9rtvpNwk7rdFRI3wAOaKxNbmNNGy6+qlJ/qS
 5/hRGZ9OC4hSA9SLAHG6LZJZHiEEZtI2kkerGFL6TKRkjoe9a3DcBCiGR1HvnJjnvFJ3CMwSVfN
 uoozbVrT3JGQB+/U=
X-Received: by 2002:a5d:468d:: with SMTP id u13mr4045068wrq.73.1592475422718; 
 Thu, 18 Jun 2020 03:17:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDKxdNAdE50p8A0y5Nvt5rPWpS+LwcxWh8eDSaQuxTOZCQ79VFFn4B2ur+WJHywiUn63AAQQ==
X-Received: by 2002:a5d:468d:: with SMTP id u13mr4045021wrq.73.1592475422237; 
 Thu, 18 Jun 2020 03:17:02 -0700 (PDT)
Received: from [192.168.1.38] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id g3sm3291443wrb.46.2020.06.18.03.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 03:17:01 -0700 (PDT)
Subject: Re: [PATCH] target/arm/kvm: Check supported feature per accelerator
 (not per vCPU)
To: Andrew Jones <drjones@redhat.com>
References: <20200617130800.26355-1-philmd@redhat.com>
 <20200618092208.nn67fgre4h7yjcnt@kamzik.brq.redhat.com>
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
Message-ID: <8729ee44-77dd-ab25-b400-859e59ced160@redhat.com>
Date: Thu, 18 Jun 2020 12:17:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200618092208.nn67fgre4h7yjcnt@kamzik.brq.redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Haibo Xu <haibo.xu@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 11:22 AM, Andrew Jones wrote:
> On Wed, Jun 17, 2020 at 03:08:00PM +0200, Philippe Mathieu-DaudÃ© wrote:
>> Since commit d70c996df23f, when enabling the PMU we get:
>>
>>   $ qemu-system-aarch64 -cpu host,pmu=on -M virt,accel=kvm,gic-version=3
>>   Segmentation fault (core dumped)
>>
>>   Thread 1 "qemu-system-aar" received signal SIGSEGV, Segmentation fault.
>>   0x0000aaaaaae356d0 in kvm_ioctl (s=0x0, type=44547) at accel/kvm/kvm-all.c:2588
>>   2588        ret = ioctl(s->fd, type, arg);
>>   (gdb) bt
>>   #0  0x0000aaaaaae356d0 in kvm_ioctl (s=0x0, type=44547) at accel/kvm/kvm-all.c:2588
>>   #1  0x0000aaaaaae31568 in kvm_check_extension (s=0x0, extension=126) at accel/kvm/kvm-all.c:916
>>   #2  0x0000aaaaaafce254 in kvm_arm_pmu_supported (cpu=0xaaaaac214ab0) at target/arm/kvm.c:213
>>   #3  0x0000aaaaaafc0f94 in arm_set_pmu (obj=0xaaaaac214ab0, value=true, errp=0xffffffffe438) at target/arm/cpu.c:1111
>>   #4  0x0000aaaaab5533ac in property_set_bool (obj=0xaaaaac214ab0, v=0xaaaaac223a80, name=0xaaaaac11a970 "pmu", opaque=0xaaaaac222730, errp=0xffffffffe438) at qom/object.c:2170
>>   #5  0x0000aaaaab5512f0 in object_property_set (obj=0xaaaaac214ab0, v=0xaaaaac223a80, name=0xaaaaac11a970 "pmu", errp=0xffffffffe438) at qom/object.c:1328
>>   #6  0x0000aaaaab551e10 in object_property_parse (obj=0xaaaaac214ab0, string=0xaaaaac11b4c0 "on", name=0xaaaaac11a970 "pmu", errp=0xffffffffe438) at qom/object.c:1561
>>   #7  0x0000aaaaab54ee8c in object_apply_global_props (obj=0xaaaaac214ab0, props=0xaaaaac018e20, errp=0xaaaaabd6fd88 <error_fatal>) at qom/object.c:407
>>   #8  0x0000aaaaab1dd5a4 in qdev_prop_set_globals (dev=0xaaaaac214ab0) at hw/core/qdev-properties.c:1218
>>   #9  0x0000aaaaab1d9fac in device_post_init (obj=0xaaaaac214ab0) at hw/core/qdev.c:1050
>>   ...
>>   #15 0x0000aaaaab54f310 in object_initialize_with_type (obj=0xaaaaac214ab0, size=52208, type=0xaaaaabe237f0) at qom/object.c:512
>>   #16 0x0000aaaaab54fa24 in object_new_with_type (type=0xaaaaabe237f0) at qom/object.c:687
>>   #17 0x0000aaaaab54fa80 in object_new (typename=0xaaaaabe23970 "host-arm-cpu") at qom/object.c:702
>>   #18 0x0000aaaaaaf04a74 in machvirt_init (machine=0xaaaaac0a8550) at hw/arm/virt.c:1770
>>   #19 0x0000aaaaab1e8720 in machine_run_board_init (machine=0xaaaaac0a8550) at hw/core/machine.c:1138
>>   #20 0x0000aaaaaaf95394 in qemu_init (argc=5, argv=0xffffffffea58, envp=0xffffffffea88) at softmmu/vl.c:4348
>>   #21 0x0000aaaaaada3f74 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at softmmu/main.c:48
>>
>> This is because in frame #2, cpu->kvm_state is still NULL
>> (the vCPU is not yet realized).
>>
>> KVM has a hard requirement of all cores supporting the same
>> feature set. We only need to check if the accelerator supports
>> a feature, not each vCPU individually.
>>
>> Fix by kvm_arm_<FEATURE>_supported() functions take a AccelState
>> argument (already realized/valid at this point) instead of a
>> CPUState argument.
>>
>> Reported-by: Haibo Xu <haibo.xu@linaro.org>
>> Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
>> ---
>>  target/arm/kvm_arm.h | 25 +++++++++++++------------
>>  target/arm/cpu.c     |  2 +-
>>  target/arm/cpu64.c   | 10 +++++-----
>>  target/arm/kvm.c     |  4 ++--
>>  target/arm/kvm64.c   | 14 +++++---------
>>  5 files changed, 26 insertions(+), 29 deletions(-)
>>
>> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
>> index 48bf5e16d5..8209525f20 100644
>> --- a/target/arm/kvm_arm.h
>> +++ b/target/arm/kvm_arm.h
>> @@ -12,6 +12,7 @@
>>  #define QEMU_KVM_ARM_H
>>  
>>  #include "sysemu/kvm.h"
>> +#include "sysemu/accel.h"
>>  #include "exec/memory.h"
>>  #include "qemu/error-report.h"
>>  
>> @@ -269,29 +270,29 @@ void kvm_arm_add_vcpu_properties(Object *obj);
>>  
>>  /**
>>   * kvm_arm_aarch32_supported:
>> - * @cs: CPUState
>> + * @as: AccelState
>>   *
>> - * Returns: true if the KVM VCPU can enable AArch32 mode
>> + * Returns: true if the KVM accelerator can enable AArch32 mode
>>   * and false otherwise.
>>   */
>> -bool kvm_arm_aarch32_supported(CPUState *cs);
>> +bool kvm_arm_aarch32_supported(AccelState *as);
>>  
>>  /**
>>   * kvm_arm_pmu_supported:
>> - * @cs: CPUState
>> + * @as: AccelState
>>   *
>> - * Returns: true if the KVM VCPU can enable its PMU
>> + * Returns: true if the KVM accelerator can enable its PMU
>>   * and false otherwise.
>>   */
>> -bool kvm_arm_pmu_supported(CPUState *cs);
>> +bool kvm_arm_pmu_supported(AccelState *as);
>>  
>>  /**
>>   * kvm_arm_sve_supported:
>> - * @cs: CPUState
>> + * @as: AccelState
>>   *
>> - * Returns true if the KVM VCPU can enable SVE and false otherwise.
>> + * Returns true if the KVM accelerator can enable SVE and false otherwise.
>>   */
>> -bool kvm_arm_sve_supported(CPUState *cs);
>> +bool kvm_arm_sve_supported(AccelState *as);
>>  
>>  /**
>>   * kvm_arm_get_max_vm_ipa_size:
>> @@ -359,17 +360,17 @@ static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>>  
>>  static inline void kvm_arm_add_vcpu_properties(Object *obj) {}
>>  
>> -static inline bool kvm_arm_aarch32_supported(CPUState *cs)
>> +static inline bool kvm_arm_aarch32_supported(AccelState *as)
>>  {
>>      return false;
>>  }
>>  
>> -static inline bool kvm_arm_pmu_supported(CPUState *cs)
>> +static inline bool kvm_arm_pmu_supported(AccelState *as)
>>  {
>>      return false;
>>  }
>>  
>> -static inline bool kvm_arm_sve_supported(CPUState *cs)
>> +static inline bool kvm_arm_sve_supported(AccelState *as)
>>  {
>>      return false;
>>  }
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 5b7a36b5d7..29b314427c 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1108,7 +1108,7 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
>>      ARMCPU *cpu = ARM_CPU(obj);
>>  
>>      if (value) {
>> -        if (kvm_enabled() && !kvm_arm_pmu_supported(CPU(cpu))) {
>> +        if (kvm_enabled() && !kvm_arm_pmu_supported(current_accel())) {
>>              error_setg(errp, "'pmu' feature not supported by KVM on this host");
>>              return;
>>          }
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index 778cecc2e6..13835768ab 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -266,7 +266,7 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>>  
>>      /* Collect the set of vector lengths supported by KVM. */
>>      bitmap_zero(kvm_supported, ARM_MAX_VQ);
>> -    if (kvm_enabled() && kvm_arm_sve_supported(CPU(cpu))) {
>> +    if (kvm_enabled() && kvm_arm_sve_supported(current_accel())) {
>>          kvm_arm_sve_get_vls(CPU(cpu), kvm_supported);
>>      } else if (kvm_enabled()) {
>>          assert(!cpu_isar_feature(aa64_sve, cpu));
>> @@ -473,7 +473,7 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
>>          return;
>>      }
>>  
>> -    if (kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
>> +    if (kvm_enabled() && !kvm_arm_sve_supported(current_accel())) {
>>          error_setg(errp, "cannot set sve-max-vq");
>>          error_append_hint(errp, "SVE not supported by KVM on this host\n");
>>          return;
>> @@ -519,7 +519,7 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
>>          return;
>>      }
>>  
>> -    if (value && kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
>> +    if (value && kvm_enabled() && !kvm_arm_sve_supported(current_accel())) {
>>          error_setg(errp, "cannot enable %s", name);
>>          error_append_hint(errp, "SVE not supported by KVM on this host\n");
>>          return;
>> @@ -556,7 +556,7 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
>>          return;
>>      }
>>  
>> -    if (value && kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
>> +    if (value && kvm_enabled() && !kvm_arm_sve_supported(current_accel())) {
>>          error_setg(errp, "'sve' feature not supported by KVM on this host");
>>          return;
>>      }
>> @@ -751,7 +751,7 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
>>       * uniform execution state like do_interrupt.
>>       */
>>      if (value == false) {
>> -        if (!kvm_enabled() || !kvm_arm_aarch32_supported(CPU(cpu))) {
>> +        if (!kvm_enabled() || !kvm_arm_aarch32_supported(current_accel())) {
>>              error_setg(errp, "'aarch64' feature cannot be disabled "
>>                               "unless KVM is enabled and 32-bit EL1 "
>>                               "is supported");
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index eef3bbd1cc..2247a96757 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -208,9 +208,9 @@ void kvm_arm_add_vcpu_properties(Object *obj)
>>      }
>>  }
>>  
>> -bool kvm_arm_pmu_supported(CPUState *cpu)
>> +bool kvm_arm_pmu_supported(AccelState *as)
>>  {
>> -    return kvm_check_extension(cpu->kvm_state, KVM_CAP_ARM_PMU_V3);
>> +    return kvm_check_extension(KVM_STATE(as), KVM_CAP_ARM_PMU_V3);
>>  }
>>  
>>  int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
>> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
>> index f09ed9f4df..ae4e37ce78 100644
>> --- a/target/arm/kvm64.c
>> +++ b/target/arm/kvm64.c
>> @@ -652,18 +652,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>      return true;
>>  }
>>  
>> -bool kvm_arm_aarch32_supported(CPUState *cpu)
>> +bool kvm_arm_aarch32_supported(AccelState *as)
>>  {
>> -    KVMState *s = KVM_STATE(current_accel());
>> -
>> -    return kvm_check_extension(s, KVM_CAP_ARM_EL1_32BIT);
>> +    return kvm_check_extension(KVM_STATE(as), KVM_CAP_ARM_EL1_32BIT);
>>  }
>>  
>> -bool kvm_arm_sve_supported(CPUState *cpu)
>> +bool kvm_arm_sve_supported(AccelState *as)
>>  {
>> -    KVMState *s = KVM_STATE(current_accel());
>> -
>> -    return kvm_check_extension(s, KVM_CAP_ARM_SVE);
>> +    return kvm_check_extension(KVM_STATE(as), KVM_CAP_ARM_SVE);
>>  }
>>  
>>  QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
>> @@ -798,7 +794,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>          env->features &= ~(1ULL << ARM_FEATURE_PMU);
>>      }
>>      if (cpu_isar_feature(aa64_sve, cpu)) {
>> -        assert(kvm_arm_sve_supported(cs));
>> +        assert(kvm_arm_sve_supported(ACCEL(cs->kvm_state)));
> 
> Might as well use current_accel() here too, right?

I was not sure, I used kvm_state since at this point we are
sure it is initialized.

> 
>>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
>>      }
>>  
>> -- 
>> 2.21.3
>>
>>
> 
> At all callsites we pass current_accel() to the kvm_arm_<feat>_supported()
> functions. Is there any reason not to drop their input parameter and just
> use current_accel() internally?

Clever idea :)

> 
> Thanks,
> drew
> 


