Received: from eggs.gnu.org ([2001:4830:134:3::10]:54974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gEaAS-0000nE-9V
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gEaAR-0003h7-EO
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:22:48 -0400
Received: from forwardcorp1g.cmail.yandex.net ([2a02:6b8:0:1465::fd]:33681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gEaAQ-0003fi-V2
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:22:47 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Date: Mon, 22 Oct 2018 16:22:43 +0300
Message-Id: <155951540214563@sas1-fc7737ec834f.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: [Qemu-devel] vhost-user devices work with chardev from different
 threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>

Hi,

I examined vhost-user devices and found some chardev using strangeness.

Is it ok, that vhost-user's set_status do sync chardev io ops from KVM thread?
It seems that chardev doesn't support working with different threads.

For example, I think such race is possible (two simultaneous events):
1) Vhost-user server was killed (main thread will handle G_IO_HUP),
2) Virtio-pci bus handles guest driver's set_status command.
   Some io op from vhost-user backend will fail because of 1).

So, it is possible to enter tcp_chr_disconnect twice from the main thread and
from KVM thread.

Backtrace examples:

KVM thread (handle set_status of guest):
tcp_chr_disconnect
tcp_chr_write (cc->chr_write)
qemu_chr_write_buffer
qemu_chr_write
qemu_chr_fe_write_all
vhost_user_write
vhost_user_set_mem_table (hdev->vhost_ops->vhost_set_mem_table)
vhost_dev_start
vhost_user_blk_start (or another vhost-user device)
vhost_user_blk_set_status (vdc->set_status)

Main thread (handle vhost server disconnect):
tcp_chr_disconnect
tcp_chr_hup
g_main_context_dispatch
glib_pollfds_poll
os_host_main_loop_wait
main_loop_wait
main_loop
main

Is it really a problem or do I misunderstand?

Thanks,
Yury
