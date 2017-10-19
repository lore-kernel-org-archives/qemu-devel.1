Received: from eggs.gnu.org ([2001:4830:134:3::10]:50700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e5GDH-0005bF-TG
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e5GDE-0003ZW-MT
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:10:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e5GDE-0003YL-Cx
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:10:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48D8C127AD
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 19:10:33 +0000 (UTC)
Date: Thu, 19 Oct 2017 20:10:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171019191029.GK2281@work-vm>
References: <20171018174013.22709-1-dgilbert@redhat.com>
	<20171019152442.GG130425@orkuz.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171019152442.GG130425@orkuz.home>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] migration: pause-before-switchover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiri Denemark <jdenemar@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com

* Jiri Denemark (jdenemar@redhat.com) wrote:
> The libvirt changes which will make use of this new migration capability
> can be found in migration-pause branch of my gitlab repository:
> 
>     git fetch https://gitlab.com/jirkade/libvirt.git migration-pause
> 
> It's not properly split into patches, it has no commit message etc.,
> but the functionality should be complete.
> 
> Feel free to test it and report any issues.

Looks promising:

virsh migrate --live --copy-storage-all --verbose

2017-10-19 17:52:38.665+0000: 31999: debug : qemuMonitorSetMigrationCapability:3948 : capability=pause-before-switchover, state=1
2017-10-19 17:52:38.666+0000: 31999: debug : virJSONValueToString:1914 : result={"execute":"migrate-set-capabilities","arguments":{"capabilities":[{"capability":"pause-before-switchover","state":true}]},"id":"libvirt-1861"}
2017-10-19 17:52:38.693+0000: 31999: debug : qemuMonitorJSONCommandWithFd:298 : Send command '{"execute":"migrate","arguments":{"detach":true,"blk":false,"inc":false,"uri":"fd:migrate"},"id":"libvirt-1865"}' for write with FD -1
2017-10-19 17:52:38.695+0000: 31998: debug : qemuMonitorJSONIOProcessLine:193 : Line [{"timestamp": {"seconds": 1508435558, "microseconds": 695732}, "event": "MIGRATION", "data": {"status": "setup"}}]
2017-10-19 17:52:38.743+0000: 31998: debug : qemuMonitorJSONIOProcessLine:193 : Line [{"timestamp": {"seconds": 1508435558, "microseconds": 743564}, "event": "MIGRATION_PASS", "data": {"pass": 1}}]
2017-10-19 17:52:38.744+0000: 31998: debug : qemuMonitorJSONIOProcessLine:193 : Line [{"timestamp": {"seconds": 1508435558, "microseconds": 743724}, "event": "MIGRATION", "data": {"status": "active"}}]
2017-10-19 17:52:43.193+0000: 31998: debug : qemuMonitorJSONIOProcessLine:193 : Line [{"timestamp": {"seconds": 1508435563, "microseconds": 192728}, "event": "MIGRATION_PASS", "data": {"pass": 2}}]
2017-10-19 17:52:43.389+0000: 31998: debug : qemuMonitorJSONIOProcessLine:193 : Line [{"timestamp": {"seconds": 1508435563, "microseconds": 388947}, "event": "STOP"}]
2017-10-19 17:52:43.862+0000: 31998: debug : qemuMonitorJSONIOProcessLine:193 : Line [{"timestamp": {"seconds": 1508435563, "microseconds": 862428}, "event": "MIGRATION", "data": {"status": "pre-switchover"}}]
2017-10-19 17:52:43.863+0000: 31999: debug : qemuMigrationDriveMirrorReady:634 : All disk mirrors are ready
2017-10-19 17:52:43.863+0000: 31999: debug : qemuMigrationCompleted:1534 : Migration paused before switchover
2017-10-19 17:52:43.865+0000: 31998: debug : qemuMonitorJSONIOProcessLine:193 : Line [{"return": {"expected-downtime": 300, "status": "pre-switchover", "setup-time": 47, "total-time": 5169, "ram": {"total": 4430053376, "postcopy-requests": 0, "dirty-sync-count": 2, "page-size": 4096, "remaining": 7204864, "mbps": 941.43529, "transferred": 450864646, "duplicate": 973832, "dirty-pages-rate": 243277, "skipped": 0, "normal-bytes": 441237504, "normal": 107724}}, "id": "libvirt-1876"}]
2017-10-19 17:52:43.866+0000: 31999: debug : qemuMigrationCancelDriveMirror:803 : Cancelling drive mirrors for domain debianlocalqemu
2017-10-19 17:52:43.866+0000: 31999: debug : qemuMonitorJSONCommandWithFd:298 : Send command '{"execute":"block-job-cancel","arguments":{"device":"drive-virtio-disk0"},"id":"libvirt-1877"}' for write with FD -1
2017-10-19 17:52:43.868+0000: 31999: debug : qemuMigrationDriveMirrorCancelled:715 : Waiting for 1 disk mirrors to finish
2017-10-19 17:52:43.872+0000: 31998: info : qemuMonitorIOProcess:439 : QEMU_MONITOR_IO_PROCESS: mon=0x7f4544008840 buf={"timestamp": {"seconds": 1508435563, "microseconds": 871816}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "drive-virtio-disk0", "len": 58430259200, "offset": 58430259200, "speed": 9223372036853727232, "type": "mirror"}}^M
2017-10-19 17:52:43.873+0000: 31998: debug : qemuProcessHandleBlockJob:1014 : Block job for device drive-virtio-disk0 (domain: 0x7f45440254c0,debianlocalqemu) type 2 status 0
2017-10-19 17:52:43.873+0000: 31999: debug : qemuBlockJobEventProcess:106 : disk=vda, mirrorState=yes, type=2, status=0
2017-10-19 17:52:43.916+0000: 31999: debug : qemuMonitorJSONCommandWithFd:298 : Send command '{"execute":"migrate-continue","arguments":{"state":"pre-switchover"},"id":"libvirt-1880"}' for write with FD -1
2017-10-19 17:52:43.918+0000: 31998: debug : qemuMonitorJSONIOProcessLine:193 : Line [{"timestamp": {"seconds": 1508435563, "microseconds": 917872}, "event": "MIGRATION", "data": {"status": "device"}}]
2017-10-19 17:52:43.921+0000: 31998: debug : qemuMonitorJSONIOProcessLine:193 : Line [{"timestamp": {"seconds": 1508435563, "microseconds": 921194}, "event": "MIGRATION_PASS", "data": {"pass": 3}}]
2017-10-19 17:52:43.991+0000: 31998: info : qemuMonitorIOProcess:439 : QEMU_MONITOR_IO_PROCESS: mon=0x7f4544008840 buf={"timestamp": {"seconds": 1508435563, "microseconds": 991528}, "event": "MIGRATION", "data": {"status": "completed"}}^M

So I think libvirt is doing the right thing - thanks!

I'll post the version with your minor comment change 1st thing tomorrow.

(I'm not too convinced qemu is that happy during the drive-mirror; the
guest complained about tasks blocked for 120seconds+ - I was running a
heavy cp;  and looking at an iostat in the guest I could see there 
were a few minute chunks where nothing was happening; and the write
performance after migrate seems way low;  however - neither of those
are related directly to this change - since the first problem
is happening before the actual migration code has started).

Dave

> Thanks,
> 
> Jirka
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
