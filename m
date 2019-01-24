Received: from eggs.gnu.org ([209.51.188.92]:44287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmcZo-0000Fd-QW
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmcZn-0005f1-6p
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:49:40 -0500
Date: Thu, 24 Jan 2019 10:49:10 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190124104910.GB2101@work-vm>
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
	<6325d205-774f-865b-1351-8a7e675bebf7@virtuozzo.com>
	<20190124101559.GC4601@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124101559.GC4601@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] Aborts in iotest 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Luiz Capitulino <lcapitulino@redhat.com>, eblake@redhat.com

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 24.01.2019 um 10:29 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > 23.01.2019 18:48, Max Reitz wrote:
> > > Hi,
> > > 
> > > When running 169 in parallel (e.g. like so:
> > > 
> > > $ while TEST_DIR=/tmp/t0 ./check -T -qcow2 169; do; done
> > > $ while TEST_DIR=/tmp/t1 ./check -T -qcow2 169; do; done
> > > $ while TEST_DIR=/tmp/t2 ./check -T -qcow2 169; do; done
> > > $ while TEST_DIR=/tmp/t3 ./check -T -qcow2 169; do; done
> > > 
> > > in four different shells), I get aborts:
> > > 
> > > (Often I get segfaults, but that's because of
> > > http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg05579.html --
> > > feel free to apply the attached patch to make them go away)
> > > 
> > > 
> > > WARNING:qemu:qemu received signal 6:
> > > build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64
> > > -chardev socket,id=mon,path=/tmp/t0/tmpbX30XU/qemua-25745-monitor.sock
> > > -mon chardev=mon,mode=control -display none -vga none -qtest
> > > unix:path=/tmp/t0/qemua-25745-qtest.sock -machine accel=qtest
> > > -nodefaults -machine accel=qtest -drive
> > > if=virtio,id=drive0,file=/tmp/t0/disk_a,format=qcow2,cache=writeback
> > > .................E..
> > > ======================================================================
> > > ERROR:
> > > test_do_test_migration_resume_source_not_persistent__not_migbitmap
> > > (__main__.TestDirtyBitmapMigration)
> > > ----------------------------------------------------------------------
> > > Traceback (most recent call last):
> > >    File "169", line 206, in <lambda>
> > >      setattr(klass, 'test_' + method + name, lambda self: mc(self))
> > >    File "169", line 113, in do_test_migration_resume_source
> > >      self.check_bitmap(self.vm_a, sha256)
> > >    File "169", line 72, in check_bitmap
> > >      node='drive0', name='bitmap0')
> > >    File "tests/qemu-iotests/../../scripts/qemu.py", line 369, in qmp
> > >      return self._qmp.cmd(cmd, args=qmp_args)
> > >    File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 191, in cmd
> > >      return self.cmd_obj(qmp_cmd)
> > >    File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 174, in cmd_obj
> > >      resp = self.__json_read()
> > >    File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 82, in
> > > __json_read
> > >      data = self.__sockfile.readline()
> > >    File "/usr/lib64/python2.7/socket.py", line 451, in readline
> > >      data = self._sock.recv(self._rbufsize)
> > > error: [Errno 104] Connection reset by peer
> > > 
> > > ----------------------------------------------------------------------
> > > Ran 20 tests
> > > 
> > > FAILED (errors=1)
> > > 
> > > 
> > > Or:
> > > 
> > > WARNING:qemu:qemu received signal 6:
> > > build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64
> > > -chardev socket,id=mon,path=/tmp/t3/tmp0pllWD/qemua-3445-monitor.sock
> > > -mon chardev=mon,mode=control -display none -vga none -qtest
> > > unix:path=/tmp/t3/qemua-3445-qtest.sock -machine accel=qtest -nodefaults
> > > -machine accel=qtest -drive
> > > if=virtio,id=drive0,file=/tmp/t3/disk_a,format=qcow2,cache=writeback
> > > WARNING:qemu:qemu received signal 6:
> > > build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64
> > > -chardev socket,id=mon,path=/tmp/t3/tmp0pllWD/qemua-3445-monitor.sock
> > > -mon chardev=mon,mode=control -display none -vga none -qtest
> > > unix:path=/tmp/t3/qemua-3445-qtest.sock -machine accel=qtest -nodefaults
> > > -machine accel=qtest -drive
> > > if=virtio,id=drive0,file=/tmp/t3/disk_a,format=qcow2,cache=writeback
> > > 
> > > ...................F
> > > ======================================================================
> > > FAIL: test_do_test_migration_resume_source_persistent__not_migbitmap
> > > (__main__.TestDirtyBitmapMigration)
> > > ----------------------------------------------------------------------
> > > Traceback (most recent call last):
> > >    File "169", line 206, in <lambda>
> > >      setattr(klass, 'test_' + method + name, lambda self: mc(self))
> > >    File "169", line 125, in do_test_migration_resume_source
> > >      self.assertEqual(log, '')
> > > AssertionError: "qemu-system-x86_64: invalid runstate transition:
> > > 'running' -> 'postmigrate'\n" != ''
> > > 
> > > ----------------------------------------------------------------------
> > > Ran 20 tests
> > > 
> > > FAILED (failures=1)
> > > 
> > > 
> > > The backtrace always goes like this:
> > > 
> > > (gdb) bt
> > > #0  0x00007f0acf5cc53f in raise () at /lib64/libc.so.6
> > > #1  0x00007f0acf5b6895 in abort () at /lib64/libc.so.6
> > > #2  0x000055a46ebbb1a6 in runstate_set (new_state=RUN_STATE_POSTMIGRATE)
> > > at vl.c:742
> > > #3  0x000055a46ebbb1a6 in runstate_set
> > > (new_state=new_state@entry=RUN_STATE_POSTMIGRATE) at vl.c:730
> > > #4  0x000055a46ed39129 in migration_iteration_finish (s=0x55a4708be000)
> > > at migration/migration.c:2972
> > > #5  0x000055a46ed39129 in migration_thread
> > > (opaque=opaque@entry=0x55a4708be000) at migration/migration.c:3130
> > > #6  0x000055a46eea665a in qemu_thread_start (args=<optimized out>) at
> > > util/qemu-thread-posix.c:502
> > > 
> > > 
> > > #7  0x00007f0acf76258e in start_thread () at /lib64/libpthread.so.0
> > > #8  0x00007f0acf6916a3 in clone () at /lib64/libc.so.6
> > > (gdb) frame 2
> > > #2  0x000055a46ebbb1a6 in runstate_set (new_state=RUN_STATE_POSTMIGRATE)
> > > at vl.c:742
> > > 742             abort();
> > > (gdb) print current_run_state
> > > $1 = RUN_STATE_RUNNING
> > > 
> > > 
> > > Neither of migration or runstates are my strong suite, so I thought I'd
> > > report it before diving into it.
> > > 
> > > Max
> > > 
> > 
> > [...]
> > 450556@1548321072.888979:migrate_set_state new state active
> > 450556@1548321072.889022:migration_thread_setup_complete
> > 450556@1548321072.988275:migrate_transferred transferred 985298 time_spent 100 bandwidth 9852 max_size 2955894
> > 450556@1548321072.988283:migration_bitmap_sync_start
> > 450556@1548321072.988293:migration_bitmap_sync_end dirty_pages 32898
> > 450556@1548321072.988495:migration_thread_low_pending 2048
> > migration_completion
> > 450556@1548321072.988541:runstate_set current_state 9 new_state 7
> > 450556@1548321072.988780:migration_bitmap_sync_start
> > 450556@1548321072.988790:migration_bitmap_sync_end dirty_pages 32898
> > 450556@1548321072.993112:migrate_global_state_pre_save saved state: running
> > [1] 450556@1548321072.993237:migrate_set_state new state completed
> > 450549@1548321072.993668:handle_qmp_command mon 0x55aebef99830 req: {"execute": "x-debug-block-dirty-bitmap-sha256", "arguments": {"name": "bitmap0", "node": "drive0"}}
> > 450556@1548321072.993697:migration_thread_after_loop
> > [2] 450549@1548321072.993917:handle_qmp_command mon 0x55aebef99830 req: {"execute": "cont"}
> > 450476@1548321072.994461:runstate_set current_state 7 new_state 9
> > qemu-system-x86_64: invalid runstate transition: 'running' -> 'postmigrate'
> > 
> > 
> > Aha, so, in test we wait for MIGRATION COMPLETED [1] and run qmp_cont [2] and go to RUNNING.
> > then in migration thread we go to migration_iteration_finish() and fail to go to POSTMIGRATE.
> > (note, that this testcase is about resuming source after migration)

