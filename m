Received: from eggs.gnu.org ([2001:4830:134:3::10]:51389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@intel.com>) id 1ebLS6-0004gw-8a
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@intel.com>) id 1ebLS2-0006vE-5T
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:14:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:10636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@intel.com>) id 1ebLS1-0006tT-SW
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:14:30 -0500
Message-ID: <1516086863.28212.27.camel@intel.com>
From: He Junyan <junyan.he@intel.com>
Date: Tue, 16 Jan 2018 15:14:23 +0800
In-Reply-To: <CAJSP0QU8YGzLo0mVL-VCWzebk1iE-ZV1XQPkOJ7pq69Ch6GtnA@mail.gmail.com>
References: <EC8A4E314CF1574AB62C80421BD9833933FEE069@SHSMSX104.ccr.corp.intel.com>
	<20180109153538.GC1197@stefanha-x1.localdomain>
	<20180109195517.GD2708@work-vm>
	<CAJSP0QVm+AoRoFNYx-r1k0WTPPopm60dmD7OhGZozm9ARfMwRQ@mail.gmail.com>
	<20180110201519.GF2451@work-vm>
	<CAJSP0QU8YGzLo0mVL-VCWzebk1iE-ZV1XQPkOJ7pq69Ch6GtnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Some question about savem/qcow2 incremental
 snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>

On 三, 2018-01-10 at 20:17 +0000, Stefan Hajnoczi wrote:
> On Wed, Jan 10, 2018 at 8:15 PM, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> > 
> > * Stefan Hajnoczi (stefanha@gmail.com) wrote:
> > > 
> > > On Tue, Jan 9, 2018 at 7:55 PM, Dr. David Alan Gilbert
> > > <dgilbert@redhat.com> wrote:
> > > > 
> > > > > 
> > > > > Certain guest operations like rebooting or zeroing memory
> > > > > will defeat
> > > > > the incremental guest RAM snapshot feature.  It's worth
> > > > > thinking about
> > > > > these cases to make sure this feature would be worth it in
> > > > > real use
> > > > > cases.
> > > > But those probably wouldn't upset an NVDimm?
> > > If the guest dirties all RAM then the incremental snapshot
> > > feature
> > > degrades to a full snapshot.  I'm asking if there are common
> > > operations where that happens.
> > > 
> > > I seem to remember Windows guests zero all pages on cold
> > > boot.  Maybe
> > > that's not the case anymore.
> > > 
> > > Worth checking before embarking on this feature because it could
> > > be a
> > > waste of effort if it turns out real-world guests dirty all
> > > memory in
> > > common cases.
> > Right, but I'm hoping that there's some magic somewhere where an
> > NVDimm doesn't
> > get zero'd because of a cold boot since that would seem to make it
> > volatile.
> This feature isn't specific to NVDIMM though.  It would be equally
> useful for regular RAM.
> 
> Stefan
> 

Thanks for all your advices.
I already did a lot of investigation and write some code. My
consideration is as following:
1. As the first step, I will use is_active() function to make it just
work for nvdimm kind memory region and just for snapshot saving, not
for live migration. I understand that this can work for all kinds of
memory, but it may low guest's performance if we always enable dirty
log tracking for memory. For the live migration, all the data need to
be copied and it seems can not get benefit by this manner.
2. Saving and Loading is relatively easy to do, while deleting some
snapshot point needs a lot of work to do. The current framework just
deletes all the data of one snapshot point by one shot. I want to add
some reference to L1/L2 table of QCOW2 when the cluster's data is
depended by other snapshot point, so we can keep the data when
deleting.

I will also check whether the cold boot will zero all pages later.
 
Thanks,
Junyan
