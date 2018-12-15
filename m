Received: from eggs.gnu.org ([2001:4830:134:3::10]:38716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gY8hN-0005gd-GX
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 07:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gY8hI-0007o6-Mi
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 07:05:37 -0500
Received: from m12-12.163.com ([220.181.12.12]:34314)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gY8hH-0007hZ-Ot
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 07:05:32 -0500
From: Li Qiang <liq3ea@163.com>
Date: Sat, 15 Dec 2018 04:03:50 -0800
Message-Id: <20181215120353.82786-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v2 0/3] vhost-user-test fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com, mst@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Currently, the vhost-user-test is not correct.
When in qtest mode, the accel is qtest, not kvm.
So when the client side of vhost-user-test send
'VHOST_USER_SET_VRING_CALL' msg, the 'fd' will
no be added in 'fds' in 'vhost_set_vring_file'.
In 'chr_read' of the server side in the 
vhost-user-test, it calls 'qemu_chr_fe_get_msgfds'
to get the fd in 'VHOST_USER_SET_VRING_CALL'. Though
there is no fd returned, but as the 'fd' is not initialized
so 'fd' maybe valid, and 'qemu_set_nonblock' will be success.
Even worse, 'qemu_set_nonblock' doesn't check the return value
of fcntl.

So this cause the interesting bug here: there are three issues,
but they combined and will bypass the qtest.

This patchset tries to address these issue.

v2: Change the second patch per Paolo's review

Li Qiang (3):
  tests: vhost-user-test: initialize 'fd' in chr_read
  vhost-user: fix ioeventfd_enabled
  util: check the return value of fcntl in qemu_set_{block,nonblock}

 hw/virtio/vhost-user.c  | 2 +-
 tests/vhost-user-test.c | 2 +-
 util/oslib-posix.c      | 8 ++++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.17.1
