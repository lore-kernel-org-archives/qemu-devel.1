Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3017C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE112064B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSDZAGVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE112064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04lY-0007rI-R0
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k04kO-00062T-HS
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:09:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k04kL-0007cL-G8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595862536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O/Zng/o3S/lplnlVaLGjgJLf+QAnr2onTPzFlZ+SYuk=;
 b=QSDZAGVWAprTS6U405J7gUacrxDZAbK9jTDtuVT4tiizUseNwB4bUdiu4wS73R7+tOu6bw
 WCIXyHTeM2yCyLxOgOL00+rNPfXCEXtUtIVlit2cqDjvAux21UOiMPh8khYCoLYVSrbgmQ
 ZWwbydik3Oq/QaW1Rg03yTPJQmlutWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-bbtNSfe8NDS_Ql5xi120SA-1; Mon, 27 Jul 2020 11:08:52 -0400
X-MC-Unique: bbtNSfe8NDS_Ql5xi120SA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBDD758;
 Mon, 27 Jul 2020 15:08:50 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B82360F96;
 Mon, 27 Jul 2020 15:08:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 (BROKEN) 0/6] migration: bring improved savevm/loadvm/delvm
 to QMP
Date: Mon, 27 Jul 2020 16:08:37 +0100
Message-Id: <20200727150843.3419256-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A followup to:=0D
=0D
 v1: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00866.html=0D
