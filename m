Received: from eggs.gnu.org ([2001:4830:134:3::10]:34231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Lia-0003WI-Jk
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9LiX-0004Dy-Dk
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:24:08 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9LiX-0004DV-7T
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:24:05 -0400
Received: by mail-qt0-x243.google.com with SMTP id q13-v6so8043536qtl.3
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 19:24:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <62d561d0-fe72-4971-1bf5-72adc4a979f2@amsat.org>
	<CAMxuvaz40mfpVRhy+GggTveNB+qvXG=sA+g=9w7RyjYAHktXDg@mail.gmail.com>
	<20180419164003.GV10259@redhat.com>
	<01ca24c6-8010-b383-1f41-c84febc684f4@amsat.org>
Message-ID: <b9c2b19c-6208-2e59-8ad5-7e4b3373fbc6@amsat.org>
Date: Thu, 19 Apr 2018 23:24:00 -0300
MIME-Version: 1.0
In-Reply-To: <01ca24c6-8010-b383-1f41-c84febc684f4@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] vnc: heap-use-after-free in vnc_client_io() after
 vnc_disconnect_finish()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Klim Kireev <klim.kireev@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 04/19/2018 09:39 PM, Philippe Mathieu-Daudé wrote:
> On 04/19/2018 01:40 PM, Daniel P. Berrangé wrote:
>> On Thu, Apr 19, 2018 at 06:37:12PM +0200, Marc-André Lureau wrote:
>>> On Tue, Apr 17, 2018 at 7:52 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>> running commit ce8d4082054519f2eaac39958edde502860a7fc6:
>>>>
>>>> qemu-system-mips -M malta -m 512 \
>>>>   -kernel vmlinux-3.2.0-4-4kc-malta \
>>>>   -append 'root=/dev/sda1 console=ttyS0' \
>>>>   -hda debian_wheezy_mips_standard.qcow2 \
>>>>   -redir tcp:5556::22 -serial stdio
>>>>
>>>> and connecting with "xtightvncviewer :0" I get when closing vnc:
>>>
>>> This is also true with other targets, ex:
>>> x86_64-softmmu/qemu-system-x86_64 -vnc :0
>>>
>>> Daniel, Gerd, are you looking at it? this looks like a 2.12 regression.
>>
>> I've not had toime to look at it - would be useful if someone can bisect
>> it at least if its a regression since 2.11
> 
> My worst bisect so far, anyway here we go:
> 
> 13e1d0e71e78a925848258391a6e616b6b5ae219 is the first bad commit
> commit 13e1d0e71e78a925848258391a6e616b6b5ae219
> Author: Daniel P. Berrange <berrange@redhat.com>
> Date:   Thu Feb 1 16:45:14 2018 +0000
> 
>     ui: convert VNC server to QIONetListener
> 
>     The VNC server already has the ability to listen on multiple sockets.
>     Converting it to use the QIONetListener APIs though, will reduce the
>     amount of code in the VNC server and improve the clarity of what is
>     left.
> 
>     Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>     Message-id: 20180201164514.10330-1-berrange@redhat.com
>     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> 
>>>> ==27686==ERROR: AddressSanitizer: heap-use-after-free on address
>>>> 0x63100003c814 at pc 0x55eed918362a bp 0x7ffdf5c36c80 sp 0x7ffdf5c36c78
>>>> READ of size 4 at 0x63100003c814 thread T0
>>>>     #0 0x55eed9183629 in vnc_client_io /source/qemu/ui/vnc.c:1549
>>>>     #1 0x55eed94ae26c in qio_channel_fd_source_dispatch
>>>> /source/qemu/io/channel-watch.c:84
>>>>     #2 0x7f3e181860f4 in g_main_context_dispatch
>>>> (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4c0f4)
>>>>     #3 0x55eed95b9799 in glib_pollfds_poll /source/qemu/util/main-loop.c:215
>>>>     #4 0x55eed95b9989 in os_host_main_loop_wait
>>>> /source/qemu/util/main-loop.c:263
>>>>     #5 0x55eed95b9b5f in main_loop_wait /source/qemu/util/main-loop.c:522
>>>>     #6 0x55eed898f7dd in main_loop /source/qemu/vl.c:1943
>>>>     #7 0x55eed89a1f0b in main /source/qemu/vl.c:4734
>>>>     #8 0x7f3dfe094a86 in __libc_start_main
>>>> (/lib/x86_64-linux-gnu/libc.so.6+0x21a86)
>>>>     #9 0x55eed8518db9 in _start
>>>> (/build/qemu/mips-softmmu/qemu-system-mips+0x14f3db9)
>>>>
>>>> 0x63100003c814 is located 20 bytes inside of 75744-byte region
>>>> [0x63100003c800,0x63100004efe0)
>>>> freed by thread T0 here:
>>>>     #0 0x7f3e18b878c8 in __interceptor_free
>>>> (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xd98c8)
>>>>     #1 0x55eed9181bb0 in vnc_disconnect_finish /source/qemu/ui/vnc.c:1278
>>>>     #2 0x55eed9183225 in vnc_client_read /source/qemu/ui/vnc.c:1511
>>>>     #3 0x55eed91835a9 in vnc_client_io /source/qemu/ui/vnc.c:1541
>>>>     #4 0x55eed94ae26c in qio_channel_fd_source_dispatch
>>>> /source/qemu/io/channel-watch.c:84
>>>>     #5 0x7f3e181860f4 in g_main_context_dispatch
>>>> (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4c0f4)
>>>>
>>>> previously allocated by thread T0 here:
>>>>     #0 0x7f3e18b87df8 in calloc
>>>> (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xd9df8)
>>>>     #1 0x7f3e1818b8b0 in g_malloc0
>>>> (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x518b0)
>>>>     #2 0x55eed9192aa0 in vnc_listen_io /source/qemu/ui/vnc.c:3186
>>>>     #3 0x55eed94b9fd7 in qio_net_listener_channel_func
>>>> /source/qemu/io/net-listener.c:57
>>>>     #4 0x55eed94ae26c in qio_channel_fd_source_dispatch
>>>> /source/qemu/io/channel-watch.c:84
>>>>     #5 0x7f3e181860f4 in g_main_context_dispatch
>>>> (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4c0f4)
>>>>
>>>> SUMMARY: AddressSanitizer: heap-use-after-free
>>>> /source/qemu/ui/vnc.c:1549 in vnc_client_io
>>>> Shadow bytes around the buggy address:
>>>>   0x0c627ffff8b0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>>>>   0x0c627ffff8c0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>>>>   0x0c627ffff8d0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>>>>   0x0c627ffff8e0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>>>>   0x0c627ffff8f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>>>> =>0x0c627ffff900: fd fd[fd]fd fd fd fd fd fd fd fd fd fd fd fd fd
>>>>   0x0c627ffff910: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>>>>   0x0c627ffff920: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>>>>   0x0c627ffff930: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>>>>   0x0c627ffff940: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>>>>   0x0c627ffff950: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>>>>
>>>> Shadow byte legend (one shadow byte represents 8 application bytes):
>>>>   Heap left redzone:       fa
>>>>   Freed heap region:       fd
>>>> ==26606==ABORTING

