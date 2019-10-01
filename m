Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E954FECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CC220B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWtd59gQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CC220B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFNw4-0001e8-Ca
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 15:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jmattson@google.com>) id 1iFNnb-0004CN-Er
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jmattson@google.com>) id 1iFNna-0001BT-3b
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:27:03 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:37532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jmattson@google.com>) id 1iFNnZ-0001AK-TL
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:27:02 -0400
Received: by mail-io1-xd44.google.com with SMTP id b19so22931108iob.4
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 12:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CDB4Mr0iG0b8DZwf+9GVE2W/2/4rQLMQuTsEyTKgfxg=;
 b=XWtd59gQjCBrAcOGNEPfbnOmeyLmC8q+y7bnqdcqPPAzsEIqnwuf8b7G/Ykbf2omhf
 qSOmk8/mV4JnCZvGjSKNBoEX0S1OOYXBxd+7YRWt/O52zkwcPPb/2fJAe5SqAVMTWyK5
 zjjkfAkywB0pP1bzx9ZlwC2xNzUCzeJ63dltV9z/0FMtS9BNIXcnUixa1nmw7tGWks2r
 7HDJCH54iauzKpQMM0kDcgTdg/NeUOCNYTAfxxvPhJIOCP8r7ISWPPZkqCL73GmmeOz6
 4fhbzzAZ1mZfgJZD49knx5oA/icUZ1tdbNKPlfgZuRJf+kHsRsqFGT9syWeP9yFVtGRN
 bI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CDB4Mr0iG0b8DZwf+9GVE2W/2/4rQLMQuTsEyTKgfxg=;
 b=a3rOd6wgVpSkBqfXzQaL5OrwNQtn8fdLWnYoi41jVO97HutzWn2AlAV7HgSvP7vRSW
 cVcvGH50bMSgng7nIoDrJTIqK0ZRckz4z/3jpU+6iZnQ0hu/3mijPXTVWcRuPARoWhxd
 wggdb8bVGblhON0ddPajoksNzh12S4Wsp7Yrh8t0FBNiPGksC6py6AQoxF3lE+NIuECn
 29JAX5X4m59RoTTZyTxvI4YdkPqz5p69Lak86kjJhKBsxFx1xgIYeFDuUKsSCaKHLNYK
 HXsmeG29I8pdykd/AT6D+YzYGKMZdx598oMeWXPkjisTlmXvDSl2xTzDrvsxki3k/efz
 DvvQ==
X-Gm-Message-State: APjAAAWh0w7a5S51MSR6BP6RyxnBBRoPSPe6Ltla/iFbA0wE8iovUjiy
 W3yQ/TBMOqWy21DpxyYLf8yby1v5OpUmna5rob1JwQ==
X-Google-Smtp-Source: APXvYqxa+XAZgS+BaZXqlx3MCcJxVxQdpqq/kdyykgpz0c7smVyWi9Y90pI/20bwlYl6cLmvD7qHH6A0LIJEnSELKek=
X-Received: by 2002:a6b:6a01:: with SMTP id x1mr6160792iog.119.1569958020338; 
 Tue, 01 Oct 2019 12:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <1545227503-214403-1-git-send-email-robert.hu@linux.intel.com>
 <CALMp9eRZCoZbeyttZdvaCUpOFKygTNVF_x7+TWh6MktmF-ZK9A@mail.gmail.com>
 <263d31d9-b21e-ceb9-b47c-008e30bbd94f@redhat.com>
 <CALMp9eRFWq+F1Dwb8NcBd-Bo-YbT6KMOLo8DoinQQfK9hEi5Qg@mail.gmail.com>
 <20190930175449.GB4084@habkost.net>
 <CALMp9eR88jE7YV-TmZSSD2oJhEpbsgo-LCgsWHkyFtHcHTmnzw@mail.gmail.com>
 <9bbe864ab8fb16d9e64745b930c89b1db24ccc3a.camel@intel.com>
 <CALMp9eSe_7on+F=ng05DkvvBpnWhSirEpSVz9Bua4Sy606xJnw@mail.gmail.com>
 <20191001170646.GA27090@linux.intel.com>
 <CALMp9eSj=KJC6SjOnPfN7R0vHB_75KjBeF3aYD2J75Sy3L7tcA@mail.gmail.com>
 <20191001175415.GB27090@linux.intel.com>
In-Reply-To: <20191001175415.GB27090@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 1 Oct 2019 12:26:48 -0700
Message-ID: <CALMp9eTrP2FHA0+cwU7SPwsitJ7PA1gRe1i2xAJ0Lx9QWxV17A@mail.gmail.com>
Subject: Re: [PATCH] x86: Add CPUID KVM support for new instruction WBNOINVD
To: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Huang, Kai" <kai.huang@intel.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, 
 "robert.hu@linux.intel.com" <robert.hu@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hu, Robert" <robert.hu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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

