Received: from eggs.gnu.org ([209.51.188.92]:55379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gznTa-0002AH-Qc
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gznTZ-0002z0-HV
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:05:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gznTW-0002S9-4S
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:05:41 -0500
Date: Fri, 1 Mar 2019 19:05:01 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190301190501.GF2851@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] vhost-user slave deadlock question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, tiwei.bie@intel.com, marcandre.lureau@redhat.com
Cc: stefanha@redhat.com, maxime.coquelin@redhat.com

Hi,
  I've added a few commands to vhost-user for virtio-fs and
am hitting a deadlock and am trying to figure out what the correct fix
is; suggestions welcome.

My setup is:
  Messages sent over the virtio queues can cause the daemon to need
  to send a request back to qemu along the slave, and qemu must respond with an
  OK/error.  Lets call this command 'setupmapping'.
  In my case I'm reading vhost-user commands in one thread and
  processing the queues in another.

  That normally works OK

My problem:
  If qemu crashes or quits it stops the queues synchronously at a point
when the main loop in qemu wont respond to anything else.  However
if we're unlucky the daemon has already sent a message to qemu and
is waiting for the response; but that response can't arrive because
qemu is shutting down.  So the queue shutdown request never completes.
Then if I kill the daemon forcibly, qemu's handler for the slavefd
wakes up and tries to read data - but it's device has gone and it
crashes.

The trace is:
(Where vuf_* is my device and the structure is pretty much the same
as the others).

vm_state_notify->virtio_set_status->vuf_set_status->vuf_stop->vhost_dev_stop->vhost_virtqueue_stop->vhost_user_get_vring_base->vhost_user_read

So it feels like we need to shut down the slave FD when we shut
down the device;  but it's not clear to me at what level.
In some ways it feels like we need a way to get out if this
hole even if we shut down one queue synchronously.

Is anyone fighting similar cases?

Dave



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
