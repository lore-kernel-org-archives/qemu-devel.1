Received: from eggs.gnu.org ([2001:4830:134:3::10]:57317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fgV53-0007fs-LV
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 09:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fgV4y-0001sI-U6
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 09:04:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fgV4y-0001s6-OY
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 09:04:16 -0400
Date: Fri, 20 Jul 2018 09:04:15 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1832644023.52851886.1532091855557.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180719084819.730b7971@doriath>
References: <20180713075232.9575-1-pagupta@redhat.com>
	<20180713075232.9575-4-pagupta@redhat.com>
	<20180718085529.133a0a22@doriath>
	<367397176.52317488.1531979293251.JavaMail.zimbra@redhat.com>
	<20180719121635.GA28107@stefanha-x1.localdomain>
	<20180719084819.730b7971@doriath>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3] qemu: Add virtio pmem device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, kvm@vger.kernel.org, riel@surriel.com, linux-nvdimm@ml01.01.org, david@redhat.com, ross zwisler <ross.zwisler@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, hch@infradead.org, imammedo@redhat.com, mst@redhat.com, niteshnarayanlal@hotmail.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, nilal@redhat.com


> > > > > +
> > > > > +typedef struct VirtIOPMEMresp {
> > > > > +    int ret;
> > > > > +} VirtIOPMEMResp;
> > > > > +
> > > > > +typedef struct VirtIODeviceRequest {
> > > > > +    VirtQueueElement elem;
> > > > > +    int fd;
> > > > > +    VirtIOPMEM *pmem;
> > > > > +    VirtIOPMEMResp resp;
> > > > > +} VirtIODeviceRequest;
> > > > > +
> > > > > +static int worker_cb(void *opaque)
> > > > > +{
> > > > > +    VirtIODeviceRequest *req = opaque;
> > > > > +    int err = 0;
> > > > > +
> > > > > +    /* flush raw backing image */
> > > > > +    err = fsync(req->fd);
> > > > > +    if (err != 0) {
> > > > > +        err = errno;
> > > > > +    }
> > > > > +    req->resp.ret = err;
> > > > 
> > > > Host question: are you returning the guest errno code to the host?
> > > 
> > > No. I am returning error code from the host in-case of host fsync
> > > failure, otherwise returning zero.
> > 
> > I think that's what Luiz meant.  errno constants are not portable
> > between operating systems and architectures.  Therefore they cannot be
> > used in external interfaces in software that expects to communicate with
> > other systems.
> 
> Oh, thanks. Only saw this email now.
> 
> > It will be necessary to define specific constants for virtio-pmem
> > instead of passing errno from the host to guest.
> 
> Yes, defining your own constants work. But I think the only fsync()
> error that will make sense for the guest is EIO. The other errors
> only make sense for the host.

Agree.

Thanks,
Pankaj