=0D
When QMP was first introduced some 10+ years ago now, the snapshot=0D
related commands (savevm/loadvm/delvm) were not converted. This was=0D
primarily because their implementation causes blocking of the thread=0D
running the monitor commands. This was (and still is) considered=0D
undesirable behaviour both in HMP and QMP.=0D
=0D
In theory someone was supposed to fix this flaw at some point in the=0D
past 10 years and bring them into the QMP world. Sadly, thus far it=0D
hasn't happened as people always had more important things to work=0D
on. Enterprise apps were much more interested in external snapshots=0D
than internal snapshots as they have many more features.=0D
=0D
Meanwhile users still want to use internal snapshots as there is=0D
a certainly simplicity in having everything self-contained in one=0D
image, even though it has limitations. Thus the apps that end up=0D
executing the savevm/loadvm/delvm via the "human-monitor-command"=0D
QMP command.=0D
=0D
IOW, the problematic blocking behaviour that was one of the reasons=0D
for not having savevm/loadvm/delvm in QMP is experienced by applications=0D
regardless. By not portting the commands to QMP due to one design flaw,=0D
we've forced apps and users to suffer from other design flaws of HMP (=0D
bad error reporting, strong type checking of args, no introspection) for=0D
an additional 10 years. This feels rather sub-optimal :-(=0D
=0D
In practice users don't appear to care strongly about the fact that these=
=0D
commands block the VM while they run. I might have seen one bug report=0D
about it, but it certainly isn't something that comes up as a frequent=0D
topic except among us QEMU maintainers. Users do care about having=0D
access to the snapshot feature.=0D
=0D
Where I am seeing frequent complaints is wrt the use of OVMF combined=0D
with snapshots which has some serious pain points. This is getting worse=0D
as the push to ditch legacy BIOS in favour of UEFI gain momentum both=0D
across OS vendors and mgmt apps. Solving it requires new parameters to=0D
the commands, but doing this in HMP is super unappealing.=0D
=0D
After 10 years, I think it is time for us to be a little pragmatic about=0D
our handling of snapshots commands. My desire is that libvirt should never=
=0D
use "human-monitor-command" under any circumstances, because of the=0D
inherant flaws in HMP as a protocol for machine consumption.=0D
=0D
Thus in this series I'm proposing a fairly direct mapping of the existing=
=0D
HMP commands for savevm/loadvm/delvm into QMP as a first step. This does=0D
not solve the blocking thread problem, but it does put in a place a=0D
design using the jobs framework which can facilitate solving it later.=0D
It does also solve the error reporting, type checking and introspection=0D
problems inherant to HMP. So we're winning on 3 out of the 4 problems,=0D
and pushed apps to a QMP design that will let us solve the last=0D
remaining problem.=0D
=0D
With a QMP variant, we reasonably deal with the problems related to OVMF:=
=0D
=0D
 - The logic to pick which disk to store the vmstate in is not=0D
   satsifactory.=0D
=0D
   The first block driver state cannot be assumed to be the root disk=0D
   image, it might be OVMF varstore and we don't want to store vmstate=0D
   in there.=0D
=0D
 - The logic to decide which disks must be snapshotted is hardwired=0D
   to all disks which are writable=0D
=0D
   Again with OVMF there might be a writable varstore, but this can be=0D
   raw rather than qcow2 format, and thus unable to be snapshotted.=0D
   While users might wish to snapshot their varstore, in some/many/most=0D
   cases it is entirely uneccessary. Users are blocked from snapshotting=0D
   their VM though due to this varstore.=0D
=0D
These are solved by adding two parameters to the commands. The first is=0D
a block device node name that identifies the image to store vmstate in,=0D
and the second is a list of node names to include for the snapshots.=0D
If the list of nodes isn't given, it falls back to the historical=0D
behaviour of using all disks matching some undocumented criteria.=0D
=0D
In the block code I've only dealt with node names for block devices, as=0D
IIUC, this is all that libvirt should need in the -blockdev world it now=0D
lives in. IOW, I've made not attempt to cope with people wanting to use=0D
these QMP commands in combination with -drive args.=0D
=0D
I've done some minimal work in libvirt to start to make use of the new=0D
commands to validate their functionality, but this isn't finished yet.=0D
=0D
My ultimate goal is to make the GNOME Boxes maintainer happy again by=0D
having internal snapshots work with OVMF:=0D
=0D
  https://gitlab.gnome.org/GNOME/gnome-boxes/-/commit/c486da262f6566326fbcb=
5e=3D=0D
f45c5f64048f16a6e=0D
=0D
HELP NEEDED:  this series starts to implement the approach that Kevin=0D
suggested wrto use of generic jobs.=0D
=0D
When I try to actually run the code though it crashes:=0D
=0D
ERROR:/home/berrange/src/virt/qemu/softmmu/cpus.c:1788:qemu_mutex_unlock_io=
th=3D=0D
read: assertion failed: (qemu_mutex_iothread_locked())=0D
Bail out! ERROR:/home/berrange/src/virt/qemu/softmmu/cpus.c:1788:qemu_mutex=
_u=3D=0D
nlock_iothread: assertion failed: (qemu_mutex_iothread_locked())=0D
=0D
Obviously I've missed something related to locking, but I've no idea=0D
what, so I'm sending this v2 simply as a way to solicit suggestions=0D
for what I've messed up.=0D
=0D
You can reproduce with I/O tests using "check -qcow2 310"  and it=0D
gave a stack:=0D
=0D
  Thread 5 (Thread 0x7fffe6e4c700 (LWP 3399011)):=0D
  #0  futex_wait_cancelable (private=3D0, expected=3D0, futex_word=3D0x5555=
566a9fd8) at ../sysdeps/nptl/futex-internal.h:183=0D
  #1  __pthread_cond_wait_common (abstime=3D0x0, clockid=3D0, mutex=3D0x555=
556227160 <qemu_global_mutex>, cond=3D0x5555566a9fb0) at pthread_cond_wait.=
c:508=0D
  #2  __pthread_cond_wait (cond=3Dcond@entry=3D0x5555566a9fb0, mutex=3Dmute=
x@entry=3D0x555556227160 <qemu_global_mutex>) at pthread_cond_wait.c:638=0D
  #3  0x0000555555ceb6cb in qemu_cond_wait_impl (cond=3D0x5555566a9fb0, mut=
ex=3D0x555556227160 <qemu_global_mutex>, file=3D0x555555d44198 "/home/berra=
nge/src/virt/qemu/softmmu/cpus.c", line=3D1145) at /home/berrange/src/virt/=
qemu/util/qemu-thread-posix.c:174=0D
  #4  0x0000555555931974 in qemu_wait_io_event (cpu=3Dcpu@entry=3D0x5555566=
