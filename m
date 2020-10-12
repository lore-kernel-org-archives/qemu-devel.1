Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDF6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8C92080A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8C92080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS16r-0004qB-Ve
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kS15s-00040b-3B
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:54:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:12892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kS15p-0000jE-2r
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:54:39 -0400
IronPort-SDR: MfZsmm2sy6hdIHYD9zE0g67HSqOC8/+sJopS0mv5j35E7Fz0Yz+gfYUpqY+/zPxYiBvEpkGuYJ
 EajCQ93zr8+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="153600645"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; d="scan'208";a="153600645"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 09:54:29 -0700
IronPort-SDR: jSyO44s9n8XltW8LqS0g9zuGqteZB9zTJR4kslVJ1qFXgSbDZ937/ZbwcMk2FdRlzXkqw3qLIW
 8I5pwW2ivQPA==
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; d="scan'208";a="317983474"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.160])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 09:54:29 -0700
Date: Mon, 12 Oct 2020 09:54:28 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: harry harry <hiharryharryharry@gmail.com>
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
Message-ID: <20201012165428.GD26135@linux.intel.com>
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
 <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
 <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=sean.j.christopherson@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 12:54:32
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, PLING_QUERY=0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, mathieu.tarral@protonmail.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 11, 2020 at 10:11:39AM -0400, harry harry wrote:
> Hi Maxim,
> 
> Thanks much for your reply.
> 
> On Sun, Oct 11, 2020 at 3:29 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> >
> > On Sun, 2020-10-11 at 01:26 -0400, harry harry wrote:
> > > Hi QEMU/KVM developers,
> > >
> > > I am sorry if my email disturbs you. I did an experiment and found the
> > > guest physical addresses (GPAs) are not the same as the corresponding
> > > host virtual addresses (HVAs). I am curious about why; I think they
> > > should be the same. I am very appreciated if you can give some
> > > comments and suggestions about 1) why GPAs and HVAs are not the same
> > > in the following experiment; 2) are there any better experiments to
> > > look into the reasons? Any other comments/suggestions are also very
> > > welcome. Thanks!
> > >
> > > The experiment is like this: in a single vCPU VM, I ran a program
> > > allocating and referencing lots of pages (e.g., 100*1024) and didn't
> > > let the program terminate. Then, I checked the program's guest virtual
> > > addresses (GVAs) and GPAs through parsing its pagemap and maps files
> > > located at /proc/pid/pagemap and /proc/pid/maps, respectively. At
> > > last, in the host OS, I checked the vCPU's pagemap and maps files to
> > > find the program's HVAs and host physical addresses (HPAs); I actually
> > > checked the new allocated physical pages in the host OS after the
> > > program was executed in the guest OS.
> > >
> > > With the above experiment, I found GPAs of the program are different
> > > from its corresponding HVAs. BTW, Intel EPT and other related Intel
> > > virtualization techniques were enabled.
> > >
> > > Thanks,
> > > Harry
> > >
> > The fundemental reason is that some HVAs (e.g. QEMU's virtual memory addresses) are already allocated
> > for qemu's own use (e.g qemu code/heap/etc) prior to the guest starting up.
> >
> > KVM does though use quite effiecient way of mapping HVA's to GPA. It uses an array of arbitrary sized HVA areas
> > (which we call memslots) and for each such area/memslot you specify the GPA to map to. In theory QEMU
> > could allocate the whole guest's memory in one contiguous area and map it as single memslot to the guest.
> > In practice there are MMIO holes, and various other reasons why there will be more that 1 memslot.
> 
> It is still not clear to me why GPAs are not the same as the
> corresponding HVAs in my experiment. Since two-dimensional paging
> (Intel EPT) is used, GPAs should be the same as their corresponding
> HVAs. Otherwise, I think EPT may not work correctly. What do you
> think?

No, the guest physical address spaces is not intrinsically tied to the host
virtual address spaces.  The fact that GPAs and HVAs are related in KVM is a
property KVM's architecture.  EPT/NPT has absolutely nothing to do with HVAs.

As Maxim pointed out, KVM links a guest's physical address space, i.e. GPAs, to
the host's virtual address space, i.e. HVAs, via memslots.  For all intents and
purposes, this is an extra layer of address translation that is purely software
defined.  The memslots allow KVM to retrieve the HPA for a given GPA when
servicing a shadow page fault (a.k.a. EPT violation).

When EPT is enabled, a shadow page fault due to an unmapped GPA will look like:

 GVA -> [guest page tables] -> GPA -> EPT Violation VM-Exit

The above walk of the guest page tables is done in hardware.  KVM then does the
following walks in software to retrieve the desired HPA:

 GPA -> [memslots] -> HVA -> [host page tables] -> HPA

KVM then takes the resulting HPA and shoves it into KVM's shadow page tables,
or when TDP is enabled, the EPT/NPT page tables.  When the guest is run with
TDP enabled, GVA->HPA translations look like the following, with all walks done
in hardware.

 GVA -> [guest page tables] -> GPA -> [extended/nested page tables] -> HPA

