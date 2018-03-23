Received: from eggs.gnu.org ([2001:4830:134:3::10]:55798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ezJrq-0007Ob-Ok
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ezJrq-0002LY-02
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:24:14 -0400
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d29ae6aa-5758-277b-b754-4e6fe7666e6b@redhat.com>
Date: Fri, 23 Mar 2018 11:24:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Regression on KVM qemu-system-aarch64 since "monitor:
 enable IO thread for (qmp & !mux) typed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu list <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>

Hi,

I observe a regression on KVM accelerated qemu-system-aarch64:

Unexpected error in kvm_device_access() at
/home/augere/UPSTREAM/qemu/accel/kvm/kvm-all.c:2164:
2018-03-23T09:59:59.629439Z qemu-system-aarch64: KVM_GET_DEVICE_ATTR
failed: Group 6 attr 0x000000000000c664: Device or resource busy
2018-03-23 10:00:00.085+0000: shutting down, reason=crashed

I did a bisect and it looks the commit that introduces the regression is

"
commit 3fd2457d18edf5736f713dfe1ada9c87a9badab1
Author: Peter Xu <peterx@redhat.com>
Date:   Fri Mar 9 17:00:03 2018 +0800

    monitor: enable IO thread for (qmp & !mux) typed

    Start to use dedicate IO thread for QMP monitors that are not using
    MUXed chardev.

    Reviewed-by: Fam Zheng <famz@redhat.com>
    Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
    Signed-off-by: Peter Xu <peterx@redhat.com>
    Message-Id: <20180309090006.10018-21-peterx@redhat.com>
    Signed-off-by: Eric Blake <eblake@redhat.com>
"

If reverted on top of v2.12.0-rc0, the guest boots fine again. The link
is not obvious though.

Thanks

Eric
