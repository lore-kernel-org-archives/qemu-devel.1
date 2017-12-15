Received: from eggs.gnu.org ([2001:4830:134:3::10]:37443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePsaX-0005wG-Fs
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePsaU-0007J0-7J
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:11:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePsaU-0007Hu-22
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:11:50 -0500
Date: Fri, 15 Dec 2017 16:11:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171215161139.GD2358@work-vm>
References: <20171213180807.7066-1-dgilbert@redhat.com>
	<20171213180807.7066-5-dgilbert@redhat.com>
	<20171214162731.50a95633@redhat.com>
	<20171215133022.GD14126@work-vm>
	<3b22f588-f7be-d1e2-9b72-072308fe8218@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b22f588-f7be-d1e2-9b72-072308fe8218@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/6] vhost: add regions to temporary list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, maxime.coquelin@redhat.com, groug@kaod.org, mst@redhat.com

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 15/12/2017 14:30, Dr. David Alan Gilbert wrote:
> >> Also it seems that we have a race in current code where
> >> region_del() unrefs memory region first and then by the
> >> commit time memory region could be gone since old flatview
> >> is unreffed before commit callback is called, but guest still
> >> uses old memory map until vhost_set_mem_table() is complete.
> >> We probably should unref deleted(old) sections after
> >> guest gets new memmap.
> >
> > Will they really get cleaned up before the commit() returns?
> > There's no rcu like thing guarding it?
> 
> The memory subsystem only keeps them alive until before commmit() is
> invoked.

Hmm ok; I guess then we do need to keep the temporary list of
MemoryRegionSections and unref all the old ones after the end of the callback.

I'll rework it (again).

Dave


> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
