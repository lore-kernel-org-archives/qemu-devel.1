Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45112C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030502065F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMOejQ1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030502065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jskxO-0001AD-92
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jskvS-0007Rc-H5
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:34:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35033
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jskvO-0005LI-Ot
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594118046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FWvHmrLOmxsfYjQ6+vkZm8h8Tzoks4VZnKbjSz7d6Ks=;
 b=DMOejQ1nNgpvMLZOyG3XKuOkZv5uk9TuhsvBg8jJJYDTZl2gJ9nXwwsvPaq4/WAYPCFUG9
 o/2WYXe6So3stbXlj60Sa2eqQm++RcjcybCETyJC4WD8htqruj11uWxzdbeAfo9GD9QQy5
 QrOzQ609QpKA4IaFtnKnHPbBHdjzszQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-ZqGom5-cNROzQeIGKuiUTw-1; Tue, 07 Jul 2020 06:33:59 -0400
X-MC-Unique: ZqGom5-cNROzQeIGKuiUTw-1
Received: by mail-wr1-f69.google.com with SMTP id y13so48197991wrp.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 03:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FWvHmrLOmxsfYjQ6+vkZm8h8Tzoks4VZnKbjSz7d6Ks=;
 b=RBj3LhETyljIXHbKK3CRGIrqGFHzn04d69tGL+3iXzt6LtimawmVK0mQintCkeKhd0
 PKeAxHeznDEc6IwrgsB1NPSTUgr45Pi52PC9ZAc6077o0VWWxkS8ohGHhmOUkKA3vTh2
 ZhpuT1PtX3nJPQ1sBaOUMphLxVTJHPd82vNJg05cAzKHBxzOZFBZgBNO98Xt/WlvN952
 hRf2aclxB0C71HAXrAd7sijod44HchDj19qL5vggyE+AmgO6xBqhf3ftzqTiu4gG/psl
 B/HIPeIEOEZLN42hkenJeVbiYbjBTxrF/+0biWGRCfpFaNkGsqGaOGoeRUycEtp1bk7K
 QdfA==
X-Gm-Message-State: AOAM5327UK20YPTE6ZgEZJWhG+rFdASEriDU9BlyP4mGeGIugqDDSZet
 /1ABbdoyhNbKh9vX5Ik81wryXdI2R9KDIpAbEDvlKd8UNbyEqoQkAlJWAHk/CZpLYuyd9opnroO
 FLtygfrDi3fNom+Y=
X-Received: by 2002:adf:a3d0:: with SMTP id m16mr16645165wrb.232.1594118038280; 
 Tue, 07 Jul 2020 03:33:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP+ztjG93pKZJ6/1fKlSquDTWw4UT+/I6Taf2Fs3oTCmf2O5pjHX3hArpECmsF+KMnv0inxw==
X-Received: by 2002:adf:a3d0:: with SMTP id m16mr16645137wrb.232.1594118037842; 
 Tue, 07 Jul 2020 03:33:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46?
 ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
 by smtp.gmail.com with ESMTPSA id d18sm507885wrj.8.2020.07.07.03.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 03:33:57 -0700 (PDT)
Subject: Re: [qemu-web PATCH] blog post: Anatomy of a Boot, a QEMU perspective
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200703173948.22156-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b10e325-32df-9bc8-99ab-27f26eeed46f@redhat.com>
Date: Tue, 7 Jul 2020 12:33:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200703173948.22156-1-alex.bennee@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/07/20 19:39, Alex Bennée wrote:
> While working on some test cases I realised there was quite a lot of
> assumed knowledge about how things boot up. I thought it would be
> worth gathering this together in a user facing document where we could
> pour in the details and background to the boot process. The consensus
> seems to be this is better as a blog post.
> 
> The post follows the socratic method and leaves the reader to ask
> themselves some questions in an effort to elucidate them about any
> problems they may be having before telling them that they probably
> wanted to use virt-manager all along.
> 
> Based on Message-Id: <20200701161153.30988-2-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> [rth: review of doc form]
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Looks good to me.

Paolo

