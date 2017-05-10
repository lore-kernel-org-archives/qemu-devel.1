Received: from eggs.gnu.org ([2001:4830:134:3::10]:40723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d8OOB-00050i-1o
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d8OO7-00039i-6W
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:58:35 -0400
Date: Wed, 10 May 2017 17:58:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170510095826.GB11394@lemon.lan>
References: <20170510092333.8890-1-famz@redhat.com>
	<8760h96nva.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8760h96nva.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] virtio: Unregister memory listener when
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Wed, 05/10 11:51, Markus Armbruster wrote:
> Fam Zheng <famz@redhat.com> writes:
> 
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  hw/virtio/virtio.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 03592c5..a7741f4 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2515,6 +2515,7 @@ static void virtio_device_unrealize(DeviceState *dev, Error **errp)
> >          }
> >      }
> >  
> > +    memory_listener_unregister(&vdev->listener);
> >      g_free(vdev->bus_name);
> >      vdev->bus_name = NULL;
> >  }
> 
> Is this a bug fix?  If yes, what exactly's broken without it?
> 

I thought it was obvious (missing unregister) but that was a mistake. There is
one in virtio_device_instance_finalize(), but the callback is just not called
due to something else with the QOM refcnt.

Will revise, and add commit message, of course.

Fam
