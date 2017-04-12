Received: from eggs.gnu.org ([2001:4830:134:3::10]:60658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cyHB8-0004hR-Ff
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 08:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cyHB2-0003zy-81
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 08:15:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cyHB2-0003zh-0S
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 08:15:12 -0400
Date: Wed, 12 Apr 2017 08:15:03 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170412121503.GB5704@localhost.localdomain>
References: <1491277689-24949-1-git-send-email-Ashish.Mittal@veritas.com>
	<1491277689-24949-2-git-send-email-Ashish.Mittal@veritas.com>
	<20170411194749.GA5704@localhost.localdomain>
	<CAAo6VWMWFDL14sA4YWgYDVYKG7hO4vLaVuo=03bpS_XQ-vWqaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAo6VWMWFDL14sA4YWgYDVYKG7hO4vLaVuo=03bpS_XQ-vWqaw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v11 1/2] block/vxhs.c: Add support for a
 new block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ashish mittal <ashmit602@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, "Venkatesha M.G." <venkatesha.mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>, Eric Blake <eblake@redhat.com>, Abhijit Dey <Abhijit.Dey@veritas.com>

On Wed, Apr 12, 2017 at 01:10:10AM -0700, ashish mittal wrote:
> On Tue, Apr 11, 2017 at 12:47 PM, Jeff Cody <jcody@redhat.com> wrote:
> > On Mon, Apr 03, 2017 at 08:48:08PM -0700, Ashish Mittal wrote:
> >> Source code for the qnio library that this code loads can be downloaded from:
> >> https://github.com/VeritasHyperScale/libqnio.git
> >>
> >> Sample command line using JSON syntax:
> >> ./x86_64-softmmu/qemu-system-x86_64 -name instance-00000008 -S -vnc 0.0.0.0:0
> >> -k en-us -vga cirrus -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5
> >> -msg timestamp=on
> >> 'json:{"driver":"vxhs","vdisk-id":"c3e9095a-a5ee-4dce-afeb-2a59fb387410",
> >> "server":{"host":"172.172.17.4","port":"9999"}}'
> >>
> >> Sample command line using URI syntax:
> >> qemu-img convert -f raw -O raw -n
> >> /var/lib/nova/instances/_base/0c5eacd5ebea5ed914b6a3e7b18f1ce734c386ad
> >> vxhs://192.168.0.1:9999/c6718f6b-0401-441d-a8c3-1f0064d75ee0
> >>
> >> Sample command line using TLS credentials (run in secure mode):
> >> ./qemu-io --object
> >> tls-creds-x509,id=tls0,dir=/etc/pki/qemu/vxhs,endpoint=client -c 'read
> >> -v 66000 2.5k' 'json:{"server.host": "127.0.0.1", "server.port": "9999",
> >> "vdisk-id": "/test.raw", "driver": "vxhs", "tls-creds":"tls0"}'
> >>
> >> Signed-off-by: Ashish Mittal <Ashish.Mittal@veritas.com>
> >
> > I was testing this some with blockdev-add and blockdev-del, and this
> > sequence causes a segfault:
> >
> > 1. blockdev-add vxhs image
> > 2. blockdev-del above image
> > 3. blockdev-add vxhs image  <--- segfaults
> >
> > Looking at it in gdb, this is an issue with libqnio.  The call to iio_fini()
> > is not sufficiently thorough in cleaning up resources.
> >
> > In nio_client.c, qnc_ctx is never freed, because there does not
> > seem to be a call such as 'qnc_driver_fini' that cleans up the allocated
> > qnio_client_ctx.
> >
> > Therefore, on the second call to iio_init, the libqnio internal variable
> > network_driver is NULL, because qnc_driver_init() returns NULL if it is
> > called when qnc_ctx is still initialized:
> >
> >
> >
> > lib/qnio/nio_client.c:
> >
> > 411 int
> > 412 iio_init(int32_t version, iio_cb_t cb)
> > 413 {
> >
> > [...]
> >
> > 432     apictx->network_driver = qnc_secure_driver_init(client_callback);
> > 433     nioDbg("Created API context.\n");
> > 434     return 0;
> > 435 }
> >
> > [...]
> >
> > 779 struct channel_driver *
> > 780 qnc_driver_init(qnio_notify client_notify)
> > 781 {
> > 782     if (qnc_ctx) {
> > 783         nioDbg("Driver already initialized");
> > 784         return NULL;
> > 785     }
> > 786
> >
> >
> > So two issues:
> >
> > A. iio_init() should check the returned pointer, and fail if NULL
> >
> > B. iio_fini() needs to clean everything up so that a new vxhs connection is
> >    possible. This likely means at least one new function in nio_client.c to
> >    clean up qnc_ctx.
> >
> > -Jeff
> 
> Thanks for reporting the issue and also suggesting the fix.
> I was able to reproduce the issue and have checked in a fix to libqnio.
> 
> This was the stack trace from the core -
> 
> Program terminated with signal 11, Segmentation fault.
> #0  0x00007f12083a3afa in iio_channel_open (uri=0x7f120c57eb70
> "of://127.0.0.1:9999", cacert=0x0, client_key=0x0, client_cert=0x0) at
> lib/qnio/iioapi.c:105
> #1  0x00007f12083a470a in iio_open (uri=0x7f120d121be0
> "of://127.0.0.1:9999", devid=0x7f120baa4bb0 "/test.raw", flags=0,
> cacert=0x0, client_key=0x0, client_cert=0x0) at lib/qnio/iioapi.c:520
> #2  0x00007f12091bf7a3 in vxhs_open (bs=<optimized out>,
> options=<optimized out>, bdrv_flags=<optimized out>,
> errp=0x7ffdf1cafd70) at block/vxhs.c:388
> #3  0x00007f120916cf14 in bdrv_open_driver
> (bs=bs@entry=0x7f120b1481b0, drv=drv@entry=0x7f1209843580 <bdrv_vxhs>,
> node_name=<optimized out>, options=options@entry=0x7f120daa6840,
> open_flags=8194,
>     errp=errp@entry=0x7ffdf1cafe28) at block.c:1011
> #4  0x00007f120917079f in bdrv_open_common (errp=0x7ffdf1cafe28,
> options=0x7f120daa6840, file=0x0, bs=0x7f120b1481b0) at block.c:1250
> #5  bdrv_open_inherit (filename=<optimized out>, filename@entry=0x0,
> reference=reference@entry=0x0, options=0x7f120daa6840,
> options@entry=0x7f120daa4800, flags=40962, parent=parent@entry=0x0,
>     child_role=child_role@entry=0x0, errp=errp@entry=0x7ffdf1caff18)
> at block.c:2413
> #6  0x00007f1209171663 in bdrv_open (filename=filename@entry=0x0,
> reference=reference@entry=0x0, options=options@entry=0x7f120daa4800,
> flags=<optimized out>, errp=errp@entry=0x7ffdf1caff18)
>     at block.c:2505
> #7  0x00007f1208f9f026 in bds_tree_init
> (bs_opts=bs_opts@entry=0x7f120daa4800, errp=errp@entry=0x7ffdf1caff18)
> at blockdev.c:656
> #8  0x00007f1208fa4e5b in qmp_blockdev_add
> (options=options@entry=0x7ffdf1caff20, errp=errp@entry=0x7ffdf1caff18)
> at blockdev.c:3885
> ...
> 
> Please test again with refreshed libqnio and let me know in case of issues.
>

Hi Ashish,

I updated libqnio to 87b641b, and I can confirm that it fixes the issue I
was seeing above.

Thanks,
Jeff
