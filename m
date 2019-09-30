Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92514C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 19:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56347224D7
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 19:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4vTjQ75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56347224D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF1I4-0007BE-Ec
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 15:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jmattson@google.com>) id 1iF1H4-0006Kr-O8
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jmattson@google.com>) id 1iF1H3-0003o2-8L
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:23:58 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:38579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jmattson@google.com>) id 1iF1H3-0003m0-1D
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:23:57 -0400
Received: by mail-io1-xd42.google.com with SMTP id u8so41337079iom.5
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=te5DLMfWA8onNH/OLne9dKpTPcg6x4Ky9UphxWzylvw=;
 b=T4vTjQ75Y01t3ZuQQZB6uIpMpoB8+HbO+lprqja2QsgE6m8xCvpfYvXTfj4mBsPtPI
 uXbzSqvg0HjmFw5S7dHFu0VH+jiZanNFjDw9FqJbcJWU6tI4PZ/0yYW79+ZVHDDqd2j4
 sYFzZQCOCoB3B/m9iyKCX/USFn+7bD47wTsCUitsnoCPHsXabSbFa25GuRKanox6Yrdq
 2Nj83szPQ8JFUmqoMuRUzFTqC1WNP34vvwaPAK+9BDPdARAa9D6XvRtzj4z2tP371rZp
 hAvJAnILDqzqmjQk91WH/txyoKC1dcUjiGRxwlxMC6w0E7+f/IqNBj9icaikPYO7Hp0u
 ICgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=te5DLMfWA8onNH/OLne9dKpTPcg6x4Ky9UphxWzylvw=;
 b=jZoZAsI8FO5nEZLDyeXuScgonOtg4BxGp/BgAtng8aQ9gOuVXMj8M0peIb407c8Q9a
 fzT8uWZckGhHo/izfI6LRDYve1RkOpQuS62pqr49dgyQOt/kJvIa5PbdHjx6M+CjboJk
 NQhWeXY48X7m1MgPqXkiPDnG20cW2sckHVKlZk91AYgKCwvJTPAG364V6/D1NeG40DsQ
 5wyNYF+qAFKE9ppWUmnO+pyK/8JTn8zsGvCT9evE+kwa9biafANE4j+idLDpNkk/aOey
 93CPBjDVizm9t91iKe79APlKwUNsdGcUcYKLsgPceHZNAGEU+Cgmjgh15XcS3iFBCQxd
 iRew==
X-Gm-Message-State: APjAAAWp13lyH2gCDPQQqGfOn2URtXQorePfKj902iqo5D4UiQMXbJ5N
 /Cgca5rolnSScOYA6CfqHyLWtbHcQT/OzZ1Tpwn+0A==
X-Google-Smtp-Source: APXvYqyh5cl7iTKHGju1AEiNOEY1mvnuS/pE37L9S/BwjAy2cS5ALkcQa2vk5F2+u5JX/YYVahjZalo7eMIaf8j0fcs=
X-Received: by 2002:a05:6638:3:: with SMTP id z3mr15548285jao.54.1569871433117; 
 Mon, 30 Sep 2019 12:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <1545227503-214403-1-git-send-email-robert.hu@linux.intel.com>
 <CALMp9eRZCoZbeyttZdvaCUpOFKygTNVF_x7+TWh6MktmF-ZK9A@mail.gmail.com>
 <263d31d9-b21e-ceb9-b47c-008e30bbd94f@redhat.com>
 <CALMp9eRFWq+F1Dwb8NcBd-Bo-YbT6KMOLo8DoinQQfK9hEi5Qg@mail.gmail.com>
 <20190930175449.GB4084@habkost.net>
In-Reply-To: <20190930175449.GB4084@habkost.net>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 30 Sep 2019 12:23:41 -0700
Message-ID: <CALMp9eR88jE7YV-TmZSSD2oJhEpbsgo-LCgsWHkyFtHcHTmnzw@mail.gmail.com>
Subject: Re: [PATCH] x86: Add CPUID KVM support for new instruction WBNOINVD
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>,
 kvm list <kvm@vger.kernel.org>, Robert Hu <robert.hu@intel.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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

