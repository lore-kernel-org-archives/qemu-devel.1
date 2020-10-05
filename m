Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F277C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECF420774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5rhEsFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECF420774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPMiq-0000N7-P4
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 05:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPMi3-0008FD-OT
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPMi1-0006vt-Oi
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601889783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ugm8HlWBBQwIq6YqZ4bqZwMlHXIN2IqfB12xnKXSLh4=;
 b=N5rhEsFOBsey02mbxiPY3OXxtRz7FnQSNOnpz+3449i+O0VHSc2yNbMYee0hb11Tk8Gzcy
 r5GvTqcBFTFU4OAF3oS8DL74wQ35wHW98hzpwv+TlDAoylTDhMHBEpfmluX2qJr812Qm5J
 HEcs599ZxclVUYvAlmmpTBMA7d1nYCA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-Lvo6zaafP0edDBk7j1THhA-1; Mon, 05 Oct 2020 05:22:58 -0400
X-MC-Unique: Lvo6zaafP0edDBk7j1THhA-1
Received: by mail-wm1-f69.google.com with SMTP id 13so2217679wmf.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 02:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ugm8HlWBBQwIq6YqZ4bqZwMlHXIN2IqfB12xnKXSLh4=;
 b=lEXAwKiBRXby6sf2sPTcB0CzofL5B39tNzI8ylj49XreOZntJ/5iYLy5DVF6XU/inm
 s/rzZTJdugZmZPRu5exb+HWc2rJnINNFbxsVOgQn5gcEHy2K7iabpBAyRMxQot8ioTQL
 W+l6vJr/SDAy9gnExkBvf5024aqL/KdCX6EntET9x+gVCd6sfvFgo5UFHrPFkvZkfPsJ
 GG1tfg8UcIAucU4SKM+8wBTv1UosslaQAzlPEclc7Cq1TRo3spslo5o+bJBnFPL2UlNC
 qQkDRq7YRywsQl10L2ENHHwK2zCJdg8BRRct7GvB52P+hLEMEfHJiFc/ucJnfZmU0uoy
 05Sw==
X-Gm-Message-State: AOAM532dJ+o21pCKocHn2fMQmO0czLmuNEONy4/7bfTzAiFRDxb+fCA8
 FC4LPrNlb73oSTjgfjuHQY+myAz2dBk6NqMGhl8OyWFhkffTQ3NOP8VbGUHsAKLmqxV+vJWE67p
 mXsnI9P33xRtqsuc=
X-Received: by 2002:adf:dd46:: with SMTP id u6mr5188160wrm.295.1601889777099; 
 Mon, 05 Oct 2020 02:22:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrKIsZvC6VCHHIw4whcHXW+LhIfZVH91rvZ5S3upGP+1eW7tYsX6+I6wejZGnSuKWVujq9IA==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr5188134wrm.295.1601889776884; 
 Mon, 05 Oct 2020 02:22:56 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a7sm11085392wmh.6.2020.10.05.02.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 02:22:56 -0700 (PDT)
