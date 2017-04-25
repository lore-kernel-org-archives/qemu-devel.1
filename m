Received: from eggs.gnu.org ([2001:4830:134:3::10]:38382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2yil-0003v7-0H
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2yik-0005rs-5J
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:33:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d2yij-0005rW-VG
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:33:26 -0400
References: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492674416-9408-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<df05a73b-fba8-a6d3-bf6a-648304458257@redhat.com>
	<58FD9546.5000104@huawei.com>
	<82c50df3-28c9-fb21-f2c6-76a99f864bee@redhat.com>
	<58FF1DF7.4000006@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bfac018b-55cf-9cf8-5ffe-ff0d1fbd4b53@redhat.com>
Date: Tue, 25 Apr 2017 19:33:17 +0800
MIME-Version: 1.0
In-Reply-To: <58FF1DF7.4000006@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, zhangchen.fnst@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, weidong.huang@huawei.com



On 2017=E5=B9=B404=E6=9C=8825=E6=97=A5 17:59, Hailiang Zhang wrote:
> On 2017/4/25 16:41, Jason Wang wrote:
>>
>> On 2017=E5=B9=B404=E6=9C=8824=E6=97=A5 14:03, Hailiang Zhang wrote:
>>> On 2017/4/24 12:10, Jason Wang wrote:
>>>> On 2017=E5=B9=B404=E6=9C=8820=E6=97=A5 15:46, zhanghailiang wrote:
>>>>> We call qemu_chr_fe_set_handlers() in colo-compare thread, it is us=
ed
>>>>> to detach watched fd from default main context, so it has chance to
>>>>> handle the same watched fd with main thread concurrently, which wil=
l
>>>>> trigger an error report:
>>>>> "qemu-char.c:918: io_watch_poll_finalize: Assertion `iwp->src =3D=3D
>>>>> ((void *)0)' failed."
>>>> Anyway to prevent fd from being handled by main thread before creati=
ng
>>>> colo thread? Using semaphore seems not elegant.
>>> So how about calling qemu_mutex_lock_iothread() before
>>> qemu_chr_fe_set_handlers() ?
>> Looks better, but I needs more information e.g how main thread can=20
>> touch it?
>
> Hmm, this happened quite occasionally, and we didn't catch the first=20
> place (backtrace)
> of removing fd from been watched, but  from the codes logic, we found=20
> there should
> be such possible cases:
> tcp_chr_write (Or tcp_chr_read/tcp_chr_sync_read/chr_disconnect)
>  ->tcp_chr_disconnect (Or char_socket_finalize)
>     ->tcp_chr_free_connection
>       -> remove_fd_in_watch(chr);
>
> Anyway, it needs the protection from been freed twice.
>
> Thanks,
> Hailiang

Still a little bit confused. The question is how could main thread still=20
call tcp_chr_write or other in the above case?

Thanks

>> Thanks
>>
>> .
>>
>
>