On Tue, Oct 1, 2019 at 10:54 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Oct 01, 2019 at 10:23:31AM -0700, Jim Mattson wrote:
> > On Tue, Oct 1, 2019 at 10:06 AM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > On Tue, Oct 01, 2019 at 07:20:17AM -0700, Jim Mattson wrote:
> > > > On Mon, Sep 30, 2019 at 5:45 PM Huang, Kai <kai.huang@intel.com> wr=
ote:
> > > > >
> > > > > On Mon, 2019-09-30 at 12:23 -0700, Jim Mattson wrote:
> > > > > > On Mon, Sep 30, 2019 at 10:54 AM Eduardo Habkost <ehabkost@redh=
at.com> wrote:
> > > > > > I had only looked at the SVM implementation of WBNOINVD, which =
is
> > > > > > exactly the same as the SVM implementation of WBINVD. So, the q=
uestion
> > > > > > is, "why enumerate WBNOINVD if its implementation is exactly th=
e same
> > > > > > as WBINVD?"
> > > > > >
> > > > > > WBNOINVD appears to be only partially documented in Intel docum=
ent
> > > > > > 319433-037, "Intel=C2=AE Architecture Instruction Set Extension=
s and Future
> > > > > > Features Programming Reference." In particular, there is no
> > > > > > documentation regarding the instruction's behavior in VMX non-r=
oot
> > > > > > mode. Does WBNOINVD cause a VM-exit when the VM-execution contr=
ol,
> > > > > > "WBINVD exiting," is set? If so, does it have the same VM-exit =
reason
> > > > > > as WBINVD (54), or a different one? If it does have the same VM=
-exit
> > > > > > reason (a la SVM), how does one distinguish a WBINVD VM-exit fr=
om a
> > > > > > WBNOINVD VM-exit? If one can't distinguish (a la SVM), then it =
would
> > > > > > seem that the VMX implementation also implements WBNOINVD as WB=
INVD.
> > > > > > If that's the case, the question for VMX is the same as for SVM=
.
> > > > >
> > > > > Unfortunately WBNOINVD interaction with VMX has not been made to =
public yet.
> > >
> > > Hint: WBNOINVD uses a previously ignored prefix, i.e. it looks a *lot=
*
> > >       like WBINVD...
> >
> > Because of the opcode selection, I would assume that we're not going
> > to see a VM-execution control for "enable WBNOINVD." To avoid breaking
> > legacy hypervisors, then, I would expect the "enable WBINVD exiting"
> > control to apply to WBNOINVD as well, and I would expect the exit
> > reason to be the same for both instructions. The exit qualification
> > field is cleared for WBINVD exits, so perhaps we will see a bit in
> > that field set to one for WBNOINVD.
>
> Those are all excellent assumptions.
>
> > If so, will this new behavior be indicated by a bit in one of the VMX
> > capability MSRs?
>
> My crystal ball came up blank on this one.
>
> > That seems to be a closely guarded secret, for some reason.
>
> Not a closely guarded secret, just poor documentation.
>
> > > > > I am reaching out internally to see when it can be done. I agree =
it may not be
> > > > > necessary to expose WBNOINVD if its implementation is exactly the=
 same as
> > > > > WBINVD, but it also doesn't have any harm, right?
> > > >
> > > > If nested VMX changes are necessary to be consistent with hardware,
> > > > then enumerating WBNOINVD support in the guest CPUID information at
> > > > this time--without the attendant nested VMX changes--is premature. =
No
> > > > changes to nested SVM are necessary, so it's fine for AMD systems.
> > > >
> > > > If no changes to nested VMX are necessary, then it is true that
> > > > WBNOINVD can be emulated by WBINVD. However, it provides no value t=
o
> > > > specifically enumerate the instruction.
> > > >
> > > > If there is some value that I'm missing, then why make guest suppor=
t
> > > > for the instruction contingent on host support for the instruction?
> > > > KVM can implement WBNOINVD as WBINVD on any host with WBINVD,
> > > > regardless of whether or not the host supports WBNOINVD.
> > >
> > > Agreed.  To play nice with live migration, KVM should enumerate WBNOI=
NVD
> > > regardless of host support.  Since WBNOINVD uses an ignored prefix, i=
t
> > > will simply look like a regular WBINVD on platforms without WBNOINVD.
> > >
> > > Let's assume the WBNOINVD VM-Exit behavior is sane, i.e. allows softw=
are
> > > to easily differentiate between WBINVD and WBNOINVD.
> >
> > That isn't the case with SVM, oddly.
>
> Assuming AMD uses the same opcode as Intel, maybe they're expecting VMMs
> to use the decode assist feature to check for the prefix?

There are no specific decode assists for WBINVD/WBNOINVD in the
EXITINFO* fields. The "generic" decode assist, where the instruction
bytes are stored in the VMCB, only applies to nested page faults and
#PF intercepts.

> > > In that case, the
> > > value added would be that KVM can do WBNOINVD instead of WBINVD in th=
e
> > > unlikely event that (a) KVM needs to executed WBINVD on behalf of the
> > > guest (because the guest has non-coherent DMA), (b) WBNOINVD is suppo=
rted
> > > on the host, and (c) WBNOINVD is used by the guest (I don't think it =
would
> > > be safe to assume that the guest doesn't need the caches invalidated =
on
> > > WBINVD).
> >
> > I agree that there would be value if KVM implemented WBNOINVD using
> > WBNOINVD, but that isn't what this change does. My question was, "What
> > is the value in enumerating WBNOINVD if KVM is just going to implement
> > it with WBINVD anyway?"
>
> Ah, I was stating what I would expect the KVM change to be, I didn't
> realize this patch was merged almost a year ago.
>
> I suppose theoretically it would allow live migrating from an old kernel
> to a new kernel and gaining actual WBNOINVD support along the way?

