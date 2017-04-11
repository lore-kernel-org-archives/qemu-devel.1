Received: from eggs.gnu.org ([2001:4830:134:3::10]:34306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cy1le-0006RZ-R7
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 15:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cy1lb-0001vL-L0
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 15:47:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cy1lb-0001uE-Dh
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 15:47:55 -0400
Date: Tue, 11 Apr 2017 15:47:49 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170411194749.GA5704@localhost.localdomain>
References: <1491277689-24949-1-git-send-email-Ashish.Mittal@veritas.com>
	<1491277689-24949-2-git-send-email-Ashish.Mittal@veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491277689-24949-2-git-send-email-Ashish.Mittal@veritas.com>
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
To: Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, stefanha@gmail.com, Ketan.Nilangekar@veritas.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, venkatesha.mg@veritas.com, Rakesh.Ranjan@veritas.com, eblake@redhat.com, Abhijit.Dey@veritas.com

On Mon, Apr 03, 2017 at 08:48:08PM -0700, Ashish Mittal wrote:
> Source code for the qnio library that this code loads can be downloaded from:
> https://github.com/VeritasHyperScale/libqnio.git
> 
> Sample command line using JSON syntax:
> ./x86_64-softmmu/qemu-system-x86_64 -name instance-00000008 -S -vnc 0.0.0.0:0
> -k en-us -vga cirrus -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5
> -msg timestamp=on
> 'json:{"driver":"vxhs","vdisk-id":"c3e9095a-a5ee-4dce-afeb-2a59fb387410",
> "server":{"host":"172.172.17.4","port":"9999"}}'
> 
> Sample command line using URI syntax:
> qemu-img convert -f raw -O raw -n
> /var/lib/nova/instances/_base/0c5eacd5ebea5ed914b6a3e7b18f1ce734c386ad
> vxhs://192.168.0.1:9999/c6718f6b-0401-441d-a8c3-1f0064d75ee0
> 
> Sample command line using TLS credentials (run in secure mode):
> ./qemu-io --object
> tls-creds-x509,id=tls0,dir=/etc/pki/qemu/vxhs,endpoint=client -c 'read
> -v 66000 2.5k' 'json:{"server.host": "127.0.0.1", "server.port": "9999",
> "vdisk-id": "/test.raw", "driver": "vxhs", "tls-creds":"tls0"}'
> 
> Signed-off-by: Ashish Mittal <Ashish.Mittal@veritas.com>

I was testing this some with blockdev-add and blockdev-del, and this
sequence causes a segfault:

1. blockdev-add vxhs image
2. blockdev-del above image
3. blockdev-add vxhs image  <--- segfaults

Looking at it in gdb, this is an issue with libqnio.  The call to iio_fini()
is not sufficiently thorough in cleaning up resources.

In nio_client.c, qnc_ctx is never freed, because there does not
seem to be a call such as 'qnc_driver_fini' that cleans up the allocated
qnio_client_ctx.

Therefore, on the second call to iio_init, the libqnio internal variable
network_driver is NULL, because qnc_driver_init() returns NULL if it is
called when qnc_ctx is still initialized:



lib/qnio/nio_client.c:

411 int
412 iio_init(int32_t version, iio_cb_t cb)
413 {

[...]

432     apictx->network_driver = qnc_secure_driver_init(client_callback);
433     nioDbg("Created API context.\n");
434     return 0;
435 } 

[...]

779 struct channel_driver *
780 qnc_driver_init(qnio_notify client_notify)
781 {
782     if (qnc_ctx) {
783         nioDbg("Driver already initialized");
784         return NULL;
785     }
786


So two issues:

A. iio_init() should check the returned pointer, and fail if NULL

B. iio_fini() needs to clean everything up so that a new vxhs connection is
   possible. This likely means at least one new function in nio_client.c to
   clean up qnc_ctx.

-Jeff