Subject: Re: [PATCH v3 17/19] hw/arm: Automatically select the 'virt' machine
 on KVM
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-18-philmd@redhat.com>
 <CAFEAcA-Rt__Du0TqqVFov4mNoBvC9hTt7t7e-3G45Eck4z94tQ@mail.gmail.com>
 <CAFEAcA-u53dVdv8EJdeeOWxw+SfPJueTq7M6g0vBF5XM2Go4zw@mail.gmail.com>
 <c7d07e18-57dd-7b55-f3dc-283c9d13e4b5@redhat.com>
 <8253ddd7-3149-17d9-1174-6474c4bde605@redhat.com>
 <36629bed-9b32-01a0-fdc2-831b10e4bad9@redhat.com>
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
Message-ID: <f3b931f5-c785-1d98-edd1-e5fcc91ff0ce@redhat.com>
Date: Mon, 5 Oct 2020 11:22:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <36629bed-9b32-01a0-fdc2-831b10e4bad9@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 5:05 PM, Philippe Mathieu-Daudé wrote:
> On 10/1/20 9:38 AM, Paolo Bonzini wrote:
>> On 29/09/20 22:36, Philippe Mathieu-Daudé wrote:
>>> Yes, the problem if I don't restrict to KVM, when
>>> using the Xen accelerator odd things occur
>>> (using configure --enable-xen --disable-tcg --disable-kvm):
>>>
>>> Compiling C object libqemu-i386-softmmu.fa.p/hw_cpu_a15mpcore.c.o
>>> hw/cpu/a15mpcore.c:28:10: fatal error: kvm_arm.h: No such file or directory
>>>
>>> See
>>> https://wiki.xenproject.org/wiki/Xen_ARM_with_Virtualization_Extensions#Use_of_qemu-system-i386_on_ARM
>>
>> I don't understand.  Is Xen adding CONFIG_ARM_VIRT=y to
>> default-configs/i386-softmmu.mak??
> 
> No, this is when using:
> 
>  config ARM_VIRT
>      bool
> +    default y
> 
> I had the understanding devices in hw/$BASEARCH would be only
> included for $ARCH, but I was wrong, any arch kconfig-include
> the devices of the other archs.
> 
> I tried the following diff which doesn't build because various
> devices in *non*-archdep folders use arch-specific Kconfig values:
> 
> -- >8 --
> diff --git a/meson.build b/meson.build
> index 9ab5d514d7..cfe19d0007 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -575,6 +575,7 @@ foreach target : target_dirs
>      if fs.is_file(target_kconfig)
>        minikconf_input += [target_kconfig]
>      endif
> +    minikconf_input += 'hw' / config_target['TARGET_BASE_ARCH'] / 'Kconfig'
>      config_devices_mak = configure_file(
>        input: minikconf_input,
>        output: config_devices_mak,
> diff --git a/hw/Kconfig b/hw/Kconfig
> index 4de1797ffd..64c120175a 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -41,29 +41,29 @@ source vfio/Kconfig
>  source watchdog/Kconfig
> 
>  # arch Kconfig
> -source arm/Kconfig
> -source alpha/Kconfig
> -source avr/Kconfig
> -source cris/Kconfig
> -source hppa/Kconfig
> -source i386/Kconfig
> -source lm32/Kconfig
> -source m68k/Kconfig
> -source microblaze/Kconfig
> -source mips/Kconfig
> -source moxie/Kconfig
> -source nios2/Kconfig
> -source openrisc/Kconfig
> -source ppc/Kconfig
> -source riscv/Kconfig
> -source rx/Kconfig
> -source s390x/Kconfig
> -source sh4/Kconfig
> -source sparc/Kconfig
> -source sparc64/Kconfig
> -source tricore/Kconfig
> -source unicore32/Kconfig
> -source xtensa/Kconfig
> 
>  # Symbols used by multiple targets
>  config TEST_DEVICES
> ---

List of arch-indep Kconfig using arch-defined selectors:

hw/acpi/Kconfig:42:    depends on PC
hw/intc/Kconfig:31:    depends on ARM_GIC && KVM
hw/intc/Kconfig:36:    depends on OPENPIC && KVM
hw/intc/Kconfig:40:    depends on POWERNV || PSERIES
hw/intc/Kconfig:49:    depends on XICS && KVM
hw/intc/Kconfig:60:    depends on S390_FLIC && KVM
hw/mem/Kconfig:11:    depends on (PC || PSERIES || ARM_VIRT)
hw/pci-bridge/Kconfig:8:    default y if Q35
hw/timer/Kconfig:14:    default y if PC
hw/tpm/Kconfig:18:    depends on TPM && PC
hw/tpm/Kconfig:24:    depends on TPM && PSERIES
hw/vfio/Kconfig:16:    depends on LINUX && S390_CCW_VIRTIO
hw/vfio/Kconfig:38:    depends on LINUX && S390_CCW_VIRTIO