> 
> ---
> v3
>   - convert from doc to blog post
>   - address pm's comments
>   - new intro/outro for blog style
> ---
>  _posts/2020-07-03-anatomy-of-a-boot.md | 161 +++++++++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 _posts/2020-07-03-anatomy-of-a-boot.md
> 
> diff --git a/_posts/2020-07-03-anatomy-of-a-boot.md b/_posts/2020-07-03-anatomy-of-a-boot.md
> new file mode 100644
> index 0000000..67aa72c
> --- /dev/null
> +++ b/_posts/2020-07-03-anatomy-of-a-boot.md
> @@ -0,0 +1,161 @@
> +---
> +layout: post
> +title:  "Anatomy of a Boot, a QEMU perspective"
> +date:   2020-07-3 18:00:00:00 +0000
> +last_modified_at: 2020-07-3 18:00:00:00 +0000
> +author: Alex Bennée
> +categories: [boot, softmmu, system, firmware]
> +---
> +
> +Have you ever wondered about the process a machine goes through to get
> +to the point of a usable system? This post will give an overview of
> +how machines boot and how this matters to QEMU. We will discuss
> +firmware and BIOSes and the things they do before the OS kernel is
> +loaded and your usable system is finally ready.
> +
> +## Firmware
> +
> +When a CPU is powered up it knows nothing about its environment. The
> +internal state, including the program counter (PC), will be reset to a
> +defined set of values and it will attempt to fetch the first
> +instruction and execute it. It is the job of the firmware to bring a
> +CPU up from the initial few instructions to running in a relatively
> +sane execution environment. Firmware tends to be specific to the
> +hardware in question and is stored on non-volatile memory (memory that
> +survives a power off), usually a ROM or flash device on the computers
> +main board.
> +
> +Some examples of what firmware does include:
> +
> +### Early Hardware Setup
> +
> +Modern hardware often requires configuring before it is usable. For
> +example most modern systems won't have working RAM until the memory
> +controller has been programmed with the correct timings for whatever
> +memory is installed on the system. Processors may boot with a very
> +restricted view of the memory map until RAM and other key peripherals
> +have been configured to appear in its address space. Some hardware
> +may not even appear until some sort of blob has been loaded into it so
> +it can start responding to the CPU.
> +
> +Fortunately for QEMU we don't have to worry too much about this very
> +low level configuration. The device model we present to the CPU at
> +start-up will generally respond to IO access from the processor straight
> +away.
> +
> +### BIOS or Firmware Services
> +
> +In the early days of the PC era the BIOS or Basic Input/Output System
> +provided an abstraction interface to the operating system which
> +allowed the OS to do basic IO operations without having to directly
> +drive the hardware. Since then the scope of these firmware services
> +has grown as systems become more and more complex.
> +
> +Modern firmware often follows the Unified Extensible Firmware
> +Interface (UEFI) which provides services like secure boot, persistent
> +variables and external time-keeping.
> +
> +There can often be multiple levels of firmware service functions. For
> +example systems which support secure execution enclaves generally have
> +a firmware component that executes in this secure mode which the
> +operating system can call in a defined secure manner to undertake
> +security sensitive tasks on its behalf.
> +
> +### Hardware Enumeration
> +
> +It is easy to assume that modern hardware is built to be discoverable
> +and all the operating system needs to do is enumerate the various
> +buses on the system to find out what hardware exists. While buses like
> +PCI and USB do support discovery there is usually much more on a
> +modern system than just these two things.
> +
> +This process of discovery can take some time as devices usually need
> +to be probed and some time allowed for the buses to settle and the
> +probe to complete. For purely virtual machines operating in on-demand
> +cloud environments you may operate with stripped down kernels that
> +only support a fixed expected environment so they can boot as fast as
> +possible.
> +
> +In the embedded world it used to be acceptable to have a similar
> +custom compiled kernel which knew where everything is meant to be.
> +However this was a brittle approach and not very flexible. For example
> +a general purpose distribution would have to ship a special kernel for
> +each variant of hardware you wanted to run on. If you try and use a
> +kernel compiled for one platform that nominally uses the same
> +processor as another platform the result will generally not work.
> +
> +The more modern approach is to have a "generic" kernel that has a
> +number of different drivers compiled in which are then enabled based
> +on a hardware description provided by the firmware. This allows
> +flexibility on both sides. The software distribution is less concerned
> +about managing lots of different kernels for different pieces of
> +hardware. The hardware manufacturer is also able to make small changes
> +to the board over time to fix bugs or change minor components.
> +
> +The two main methods for this are the Advanced Configuration and Power
> +Interface (ACPI) and Device Trees. ACPI originated from the PC world
> +although it is becoming increasingly common for "enterprise" hardware
> +like servers. Device Trees of various forms have existed for a while
> +with perhaps the most common being Flattened Device Trees (FDT).
> +
> +## Boot Code
> +
> +The line between firmware and boot code is a very blurry one. However
> +from a functionality point of view we have moved from ensuring the
> +hardware is usable as a computing device to finding and loading a
> +kernel which is then going to take over control of the system. Modern
> +firmware often has the ability to boot a kernel directly and in some
> +systems you might chain through several boot loaders before the final
> +kernel takes control.
> +
> +The boot loader needs to do 3 things:
> +
> +  - find a kernel and load it into RAM
> +  - ensure the CPU is in the correct mode for the kernel to boot
> +  - pass any information the kernel may need to boot and can't find itself
> +
> +Once it has done these things it can jump to the kernel and let it get
> +on with things.
> +
> +## Kernel
> +
> +The Kernel now takes over and will be in charge of the system from now
> +on. It will enumerate all the devices on the system (again) and load
> +drivers that can control them. It will then locate some sort of
> +file-system and eventually start running programs that actually do
> +work.
> +
> +## Questions to ask yourself
> +
> +Having given this overview of booting here are some questions you
> +should ask when diagnosing boot problems.
> +
> +### Hardware
> +
> + - is the platform fixed or dynamic?
> + - is the platform enumeratable (e.g. PCI/USB)?
> +
> +### Firmware
> +
> + - is the firmware built for the platform you are booting?
> + - does the firmware need storage for variables (boot index etc)?
> + - does the firmware provide a service to kernels (e.g. ACPI/EFI)?
> +
> +### Kernel
> +
> + - is the kernel platform specific or generic?
> + - how will the kernel enumerate the platform?
> + - can the kernel interface talk to the firmware?
> +
> +## Final Thoughts
> +
> +When users visit the IRC channel to ask why a particular kernel won't
> +boot our first response is almost always to check the kernel is
> +actually matched to the hardware being instantiated. For ARM boards in
> +particular just being built for the same processor is generally not
> +enough and hopefully having made it through this post you see why.
> +This complexity is also the reason why we generally suggest using a
> +tool like [virt-manager](https://virt-manager.org/) to configure QEMU
> +as it is designed to ensure the right components and firmware is
> +selected to boot a given system.
> +
> 


