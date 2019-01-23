Received: from eggs.gnu.org ([209.51.188.92]:53935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmMxS-0006yJ-GL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmMxQ-0003Fz-PT
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:09:02 -0500
Date: Wed, 23 Jan 2019 18:08:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190123180844.GF2193@work-vm>
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
	<20190123110417.69e41c38@doriath>
	<b6fd5a23-3afc-0ba2-2e24-b6d7d53c7fc2@redhat.com>
	<20190123112420.0fe8fb0c@doriath> <20190123163553.GD2193@work-vm>
	<a5899bdc-b5d7-d287-5457-e9aafa613c13@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5899bdc-b5d7-d287-5457-e9aafa613c13@redhat.com>
Subject: Re: [Qemu-devel] Aborts in iotest 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

* Max Reitz (mreitz@redhat.com) wrote:
> On 23.01.19 17:35, Dr. David Alan Gilbert wrote:
> > * Luiz Capitulino (lcapitulino@redhat.com) wrote:
> >> On Wed, 23 Jan 2019 17:12:35 +0100
> >> Max Reitz <mreitz@redhat.com> wrote:
> >>
> >>> On 23.01.19 17:04, Luiz Capitulino wrote:
> >>>> On Wed, 23 Jan 2019 16:48:49 +0100
> >>>> Max Reitz <mreitz@redhat.com> wrote:
> >>>>   
> >>>>> Hi,
> >>>>>
> >>>>> When running 169 in parallel (e.g. like so:
> >>>>>
> >>>>> $ while TEST_DIR=/tmp/t0 ./check -T -qcow2 169; do; done
> >>>>> $ while TEST_DIR=/tmp/t1 ./check -T -qcow2 169; do; done
> >>>>> $ while TEST_DIR=/tmp/t2 ./check -T -qcow2 169; do; done
> >>>>> $ while TEST_DIR=/tmp/t3 ./check -T -qcow2 169; do; done
> >>>>>
> >>>>> in four different shells), I get aborts:  
> >>>>
> >>>> OK, is this part of a test-suite that's also running migration
> >>>> tests in parallel or in sequence? In other words, what does
> >>>> iotests have to do with migration (sorry if this is stupid
> >>>> question, but it's been years I don't do qemu).  
> >>>
> >>> They run migration tests in sequence, but if you run multiple test
> >>> instances in parallel, well, then they will be run in parallel.
> >>>
> >>> The only reason I CC'd you was because you were so prominent in git
> >>> blame. O:-)
> >>
> >> Yeah, that's often the case with me :-)
> >>
> >>>> When this happened in the past it meant some QEMU code skipped a
> >>>> transition, but I can't tell what this has to do with iotests.  
> >>>
> >>> Well, this iotest (which tests a migration configuration) sometimes
> >>> apparently results in this invalid transition.  But that can't be just
> >>> the test's fault, as qemu should handle that gracefully.
> >>
> >> Does iotest run a guest or does it only executes parts of qemu
> >> code? If it's the latter, then I'd guess the test code is missing
> >> calling qemu code that sets the appropriate state between
> >> running and postmigrate states.
> >>
> >>> It's probably an issue in the migration code and not so much in vl.c, yes...
> >>
> >> Yeah, I'll let the migration people jump in.
> > 
> > Can we get a log of the qmp commands when it fails?
> > A 'running->postmigrate' transition is a bit weird; you could get a
> > something->postmigrate if you migrate a VM twice, and the source is
> > already in postmigrate, so it tells the destination to go into
> > postmigrate.   That's odd in itself, but not *that* odd.
> > But then why is it going running->postmigrate?  That suggests
> > the source is currently running when it receives an incoming migration,
> > and that really shouldn't happen.
> 
> This is what I get with -d:
> 
> > 
> > test_do_test_migration_resume_source_persistent__not_migbitmap (__main__.TestDirtyBitmapMigration) ... DEBUG:QMP:>>> {'execute': 'qmp_capabilities'}
> > DEBUG:QMP:<<< {u'return': {}}
> > DEBUG:QMP:>>> {'execute': 'migrate-set-capabilities', 'arguments': {'capabilities': [{'capability': 'events', 'state': True}]}}
> > DEBUG:QMP:<<< {u'return': {}}
> > DEBUG:QMP:>>> {'execute': 'block-dirty-bitmap-add', 'arguments': {'node': 'drive0', 'persistent': True, 'name': 'bitmap0', 'granularity': 512}}
> > DEBUG:QMP:<<< {u'return': {}}
> > DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'command-line': 'qemu-io drive0 "write 0 65536"'}}
> > DEBUG:QMP:<<< {u'return': u''}
> > DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'command-line': 'qemu-io drive0 "write 983040 65536"'}}
> > DEBUG:QMP:<<< {u'return': u''}
> > DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'command-line': 'qemu-io drive0 "write 655873 4096"'}}
> > DEBUG:QMP:<<< {u'return': u''}
> > DEBUG:QMP:>>> {'execute': 'x-debug-block-dirty-bitmap-sha256', 'arguments': {'node': 'drive0', 'name': 'bitmap0'}}
> > DEBUG:QMP:<<< {u'return': {u'sha256': u'01d2ebedcb8f549a2547dbf8e231c410e3e747a9479e98909fc936e0035cf8b1'}}
> > DEBUG:QMP:>>> {'execute': 'migrate', 'arguments': {'uri': 'exec: cat > /tmp/t0/test-qcow2-file/mig_file'}}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': 301029}, u'data': {u'status': u'setup'}, u'event': u'MIGRATION'}
> > DEBUG:QMP:<<< {u'return': {}}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': 302836}, u'data': {u'pass': 1}, u'event': u'MIGRATION_PASS'}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': 302899}, u'data': {u'status': u'active'}, u'event': u'MIGRATION'}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': 312321}, u'event': u'STOP'}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': 312413}, u'data': {u'pass': 2}, u'event': u'MIGRATION_PASS'}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': 314779}, u'data': {u'status': u'completed'}, u'event': u'MIGRATION'}
> > DEBUG:QMP:>>> {'execute': 'x-debug-block-dirty-bitmap-sha256', 'arguments': {'node': 'drive0', 'name': 'bitmap0'}}
> > DEBUG:QMP:<<< {u'error': {u'class': u'GenericError', u'desc': u"Dirty bitmap 'bitmap0' not found"}}
> > DEBUG:QMP:>>> {'execute': 'cont'}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': 316624}, u'event': u'RESUME'}
> > DEBUG:QMP:<<< {u'return': {}}
> > DEBUG:QMP:>>> {'execute': 'x-debug-block-dirty-bitmap-sha256', 'arguments': {'node': 'drive0', 'name': 'bitmap0'}}
> > WARNING:qemu:qemu received signal 6: build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -chardev socket,id=mon,path=/tmp/t0/test-qcow2-file/tmp1d4GTg/qemua-28430-monitor.sock -mon chardev=mon,mode=control -display none -vga none -qtest unix:path=/tmp/t0/test-qcow2-file/qemua-28430-qtest.sock -machine accel=qtest -nodefaults -machine accel=qtest -drive if=virtio,id=drive0,file=/tmp/t0/test-qcow2-file/disk_a,format=qcow2,cache=writethrough
> > ERROR
> > 
> > ======================================================================
> > ERROR: test_do_test_migration_resume_source_persistent__not_migbitmap (__main__.TestDirtyBitmapMigration)
> > ----------------------------------------------------------------------
> > Traceback (most recent call last):
> >   File "169", line 206, in <lambda>
> >     setattr(klass, 'test_' + method + name, lambda self: mc(self))
> >   File "169", line 113, in do_test_migration_resume_source
> >     self.check_bitmap(self.vm_a, sha256)
> >   File "169", line 72, in check_bitmap
> >     node='drive0', name='bitmap0')
> >   File "tests/qemu-iotests/../../scripts/qemu.py", line 368, in qmp
> >     return self._qmp.cmd(cmd, args=qmp_args)
> >   File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 191, in cmd
> >     return self.cmd_obj(qmp_cmd)
> >   File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 174, in cmd_obj
> >     resp = self.__json_read()
> >   File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 82, in __json_read                                                                                                                                                                
> >     data = self.__sockfile.readline()
> >   File "/usr/lib64/python2.7/socket.py", line 451, in readline
> >     data = self._sock.recv(self._rbufsize)
> > error: [Errno 104] Connection reset by peer
> > 
> > ----------------------------------------------------------------------
> 
> 
> I'm not sure whether the problem is really from
> x-debug-block-dirty-bitmap-sha256, or from the self.vm_a.shutdown() on
> line 116 in iotest 169...  Or maybe from something else entirely?
> 
> 
> A slightly different failure pattern is this:
> 
> > test_do_test_migration_resume_source_not_persistent__migbitmap (__main__.TestDirtyBitmapMigration) ... DEBUG:QMP:>>> {'execute': 'qmp_capabilities'}
> > DEBUG:QMP:<<< {u'return': {}}
> > DEBUG:QMP:>>> {'execute': 'migrate-set-capabilities', 'arguments': {'capabilities': [{'capability': 'events', 'state': True}, {'capability': 'dirty-bitmaps', 'state': True}]}}
> > DEBUG:QMP:<<< {u'return': {}}
> > DEBUG:QMP:>>> {'execute': 'block-dirty-bitmap-add', 'arguments': {'node': 'drive0', 'name': 'bitmap0', 'granularity': 512}}
> > DEBUG:QMP:<<< {u'return': {}}
> > DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'command-line': 'qemu-io drive0 "write 0 65536"'}}
> > DEBUG:QMP:<<< {u'return': u''}
> > DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'command-line': 'qemu-io drive0 "write 983040 65536"'}}
> > DEBUG:QMP:<<< {u'return': u''}
> > DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'command-line': 'qemu-io drive0 "write 655873 4096"'}}
> > DEBUG:QMP:<<< {u'return': u''}
> > DEBUG:QMP:>>> {'execute': 'x-debug-block-dirty-bitmap-sha256', 'arguments': {'node': 'drive0', 'name': 'bitmap0'}}
> > DEBUG:QMP:<<< {u'return': {u'sha256': u'01d2ebedcb8f549a2547dbf8e231c410e3e747a9479e98909fc936e0035cf8b1'}}
> > DEBUG:QMP:>>> {'execute': 'migrate', 'arguments': {'uri': 'exec: cat > /tmp/t0/test-qcow2-file/mig_file'}}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': 466831}, u'data': {u'status': u'setup'}, u'event': u'MIGRATION'}
> > DEBUG:QMP:<<< {u'return': {}}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': 472171}, u'data': {u'pass': 1}, u'event': u'MIGRATION_PASS'}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': 472233}, u'data': {u'status': u'active'}, u'event': u'MIGRATION'}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': 571246}, u'data': {u'pass': 2}, u'event': u'MIGRATION_PASS'}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': 571665}, u'event': u'STOP'}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': 571934}, u'data': {u'pass': 3}, u'event': u'MIGRATION_PASS'}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': 574302}, u'data': {u'status': u'completed'}, u'event': u'MIGRATION'}
> > DEBUG:QMP:>>> {'execute': 'x-debug-block-dirty-bitmap-sha256', 'arguments': {'node': 'drive0', 'name': 'bitmap0'}}
> > DEBUG:QMP:<<< {u'return': {u'sha256': u'01d2ebedcb8f549a2547dbf8e231c410e3e747a9479e98909fc936e0035cf8b1'}}
> > DEBUG:QMP:>>> {'execute': 'cont'}
> > DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': 576305}, u'event': u'RESUME'}
> > DEBUG:QMP:<<< {u'return': {}}
> > DEBUG:QMP:>>> {'execute': 'x-debug-block-dirty-bitmap-sha256', 'arguments': {'node': 'drive0', 'name': 'bitmap0'}}
> > DEBUG:QMP:<<< {u'return': {u'sha256': u'01d2ebedcb8f549a2547dbf8e231c410e3e747a9479e98909fc936e0035cf8b1'}}
> > DEBUG:QMP:>>> {'execute': 'quit'}
> > WARNING:qemu:qemu received signal 6: build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -chardev socket,id=mon,path=/tmp/t0/test-qcow2-file/tmpG2ZjZB/qemua-4834-monitor.sock -mon chardev=mon,mode=control -display none -vga none -qtest unix:path=/tmp/t0/test-qcow2-file/qemua-4834-qtest.sock -machine accel=qtest -nodefaults -machine accel=qtest -drive if=virtio,id=drive0,file=/tmp/t0/test-qcow2-file/disk_a,format=qcow2,cache=writethrough
> > WARNING:qemu:qemu received signal 6: build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -chardev socket,id=mon,path=/tmp/t0/test-qcow2-file/tmpG2ZjZB/qemua-4834-monitor.sock -mon chardev=mon,mode=control -display none -vga none -qtest unix:path=/tmp/t0/test-qcow2-file/qemua-4834-qtest.sock -machine accel=qtest -nodefaults -machine accel=qtest -drive if=virtio,id=drive0,file=/tmp/t0/test-qcow2-file/disk_a,format=qcow2,cache=writethrough
> > 
> > ======================================================================
> > FAIL: test_do_test_migration_resume_source_not_persistent__migbitmap (__main__.TestDirtyBitmapMigration)
> > ----------------------------------------------------------------------
> > Traceback (most recent call last):
> >   File "169", line 206, in <lambda>
> >     setattr(klass, 'test_' + method + name, lambda self: mc(self))
> >   File "169", line 125, in do_test_migration_resume_source
> >     self.assertEqual(log, '')
> > AssertionError: "qemu-system-x86_64: invalid runstate transition: 'running' -> 'postmigrate'\n" != ''
> 
> So here looks more like the shutdown is the problem.

It doesn't repeat for me here in a  few minutes of testing;  can you get
me a full all-threads backtrace for those asserts?

Dave

> Max
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