Apparently this commit only _triggers_ a latent bug...

What I see is

void vnc_disconnect_finish(VncState *vs)
{
    ...
    g_free(vs);
}

So:

static int vnc_client_read(VncState *vs)
{
    ...
    ret = vnc_client_read_plain(vs);
    if (!ret) {
        if (vs->disconnecting) {
            vnc_disconnect_finish(vs); // free(vs)
            return -1;

Then:

gboolean vnc_client_io(QIOChannel *ioc G_GNUC_UNUSED,
                       GIOCondition condition, void *opaque)
{
    VncState *vs = opaque;
    if (condition & G_IO_IN) {
        if (vnc_client_read(vs) < 0) { // vs freed
            goto end;
        }
    }
    ...
 end:
    if (vs->disconnecting) { // vs use-after-free

Which seems related to:

    commit d49b87f0d1e0520443a990fc610d0f02bc63c556
    Author: Klim Kireev <klim.kireev@virtuozzo.com>
    Date:   Wed Feb 7 12:48:44 2018 +0300

        vnc: fix segfault in closed connection handling

        On one of our client's node, due to trying to read from closed ioc,
        a segmentation fault occured. Corresponding backtrace:

        0  object_get_class (obj=obj@entry=0x0)
        1  qio_channel_readv_full (ioc=0x0, iov=0x7ffe55277180 ...
        2  qio_channel_read (ioc=<optimized out> ...
        3  vnc_client_read_buf (vs=vs@entry=0x55625f3c6000, ...
        4  vnc_client_read_plain (vs=0x55625f3c6000)
        5  vnc_client_read (vs=0x55625f3c6000)
        6  vnc_client_io (ioc=<optimized out>, condition=G_IO_IN, ...
        7  g_main_dispatch (context=0x556251568a50)
        8  g_main_context_dispatch (context=context@entry=0x556251568a50)
        9  glib_pollfds_poll ()
        10 os_host_main_loop_wait (timeout=<optimized out>)
        11 main_loop_wait (nonblocking=nonblocking@entry=0)
        12 main_loop () at vl.c:1909
        13 main (argc=<optimized out>, argv=<optimized out>, ...

        Having analyzed the coredump, I understood that the reason is that
        ioc_tag is reset on vnc_disconnect_start and ioc is cleaned
        in vnc_disconnect_finish. Between these two events due to some
        reasons the ioc_tag was set again and after vnc_disconnect_finish
        the handler is running with freed ioc,
        which led to the segmentation fault.

        The patch checks vs->disconnecting in places where we call
        qio_channel_add_watch and resets handler if disconnecting == TRUE
        to prevent such an occurrence.
