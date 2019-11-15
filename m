Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E44BC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2322073C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dx1NfYNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2322073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVagv-00068h-7E
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iVafr-0004sk-3Q
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iVafp-0008Ef-0c
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:26:02 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iVafo-0008Ea-Pi
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:26:00 -0500
Received: by mail-wr1-x442.google.com with SMTP id e6so10810982wrw.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 04:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2eA1tdA9Vp0KF0ArCn/9pmdEdHA9aAE9JyEY4YzRnNg=;
 b=Dx1NfYNPWZs7flHQ7KcqNJpVrtwRzriGUDmXjmNYzUp6Zx73YSJhlVmfOAK/+0DxNn
 t0QaRQHArcsskpNUu/qJAPozF2kz5+qzHoTnEGvFJ/zZ4fJfXSrhrag/yxdTAHWGDKFL
 4hBm7Y/6uCNmKo0K54DSiZfF1vAaFVd7yazclFyp5W7hz5iRmZbHDJ2PsFZ/e5kR2mpB
 Joa3ZCAzaciep673yIM4n/by+D/vrwZbtkQNkxa5lZM67FVfBN+swWehZ6tZqKCui4FP
 uzo1PYVGEZXX3VrOG0oLndc9dIiZAsTSUX8uQlB/g+qnVEdFD8mLdHZIVQ7pHafvKGvj
 O7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2eA1tdA9Vp0KF0ArCn/9pmdEdHA9aAE9JyEY4YzRnNg=;
 b=WGUURtAmLOxOWqlf9hPgbUkv2D3Zrc9+XjarMSmvyXUsAQ/dpLHQXUKTF2K4bRi4HS
 1hkWp28GJJOxOC6SOlXAb//VxZLME0GrXcSYm1SLCDIqZ3r9wUyDQvjNjM7C1QjslPwl
 osmpmS20Ct0U3IaqDEI6QA38yiXN/zPSI6moYkUZrJHg/F7P1ePofMdvJtaC0g8ncVBQ
 swm4B5A626HEX1pDh4c90NwZNBgrMixuxI+Ekfh9rDWwF8L8gJO5+uEhQ1EKOLXdQgsO
 BBAgWAzI0kBlMNU3GuGs5r+6tLZjhEw3eYf9DSYKQzoNWP1NLw3HsNA2akrV4sDuBK+d
 o3xg==
X-Gm-Message-State: APjAAAWvwkA8ujoNL/CtKdlbhJNcrCNz11r51Ig6DCzrHeqEMF98dJCW
 qiOlbrBFOF30+W3A393bFxu/KAjU0o0=
X-Google-Smtp-Source: APXvYqwrLxCmQUg/plhp0jA90K6NM19KcfFsvetrsxK984BDMpBP+hDIzlgjs55P1i063hZnXUE6Wg==
X-Received: by 2002:adf:fec5:: with SMTP id q5mr15126722wrs.293.1573820758623; 
 Fri, 15 Nov 2019 04:25:58 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b196sm10083999wmd.24.2019.11.15.04.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 04:25:57 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CD9DB1FF87;
 Fri, 15 Nov 2019 12:25:56 +0000 (GMT)
References: <20191108092247.16207-1-kchamart@redhat.com>
 <f8dce546-ea28-0619-a20a-62c762f99721@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH qemu-web] Add a blog post on "Micro-Optimizing KVM
 VM-Exits"
In-reply-to: <f8dce546-ea28-0619-a20a-62c762f99721@redhat.com>
Date: Fri, 15 Nov 2019 12:25:56 +0000
Message-ID: <87zhgx5nsb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: aarcange@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>,
 dgilbert@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 08/11/2019 10.22, Kashyap Chamarthy wrote:
>> This blog post summarizes the talk "Micro-Optimizing KVM VM-Exits"[1],
>> given by Andrea Arcangeli at the recently concluded KVM Forum 2019.
>>
>
>  Hi Kashyap,
>
> first thanks for writing up this article! It's a really nice summary of
> the presentation, I think.
>
> But before we include it, let me ask a meta-question: Is an article
> about the KVM *kernel* code suitable for the *QEMU* blog? Or is there
> maybe a better place for this, like an article on www.linux-kvm.org ?
>
> Opinions? Ideas?

I don't think it is a particular problem hosting it on the QEMU blog
given the closeness of the two projects. It would get syndicated to
planet.libvirt as well ;-)

