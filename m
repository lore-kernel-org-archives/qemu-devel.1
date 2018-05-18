Received: from eggs.gnu.org ([2001:4830:134:3::10]:33641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fJitM-0001Hq-Kc
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fJitL-0002uG-2j
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:10:08 -0400
Date: Fri, 18 May 2018 18:09:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180518170956.GI8615@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180518180440-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518180440-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: ehabkost@redhat.com, stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, May 18, 2018 at 06:30:38PM +0300, Michael S. Tsirkin wrote:
> Hi!
> Right now, QEMU supports multiple machine types within
> a given architecture. This was the case for many architectures
> (like ARM) for a while, somewhat more recently this is the case
> for x86 with I440FX and Q35 options.
> 
> Unfortunately this means that it's no longer possible
> to more or less reliably boot a VM just given a disk image,
> even if you select the correct QEMU binary:
> you must supply the correct machine type.

You must /sometimes/ supply the correct machine type.

It is quite dependent on the guest OS you have installed, and even
just how the guest OS is configured.  In general Linux is very
flexible and can adapt to a wide range of hardware, automatically
detecting things as needed. It is possible for a sysadmin to build
a Linux image in a way that would only work with I440FX, but I
don't think it would be common to see that. Many distros build
and distribute disk images that can work across VMWare, KVM,
and VirtualBox which all have very quite different hardware.
Non-x86 archs may be more fussy but I don't have personal
experiance with them

Windows is probably where things get more tricky, as it is not
happy with disks moving between different controller types
for example, and you might trigger license activation again.


> Some guests go even further and require specific devices to be present.
> 
> Would it be reasonable to support storing this information in the qcow
> image itself?  For example, I can see it following immediately the
> backing file path within the image.

The backing file string needs to go in space between the end of headers
and start of first cluster, and the spec explicitly says nothing else
must be stored there. Also we can already hit the length limit on the
backing file.

There would need to be an explicit header extension defined with its
own clusters allocated instead.

That said I'm not really convinced that using the qcow2 headers is
a good plan. We have many disk image formats in common use, qcow2
is just one. Even if the user provides the image in qcow2 format,
that doesn't mean that mgmt apps actually store the qcow2 file.

For example in some deployments OpenStack will immediately
convert the image to raw for storage in an RBD volume as it is
uploaded to Glance. So the glance image store would need to
have a way to extract & save the info at time of upload. OpenStack
targets multiple hypervisors though, so I'm not sure they would
welcome something that is specific to just qcow2 in this area.

The closest to a cross-hypervisor standard is OVF which can store
metadata about required hardware for a VM. I'm pretty sure it does
not have the concept of machine types, but maybe it has a way for
people to define metadata extensions. Since it is just XML at the
end of the day, even if there was nothing official in OVF, it would
be possible to just define a custom XML namespace and declare a
schema for that to follow.


> As Eduardo pointed out off-list, the format could be a set of key-value
> pairs. Initially qemu-img could gain ability to retrieve and manipulate
> these. Down the road we could teach qemu to use them automatically.
> We could also thinkably warn the user, or drop the image from the boot
> order.
> 
> Reasonable (IMO) things we could store in such a section:
> - qemu architecture to use with the image
> - machine type

A concern is about what you actually put here. We could easily create a
situation where we make images /less/ portable. eg take a Linux image
which is capable of running on both i440fx and q35, if that was built
on i44fx and that gets recorded, a mgmt app which honours this info
is needless restricting how the image can be run.

Or consider that LTS distros typically create custom machine types,
so you can have a image with machine type  pc-rhel-7.4.0 which is
now unable to be used on an Ubuntu distro which lacks the RHEL
machine types.

IOW, there's a distinction between what's recommended, vs what's
required, vs what's forbidden. Whitelisting valid machine types
is too restrictive, but blacklisting is not broad enough.

> more possibilities:
> - required cpu flags

Again this is not so black & white - there's a distinction between
what is absolutely required vs what is merely recommended

> - expected frontend devices
> - kernel flags for device tree based guests
> 
> Security considerations
> - If there is a machine type specific security issue,
>   this makes it easier to trick user to hitting it.
>   Not sure how common this is.

This would imply setting very specific versioned machine type
choice, but that kills any kind of platform portability.

> - We most likely shouldn't get backend parameters from the image
> 
> Thoughts?

I tend to think we'd be better looking at what we can do in the context
of an existing standard like OVF rather than inventing something that
only works with qcow2. I think it would need to be more expressive than
just a single list of key,value pairs for each item.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
