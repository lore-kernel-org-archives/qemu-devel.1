Received: from eggs.gnu.org ([2001:4830:134:3::10]:60694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fpXru-000091-7v
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fpXrr-0002cQ-6u
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:52:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33432 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fpXrr-0002cI-1x
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:52:07 -0400
Date: Tue, 14 Aug 2018 12:52:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180814115202.GH2580@work-vm>
References: <1534243693-9560-1-git-send-email-jianjay.zhou@huawei.com>
	<2278afdb-d2a6-54b3-67c7-c1f43e4d311c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2278afdb-d2a6-54b3-67c7-c1f43e4d311c@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] vl: fix migration when watchdog expires
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jay Zhou <jianjay.zhou@huawei.com>, qemu-devel@nongnu.org, quintela@redhat.com, wangxinxin.wang@huawei.com

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 14/08/2018 12:48, Jay Zhou wrote:
> > I got the following error when migrating a VM with watchdog
> > device:
> > 
> > {"timestamp": {"seconds": 1533884471, "microseconds": 668099},
> > "event": "WATCHDOG", "data": {"action": "reset"}}
> > {"timestamp": {"seconds": 1533884471, "microseconds": 677658},
> > "event": "RESET", "data": {"guest": true}}
> > {"timestamp": {"seconds": 1533884471, "microseconds": 677874},
> > "event": "STOP"}
> > qemu-system-x86_64: invalid runstate transition: 'prelaunch' -> 'postmigrate'
> > Aborted
> > 
> > The run state transition is RUN_STATE_FINISH_MIGRATE to RUN_STATE_PRELAUNCH,
> > then the migration thread aborted when it tries to set RUN_STATE_POSTMIGRATE.
> > There is a race between the main loop thread and the migration thread I think.
> 
> In that case I think you shouldn't go to POSTMIGRATE at all, because the
> VM has been reset.

Migration has the VM stopped; it's not expecting the state to change at
that point.

> Alternatively, when the watchdog fires in RUN_STATE_FINISH_MIGRATE
> state, it might delay the action until after the "cont" command is
> invoked on the source, but I'm not sure what's the best way to achieve
> that...

Jay: Which watchdog were you using?

 a) Should the watchdog expire when the VM is stopped; I think it
shouldn't - hw/acpi/tco.c uses a virtual timer as does i6300esb; so
is the bug here that the watchdog being used didn't use a virtual
timer?

 b) If the watchdog expires just before the VM gets stopped, is there
a race which could hit this?  Possibly.

 c) Could main_loop_should_exit guard all the 'request's by
something that checks whether the VM is stopped?

Dave


> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
