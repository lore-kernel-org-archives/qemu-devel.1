Received: from eggs.gnu.org ([2001:4830:134:3::10]:51276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ez0gQ-0007r3-4E
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ez0gO-00079L-Mp
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:55:10 -0400
Date: Thu, 22 Mar 2018 21:54:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180322135443.GJ32362@xz-mi>
References: <a80175c7-0d54-dc0b-5dbe-8bb05f51913b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a80175c7-0d54-dc0b-5dbe-8bb05f51913b@redhat.com>
Subject: Re: [Qemu-devel] raw iotest regressions in 2.12.0-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

On Wed, Mar 21, 2018 at 05:58:48PM -0400, John Snow wrote:
> ./check -v -raw
> Failures: 109 132 136 148 152 183
> 
> 3fd2457d18edf5736f713dfe1ada9c87a9badab1 is the first bad commit
> commit 3fd2457d18edf5736f713dfe1ada9c87a9badab1
> Author: Peter Xu <peterx@redhat.com>
> Date:   Fri Mar 9 17:00:03 2018 +0800
> 
>     monitor: enable IO thread for (qmp & !mux) typed
> 
>     Start to use dedicate IO thread for QMP monitors that are not using
>     MUXed chardev.
> 
>     Reviewed-by: Fam Zheng <famz@redhat.com>
>     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>     Signed-off-by: Peter Xu <peterx@redhat.com>
>     Message-Id: <20180309090006.10018-21-peterx@redhat.com>
>     Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> 
> The symptom appears to be extra "RESUME" events in the stream that
> weren't expected by the original output for tests 109 and 183; the rest
> are python and I didn't dig yet.
> 
> ./check -v raw
> Failures: 055
> Failed 5 of 5 tests
> 
> 91ad45061af0fe44ac5dadb5bedaf4d7a08077c8 is the first bad commit
> commit 91ad45061af0fe44ac5dadb5bedaf4d7a08077c8
> Author: Peter Xu <peterx@redhat.com>
> Date:   Fri Mar 9 17:00:05 2018 +0800
> 
>     tests: qmp-test: verify command batching
> 
>     OOB introduced DROP event for flow control.  This should not affect old
>     QMP clients.  Add a command batching check to make sure of it.
> 
>     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>     Signed-off-by: Peter Xu <peterx@redhat.com>
>     Message-Id: <20180309090006.10018-23-peterx@redhat.com>
>     Reviewed-by: Eric Blake <eblake@redhat.com>
>     Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> 
> 
> Maybe these are known, but I wanted to consolidate them for rc0 for
> something easy to search for. There are others for qcow2 which I'll post
> in a bit...!
> 
> 
> Thanks,
> --js

CCing Max, Fam.

Now I think I know how to solve some of the tests already (109, 132,
148, 152, 183). While I am still working (or, not yet started to work)
on some others (055, 136, 205).

205 is interesting - it won't fail every time, but randomly:

        205 1s ... [failed, exit status 1] - output mismatch (see 205.out.bad)
        --- /home/peterx/git/qemu/tests/qemu-iotests/205.out    2018-03-08 19:36:27.452220803 +0800
        +++ /home/peterx/git/qemu/bin/tests/qemu-iotests/205.out.bad    2018-03-22 21:16:52.727152006 +0800
        @@ -1,5 +1,19 @@
        -.......
        +F......
        +======================================================================
        +FAIL: test_connect_after_remove_default (__main__.TestNbdServerRemove)
        +----------------------------------------------------------------------
        +Traceback (most recent call last):
        +  File "205", line 96, in test_connect_after_remove_default
        +    self.do_test_connect_after_remove()
        +  File "205", line 90, in do_test_connect_after_remove
        +    self.assert_qmp(result, 'return', {})
        +  File "/home/peterx/git/qemu/tests/qemu-iotests/iotests.py", line 422, in assert_qmp
        +    result = self.dictpath(d, path)
        +  File "/home/peterx/git/qemu/tests/qemu-iotests/iotests.py", line 381, in dictpath
        +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
        +AssertionError: failed path traversal for "return" in "{u'error': {u'class': u'GenericError', u'desc': u"export 'exp' still in use"}}"
        +
        ----------------------------------------------------------------------
        Ran 7 tests

Not digged yet.

For 136, it happens always, this is the error:

        136 4s ... [failed, exit status 1] - output mismatch (see 136.out.bad)
        --- /home/peterx/git/qemu/tests/qemu-iotests/136.out    2018-01-12 12:46:42.069915434 +0800
        +++ /home/peterx/git/qemu/bin/tests/qemu-iotests/136.out.bad    2018-03-22 21:16:13.981116000 +0800
        @@ -1,5 +1,125 @@
        -...................................
        +.....EE.....EE.....EE.....EE.....EE
        +======================================================================
        +ERROR: test_read_only (__main__.BlockDeviceStatsTestAccountBoth)
        +----------------------------------------------------------------------
        +Traceback (most recent call last):
        +  File "136", line 286, in test_read_only
        +    self.do_test_stats(rd_size = i[0], rd_ops = i[1])
        +  File "136", line 278, in do_test_stats
        +    self.check_values()
        +  File "136", line 204, in check_values
        +    self.assertLess(0, stats['idle_time_ns'])
        +KeyError: 'idle_time_ns'
        +
        +======================================================================
        +ERROR: test_write_only (__main__.BlockDeviceStatsTestAccountBoth)
        +----------------------------------------------------------------------
        +Traceback (most recent call last):
        +  File "136", line 294, in test_write_only
        +    self.do_test_stats(wr_size = i[0], wr_ops = i[1])
        +  File "136", line 278, in do_test_stats
        +    self.check_values()
        +  File "136", line 204, in check_values
        +    self.assertLess(0, stats['idle_time_ns'])
        +KeyError: 'idle_time_ns'
        ...
        (similar ones)

I think it says "idle_time_ns" is missing.  I saw that it will only be
there if BlockAcctStats.last_access_time_ns > 0, and I saw that
last_access_time_ns is updated by QEMU_CLOCK_VIRTUAL.  I tried to add
an assertion inside block_account_one_io() after line:

        stats->last_access_time_ns = time_ns;
        assert(time_ns);

And it triggers.  Firstly it means block_account_one_io() is for sure
be called, meanwhile here time_ns can be zero (read from
QEMU_CLOCK_VIRTUAL).  But should it?

While I haven't started to look at 055, which is:

        055 80s ... [failed, exit status 1] - output mismatch (see 055.out.bad)
        --- /home/peterx/git/qemu/tests/qemu-iotests/055.out    2018-01-12 12:46:42.062915425 +0800
        +++ /home/peterx/git/qemu/bin/tests/qemu-iotests/055.out.bad    2018-03-22 21:32:46.242098794 +0800
        @@ -1,5 +1,19 @@
        -..............................
        +.......F......................
        +======================================================================
        +FAIL: test_set_speed_drive_backup (__main__.TestSetSpeed)
        +----------------------------------------------------------------------
        +Traceback (most recent call last):
        +  File "055", line 217, in test_set_speed_drive_backup
        +    self.do_test_set_speed('drive-backup', target_img)
        +  File "055", line 207, in do_test_set_speed
        +    self.assert_qmp(result, 'return', {})
        +  File "/home/peterx/git/qemu/tests/qemu-iotests/iotests.py", line 422, in assert_qmp
        +    result = self.dictpath(d, path)
        +  File "/home/peterx/git/qemu/tests/qemu-iotests/iotests.py", line 381, in dictpath
        +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
        +AssertionError: failed path traversal for "return" in "{u'error': {u'class': u'GenericError', u'desc': u'Need a root block node'}}"
        +
        ----------------------------------------------------------------------

I'll continue and update tomorrow.  So if anyone has any idea on
solving any of the problem, please feel free to shoot.

(Really know too little about QEMU block layer!)

Thanks,

-- 
Peter Xu
