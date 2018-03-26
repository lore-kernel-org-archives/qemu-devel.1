Received: from eggs.gnu.org ([2001:4830:134:3::10]:37866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0PNf-0003gn-Oi
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0PNe-0007dM-UL
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:29:35 -0400
Date: Mon, 26 Mar 2018 12:29:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180326102919.GB5267@localhost.localdomain>
References: <20180323034356.72130-1-haoqf@linux.vnet.ibm.com>
	<20180323034356.72130-2-haoqf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323034356.72130-2-haoqf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] iotests: fix test case 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jcody@redhat.com, stefanha@redhat.com, famz@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

Am 23.03.2018 um 04:43 hat QingFeng Hao geschrieben:
> Test case 185 failed since commit 4486e89c219 --- "vl: introduce vm_shutdown()".
> It's because of the newly introduced function vm_shutdown calls bdrv_drain_all,
> which is called later by bdrv_close_all. bdrv_drain_all resumes the jobs
> that doubles the speed and offset is doubled.
> Some jobs' status are changed as well.
> 
> The fix is to not resume the jobs that are already yielded and also change
> 185.out accordingly.
> 
> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>

Stefan already commented on the fix itself, but I want to add two more
points:

Please change your subject line. "iotests: fix test case 185" means that
you are fixing the test case, not qemu code that makes the test case
fail. The subject line should describe the actual change. In all
likelihood it will start with "blockjob:" rather than "iotests:".

> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
> index fc645dac68..f8f208bbcf 100644
> --- a/include/block/blockjob.h
> +++ b/include/block/blockjob.h
> @@ -99,6 +99,11 @@ typedef struct BlockJob {
>      bool ready;
>  
>      /**
> +     * Set to true when the job is yielded.
> +     */
> +    bool yielded;

This is the same as !busy, so we don't need a new field for this.

Kevin
