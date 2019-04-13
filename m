Received: from eggs.gnu.org ([209.51.188.92]:38155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hFDzq-0005mJ-8o
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hFDzp-00008L-9V
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:26:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hFDzo-00006q-Ry
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:26:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 078FFC7E87
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 08:26:43 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F11E35C219
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 08:26:42 +0000 (UTC)
Date: Sat, 13 Apr 2019 04:26:41 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1892546178.13440598.1555144001543.JavaMail.zimbra@redhat.com>
In-Reply-To: <55adf1ce-7f21-bff0-c75a-2b7abd2b110e@redhat.com>
References: <20181119182330.17147-1-pbonzini@redhat.com>
	<20181120114422.GA5072@work-vm>
	<f6c43c98-1319-85bb-c379-72d8caacf68d@redhat.com>
	<c348ffd5-a044-bc12-d1a7-50b7ab543045@redhat.com>
	<55adf1ce-7f21-bff0-c75a-2b7abd2b110e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] R: Re: [PATCH v2] target/i386: kvm: add VMX migration
 blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org


----- Cole Robinson <crobinso@redhat.com> ha scritto:
> On 4/12/19 3:47 AM, Paolo Bonzini wrote:
> > On 10/04/19 20:26, Cole Robinson wrote:
> >> On 11/20/18 6:44 AM, Dr. David Alan Gilbert wrote:
> >>> * Paolo Bonzini (pbonzini@redhat.com) wrote:
> >>>> Nested VMX does not support live migration yet.  Add a blocker
> >>>> until that is worked out.
> >>>>
> >>>> Nested SVM only does not support it, but unfortunately it is
> >>>> enabled by default for -cpu host so we cannot really disable it.
> >>>>
> >>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>>
> >>> So I'm OK with this, but it does need a release note warning whenever it
> >>> goes in, because it'll surprise those who've already enabled nesting
> >>> but don't use it on all their VMs.
> >>>
> >>
> >> We are hitting this in Fedora 30. Now that nested VMX is enabled by
> >> default at the kernel level, and virt-manager/boxes will use the
> >> equivalent of -cpu host by default, libvirt managedsave (migrate to
> >> file) and virt-manager snapshots (savevm) are rejected for default
> >> created VMs on intel. That's quite unfortunate.
> >>
> >> Any ideas on how to resolve this?
> > 
> > I think the simplest solution is just to finish implementation of nested
> > VMX live migration and backport it to Fedora 30.
> > 
> 
> That would simplify things :) Any guess on the timeframe? This is kernel
> work I presume?

No, the kernel part is already in. As a contingency plan, you could just revert this QEMU patch.

Paolo

> 
> If changes aren't landing in the near term I think we should disable
> nested VMX by default in Fedora, maybe just with modules.d/kvm.conf
> override. (Or revert this patch downstream, but I presume that's not a
> good idea).
> 
> The alternative of just letting it sit is going to generate a lot of
> complaints I suspect. And the only solutions will be 1) disable nested
> VMx for your whole machine and reboot, or 2) run this virt-xml command
> to disable VMX in your domain config... and probably forget that it's
> there and then a year later when this is all sorted out file a bug
> asking why nested virt isn't working for this one VM ;)
> 
> I guess #2 might not be avoidable anyways for the amount of people that
> have already opted into nested VMX
> 
> Thanks,
> Cole
