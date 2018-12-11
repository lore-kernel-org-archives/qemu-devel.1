Received: from eggs.gnu.org ([2001:4830:134:3::10]:37930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gWiwz-0002nl-BD
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1gWiwv-0004Tp-G8
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:23:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3111 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ann.zhuangyanying@huawei.com>)
	id 1gWiwu-0004Qw-W4
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:23:49 -0500
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Tue, 11 Dec 2018 14:20:42 +0000
Message-ID: <1544538042-16072-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFH]vcpu may hang for up to 4s while starting
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jianjay.zhou@huawei.com, dgilbert@redhat.com, qemu-devel@nongnu.org, xiaoguangrong@tencent.com
Cc: xiexiangyou@huawei.com, Zhuang Yanying <ann.zhuangyanying@huawei.com>

From: Zhuang Yanying <ann.zhuangyanying@huawei.com>

Hi,

Recently I test live-migration vm with 1T memory,
find vcpu may hang for up to 4s while starting migration.
The reason is memory_global_dirty_log_start taking too long, and the vcpu=
 is waiting for BQL.

migrate thread                                    vcpu
-------------------------------------------------------------------------=
-----------------------------------------
qemu_mutex_lock_iothread
                                                 kvm_handle_io
memory_global_dirty_log_start  /* lasts 4s */           try qemu_mutex_lo=
ck_iothread

qemu_mutex_unlock_iothread
                                                 success qemu_mutex_lock_=
iothread

Memory_global_dirty_log_start will cleans up the dirty bits of spte in th=
e KVM, and starts the dirty page tracking of PML.Because the VM's memory =
is very large, it takes too long time in KVM.

Is the following scheme feasible=EF=BC=9A
(1)Put the action of turning on dirty page tracking in memory_global_dirt=
y_log_start into asynchronous execution outside BQL.
(2)The first time tunrning on dirty page tracking, only clean up the dirt=
y page bits of the 1G pagetable, and the time spent by memory_global_dirt=
y_log_start is reduced.

Best regards,
 -Zhuang Yanying
---