On Mon, Sep 30, 2019 at 10:54 AM Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
>
> CCing qemu-devel.
>
> On Tue, Sep 24, 2019 at 01:30:04PM -0700, Jim Mattson wrote:
> > On Wed, Dec 19, 2018 at 1:02 PM Paolo Bonzini <pbonzini@redhat.com> wro=
te:
> > >
> > > On 19/12/18 18:39, Jim Mattson wrote:
> > > > Is this an instruction that kvm has to be able to emulate before it
> > > > can enumerate its existence?
> > >
> > > It doesn't have any operands, so no.
> > >
> > > Paolo
> > >
> > > > On Wed, Dec 19, 2018 at 5:51 AM Robert Hoo <robert.hu@linux.intel.c=
om> wrote:
> > > >>
> > > >> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > > >> ---
> > > >>  arch/x86/include/asm/cpufeatures.h | 1 +
> > > >>  arch/x86/kvm/cpuid.c               | 2 +-
> > > >>  2 files changed, 2 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include=
/asm/cpufeatures.h
> > > >> index 28c4a50..932b19f 100644
> > > >> --- a/arch/x86/include/asm/cpufeatures.h
> > > >> +++ b/arch/x86/include/asm/cpufeatures.h
> > > >> @@ -280,6 +280,7 @@
> > > >>  /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 1=
3 */
> > > >>  #define X86_FEATURE_CLZERO             (13*32+ 0) /* CLZERO instr=
uction */
> > > >>  #define X86_FEATURE_IRPERF             (13*32+ 1) /* Instructions=
 Retired Count */
> > > >> +#define X86_FEATURE_WBNOINVD           (13*32+ 9) /* Writeback an=
d Don't invalid cache */
> > > >>  #define X86_FEATURE_XSAVEERPTR         (13*32+ 2) /* Always save/=
restore FP error pointers */
> > > >>  #define X86_FEATURE_AMD_IBPB           (13*32+12) /* "" Indirect =
Branch Prediction Barrier */
> > > >>  #define X86_FEATURE_AMD_IBRS           (13*32+14) /* "" Indirect =
Branch Restricted Speculation */
> > > >> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > > >> index cc6dd65..763e115 100644
> > > >> --- a/arch/x86/kvm/cpuid.c
> > > >> +++ b/arch/x86/kvm/cpuid.c
> > > >> @@ -380,7 +380,7 @@ static inline int __do_cpuid_ent(struct kvm_cp=
uid_entry2 *entry, u32 function,
> > > >>
> > > >>         /* cpuid 0x80000008.ebx */
> > > >>         const u32 kvm_cpuid_8000_0008_ebx_x86_features =3D
> > > >> -               F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_S=
SBD) |
> > > >> +               F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SS=
BD) | F(VIRT_SSBD) |
> > > >>                 F(AMD_SSB_NO) | F(AMD_STIBP);
> > > >>
> > > >>         /* cpuid 0xC0000001.edx */
> > > >> --
> > > >> 1.8.3.1
> > > >>
> >
> > What is the point of enumerating support for WBNOINVD if kvm is going
> > to implement it as WBINVD?
>
> I expect GET_SUPPORTED_CPUID to return WBNOINVD, because it
> indicates to userspace what is supported by KVM.  Are there any
> expectations that GET_SUPPORTED_CPUID will also dictate what is
> enabled by default in some cases?
>
> In either case, your question applies to QEMU: why do we want
> WBNOINVD to be enabled by "-cpu host" by default and be part of
> QEMU's Icelake-* CPU model definitions?

I had only looked at the SVM implementation of WBNOINVD, which is
exactly the same as the SVM implementation of WBINVD. So, the question
is, "why enumerate WBNOINVD if its implementation is exactly the same
as WBINVD?"

WBNOINVD appears to be only partially documented in Intel document
319433-037, "Intel=C2=AE Architecture Instruction Set Extensions and Future
Features Programming Reference." In particular, there is no
documentation regarding the instruction's behavior in VMX non-root
mode. Does WBNOINVD cause a VM-exit when the VM-execution control,
"WBINVD exiting," is set? If so, does it have the same VM-exit reason
as WBINVD (54), or a different one? If it does have the same VM-exit
reason (a la SVM), how does one distinguish a WBINVD VM-exit from a
WBNOINVD VM-exit? If one can't distinguish (a la SVM), then it would
seem that the VMX implementation also implements WBNOINVD as WBINVD.
If that's the case, the question for VMX is the same as for SVM.