>
>  Thomas
>
>
>> ---
>>  ...019-11-06-micro-optimizing-kvm-vmexits.txt | 115 ++++++++++++++++++
>>  1 file changed, 115 insertions(+)
>>  create mode 100644 _posts/2019-11-06-micro-optimizing-kvm-vmexits.txt
>>
>> diff --git a/_posts/2019-11-06-micro-optimizing-kvm-vmexits.txt b/_posts=
/2019-11-06-micro-optimizing-kvm-vmexits.txt
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..f4a28d58ddb40103dd599fdf=
d861eeb4c41ed976
>> --- /dev/null
>> +++ b/_posts/2019-11-06-micro-optimizing-kvm-vmexits.txt
>> @@ -0,0 +1,115 @@
>> +---
>> +layout: post
>> +title: "Micro-Optimizing KVM VM-Exits"
>> +date:   2019-11-08
>> +categories: [kvm, optimization]
>> +---
>> +
>> +Background on VM-Exits
>> +----------------------
>> +
>> +KVM (Kernel-based Virtual Machine) is the Linux kernel module that
>> +allows a host to run virtualized guests (Linux, Windows, etc).  The KVM
>> +"guest execution loop", with QEMU (the open source emulator and
>> +virtualizer) as its user space, is roughly as follows: QEMU issues the
>> +ioctl(), KVM_RUN, to tell KVM to prepare to enter the CPU's "Guest Mode"
>> +-- a special processor mode which allows guest code to safely run
>> +directly on the physical CPU.  The guest code, which is inside a "jail"
>> +and thus cannot interfere with the rest of the system, keeps running on
>> +the hardware until it encounters a request it cannot handle.  Then the
>> +processor gives the control back (referred to as "VM-Exit") either to
>> +kernel space, or to the user space to handle the request.  Once the
>> +request is handled, native execution of guest code on the processor
>> +resumes again.  And the loop goes on.
>> +
>> +There are dozens of reasons for VM-Exits (Intel's Software Developer
>> +Manual outlines 64 "Basic Exit Reasons").  For example, when a guest
>> +needs to emulate the CPUID instruction, it causes a "light-weight exit"
>> +to kernel space, because CPUID (among a few others) is emulated in the
>> +kernel itself, for performance reasons.  But when the kernel _cannot_
>> +handle a request, e.g. to emulate certain hardware, it results in a
>> +"heavy-weight exit" to QEMU, to perform the emulation.  These VM-Exits
>> +and subsequent re-entries ("VM-Enters"), even the light-weight ones, can
>> +be expensive.  What can be done about it?
>> +
>> +Guest workloads that are hard to virtualize
>> +-------------------------------------------
>> +
>> +At the 2019 edition of the KVM Forum in Lyon, kernel developer, Andrea
>> +Arcangeli, attempted to address the kernel part of minimizing VM-Exits.
>> +
>> +His talk touched on the cost of VM-Exits into the kernel, especially for
>> +guest workloads (e.g. enterprise databases) that are sensitive to their
>> +performance penalty.  However, these workloads cannot avoid triggering
>> +VM-Exits with a high frequency.  Andrea then outlined some of the
>> +optimizations he's been working on to improve the VM-Exit performance in
>> +the KVM code path -- especially in light of applying mitigations for
>> +speculative execution flaws (Spectre v2, MDS, L1TF).
>> +
>> +Andrea gave a brief recap of the different kinds of speculative
>> +execution attacks (retpolines, IBPB, PTI, SSBD, etc).  Followed by that
>> +he outlined the performance impact of Spectre-v2 mitigations in context
>> +of KVM.
>> +
>> +The microbechmark: CPUID in a one million loop
>> +----------------------------------------------
>> +
>> +The synthetic microbenchmark (meaning, focus on measuring the
>> +performance of a specific area of code) Andrea used was to run the CPUID
>> +instruction one million times, without any GCC optimizations or caching.
>> +This was done to test the latency of VM-Exits.
>> +
>> +While stressing that the results of these microbenchmarks do not
>> +represent real-world workloads, he had two goals in mind with it: (a)
>> +explain how the software mitigation works; and (b) to justify to the
>> +broader community the value of the software optimizations he's working
>> +on in KVM.
>> +
>> +Andrea then reasoned through several interesting graphs that show how
>> +CPU computation time gets impacted when you disable or enable the
>> +various kernel-space mitigations for Spectre v2, L1TF, MDS, et al.
>> +
>> +The proposal: "KVM Monolithic"
>> +------------------------------
>> +
>> +Based on his investigation, Andrea proposed a patch series, ["KVM
>> +monolithc"](https://lwn.net/Articles/800870/), to get rid of the KVM
>> +common module, 'kvm.ko'.  Instead the KVM common code gets linked twice
>> +into each of the vendor-specific KVM modules, 'kvm-intel.ko' and
>> +'kvm-amd.ko'.
>> +
>> +The reason for doing this is that the 'kvm.ko' module indirectly calls
>> +(via the "retpoline" technique) the vendor-specific KVM modules at every
>> +VM-Exit, several times.  These indirect calls were not optimal before,
>> +but the "retpoline" mitigation (which isolates indirect branches, that
>> +allow a CPU to execute code from arbitrary locations, from speculative
>> +execution) for Spectre v2 compounds the problem, as it degrades
>> +performance.
>> +
>> +This approach will result in a few MiB of increased disk space for
>> +'kvm-intel.ko' and 'kvm-amd.ko', but the upside in saved indirect calls,
>> +and the elimination of "retpoline" overhead at run-time more than
>> +compensate for it.
>> +
>> +With the "KVM Monolithic" patch series applied, Andrea's microbenchmarks
>> +show a double-digit improvement in performance with default mitigations
>> +(for Spectre v2, et al) enabled on both Intel 'VMX' and AMD 'SVM'.  And
>> +with 'spectre_v2=3Doff' or for CPUs with IBRS_ALL in ARCH_CAPABILITIES
>> +"KVM monolithic" still improve[s] performance, albiet it's on the order
>> +of 1%.
>> +
>> +Conclusion
>> +----------
>> +
>> +Removal of the common KVM module has a non-negligible positive
>> +performance impact.  And the "KVM Monolitic" patch series is still
>> +actively being reviewed, modulo some pending clean-ups.  Based on the
>> +upstream review discussion, KVM Maintainer, Paolo Bonzini, and other
>> +reviewers seemed amenable to merge the series.
>> +
>> +Although, we still have to deal with mitigations for 'indirect branch
>> +prediction' for a long time, reducing the VM-Exit latency is important
>> +in general; and more specifically, for guest workloads that happen to
>> +trigger frequent VM-Exits, without having to disable Spectre v2
>> +mitigations on the host, as Andrea stated in the cover letter of his
>> +patch series.
>>


--
Alex Benn=C3=A9e