85050) at /home/berrange/src/virt/qemu/softmmu/cpus.c:1145=0D
  #5  0x0000555555933a89 in qemu_dummy_cpu_thread_fn (arg=3Darg@entry=3D0x5=
55556685050) at /home/berrange/src/virt/qemu/softmmu/cpus.c:1241=0D
  #6  0x0000555555ceb049 in qemu_thread_start (args=3D0x7fffe6e476f0) at /h=
ome/berrange/src/virt/qemu/util/qemu-thread-posix.c:521=0D
  #7  0x00007ffff4fdc432 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:477=0D
  #8  0x00007ffff4f0a9d3 in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95=0D
 =20=0D
  Thread 4 (Thread 0x7fffe764d700 (LWP 3399010)):=0D
  #0  0x00007ffff4effb6f in __GI___poll (fds=3D0x7fffdc006ec0, nfds=3D3, ti=
meout=3D-1) at ../sysdeps/unix/sysv/linux/poll.c:29=0D
  #1  0x00007ffff7c1aace in g_main_context_iterate.constprop () at /lib64/l=
ibglib-2.0.so.0=0D
  #2  0x00007ffff7c1ae53 in g_main_loop_run () at /lib64/libglib-2.0.so.0=
=0D
  #3  0x00005555559a9d81 in iothread_run (opaque=3Dopaque@entry=3D0x5555563=
2f200) at /home/berrange/src/virt/qemu/iothread.c:82=0D
  #4  0x0000555555ceb049 in qemu_thread_start (args=3D0x7fffe76486f0) at /h=
ome/berrange/src/virt/qemu/util/qemu-thread-posix.c:521=0D
  #5  0x00007ffff4fdc432 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:477=0D
  #6  0x00007ffff4f0a9d3 in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95=0D
 =20=0D
  Thread 3 (Thread 0x7fffe7e4e700 (LWP 3399009)):=0D
  #0  0x00007ffff4fe5c58 in futex_abstimed_wait_cancelable (private=3D0, ab=
stime=3D0x7fffe7e49650, clockid=3D0, expected=3D0, futex_word=3D0x5555562bf=
888) at ../sysdeps/nptl/futex-internal.h:320=0D
  #1  do_futex_wait (sem=3Dsem@entry=3D0x5555562bf888, abstime=3Dabstime@en=
try=3D0x7fffe7e49650, clockid=3D0) at sem_waitcommon.c:112=0D
  #2  0x00007ffff4fe5d83 in __new_sem_wait_slow (sem=3Dsem@entry=3D0x555556=
2bf888, abstime=3Dabstime@entry=3D0x7fffe7e49650, clockid=3D0) at sem_waitc=
ommon.c:184=0D
  #3  0x00007ffff4fe5e12 in sem_timedwait (sem=3Dsem@entry=3D0x5555562bf888=
, abstime=3Dabstime@entry=3D0x7fffe7e49650) at sem_timedwait.c:40=0D
  #4  0x0000555555cebbdf in qemu_sem_timedwait (sem=3Dsem@entry=3D0x5555562=
bf888, ms=3Dms@entry=3D10000) at /home/berrange/src/virt/qemu/util/qemu-thr=
ead-posix.c:307=0D
  #5  0x0000555555d03fa4 in worker_thread (opaque=3Dopaque@entry=3D0x555556=
2bf810) at /home/berrange/src/virt/qemu/util/thread-pool.c:91=0D
  #6  0x0000555555ceb049 in qemu_thread_start (args=3D0x7fffe7e496f0) at /h=
ome/berrange/src/virt/qemu/util/qemu-thread-posix.c:521=0D
  #7  0x00007ffff4fdc432 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:477=0D
  #8  0x00007ffff4f0a9d3 in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95=0D
 =20=0D
  Thread 2 (Thread 0x7fffe8750700 (LWP 3399008)):=0D
  #0  0x00007ffff4ed1871 in __GI___clock_nanosleep (clock_id=3Dclock_id@ent=
ry=3D0, flags=3Dflags@entry=3D0, req=3D0x7fffe874b670, rem=3D0x7fffe874b680=
) at ../sysdeps/unix/sysv/linux/--Type <RET> for more, q to quit, c to cont=
inue without paging--=0D
  clock_nanosleep.c:48=0D
  #1  0x00007ffff4ed71c7 in __GI___nanosleep (requested_time=3D<optimized o=
