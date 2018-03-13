Received: from eggs.gnu.org ([2001:4830:134:3::10]:42509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1evgP1-0006An-Ne
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1evgOx-0007G7-OO
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:39:27 -0400
From: sochin.jiang <sochin.jiang@huawei.com>
Message-ID: <8848a27f-4bac-b6be-08ab-a366438791a6@huawei.com>
Date: Tue, 13 Mar 2018 17:38:09 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Question: an IO hang problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel <qemu-devel@nongnu.org>, "Subo (A)" <subo7@huawei.com>, "Lulina (A)" <lina.lulina@huawei.com>, "Fangyi (C)" <eric.fangyi@huawei.com>, sochin.jiang@huawei.com


 Hi, guys,

 Recently, I encountered an IO hang problem in occasion which I cannot reproduce it now.

 I analyzed this problem carefully, the critical stack is as following:


After reading the codes in linux-aio.c(see ioq_submit() function), I found two situations could lead us here.

1) no AIOs are in flight(s->ioq.in_flight is 0) and another call to io_submit returns -EAGAIN

2) no AIOs are in flight(s->ioq.in_flight is 0) and s->io_q.pending IOs reach to MAX_EVENTS at once

In both the two situations above, the do{...}while loop breaks out and set s->io_q.blocked true.

After that, AIO completion callback will never be called,  ioq_submit() either, all pended requests will hang.


Is there a proper way we can fix this while do not affect(stuck) the guest ?

Hope for a reply, thanks.


Sochin.
