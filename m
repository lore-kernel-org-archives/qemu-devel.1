Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342AEC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AAB216B7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqrcPzxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AAB216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hudYF-0006rq-85
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 10:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60939)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hudXL-0006NP-9U
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hudXK-00056M-7U
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:00:31 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hudXK-00053p-1u
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:00:30 -0400
Received: by mail-pf1-x443.google.com with SMTP id r1so39689371pfq.12
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/wy4ViPRWDvx0bz3Qem2DWS/A61LNcdI96nSPoQZO7Q=;
 b=OqrcPzxPBU4o/ROYAzmcRiDWfCh0y6Jo8frZ3nHTDvjwxMLuC3AYHjMHkDeeh7w48h
 0uaLwkLECFspyC6JpWkOPYScr6o7LvM0d7+gPmJ5XUByRoDCHI495emwq412iLJD3XTv
 KhESveGD0roWLaQt7DS6HHLTmPnRXYbTV6LF6+a6CLlrx1gJy5D9W+mPPuUa3FrQn9Ct
 YpGrEFoJTmdXc3o+J45fUKe+jHKde7AAQDNpIXdjaNLQTwwgQEvx2x6YYqmFf0TlHIEc
 fLnmGpl7LnNsReBiMi9tSpIHyEzrFxav/GmykQAOEU2YkieqpVOmSBqKzht1pZ4Xpn6w
 KRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/wy4ViPRWDvx0bz3Qem2DWS/A61LNcdI96nSPoQZO7Q=;
 b=FO+pg7P7s1vSdmX4qAmaFXrzRZda3NBD48ta63kKjE4VKSrqc5wWALIgHUMqySCfwf
 8XkGkNjz6r/z4TArjKv6E05fUDKGBfkGaKr8vphxVbPH6GXkSI3Zh+4MR8gIeSJQaNg8
 RWRi3K/vYtHQSRlwXFwZtxNL8R0YCv+gCPY1MT7i9rdjClydnX554agve46buqTGMD+p
 TNrq/CVnuUrZshWDJd6o/YkMSa8mTX8dx/kjc9omb07wLxxrcJaHoFEhUuA352AKj511
 y0RjPaH1G/ESG/EAx80oCMWtih06TLs60kIG4jiyq/7kvoJN4jriJw3aCqJDm3kgRg36
 1hmQ==
X-Gm-Message-State: APjAAAUsDoLVAYj1vgDzAIjZzKpYgAsGGlBG1NaoM6BEpd9RaW7lcYVp
 e9HtFtKQxDwhH6ZevVt/oUoSfw==
X-Google-Smtp-Source: APXvYqzS2SXsW/nAT0UTDFb8y5gV5wxcDbQ5Tk2+SjQ3slGFXKZIVnZ7cn2KuXG217ZJshX3eNMx7w==
X-Received: by 2002:a17:90a:7f85:: with SMTP id
 m5mr18234603pjl.78.1565013628309; 
 Mon, 05 Aug 2019 07:00:28 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id p20sm108180589pgi.81.2019.08.05.07.00.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 07:00:27 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
 <8736ifkbod.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <db7e63d9-fcf6-fda2-c164-af8f90815617@linaro.org>
Date: Mon, 5 Aug 2019 07:00:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8736ifkbod.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v3 00/34] target/arm: Implement ARMv8.1-VHE
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/19 6:02 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> About half of this patch set is cleanup of the qemu tlb handling
>> leading up to the actual implementation of VHE, and the biggest
>> piece of that: The EL2&0 translation regime.
>>
>> Changes since v2:
>>   * arm_mmu_idx was incomplete; test TGE+E2H not just E2H.
>>   * arm_sctlr was incomplete; now uses arm_mmu_idx to avoid
>>     duplication of tests.
>>   * Update aa64_zva_access and ctr_el0_access for EL2.
>>
>> Changes since v1:
>>   * Merge feedback from AJB.
>>   * Split out 7 renaming patches from "Reorganize ARMMMUIdx".
>>   * Alex's MIDR patch keeps the nested KVM from spitting warnings.
>>
>> I have tested
>>
>>   qemu-system-aarch64 -accel kvm -cpu host -M virt,gic-version-host \
>>     -m 512 -bios /usr/share/edk2/aarch64/QEMU_EFI.fd -nographic
> 
> So testing with a host doing:
> 
>   ./aarch64-softmmu/qemu-system-aarch64 -machine type=virt,virtualization=on -cpu cortex-a57 -serial mon:stdio -nic user,model=virtio-net-pci,hostfwd=tcp::2222-:22 -device virtio-scsi-pci -drive file=/dev/zvol/hackpool-0/debian-buster-arm64,id=hd0,index=0,if=none,format=raw,discard=on -device scsi-hd,drive=hd0 -kernel ../linux.git/builds/arm64/arch/arm64/boot/Image -append "console=ttyAMA0 root=/dev/sda2" -display none -m 4096 -smp 8
> 
> And a guest doing:
> 
>   ./aarch64-softmmu/qemu-system-aarch64 -machine type=virt -cpu host
>   -serial mon:stdio -nic user,model=virtio-net-pci -device
>   virtio-scsi-pci -kernel /boot/vmlinuz-4.19.0-5-arm64 -append "console=ttyAMA0 panic=-1" -display none -m 256 -smp 4 --no-reboot
>   --enable-kvm
> 
> I triggered:
> 
>   ERROR:/home/alex.bennee/lsrc/qemu.git/target/arm/helper.c:3436:update_lpae_el1_asid: code should not be reached
> fish: “./aarch64-softmmu/qemu-system-a…” terminated by signal SIGABRT (Abort)

Whoops.  Rebase error while changing the signature of this function.
Thanks for re-testing the case where VHE isn't present.  :-P

> With -cpu max on the host it hangs the whole thing. I'm going to
> continue to experiment with explicit GIC versions.

Hangs the host?  Are you sure that the guest isn't just slow?
That's why I changed my testing to boot a debug edk2, which
outputs stuff much sooner than the kernel does.

Although I have no idea why the guest should be extra slow.
It does seem like it ought to be booting at the same speed as
the host.  I see tlb flushes as quite high in the profile,
and wonder if I'm doing too many of them.


r~

