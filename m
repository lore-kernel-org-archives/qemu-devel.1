Received: from eggs.gnu.org ([209.51.188.92]:36817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hDcr8-0004Y8-Hq
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 18:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hDcr6-0005cz-FA
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 18:35:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hDcr6-0005Xy-0x
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 18:35:08 -0400
Date: Mon, 8 Apr 2019 19:26:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190408222601.GR7238@habkost.net>
References: <20190407092314.11066-1-thuth@redhat.com>
	<20190408134517.GA9047@richard>
	<14147807-8723-adac-dffb-31b7bbd0fc3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14147807-8723-adac-dffb-31b7bbd0fc3b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0] hw/i386/pc: Fix crash when
 hot-plugging nvdimm on older machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Apr 08, 2019 at 05:06:49PM +0200, Thomas Huth wrote:
> On 08/04/2019 15.45, Wei Yang wrote:
[...]
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 6077d27361..b11f3b15c1 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -2091,6 +2091,9 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >      }
> >  
> >      hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
> > +    if (*errp) {
> > +        return;
> > +    }
> 
> Not sure, but I think you can not rely on the fact that the caller set
> *errp = NULL already... that's why it is more common to use a local_err
> variable and error_propagate() for such cases (which is what I did in my
> patch).

*errp can't be non-NULL (otherwise functions calling error_setg()
would crash).  errp can be NULL, though, and that's why you need
a local_err variable.

I'd love to eliminate NULL errp from our codebase, but I couldn't
find a way to do it that is safe and simple (i.e. not letting us
pass NULL errp by mistake and not requiring a macro wrapping
every `&local_err` expression).

-- 
Eduardo
