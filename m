Received: from eggs.gnu.org ([2001:4830:134:3::10]:33628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQYFB-0005RG-Af
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQYF8-00060o-6v
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:36:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cQYF8-0005yo-15
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:36:02 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0905C05AA4F
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 11:35:59 +0000 (UTC)
Date: Mon, 9 Jan 2017 11:35:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170109113553.GC2541@work-vm>
References: <20170108194041.10908-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170108194041.10908-1-ehabkost@redhat.com>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, fweimer@redhat.com, carlos@redhat.com, triegel@redhat.com, berrange@redhat.com, jdenemar@redhat.com, pbonzini@redhat.com

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> A recent glibc commit[1] added a blacklist to ensure it won't use
> TSX on hosts that are known to have a broken TSX implementation.
> 
> Our existing Haswell CPU model has a blacklisted
> family/model/stepping combination, so it has to be updated to
> make sure guests will really use TSX. This is done by patch 5/5.
> 
> However, to do this safely we need to ensure the host CPU is not
> a blacklisted one, so we won't mislead guests by exposing
> known-to-be-good FMS values on a known-to-be-broken host. This is
> done by patch 3/5.

I'd just like to mke sure I understand the way this will fail in a migration;
lets say we have a guest that doesn't have the new libc and hosts
with a blacklisted CPU, and -cpu Haswell.

If I understand correctly then:
  a) With 'enforce' the destination qemu will fail to start
     printing an error about the host lack of tsx feature.
  b) Without 'enforce' the destination will start but print 
     the same error as a warning, but the guest will probably
     break as soon as it tries to use a tsx feature?

Any other combination?

Dave

> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=2702856bf45c82cf8e69f2064f5aa15c0ceb6359
> 
> ---
> Cc: dgilbert@redhat.com
> Cc: fweimer@redhat.com
> Cc: carlos@redhat.com
> Cc: triegel@redhat.com
> Cc: berrange@redhat.com
> Cc: jdenemar@redhat.com
> Cc: pbonzini@redhat.com
> 
> Eduardo Habkost (5):
>   i386: Add explicit array size to x86_cpu_vendor_words2str()
>   i386: host_vendor_fms() helper function
>   i386/kvm: Blacklist TSX on known broken hosts
>   pc: Add 2.9 machine-types
>   i386: Change stepping of Haswell to non-blacklisted value
> 
>  include/hw/i386/pc.h |  6 ++++++
>  target/i386/cpu.h    |  1 +
>  hw/i386/pc_piix.c    | 15 ++++++++++++---
>  hw/i386/pc_q35.c     | 13 +++++++++++--
>  target/i386/cpu.c    | 32 ++++++++++++++++++++++----------
>  target/i386/kvm.c    | 17 +++++++++++++++++
>  6 files changed, 69 insertions(+), 15 deletions(-)
> 
> -- 
> 2.11.0.259.g40922b1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
