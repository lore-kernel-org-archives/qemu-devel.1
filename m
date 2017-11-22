Received: from eggs.gnu.org ([2001:4830:134:3::10]:51550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eHWb0-0000In-Ja
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eHWax-00068e-Ag
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:05:50 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
References: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
Date: Wed, 22 Nov 2017 16:05:43 +0100
Message-ID: <w51r2sqs69k.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] segfault in parallel blockjobs
 (iotest 30)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Tue 07 Nov 2017 05:19:41 PM CET, Anton Nefedov wrote:

> The small attached tweak makes iotest 30 (-qcow2 -nocache) fail 10/10
> times on my machine.

I can reproduce the crash with v2.11.0-rc2 without having to modify QEMU
at all using the attached test case (it's based on one of the existing
tests from 030). It doesn't fail 100% of the times, though, but enough
to reproduce it easily.

Berto

----

class TestStreamCommit(iotests.QMPTestCase):
    num_imgs = 6
    imgs = []

    def setUp(self):
        opts = []
        self.imgs = []

        # Initialize file names and command-line options
        for i in range(self.num_imgs):
            img_depth = self.num_imgs - i - 1
            opts.append("backing." * img_depth + "node-name=node%d" % i)
            self.imgs.append(os.path.join(iotests.test_dir, 'img-%d.img' % i))

        # Create all images
        qemu_img('create', '-f', iotests.imgfmt, self.imgs[0], '1M')
        for i in range(1, self.num_imgs):
            qemu_img('create', '-f', iotests.imgfmt,
                     '-o', 'backing_file=%s' % self.imgs[i-1], self.imgs[i])

        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 256k 512k', self.imgs[1])
        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x2 768k 256k', self.imgs[1])
        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x3 0 1M', self.imgs[5])

        # Attach the drive to the VM
        self.vm = iotests.VM()
        self.vm.add_drive(self.imgs[-1], ','.join(opts))
        self.vm.launch()

    def tearDown(self):
        self.vm.shutdown()
        for img in self.imgs:
            os.remove(img)

    # Test a block-stream and a block-commit job in parallel
    def test_stream_commit(self):
        self.assert_no_active_block_jobs()

        # Stream from node0 into node2
        result = self.vm.qmp('block-stream', device='node2', job_id='node2')
        self.assert_qmp(result, 'return', {})

        # Commit from the active layer into node3
        result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[3])
        self.assert_qmp(result, 'return', {})

        # Wait for all jobs to be finished.
        pending_jobs = ['node2', 'drive0']
        while len(pending_jobs) > 0:
            for event in self.vm.get_qmp_events(wait=True):
                if event['event'] == 'BLOCK_JOB_COMPLETED':
                    node_name = self.dictpath(event, 'data/device')
                    self.assertTrue(node_name in pending_jobs)
                    self.assert_qmp_absent(event, 'data/error')
                    pending_jobs.remove(node_name)
                if event['event'] == 'BLOCK_JOB_READY':
                    self.assert_qmp(event, 'data/device', 'drive0')
                    self.assert_qmp(event, 'data/type', 'commit')
                    self.assert_qmp_absent(event, 'data/error')
                    self.assertTrue('drive0' in pending_jobs)
                    self.vm.qmp('block-job-complete', device='drive0')

        self.assert_no_active_block_jobs()
