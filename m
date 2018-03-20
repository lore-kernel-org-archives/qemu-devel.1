Received: from eggs.gnu.org ([2001:4830:134:3::10]:42008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyJAc-0001T0-Vf
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyJAW-000708-UR
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:27:26 -0400
Date: Tue, 20 Mar 2018 15:27:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180320152704.GW4530@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180320150421.GC4865@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180320150421.GC4865@localhost.localdomain>
Subject: Re: [Qemu-devel] luks: Initial content of unwritten blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, eblake@redhat.com

On Tue, Mar 20, 2018 at 04:04:21PM +0100, Kevin Wolf wrote:
> Hi,
> 
> I just tried to add luks support to qemu-iotests 025, a basic resize
> test, which made me realise that luks doesn't read zeros in unwritten
> blocks (which makes the test fail).
> 
> The reason for this is that we get zeros on the protocol layer (i.e. in
> the encrpyted data as it is on the disk), but not in the decrpyted
> format layer.

That is basically the same that you would see with dm-crypt luks impl
over a physical device. ie if /dev/sda1 is filled with zeros (or sparse
such that reading from unallocated sectors returns zeros), and you then
format it with luks, and then read data you'll not get zeros - you'll
get the decrypted zeros which is essentially random garbage. The user
would have to make a concious decision to fill the disk with all zeros
in the cipher text if they want their newly formatted luks voilume
to return all zeros.

> Now I'm wondering if that's a problem. Not reading zeros in the guest is
> unusual, but not unheard of (e.g. host_device), but visible zeros in the
> image file could be considered an information leak. On the other hand,
> qcow2 metadata for encrypted images is visible, too, so that's really
> just the same thing.

Leaking information to the guest on whether a sector in a qcow2 file is
allocated or unallocated, might be considered undesirable, but I think
that's one of the tradeoffs of using qcow2 in general not just when
luks is enabled in qcow.

> What do you think, is the current behaviour good enough or should we
> essentially enforce full preallocation for luks images and initialise
> the image so that zeros are visible on the format layer, but random
> encrypted stuff on the protocol layer?

I don't think that's neccessary, as long as users have the option to
opt-in to do that, which they do.

The more important missing piece of the puzzle currently is secure
delete. We need to provide a 'qemu-img rm' command for deleting
volumes that would explicitly overwrite the LUKS headers and key
material, rather than having apps just run plain 'rm'.

> Either way, we should probably document the decision somewhere as
> intentional.

Agreed.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
