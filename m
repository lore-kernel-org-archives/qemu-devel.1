Received: from eggs.gnu.org ([2001:4830:134:3::10]:58712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etuzE-0004pn-6Q
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etuzD-0003eD-3Y
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:49:32 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1520507908-16743-5-git-send-email-pl@kamp.de> (Peter Lieven's
	message of "Thu, 8 Mar 2018 12:18:27 +0100")
References: <1520507908-16743-1-git-send-email-pl@kamp.de>
	<1520507908-16743-5-git-send-email-pl@kamp.de>
Reply-To: quintela@redhat.com
Date: Thu, 08 Mar 2018 13:50:00 +0100
Message-ID: <87po4ed953.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/5] migration/block: limit the number of
 parallel I/O requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com, famz@redhat.com, stefanha@redhat.com, jjherne@linux.vnet.ibm.com

Peter Lieven <pl@kamp.de> wrote:
> the current implementation submits up to 512 I/O requests in parallel
> which is much to high especially for a background task.
> This patch adds a maximum limit of 16 I/O requests that can
> be submitted in parallel to avoid monopolizing the I/O device.
>
> Signed-off-by: Peter Lieven <pl@kamp.de>

This code is already a mess (TM).  It is difficult to understand what we
are doing, so not easy to see if your changes are better/worse than what
we have.

I am not sure that your solution help to improve things here.  Let's see
what I understand.

We have three fields (without a single comment):

- submitted: this is the number of blocks that we have asked the block
             device to read asynchronously to main memory, and that
             haven't yet read.  I.e. "blocks_read_pending" would be a
             better name?

- read_done: this is the number of blocks that we have finished read
             asynchronously from this block device.  When we finish, we
             do a submitted -- and a read_done++.  blocks_read_finished
             name?

- transferred: This is the number of blocks that we have transferred
               since the beginning of migration.  At this point, we do a
               read_done-- and a transferred++

Note also that we do malloc()/free() for each block

So, now that we have defined what our fields mean, we need to know what
is our test.  block_save_pending():

    get_remaining_dirty() + (submitted + read_done) * BLOCK_SIZE

Looks good.

But let's us see what test we do in block_save_iterate() (Yes, I have
been very liberal with reformatting and removal of struct names):

(submitted + read_done) * BLOCK_SIZE <  qemu_file_get_rate_limit(f) &&
(submitted + read_done) < MAX_INFLIGHT_IO

The idea of that test is to make sure that we _don't send_ through the
QEMUFile more than qemu_file_get_rate_limit(f).  But there are several
things here:
- we have already issued a flush_blks() call before we enter the loop
  And it is inside possibility that we have already sent too much data at
  this point, but we enter the while loop anyways.

  Notice that flush_blks() does the right thing and test in each loop if
  qemu_file_rate_limit() has been reached and stops sending more data if
  it returns true;

- At this point, we *could* have sent all that can be sent for this
  round, but we enter the loop anyways.  And we test two things:
     - that we haven't read from block devices more than
       qemu_file_get_rate_limit() bytes (notice that this is the maximum
       that we could put through the migration channel, not really
       related  with what we read from block devices).

     - that we haven't read in this round more than MAX_INFLIGHT_IO
       blocks.  That is 512 blocks, at BLOCK_SIZE bytes is 512MB. Why?
       Who knows.

- Now we exit the while loop, and we have pending blocks to send, the
    minimum between:
       - qemu_file_get_rate_limit()/BLOCK_SIZE, and
       - MAX_INFLIGHT_IO

But not all of them are ready to send, only "read_done" blocks are
ready, the "submitted" ones are still waiting for read completion.

And we call back flush_blks() that will try to send all the "read_done"
blocks through the migration channel until we hit
qemu_file_rate_limit().

So, looking at the problem from far away:

- how many read requests are we have to have in flight at any moment, is
  that 16 from this series the right number? Notice that each request
  are 1MB, so this is 16MB (I have no clue what is the right value).

- how many blocks should we get on each round.  Notice that the reason
  for the 1st patch on this series is because the block layer is not
  sending enough blocks to prevent ram migration to start.  If there are
  enough dirty memory sent from the block layer, we shouldn't ever enter
  the ram stage.
  Notice how we register them in vl.c:

    blk_mig_init();
    ram_mig_init();

So, after so long mail, do I have some suggestion?

- should we make the MAX_PARALLEL_IO autotunig?  i.e. if we are not
  being able to get qemu_file_get_rate_limit()/BLOCK_SIZE read_blocks by
  iteration, we should increase MAX_PARALLEL_IO limit?

- should we "take" into account how many blocks have transferred the 1st
  call to flush_blks() and only wait for "read_blocks" until
  flush_blks() instead of for the whole set?

Later, Juan.
