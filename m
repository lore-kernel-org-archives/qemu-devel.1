Received: from eggs.gnu.org ([2001:4830:134:3::10]:41775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2xHo-0000H5-SV
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2xHk-0002tH-DJ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:01:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3524
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2xHj-0002sT-Q6
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:01:28 -0400
References: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492674416-9408-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<df05a73b-fba8-a6d3-bf6a-648304458257@redhat.com>
	<58FD9546.5000104@huawei.com>
	<82c50df3-28c9-fb21-f2c6-76a99f864bee@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58FF1DF7.4000006@huawei.com>
Date: Tue, 25 Apr 2017 17:59:19 +0800
MIME-Version: 1.0
In-Reply-To: <82c50df3-28c9-fb21-f2c6-76a99f864bee@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] colo-compare: serialize compare
 thread's initialization with main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, zhangchen.fnst@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, weidong.huang@huawei.com

On 2017/4/25 16:41, Jason Wang wrote:
>
> On 2017年04月24日 14:03, Hailiang Zhang wrote:
>> On 2017/4/24 12:10, Jason Wang wrote:
>>> On 2017年04月20日 15:46, zhanghailiang wrote:
>>>> We call qemu_chr_fe_set_handlers() in colo-compare thread, it is used
>>>> to detach watched fd from default main context, so it has chance to
>>>> handle the same watched fd with main thread concurrently, which will
>>>> trigger an error report:
>>>> "qemu-char.c:918: io_watch_poll_finalize: Assertion `iwp->src ==
>>>> ((void *)0)' failed."
>>> Anyway to prevent fd from being handled by main thread before creating
>>> colo thread? Using semaphore seems not elegant.
>> So how about calling qemu_mutex_lock_iothread() before
>> qemu_chr_fe_set_handlers() ?
> Looks better, but I needs more information e.g how main thread can touch it?

Hmm, this happened quite occasionally, and we didn't catch the first place (backtrace)
of removing fd from been watched, but  from the codes logic, we found there should
be such possible cases:
tcp_chr_write (Or tcp_chr_read/tcp_chr_sync_read/chr_disconnect)
  ->tcp_chr_disconnect (Or char_socket_finalize)
     ->tcp_chr_free_connection
       -> remove_fd_in_watch(chr);

Anyway, it needs the protection from been freed twice.

Thanks,
Hailiang
> Thanks
>
> .
>
