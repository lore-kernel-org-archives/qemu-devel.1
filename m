Received: from eggs.gnu.org ([2001:4830:134:3::10]:46837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cReZC-0004X8-HD
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cReZ7-0000bg-JK
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:33:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cReZ7-0000bM-B7
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:33:13 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB7CC83F3A
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 12:33:11 +0000 (UTC)
Date: Thu, 12 Jan 2017 10:33:08 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170112123308.GH3565@thinpad.lan.raisama.net>
References: <20170108194041.10908-1-ehabkost@redhat.com>
	<20170109113553.GC2541@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170109113553.GC2541@work-vm>
Subject: Re: [Qemu-devel] [PATCH 0/5] Use non-blacklisted
 family/model/stepping for Haswell CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, fweimer@redhat.com, carlos@redhat.com, triegel@redhat.com, berrange@redhat.com, jdenemar@redhat.com, pbonzini@redhat.com

On Mon, Jan 09, 2017 at 11:35:54AM +0000, Dr. David Alan Gilbert wrote:
> * Eduardo Habkost (ehabkost@redhat.com) wrote:
> > A recent glibc commit[1] added a blacklist to ensure it won't use
> > TSX on hosts that are known to have a broken TSX implementation.
> > 
> > Our existing Haswell CPU model has a blacklisted
> > family/model/stepping combination, so it has to be updated to
> > make sure guests will really use TSX. This is done by patch 5/5.
> > 
> > However, to do this safely we need to ensure the host CPU is not
> > a blacklisted one, so we won't mislead guests by exposing
> > known-to-be-good FMS values on a known-to-be-broken host. This is
> > done by patch 3/5.
> 
> I'd just like to mke sure I understand the way this will fail in a migration;
> lets say we have a guest that doesn't have the new libc and hosts
> with a blacklisted CPU, and -cpu Haswell.
> 
> If I understand correctly then:
>   a) With 'enforce' the destination qemu will fail to start
>      printing an error about the host lack of tsx feature.

Yes.

>   b) Without 'enforce' the destination will start but print 
>      the same error as a warning, but the guest will probably
>      break as soon as it tries to use a tsx feature?

Yes. The general rule is: without "enforce", live migration can
break in unpredictable ways.

Without "enforce", QEMU will print a warning, and the VCPU will
run _without_ the TSX features on CPUID. If we're live-migrating,
it may break the guest if it tries to use a TSX feature, or break
migration if a TSX-related bit is already set on a MSR.


> 
> Any other combination?
> 
> Dave
> 
> > [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=2702856bf45c82cf8e69f2064f5aa15c0ceb6359
> > 
> > ---
> > Cc: dgilbert@redhat.com
> > Cc: fweimer@redhat.com
> > Cc: carlos@redhat.com
> > Cc: triegel@redhat.com
> > Cc: berrange@redhat.com
> > Cc: jdenemar@redhat.com
> > Cc: pbonzini@redhat.com
> > 
> > Eduardo Habkost (5):
> >   i386: Add explicit array size to x86_cpu_vendor_words2str()
> >   i386: host_vendor_fms() helper function
> >   i386/kvm: Blacklist TSX on known broken hosts
> >   pc: Add 2.9 machine-types
> >   i386: Change stepping of Haswell to non-blacklisted value
> > 
> >  include/hw/i386/pc.h |  6 ++++++
> >  target/i386/cpu.h    |  1 +
> >  hw/i386/pc_piix.c    | 15 ++++++++++++---
> >  hw/i386/pc_q35.c     | 13 +++++++++++--
> >  target/i386/cpu.c    | 32 ++++++++++++++++++++++----------
> >  target/i386/kvm.c    | 17 +++++++++++++++++
> >  6 files changed, 69 insertions(+), 15 deletions(-)
> > 
> > -- 
> > 2.11.0.259.g40922b1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Eduardo