ut>, remaining=3D<optimized out>) at nanosleep.c:27=0D
  #2  0x00007ffff7c462f7 in g_usleep () at /lib64/libglib-2.0.so.0=0D
  #3  0x0000555555cf3fd0 in call_rcu_thread (opaque=3Dopaque@entry=3D0x0) a=
t /home/berrange/src/virt/qemu/util/rcu.c:250=0D
  #4  0x0000555555ceb049 in qemu_thread_start (args=3D0x7fffe874b6f0) at /h=
ome/berrange/src/virt/qemu/util/qemu-thread-posix.c:521=0D
  #5  0x00007ffff4fdc432 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:477=0D
  #6  0x00007ffff4f0a9d3 in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95=0D
 =20=0D
  Thread 1 (Thread 0x7fffe88abec0 (LWP 3398996)):=0D
  #0  __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.=
c:50=0D
  #1  0x00007ffff4e2e895 in __GI_abort () at abort.c:79=0D
  #2  0x00007ffff7be5b8c in g_assertion_message_expr.cold () at /lib64/libg=
lib-2.0.so.0=0D
  #3  0x00007ffff7c43a1f in g_assertion_message_expr () at /lib64/libglib-2=
.0.so.0=0D
  #4  0x0000555555932da0 in qemu_mutex_unlock_iothread () at /home/berrange=
/src/virt/qemu/softmmu/cpus.c:1788=0D
  #5  qemu_mutex_unlock_iothread () at /home/berrange/src/virt/qemu/softmmu=
/cpus.c:1786=0D
  #6  0x0000555555cfeceb in os_host_main_loop_wait (timeout=3D2635927574700=
0) at /home/berrange/src/virt/qemu/util/main-loop.c:232=0D
  #7  main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at /home/berrang=
e/src/virt/qemu/util/main-loop.c:516=0D
  #8  0x0000555555941f27 in qemu_main_loop () at /home/berrange/src/virt/qe=
mu/softmmu/vl.c:1676=0D
  #9  0x000055555581a18e in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>) at /home/berrange/src/virt/qemu/softmmu/main=
.c:49=0D
  (gdb)=20=0D
=0D
=0D
Changed in v2:=0D
=0D
 - Use new command names "snapshot-{load,save,delete}" to make it=0D
   clear that these are different from the "savevm|loadvm|delvm"=0D
   as they use the Job framework=0D
=0D
 - Use an include list for block devs, not an exclude list=0D
=0D
Daniel P. Berrang=3DC3=3DA9 (6):=0D
  migration: improve error reporting of block driver state name=0D
  block: push error reporting into bdrv_all_*_snapshot functions=0D
  migration: stop returning errno from load_snapshot()=0D
  block: add ability to specify list of blockdevs during snapshot=0D
  block: allow specifying name of block device for vmstate storage=0D
  migration: introduce snapshot-{save,load,delete} QMP commands=0D
=0D
 block/monitor/block-hmp-cmds.c |   7 +-=0D
 block/snapshot.c               | 167 +++++++++++++++++---------=0D
 include/block/snapshot.h       |  19 +--=0D
 include/migration/snapshot.h   |  10 +-=0D
 migration/savevm.c             | 210 +++++++++++++++++++++++++++------=0D
 monitor/hmp-cmds.c             |  11 +-=0D
 qapi/job.json                  |   9 +-=0D
 qapi/migration.json            | 112 ++++++++++++++++++=0D
 replay/replay-snapshot.c       |   4 +-=0D
 softmmu/vl.c                   |   2 +-=0D
 tests/qemu-iotests/267.out     |  14 +--=0D
 tests/qemu-iotests/310         | 125 ++++++++++++++++++++=0D
 tests/qemu-iotests/310.out     |   0=0D
 tests/qemu-iotests/group       |   1 +=0D
 14 files changed, 562 insertions(+), 129 deletions(-)=0D
 create mode 100755 tests/qemu-iotests/310=0D
 create mode 100644 tests/qemu-iotests/310.out=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


