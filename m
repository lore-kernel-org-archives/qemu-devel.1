Received: from eggs.gnu.org ([2001:4830:134:3::10]:58905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJtT9-0007qo-1e
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 22:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJtT7-00076i-T6
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 22:55:31 -0500
Date: Wed, 29 Nov 2017 11:55:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171129035502.GD8889@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Block layer complexity: what to do to keep it under
 control?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, jcody@redhat.com, kwolf@redhat.com, stefanha@redhat.com, mreitz@redhat.com, eblake@redhat.com, famz@redhat.com

Hi all,

As we move forwards with new features in the block layer, the chances of tricky
bugs happening have been increasing alongside - block jobs, coroutines,
throttling, AioContext, op blockers and image locking combined together make a
large and complex picture that is hard to fully understand and work with. Some
bugs we've encountered are quite challenging already.  Examples are:

- segfault in parallel blockjobs (iotest 30)
  https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01144.html

- Intermittent hang of iotest 194 (bdrv_drain_all after non-shared storage
  migration)
  https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01626.html

- Drainage in bdrv_replace_child_noperm()
  https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00868.html

- Regression from 2.8: stuck in bdrv_drain()
  https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02193.html

So in principle, what should we do to make the block layer easy to understand,
develop with and debug? I think we have opportunities in these aspects:

- Documentation

  There is no central developer doc about block layer, especially how all pieces
  fit together. Having one will make it a lot easier for new contributors to
  understand better. Of course, we're facing the old problem: the code is
  moving, maintaining an updated document needs effort.

  Idea: add ./doc/deve/block.txt?

- Tests

  Writing tests is a great way not only to exercise code, verify new features
  work as expected and catch regression bugs, but also a way to show how the
  feature can be used. There is this trend that the QEMU user interface
  gradually moves from high level commands and args to small and flexible
  building blocks, therefore demostrating the usage in iotests is meaningful.

  Idea: Add tests to simulate how libvirt uses block layer, or how we expect it
  to. This would be a long term investment. We could reuse iotests, or create a
  new test framework specifically, if it's easier (for example, use docker/vm
  tests that just uses libvirt).

  Idea: Patchew already tests the quick group of iotests for a few
  formats/protocols, but we should really add it to "make check".

- Simplified code, or more orthogonal/modularized architecture.

  Each aspect of block layer is complex enough so isolating them as much as
  possible is a reasonable approach to control the complexity. Block jobs and
  throttling becoming block filters is a good example, we should identify more.

  Idea: rethink event loops. Create coroutines ubiquitously (for example for
  each fd handler, BH and timer), so that many nested aio_poll() can be removed.

  Crazy idea: move the whole block layer to a vhost process, and implement
  existing features differently, especially in terms of multi-threading (hint:
  rust?).

- Debuggability.

  Working with backtraces when coroutine is used is pretty hard, it would be
  nice if ./scripts/qemugdb/coroutine.py could work with core files (i.e.
  without a process to debug), and trace back to co->caller automatically.

  It's always useful to dump block graph. Maybe we should add a helper function
  in block layer that dumps all node graphs in graphviz DOT format, and even
  make it available in QMP as x-dump-block-graph?

  Of course gdb scripts to dump various lists are also nice little things to
  have.

  Idea: write more ./scripts/qemugdb/<scriptlet>.py.

More thoughts?

Fam
