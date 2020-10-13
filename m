Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9707C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 04:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498A120872
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 04:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498A120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSCKH-0006P9-CL
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 00:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kSCIy-0005Wy-KI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 00:52:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:60361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kSCIw-0000Lt-07
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 00:52:56 -0400
IronPort-SDR: bPFBYna63dBBeZoF+x2Z5QiSeytknHoUYeWZklqrJ9o67VqWV2U35+/QvCclqDeGBt9tVsBMZK
 +gVDyjMhXqUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165060406"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="165060406"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 21:52:47 -0700
IronPort-SDR: JTyvnc12S1kQiiZJgg4rnYCcYaPtwvgUrkZPyP0bv8wO6HSf5x4alc6NZwBMKoVhy+rMETozEw
 1HoTSMgPCsFg==
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="463353306"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.160])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 21:52:46 -0700
Date: Mon, 12 Oct 2020 21:52:45 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: harry harry <hiharryharryharry@gmail.com>
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
Message-ID: <20201013045245.GA11344@linux.intel.com>
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
 <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
 <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
 <20201012165428.GD26135@linux.intel.com>
 <CA+-xGqPkkiws0bxrzud_qKs3ZmKN9=AfN=JGephfGc+2rn6ybw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-xGqPkkiws0bxrzud_qKs3ZmKN9=AfN=JGephfGc+2rn6ybw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=sean.j.christopherson@intel.com; helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 00:52:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9, PLING_QUERY=0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On Tue, Oct 13, 2020 at 12:30:39AM -0400, harry harry wrote:
> Hi Sean,
> 
> Thank you very much for your thorough explanations. Please see my
> inline replies as follows. Thanks!
> 
> On Mon, Oct 12, 2020 at 12:54 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > No, the guest physical address spaces is not intrinsically tied to the host
> > virtual address spaces.  The fact that GPAs and HVAs are related in KVM is a
> > property KVM's architecture.  EPT/NPT has absolutely nothing to do with HVAs.
> >
> > As Maxim pointed out, KVM links a guest's physical address space, i.e. GPAs, to
> > the host's virtual address space, i.e. HVAs, via memslots.  For all intents and
> > purposes, this is an extra layer of address translation that is purely software
> > defined.  The memslots allow KVM to retrieve the HPA for a given GPA when
> > servicing a shadow page fault (a.k.a. EPT violation).
> >
> > When EPT is enabled, a shadow page fault due to an unmapped GPA will look like:
> >
> >  GVA -> [guest page tables] -> GPA -> EPT Violation VM-Exit
> >
> > The above walk of the guest page tables is done in hardware.  KVM then does the
> > following walks in software to retrieve the desired HPA:
> >
> >  GPA -> [memslots] -> HVA -> [host page tables] -> HPA
> 
> Do you mean that GPAs are different from their corresponding HVAs when
> KVM does the walks (as you said above) in software?

What do you mean by "different"?  GPAs and HVAs are two completely different
address spaces.

