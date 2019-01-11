Received: from eggs.gnu.org ([209.51.188.92]:38670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghtVh-0000J2-Cm
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghtVf-0006nA-Kr
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:53:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghtVf-0006kx-DN
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:53:51 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
Date: Fri, 11 Jan 2019 10:53:40 +0100
In-Reply-To: <20190111063732.10484-1-xiaoguangrong@tencent.com> (guangrong
	xiao's message of "Fri, 11 Jan 2019 14:37:29 +0800")
Message-ID: <87tvif5xln.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/3] optimize waiting for free thread to
 do compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, cota@braap.org

guangrong.xiao@gmail.com writes:

> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>
> Changelog in v2:
> squash 'compress-wait-thread-adaptive' into 'compress-wait-thread' based
> on peter's suggestion
>
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
> behavior, adaptive, which make the main thread wait
> if there is no bandwidth left or let the page go out as normal page if there
> has enough bandwidth to make sure the migration process will not be
> throttled
>
> Another patch introduces a new statistic, pages-per-second, as bandwidth
> or mbps is not enough to measure the performance of posting pages out as
> we have compression, xbzrle, which can significantly reduce the amount of
> the data size, instead, pages-per-second is the one we want
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

I think you mean compress-wait-thread = adaptive here.

Can you sketch use cases for all three settings?  The resulting guidance
should then be worked into documentation.
