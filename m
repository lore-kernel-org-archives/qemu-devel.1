Received: from eggs.gnu.org ([209.51.188.92]:47139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLOQD-0007BG-Gi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLOQC-00045F-Fi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:47:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hLOQC-00044t-9y
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:47:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id a12so19985254wrq.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 01:47:28 -0700 (PDT)
Date: Tue, 30 Apr 2019 10:47:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190430084724.ee2zeudgrqfoldmo@steredhat>
References: <20190427135642.16464-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190427135642.16464-1-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qom/object: Display more helpful message
 when an object type is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>

On Sat, Apr 27, 2019 at 03:56:42PM +0200, Philippe Mathieu-Daudé wrote:
> When writing a new board, adding device which uses other devices
> (container) or simply refactoring, one can discover the hard way
> his machine misses some devices. In the case of containers, the
> error is not obvious:
> 
>   $ qemu-system-microblaze -M xlnx-zynqmp-pmu
>   **
>   ERROR:/source/qemu/qom/object.c:454:object_initialize_with_type: assertion failed: (type != NULL)
>   Aborted (core dumped)
> 
> And we have to look at the coredump to figure the error:
> 
>   (gdb) bt
>   #1  0x00007f84773cf895 in abort () at /lib64/libc.so.6
>   #2  0x00007f847961fb53 in  () at /lib64/libglib-2.0.so.0
>   #3  0x00007f847967a4de in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
>   #4  0x000055c4bcac6c11 in object_initialize_with_type (data=data@entry=0x55c4bdf239e0, size=size@entry=2464, type=<optimized out>) at /source/qemu/qom/object.c:454
>   #5  0x000055c4bcac6e6d in object_initialize (data=data@entry=0x55c4bdf239e0, size=size@entry=2464, typename=typename@entry=0x55c4bcc7c643 "xlnx.zynqmp_ipi") at /source/qemu/qom/object.c:474
>   #6  0x000055c4bc9ea474 in xlnx_zynqmp_pmu_init (machine=0x55c4bdd46000) at /source/qemu/hw/microblaze/xlnx-zynqmp-pmu.c:176
>   #7  0x000055c4bca3b6cb in machine_run_board_init (machine=0x55c4bdd46000) at /source/qemu/hw/core/machine.c:1030
>   #8  0x000055c4bc95f6d2 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /source/qemu/vl.c:4479
> 
> Since the caller knows the type name requested, we can simply display it
> to ease development.
> 
> With this patch applied we get:
> 
>   $ qemu-system-microblaze -M xlnx-zynqmp-pmu
>   qemu-system-microblaze: missing object type 'xlnx.zynqmp_ipi'
>   Aborted (core dumped)
> 
> Since the assert(type) check in object_initialize_with_type() is
> now impossible, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  qom/object.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Very appreciated!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