Ah that makes sense as to why we failed.

> > So, fix for test may be additionally wait for POSTMIGRATE, not only for MIGRATION COMPLETION.
> > 
> > But how to fix Qemu not to crash? May be, forbid some transitions (FINISH_MIGRATE -> RUNNING),
> >   or at least error-out qmp_cont if runstate is  FINISH_MIGRATE?
> 
> qmp_cont currently checks for RUN_STATE_INMIGRATE and gives it special
> treatment. As a quick hack, doing the same for RUN_STATE_FINISH_MIGRATE
> might fix the problem. A better simple fix would possibly include a
> whitelist of states where you can use 'cont' to avoid that the user
> messes with other internal states.
> 
> However, like the problem that Dave reported a few days ago (migrating
> twice leads to a crash because we try to inactivate already inactive
> block devices), I think this is a symptom of a larger problem. We're
> not taking the state machine serious enough. One-off checks here and
> there are unlikely to ever fully solve the problem of running a command
> in a runstate in which it was never supposed to run.
> 
> I wonder whether the QAPI schema should have a field 'run-states' for
> commands, and by default we would only include states where the VM has
> ownership of its resources (e.g. images are activated) and which are not
> temporary states that are automatically left, like finish-migrate.
> 
> Then the default for commands is to be rejected in "unusual" runstates
> where we're not expecting user intervention, and we must explicitly
> allow them if they are okay, in fact.
> 
> Instead of listing every obscure runstate, maybe we should really use
> categories of runstates instead:
> 
> 1. Running
> 2. Paused, owns all resources (like disk images)
> 3. Paused, doesn't own some resources (source VM after migration
>    completes, destination before migration completes)
> 4. Paused temporarily for internal reasons (e.g. finish-migrate,
>    restore-vm, save-vm)
> 
> Most commands should be okay with 1 and 2, but possibly not 3, and
> almost never 4.

The problem is it's tricky to get those groupings right and to figure
out how they all interact.  For example it's perfectly fine for most
query type commands to run in (3) and (4), and you need a bunch of
commands to let you recover from failures that might leave you in (3)
and cont is one of those that you might use after a particular form
of failed migration.

Dave

> Kevin
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
