Received: from eggs.gnu.org ([2001:4830:134:3::10]:49274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gaFtm-0007OJ-O1
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 03:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gaFti-0007Dq-8K
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 03:11:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gaFti-0007Bo-28
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 03:11:06 -0500
Date: Fri, 21 Dec 2018 16:10:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181221081055.GD2996@xz-x1>
References: <20181213075727.23540-1-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213075727.23540-1-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] optimize waiting for free thread to do
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

On Thu, Dec 13, 2018 at 03:57:25PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Currently we have two behaviors if all threads are busy to do compression,
> the main thread mush wait one of them becoming free if @compress-wait-thread
> set to on or the main thread can directly return without wait and post
> the page out as normal one
> 
> Both of them have its profits and short-comes, however, if the bandwidth is
> not limited extremely so that compression can not use out all of it bandwidth,
> at the same time, the migration process is easily throttled if we posted too
> may pages as normal pages. None of them can work properly under this case
> 
> In order to use the bandwidth more effectively, we introduce the third
> behavior, compress-wait-thread-adaptive, which make the main thread wait
> if there is no bandwidth left or let the page go out as normal page if there
> has enough bandwidth to make sure the migration process will not be
> throttled
> 
> Another patch introduces a new statistic, pages-per-second, as bandwidth
> or mbps is not enough to measure the performance of posting pages out as
> we have compression, xbzrle, which can significantly reduce the amount of
> the data size, instead, pages-per-second if the one we want
> 
> Performance data
> ================
> We have limited the bandwidth to 300
> 
>                                 Used Bandwidth     Pages-per-Second
> compress-wait-thread = on         951.66 mbps         131784
> 
> compress-wait-thread = off        2491.74 mbps        93495
> compress-wait-thread-adaptive     1982.94 mbps        162529
>    = on

Sounds reasonable to me, though it looks like there're only three
options: on, off, adaptive.  Should we squash the two parameters?

Thanks,

-- 
Peter Xu
