Received: from eggs.gnu.org ([2001:4830:134:3::10]:35183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gYxw1-0006N6-R0
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gYxvy-0002kv-Ff
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:48:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gYxvy-0002j7-7z
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:48:06 -0500
Date: Tue, 18 Dec 2018 00:17:59 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20181216203052.GA5065@lap1>
Message-ID: <nycvar.YSQ.7.76.1812180006430.28971@xnncv>
References: <20181212193039.11445-1-ppandit@redhat.com>
	<20181212193039.11445-4-ppandit@redhat.com>
	<20181216203052.GA5065@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 3/6] pvrdma: check number of pages when
 creating rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>

  Hello Yuval,

+-- On Sun, 16 Dec 2018, Yuval Shaia wrote --+
| With this patch the last step fails, the guest OS hangs, trying to probably 
| unload pvrdma driver and finally gave up after 3 minutes.

Strange...
 
| Anyways with debug turned on i have noticed that there is one case that 
| devices gets 129 nchunks (i think in MPI) while your patch limits it to 128.
| >From pvrdma source code  we can see that first page is dedicated to ring
| state, this means that it maybe correct that 128 is the limit but we
| should check that nchunks does not exceed 129, not 128.
| 
| What do you think?

 -> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c?id=fdf82a7856b32d905c39afc85e34364491e46346#n201

the vmw_pvrdma kernel driver also seems to set MAX_FAST_REG_PAGE = 128.


| Ie. to replace this line from create_cq_ring
| +    if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES) {
| with this
| +    if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES + 1) {
| 
| Let me know your opinion.

While it may help to fix the regression. I'm not sure it's a right fix.
129 seems a little odd number to have as limit.

Is it possible MPI is erring in getting 129 chunks?

IMO it's better to confirm the right value for 'MAX_FAST_REG_PAGES', before 
going with > PVRDMA_MAX_FAS_REG_PAGES(=128) + 1.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
