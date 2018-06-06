Received: from eggs.gnu.org ([2001:4830:134:3::10]:34272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQbRg-0004Dp-Ch
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQbRf-0007am-Ff
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:38:00 -0400
References: <20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606150507.GJ2660@work-vm>
	<66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
	<20180606181135.2985cf0c@kitsune.suse.cz>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5665031b-f400-8f8b-e43f-8b93e79ead85@redhat.com>
Date: Wed, 6 Jun 2018 11:37:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180606181135.2985cf0c@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com

On 06/06/2018 11:11 AM, Michal Such=C3=A1nek wrote:

> The reason why storing the config inside the qcow2 file is you have one
> self-contained file that can be updated by qemu itself.
>=20
> So you take an image file, point your management console to it, boot
> it, change something on it, shut it down, and publish the image as the
> new revision of the VM.
>=20
> With the tar file the management console needs to chew the tar file,
> save a copy of the config file and the disk image somewhere, and when
> you update the image you have to re-export the tar file.

That's not necessarily true.  We're arguing that as long as the qcow2=20
image is last in the tar file, it should still be relatively easy to=20
write a qemu block driver that manages tar files for in-place qcow2=20
editing.  GNU tar can also do --append or --update to modify the config=20
file; although we may have to be careful if that starts to make the=20
qcow2 image not the last member in the tar file.  On the other hand, if=20
updating the config file is a common enough operation, I would not be=20
surprised if we end up teaching the qemu tar driver how to resize images=20
even when the qcow2 portion of the tar file is not last, or adding=20
qemu-img commands that wrap typical tar file manipulations.

>=20
> This is a lot of lengthy copying. The upside is that the console can
> check that the machine you are exporting is not running an you are not
> prone to publishing images in inconsistent state.

Read-only qcow2 within a tar does NOT require lengthy copying.  Updating=20
qcow2 within tar might, but then again, we are arguing that with a sane=20
layout, copying the ENTIRE qcow2 portion is NOT always going to be=20
necessary.  For example, modern Linux has things like=20
fallocate(FALLOC_FL_INSERT_RANGE) (on file systems that are capable) for=20
enlarging the head of a tar file enough to stick in a larger config file=20
at the front, with a LOT less data movement effort when compared to=20
moving the qcow2 tail of that same tar file.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
