Received: from eggs.gnu.org ([2001:4830:134:3::10]:34070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dorfM-0003Br-Pf
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dorel-0003sr-KU
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:43:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dorel-0003rw-9p
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:43:15 -0400
Date: Mon, 4 Sep 2017 15:43:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170904154303.48c525fd.cohuck@redhat.com>
In-Reply-To: <20170901154300.2f83c59a.cohuck@redhat.com>
References: <1504190408-11143-1-git-send-email-thuth@redhat.com>
	<20170901154300.2f83c59a.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tests: Enable the drive_del test also
 on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, 1 Sep 2017 15:43:00 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 31 Aug 2017 16:40:08 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
> > We can use the drive_del test on s390x, too, to check that adding and
> > deleting also works fine with the virtio-ccw bus. But we have to make
> > sure that we use the devices with the "-ccw" suffix instead of the
> > "-pci" suffix for the virtio-ccw transport on s390x. Introduce a helper
> > function called qvirtio_get_dev_type() that returns the correct string
> > for the current architecture.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  I'm just sending a patch for this test now to get some feedback whether
> >  I'm on the right track now. If this approach with qvirtio_get_dev_type()
> >  gets accepted, I'll continue converting the other virtio tests, too.  
> 
> Looks good.
> 
> > 
> >  tests/Makefile.include |  3 ++-
> >  tests/drive_del-test.c | 25 ++++++++++++++++---------
> >  tests/libqos/virtio.c  | 17 +++++++++++++++++
> >  tests/libqos/virtio.h  |  3 +++
> >  4 files changed, 38 insertions(+), 10 deletions(-)
> >   
> 
> > diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
> > index 9880a69..0879a62 100644
> > --- a/tests/libqos/virtio.c
> > +++ b/tests/libqos/virtio.c
> > @@ -339,3 +339,20 @@ void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx)
> >      /* vq->avail->used_event */
> >      writew(vq->avail + 4 + (2 * vq->size), idx);
> >  }
> > +
> > +/*
> > + * qvirtio_get_dev_type:
> > + * Returns: the preferred virtio bus/device type for the current architecture.
> > + */
> > +const char *qvirtio_get_dev_type(void)
> > +{
> > +    const char *arch = qtest_get_arch();
> > +
> > +    if (g_str_equal(arch, "arm") || g_str_equal(arch, "aarch64")) {
> > +        return "device";  /* for virtio-mmio */  
> 
> Would not mind a comment from someone familiar with virtio-mmio, though.
> 
> > +    } else if (g_str_equal(arch, "s390x")) {
> > +        return "ccw";
> > +    } else {
> > +        return "pci";
> > +    }
> > +}  
> 
> I'll take this, unless someone complains.

Nobody complained, so I applied this.
