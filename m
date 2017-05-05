Received: from eggs.gnu.org ([2001:4830:134:3::10]:55378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d6TWp-0002iS-E4
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d6TWl-0007cK-E3
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:03:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d6TWl-0007aM-4f
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:03:31 -0400
References: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492674416-9408-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<df05a73b-fba8-a6d3-bf6a-648304458257@redhat.com>
	<58FD9546.5000104@huawei.com>
	<82c50df3-28c9-fb21-f2c6-76a99f864bee@redhat.com>
	<58FF1DF7.4000006@huawei.com>
	<bfac018b-55cf-9cf8-5ffe-ff0d1fbd4b53@redhat.com>
	<590A971B.1070900@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6af63243-5e20-8a43-9ba1-fce37323bf78@redhat.com>
Date: Fri, 5 May 2017 11:03:23 +0800
MIME-Version: 1.0
In-Reply-To: <590A971B.1070900@huawei.com>
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
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com



On 2017=E5=B9=B405=E6=9C=8804=E6=97=A5 10:51, Hailiang Zhang wrote:
> Hi Jason,
>
> On 2017/4/25 19:33, Jason Wang wrote:
>>
>> On 2017=E5=B9=B404=E6=9C=8825=E6=97=A5 17:59, Hailiang Zhang wrote:
>>> On 2017/4/25 16:41, Jason Wang wrote:
>>>> On 2017=E5=B9=B404=E6=9C=8824=E6=97=A5 14:03, Hailiang Zhang wrote:
>>>>> On 2017/4/24 12:10, Jason Wang wrote:
>>>>>> On 2017=E5=B9=B404=E6=9C=8820=E6=97=A5 15:46, zhanghailiang wrote:
>>>>>>> We call qemu_chr_fe_set_handlers() in colo-compare thread, it is=20
>>>>>>> used
>>>>>>> to detach watched fd from default main context, so it has chance =
to
>>>>>>> handle the same watched fd with main thread concurrently, which=20
>>>>>>> will
>>>>>>> trigger an error report:
>>>>>>> "qemu-char.c:918: io_watch_poll_finalize: Assertion `iwp->src =3D=
=3D
>>>>>>> ((void *)0)' failed."
>>>>>> Anyway to prevent fd from being handled by main thread before=20
>>>>>> creating
>>>>>> colo thread? Using semaphore seems not elegant.
>>>>> So how about calling qemu_mutex_lock_iothread() before
>>>>> qemu_chr_fe_set_handlers() ?
>>>> Looks better, but I needs more information e.g how main thread can
>>>> touch it?
>>> Hmm, this happened quite occasionally, and we didn't catch the first
>>> place (backtrace)
>>> of removing fd from been watched, but  from the codes logic, we found
>>> there should
>>> be such possible cases:
>>> tcp_chr_write (Or tcp_chr_read/tcp_chr_sync_read/chr_disconnect)
>>>   ->tcp_chr_disconnect (Or char_socket_finalize)
>>>      ->tcp_chr_free_connection
>>>        -> remove_fd_in_watch(chr);
>>>
>>> Anyway, it needs the protection from been freed twice.
>>>
>>> Thanks,
>>> Hailiang
>> Still a little bit confused. The question is how could main thread sti=
ll
>> call tcp_chr_write or other in the above case?
>
> Finally, we reproduced this bug (We use qemu 2.6), and got the follow=20
> backtrace of this problem:
>
> (gdb) thread apply all bt
>
> Thread 7 (Thread 0x7f407a1ff700 (LWP 23144)):
> #0  0x00007f41037e0db5 in _int_malloc () from /usr/lib64/libc.so.6
> #1  0x00007f41037e3b96 in calloc () from /usr/lib64/libc.so.6
> #2  0x00007f41041ad4d7 in g_malloc0 () from /usr/lib64/libglib-2.0.so.0
> #3  0x00007f41041a5437 in g_source_new () from=20
> /usr/lib64/libglib-2.0.so.0
> #4  0x00007f410a2cec9c in qio_channel_create_fd_watch=20
> (ioc=3Dioc@entry=3D0x7f410d6238c0, fd=3D20, condition=3Dcondition@entry=
=3D
>     (G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL)) at=20
> io/channel-watch.c:259
> #5  0x00007f410a2ced01 in qio_channel_create_socket_watch=20
> (ioc=3Dioc@entry=3D0x7f410d6238c0, socket=3D<optimized out>,
>     condition=3Dcondition@entry=3D(G_IO_IN | G_IO_ERR | G_IO_HUP |=20
> G_IO_NVAL)) at io/channel-watch.c:311
> #6  0x00007f410a2cbea7 in qio_channel_socket_create_watch=20
> (ioc=3D0x7f410d6238c0, condition=3D(G_IO_IN | G_IO_ERR | G_IO_HUP |=20
> G_IO_NVAL))
>     at io/channel-socket.c:732
> #7  0x00007f410a2c94d2 in qio_channel_create_watch=20
> (ioc=3D0x7f410d6238c0, condition=3Dcondition@entry=3D
>     (G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL)) at io/channel.c:132
> #8  0x00007f410a003cd6 in io_watch_poll_prepare=20
> (source=3D0x7f4070000d00, timeout_=3D<optimized out>) at qemu-char.c:88=
3
> #9  0x00007f41041a72ed in g_main_context_prepare () from=20
> /usr/lib64/libglib-2.0.so.0
> #10 0x00007f41041a7b7b in g_main_context_iterate.isra.24 () from=20
> /usr/lib64/libglib-2.0.so.0
> #11 0x00007f41041a7fba in g_main_loop_run () from=20
> /usr/lib64/libglib-2.0.so.0
> #12 0x00007f410a1e528f in colo_compare_thread (opaque=3D0x7f410d7d6800)=
=20
> at net/colo-compare.c:651
> #13 0x00007f4103b2bdc5 in start_thread () from /usr/lib64/libpthread.so=
.0
> #14 0x00007f410385971d in clone () from /usr/lib64/libc.so.6=20

It looks like we use main context which is wrong, maybe you can track=20
io_add_watch_poll() and its caller get the reason.

Thanks
