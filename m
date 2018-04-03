Received: from eggs.gnu.org ([2001:4830:134:3::10]:38106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3FyD-0005R4-Go
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 03:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3Fy9-00037y-FM
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 03:03:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f3Fy9-00037f-9P
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 03:03:01 -0400
Date: Tue, 3 Apr 2018 15:02:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180403070246.GE26441@xz-mi>
References: <20180403050115.6037-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180403050115.6037-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] monitor: bind dispatch bh to
 iohandler context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On Tue, Apr 03, 2018 at 01:01:15PM +0800, Peter Xu wrote:
> Eric Auger reported the problem days ago that OOB broke ARM when running
> with libvirt:
> 
> http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
> 
> This patch fixes the problem.
> 
> It's not really needed now since we have turned OOB off now, but it's
> still a bug fix, and it'll start to work when we turn OOB on for ARM.
> 
> The problem was that the monitor dispatcher bottom half was bound to
> qemu_aio_context, but that context seems to be for block only.  For the
> rest of the QEMU world we should be using iohandler context.  So
> assigning monitor dispatcher bottom half to that context.
> 
> If without this change, QMP dispatcher might be run even before reaching
> main loop in block IO path, for example, in a stack like:
> 
>         #0  qmp_cont ()
>         #1  0x00000000006bd210 in qmp_marshal_cont ()
>         #2  0x0000000000ac05c4 in do_qmp_dispatch ()
>         #3  0x0000000000ac07a0 in qmp_dispatch ()
>         #4  0x0000000000472d60 in monitor_qmp_dispatch_one ()
>         #5  0x000000000047302c in monitor_qmp_bh_dispatcher ()
>         #6  0x0000000000acf374 in aio_bh_call ()
>         #7  0x0000000000acf428 in aio_bh_poll ()
>         #8  0x0000000000ad5110 in aio_poll ()
>         #9  0x0000000000a08ab8 in blk_prw ()
>         #10 0x0000000000a091c4 in blk_pread ()
>         #11 0x0000000000734f94 in pflash_cfi01_realize ()
>         #12 0x000000000075a3a4 in device_set_realized ()
>         #13 0x00000000009a26cc in property_set_bool ()
>         #14 0x00000000009a0a40 in object_property_set ()
>         #15 0x00000000009a3a08 in object_property_set_qobject ()
>         #16 0x00000000009a0c8c in object_property_set_bool ()
>         #17 0x0000000000758f94 in qdev_init_nofail ()
>         #18 0x000000000058e190 in create_one_flash ()
>         #19 0x000000000058e2f4 in create_flash ()
>         #20 0x00000000005902f0 in machvirt_init ()
>         #21 0x00000000007635cc in machine_run_board_init ()
>         #22 0x00000000006b135c in main ()
> 
> This can cause ARM to crash when used with both OOB capability enabled
> and libvirt as upper layer, since libvirt will start QEMU with "-S" and
> the first "cont" command will arrive very early if the context is not
> correct (which is what above stack shows).  Then, the vcpu threads will
> start to run right after the qmp_cont() call, even when GICs have not
> been setup correctly yet (which is done in kvm_arm_machine_init_done()).
> 
> My sincere thanks to Eric Auger who offered great help during both
> debugging and verifying the problem.  The ARM test was carried out by
> applying this patch upon QEMU 2.12.0-rc0 and problem is gone after the
> patch.
> 
> A quick test of mine shows that after this patch applied we can pass all
> raw iotests even with OOB on by default.
> 
> CC: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <famz@redhat.com>
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

It seems that Reported-by and Tested-by didn't really trigger the
add-cc operation.  Cc Eric Auger too.

-- 
Peter Xu
