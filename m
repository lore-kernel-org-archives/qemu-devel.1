Received: from eggs.gnu.org ([2001:4830:134:3::10]:49949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gXykZ-0005Ay-7R
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 20:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gXykU-0003Mu-DU
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 20:28:15 -0500
Received: from m12-13.163.com ([220.181.12.13]:55331)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gXykT-0003DN-Nh
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 20:28:10 -0500
From: Li Qiang <liq3ea@163.com>
Date: Fri, 14 Dec 2018 17:26:22 -0800
Message-Id: <20181215012625.73315-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 0/3] vhost-user-test fix
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

Li Qiang (3):
  tests: vhost-user-test: initialize 'fd' in chr_read
  vhost-user: add fds inf 'vhost_set_vring_file' in qtest
  util: check the return value of fcntl in qemu_set_{block, nonblock}

 hw/virtio/vhost-user.c  | 3 ++-
 tests/vhost-user-test.c | 2 +-
 util/oslib-posix.c      | 8 ++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.17.1
