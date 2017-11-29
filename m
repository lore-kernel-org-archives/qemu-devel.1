Received: from eggs.gnu.org ([2001:4830:134:3::10]:49648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK0qM-000349-KM
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 06:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK0qH-0002EE-OP
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 06:47:58 -0500
Date: Wed, 29 Nov 2017 12:47:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171129124747.63c1359b.cohuck@redhat.com>
In-Reply-To: <20171129081735.GR5859@bjsdjshi@linux.vnet.ibm.com>
References: <20171128130758.67556-1-pasic@linux.vnet.ibm.com>
	<20171129081735.GR5859@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/1] s390x/css: unrestrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Wed, 29 Nov 2017 16:17:35 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-11-28 14:07:58 +0100]:
> 
> [...]
> > 
> > The auto-generated bus ids are affected by both changes. We hope to not
> > encounter any auto-generated bus ids in production as Libvirt is always
> > explicit about the bus id.  Since 8ed179c937 ("s390x/css: catch section
> > mismatch on load", 2017-05-18) the worst that can happen because the same
> > device ended up having a different bus id is a cleanly failed migration.
> > I find it hard to reason about the impact of changed auto-generated bus
> > ids on migration for command line users as I don't know which rules is
> > such an user supposed to follow.  
> For this paragraph, Halil pointed to me a case that he is thinking of.
> 1. VM configuration with 3 devices:
>   -device virtio (e.g. virtio-blk-ccw,id=disk0)
>   -device vfio-ccw (e.g. id=vfio0)
>   -device virtio (e.g. virtio-rng-ccw,id=rng0)
> 2. Start the vm.
> 3. device_del vfio0
> 4. migrate "exec:gzip -c > /tmp/tmp_vmstate.gz"
> 5. modify cmd line from step 1 by removing the vfio0 device, and adding:
>    -incoming "exec:gzip -c -d /tmp/tmp_vmstate.gz"
> 
> Let me list my test results here for everybody's reference.
> 
> W/o this patch
> ==============
> 
> ------------+---------------+-------------
>             | squashing off | squashing on
> ------------+---------------+-------------
>     auto id |        F      |     F
> ------------+---------------+-------------
> explicit id |        F      |     S
> ------------+---------------+-------------
> 
> T1. squashing off + auto id
>   qemu-system-s390x: vmstate: get_nullptr expected VMS_NULLPTR_MARKER
>   qemu-system-s390x: Failed to load s390_css:css
>   qemu-system-s390x: error while loading state for instance 0x0 of device 's390_css'
>   qemu-system-s390x: load of migration failed: Invalid argument
> [Fail due to css mismatch - there is no css 0 in the new vm.]
> 
> T2. squashing off + explicit given id
>   qemu-system-s390x: vmstate: get_nullptr expected VMS_NULLPTR_MARKER
>   qemu-system-s390x: Failed to load s390_css:css
>   qemu-system-s390x: error while loading state for instance 0x0 of device 's390_css'
>   qemu-system-s390x: load of migration failed: Invalid argument
> [Fail due to css mismatch - there is no css 0 in the new vm.]

Hmm... so should we even try to migrate an empty css 0? It only exists
because we have created a device that we had to detach anyway because
it was non-migrateable...

[Probably no easy way to deal with this, though.]

> 
> T3. squashing on  + auto id
>   qemu-system-s390x: Unknown savevm section or instance '/00.0.0003/virtio-rng' 0
>   qemu-system-s390x: load of migration failed: Invalid argument
> [Fail due to busid mismatch.]
> 
> T4. squashing on  + explicit given id
>   Succeed.
> 
> With this patch
> ===============
> 
> ------------+---------------+-------------
>             | squashing off | squashing on
> ------------+---------------+-------------
>     auto id |        F      |     F
> ------------+---------------+-------------
> explicit id |        S'     |     S
> ------------+---------------+-------------
> 
> T5. squashing off + auto id
>   qemu-system-s390x: Unknown savevm section or instance '/fe.0.0003/virtio-rng' 0
>   qemu-system-s390x: load of migration failed: Invalid argument
> [Fail due to busid mismatch.]
> 
> T6. squashing off + explicit given id
>   qemu-system-s390x: vmstate: get_nullptr expected VMS_NULLPTR_MARKER
>   qemu-system-s390x: Failed to load s390_css:css
>   qemu-system-s390x: error while loading state for instance 0x0 of device 's390_css'
>   qemu-system-s390x: load of migration failed: Invalid argument
> [Setting vfio-ccw.devno=non-fe.x.xxxx. (same as T1)
>  Fail due to css mismatch - there is no css 0 in the new vm.]
> 
>   Succeed.
> [Setting vfio-ccw.devno=fe.x.xxxx.]

Don't you need to attach the vfio-ccw device later anyway? You have to
detach it from the source before you migrate, and I'd expect it to be
symmetric.

> 
> T7. squashing on  + auto id
>   qemu-system-s390x: Unknown savevm section or instance '/00.0.0003/virtio-rng' 0
>   qemu-system-s390x: load of migration failed: Invalid argument
> [Fail due to busid mismatch.]
> 
> T8. squashing on  + explicit given id
>   Succeed.
> 
> 
> Notice:
> The differences of the test results between w and w/o this patch are in
> the "squashing off" cases. I think these are things that we can accept.

Yes, I think that makes sense. If you want reliable migration, you need
to be specific with your ids. I'd just don't want us to break things
explicitly.
