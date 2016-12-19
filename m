Received: from eggs.gnu.org ([2001:4830:134:3::10]:56585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJ0ro-0007VQ-4Y
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJ0rk-000322-6y
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:32:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cJ0rk-00031p-1c
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:32:44 -0500
Date: Tue, 20 Dec 2016 00:32:40 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161219163214.GA9801@lemon>
References: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20161219150230.GA20757@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161219150230.GA20757@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC v2 0/4] block/qapi: refactor and
 optimize the qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org

On Mon, 12/19 15:02, Stefan Hajnoczi wrote:
> On Mon, Dec 19, 2016 at 04:51:22PM +0800, Dou Liyang wrote:
> > These patches aim to refactor the qmp_query_blockstats() and
> > improve the performance by reducing the running time of it.
> > 
> > qmp_query_blockstats() is used to monitor the blockstats, it
> > querys all the graph_bdrv_states or monitor_block_backends.
> > 
> > There are the two jobs:
> > 
> > 1 For the performance:
> > 
> > 1.1 the time it takes(ns) in each time:
> > the disk numbers     | 10    | 500
> > -------------------------------------
> > before these patches | 19429 | 667722 
> > after these patches  | 17516 | 557044
> > 
> > 1.2 the I/O performance is degraded(%) during the monitor:
> > 
> > the disk numbers     | 10    | 500
> > -------------------------------------
> > before these patches | 1.3   | 14.2
> > after these patches  | 0.8   | 9.1
> 
> Do you know what is consuming the remaining 9.1%?
> 
> I'm surprised to see such a high performance impact caused by a QMP
> command.

If it's "performance is 9.1% worse only during the 557044 ns when the QMP
command is being processed", it's probably becaues the main loop is stalled a
bit, and it's not a big problem. I'd be very surprised if the degradation is
more longer than that.

Fam

> 
> Please post your QEMU command-line.
