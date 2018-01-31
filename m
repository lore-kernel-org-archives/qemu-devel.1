Received: from eggs.gnu.org ([2001:4830:134:3::10]:38426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egswd-0005hG-2j
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egswZ-0003IA-1x
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:00:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egswY-0003Hf-Qr
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:00:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8ADC8E3E7
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 14:00:53 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
	<b0395258-20bd-657a-fc79-c1e4bafe15cb@redhat.com>
Date: Wed, 31 Jan 2018 15:00:40 +0100
In-Reply-To: <b0395258-20bd-657a-fc79-c1e4bafe15cb@redhat.com> (Thomas Huth's
	message of "Wed, 31 Jan 2018 08:10:00 +0100")
Message-ID: <87a7wu162f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/18] Clean up includes to reduce compile
 time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> On 30.01.2018 11:21, Markus Armbruster wrote:
>> We have awfully many "touch it, recompile the world" headers.  Right
>> now, I count about fifty that are prerequisites of more than half the
>> objects in my "build everything" tree.
>
> Could you maybe share the list of these 50 headers? ... cleaning this up
> could also be a good task for https://wiki.qemu.org/BiteSizedTasks I guess?

Top-scorers after this series appended, arbitrarily cut off at 1000
objects.

qemu/osdep.h and the headers it includes (config-host.h exec/poison.h
qemu/compiler.h sysemu/os-posix.h glib-compat.h qemu/typedefs.h) trigger
full recompiles by design, and some headers might be necessarily bad
(e.g. trace/control.h).  But I'm sure plenty of stupid shit that could
be cleaned up.

I'm going to post patches for qapi-types.h.

config-host.h 4939
include/glib-compat.h 4939
include/qemu/compiler.h 4939
include/qemu/osdep.h 4939
include/qemu/typedefs.h 4939
include/sysemu/os-posix.h 4939
include/qemu/fprintf-fn.h 4657
include/qemu/module.h 4643
include/qemu/atomic.h 4625
include/qapi/util.h 4615
include/qemu/queue.h 4612
qapi-types.h 4612
include/fpu/softfloat.h 4572
include/qemu/bswap.h 4512
include/qemu-common.h 4498
include/qemu/host-utils.h 4470
include/qemu/processor.h 4424
include/qemu/thread-posix.h 4423
include/qemu/thread.h 4423
include/qemu/bitops.h 4378
include/qom/object.h 4353
include/qemu/bitmap.h 4307
include/hw/irq.h 4249
include/hw/hotplug.h 4241
include/hw/qdev-core.h 4240
include/exec/hwaddr.h 4239
include/exec/memattrs.h 4237
include/qemu/notify.h 4100
include/qemu/rcu.h 4054
include/exec/cpu-common.h 4047
include/exec/memory.h 4044
config-target.h 3805
include/disas/bfd.h 3622
include/qom/cpu.h 3605
include/qemu/timer.h 3424
include/qemu/int128.h 3019
include/exec/cpu-all.h 2903
include/exec/cpu-defs.h 2903
tcg/i386/tcg-target.h 2903
tcg/tcg-mo.h 2903
include/qemu/rcu_queue.h 2884
include/exec/ramlist.h 2850
include/qemu/log.h 2587
include/qemu/event_notifier.h 2348
include/block/aio.h 2339
include/qemu/main-loop.h 2039
migration/qjson.h 2029
include/migration/vmstate.h 2028
include/hw/qdev-properties.h 1991
include/sysemu/reset.h 1931
include/migration/qemu-file-types.h 1930
include/hw/hw.h 1929
trace/control-internal.h 1863
trace/control.h 1863
trace/event-internal.h 1863
include/hw/qdev.h 1784
include/qapi/error.h 1657
include/qemu/qdist.h 1639
include/qemu/qht.h 1637
include/qemu/seqlock.h 1637
include/exec/tb-context.h 1634
include/sysemu/cpus.h 1626
include/qemu/error-report.h 1610
include/qemu/uuid.h 1609
include/sysemu/sysemu.h 1599
include/exec/exec-all.h 1518
include/qemu/iov.h 1491
include/qemu/coroutine.h 1481
include/exec/address-spaces.h 1408
include/qemu/timed-average.h 1360
include/qemu/hbitmap.h 1359
include/block/accounting.h 1358
include/block/block.h 1358
include/block/blockjob.h 1358
include/block/dirty-bitmap.h 1358
include/exec/user/abitypes.h 1195
tcg/tcg-opc.h 1187
tcg/tcg.h 1187
include/exec/poison.h 1134
trace-root.h 1097
