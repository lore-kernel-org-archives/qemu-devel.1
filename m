Received: from eggs.gnu.org ([209.51.188.92]:43791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtEV1-0001z4-BH
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtEUv-0002Zz-Hc
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:32:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gtEUu-0002Rx-QP
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:31:57 -0500
Date: Mon, 11 Feb 2019 16:13:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190211161325.GG27585@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
	<20190211160357.GK2627@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211160357.GK2627@work-vm>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Add ignore-external migration
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Yury Kotov <yury-kotov@yandex-team.ru>, qemu-devel@lists.ewheeler.net, jiangshanlai@gmail.com, peter.maydell@linaro.org, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, wrfsh@yandex-team.ru, Richard Henderson <rth@twiddle.net>

On Mon, Feb 11, 2019 at 04:03:57PM +0000, Dr. David Alan Gilbert wrote:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> > Hi,
> > 
> > The series adds a migration capability, which allows to skip shared RAM blocks
> > during the migration. It's useful for fast local migration. E.g. to update QEMU
> > for the running guests.
> > 
> > Usage example:
> > 1. Start source VM:
> >    qemu-system-x86 \
> >      -m 4G \
> >      -object memory-backend-file,id=mem0,size=4G,share=on,mem-path=/dev/shm/mem0 \
> >      -numa node,memdev=mem0 \
> >      -qmp unix:/tmp/qemu-qmp-1.sock,server,nowait \
> > 
> > 2. Start target VM:
> >    qemu-system-x86 \
> >      -m 4G \
> >      -object memory-backend-file,id=mem0,size=4G,share=on,mem-path=/dev/shm/mem0 \
> >      -numa node,memdev=mem0 \
> >      -qmp unix:/tmp/qemu-qmp-2.sock,server,nowait \
> >      -incoming defer
> > 
> > 3. Enable ignore-external capability on both VMs:
> >    { "execute": "migrate-set-capabilities" , "arguments":
> >      { "capabilities": [ { "capability": "x-ignore-external", "state": true } ] } }
> > 
> > 4. Start migration.
> > 
> > Another use case I keep in mind is to migrate to file. Usage is very similar.
> 
> Hi,
>   I've cc'd in Eric, Lai and Peter, all who were asking for something
> similar last year;  can you all confirm this patch does what you need or
> can work with what you needed to do?

x-ignore-external is a global setting so affects all memory-backend-file
instances. The obvious question is where there is any reasonable/conceivable
scenario in which QEMU would have multiple "-object memory-backend-file"
intsances and it be neccessary/desirable to migrate some, but skip migrate
of others ?

Could there ever be a device backend which is using a memory region
to communicate with an external process, where you would need to have
a new instance for the migration target QEMU, and explicitly not reuse
the source QEMU's memory-backend-file storage  ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
