Received: from eggs.gnu.org ([2001:4830:134:3::10]:55393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAED7-0007Sc-PW
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAED6-0004p9-6k
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:03:01 -0400
Date: Thu, 2 Nov 2017 12:02:23 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171102120223.GI32533@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] RFC: use case for adding QMP,
 block jobs & multiple exports to qemu-nbd ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

I've been thinking about a potential design/impl improvement for the way
that OpenStack Nova handles disk images when booting virtual machines, and
thinking if some enhancements to qemu-nbd could be beneficial...

At a high level, OpenStack has a repository of disk images (Glance), and
when we go to boot a VM, Nova copies the disk image out of the repository
onto the local host's image cache. We doing this, Nova may also enlarge
disk image (eg if the original image has 10GB size, it may do a qemu-img
resize to 40GB). Nova then creates a qcow2 overlay with backing file
pointing to its local cache. Multiple VMs can be booted in parallel each
with their own overlay pointing to the same backing file

The problem with this approach is that VM startup is delayed while we copy
the disk image from the glance repository to the local cache, and again
while we do the image resize (though the latter is pretty quick really
since its just changing metadata in the image and/or host filesystem)

One might suggest that we avoid the local disk copy and just point the
VM directly at an NBD server running in the remote image repository, but
this introduces a centralized point of failure. With the local disk copy
VMs can safely continue running even if the image repository dies. Running
from the local image cache can offer better performance too, particularly
if having SSD storage. 

Conceptually what I want to start with is a 3 layer chain

   master-disk1.qcow2  (qemu-nbd)
          |
          |  (format=raw, proto=nbd)
	  |
   cache-disk1.qcow2   (qemu-system-XXX)
          |
          |  (format=qcow2, proto=file)
	  |
          +-  vm-a-disk1.qcow2   (qemu-system-XXX)

NB vm-?-disk.qcow2 sizes may different than the backing file.
Sometimes OS disk images are built with a fairly small root filesystem
size, and the guest OS will grow its root FS to fill the actual disk
size allowed to the specific VM instance.

The cache-disk1.qcow2 is on each local virt host that needs disk1, and
created when the first VM is launched. Further launched VMs can all use
this same cached disk.  Now the cache-disk1.qcow2 is not useful as is,
because it has no allocated clusters, so after its created we need to
be able to stream content into it from master-disk1.qcow2, in parallel
with the VM A booting off vm-a-disk1.qcow2

If there was only a single VM, this would be easy enough, because we
can use drive-mirror monitor command to pull master-disk1.qcow2 data
into cache-disk1.qcow2 and then remove the backing chain leaving just

   cache-disk1.qcow2   (qemu-system-XXX)
          |
	  |  (format=qcow2, proto=file)
          |
          +-  vm-a-disk1.qcow2  (qemu-system-XXX)

The problem is that many VMs are wanting to use cache-disk1.qcow2 as
their disk's backing file, and only one process is permitted to be
writing to disk backing file at any time. So I can't use the drive-mirror
in the QEMU processes to deal with this; all QEMU's must see their
backing file in a consistent read-only state

I've been wondering if it is possible to add an extra layer of NBD to
deal with this scenario. i.e. start off with:

   master-disk1.qcow2  (qemu-nbd)
          |
          |  (format=raw, proto=nbd)
	  |
   cache-disk1.qcow2  (qemu-nbd)
          |
          |  (format=raw, proto=nbd)
	  |
          +-  vm-a-disk1.qcow2  (qemu-system-XXX)
          +-  vm-b-disk1.qcow2  (qemu-system-XXX)
          +-  vm-c-disk1.qcow2  (qemu-system-XXX)


In this model 'cache-disk1.qcow2' would be opened read-write by a
qemu-nbd server process, but exported read-only to QEMU. qemu-nbd
would then do a drive mirror to stream the contents of
master-disk1.qcow2 into its cache-disk1.qcow2, concurrently with
servicing read requests from many QEMU's vm-*-disk1.qcow2 files
over NBD. When the drive mirror is complete we would again cut
the backing file to give

   cache-disk1.qcow2  (qemu-nbd)
          |
          |  (format=raw, proto=nbd)
	  |
          +-  vm-a-disk1.qcow2  (qemu-system-XXX)
          +-  vm-b-disk1.qcow2  (qemu-system-XXX)
          +-  vm-c-disk1.qcow2  (qemu-system-XXX)

Since qemu-nbd no longer needs write to cache-disk1.qcow2 at this point,
we can further pivot all the QEMU servers to make vm-*-disk1.qcow2 use
format=qcow2,proto=file, allowing the local qemu-nbd to close the disk
image, and potentially exit (assuming it doesn't have other disks to
service). This would leave

   cache-disk1.qcow2  (qemu-system-XXX)
          |
          |  (format=qcow2, proto=file)
	  |
          +-  vm-a-disk1.qcow2  (qemu-system-XXX)
          +-  vm-b-disk1.qcow2  (qemu-system-XXX)
          +-  vm-c-disk1.qcow2  (qemu-system-XXX)

Conceptually QEMU has all the pieces neccessary to support this kind of
approach to disk images, but they're not exposed by qemu-nbd as it has
no QMP interface of its own.

Another more minor issue is that the disk image repository may have
1000's of images in it, and I don't want to be running 1000's of
qemu-nbd instances. I'd like 1 server to export many disks. I could
use iscsi in the disk image repository instead to deal with that, 
only having the qemu-nbd processes running on the local virt host
for the duration of populating cache-disks1.qcow2 from master-disk1.qcow2
The iscsi server admin commands are pretty unplesant to use compared
to QMP though, so its appealing to use NBD for everything.

After all that long background explanation, what I'm wondering is whether
there is any interest / desire to extend qemu-nbd to have more advanced
featureset than simply exporting a single disk image which must be listed
at startup time.

 - Ability to start qemu-nbd up with no initial disk image connected
 - Option to have a QMP interface to control qemu-nbd
 - Commands to add / remove individual disk image exports
 - Commands for doing the drive-mirror / backing file pivot

It feels like this wouldn't require significant new functionality in either
QMP or block layer. It ought to be mostly a cache of taking existing QMP
code and wiring it up in qemu-nbd, and only exposing a whitelisted subset
of existing QMP commands related to block backends. 

One alternative approach to doing this would be to suggest that we should
instead just spawn qemu-system-x86_64 with '--machine none' and use that
as a replacement for qemu-nbd, since it already has a built-in NBD server
which can do many exports at once and arbitrary block jobs.

I'm concerned that this could end up being a be a game of whack-a-mole
though, constantly trying to cut out/down all the bits of system emulation
in the machine emulators to get its resource overhead to match the low
overhead of standalone qemu-nbd.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
