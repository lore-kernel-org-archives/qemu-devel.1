Received: from eggs.gnu.org ([2001:4830:134:3::10]:41613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1clEBO-0006il-OJ
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1clEBK-0001Lr-V4
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:25:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1clEBK-0001LP-Ni
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:25:34 -0500
Date: Tue, 7 Mar 2017 12:25:29 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170307122529.GF15368@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170303135150.12145-1-stefanha@redhat.com>
	<20170307103654.GD15368@redhat.com>
	<w51fuip2sn3.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w51fuip2sn3.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [RFC 0/4] qemu-img: add max-size subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Nir Soffer <nsoffer@redhat.com>, John Snow <jsnow@redhat.com>

On Tue, Mar 07, 2017 at 01:11:44PM +0100, Alberto Garcia wrote:
> On Tue 07 Mar 2017 11:36:54 AM CET, Daniel P. Berrange wrote:
> >> The creation scenario is:
> >> 
> >>   $ qemu-img max-size -O qcow2 --size 5G
> >>   196688
> >
> > Hmm, so that appears to be indicating the amount of physical space
> > that a qcow2 image would take up before any data has been written to
> > it.
> >
> > That's not actually what I was thinking. I would like to know the
> > maximum possible physical space that a 5G qcow2 image would take up
> > once data is written to every sector. Obviously this is impossible to
> > say if you allow for internal snapshots, but I think it is fine to say
> > that we ignore internal snapshots for purposes of this command.
> 
> We have clearly two different use cases here, although I wonder how
> useful the one that you are describing is. After all the maximum size of
> a fully allocated imaged is always going to be the virtual size plus a
> small overhead for the metadata. I haven't made the numbers for all
> cases, but I'll take the risk and say it's always going to be really
> small (the 10% you use to illustrate your point is way too much).
> 
> A fully allocated 1TB qcow2 image needs less than 200MB of metadata
> (that's 0.02% of the total size). If we reduce the cluster size to its
> minimum (512 bytes) then it's around 20GB (still ~2% of the total size).

I know of several places where this info is useful. OpenStack stores
images in a filesystem. It knows what space is available in the filesystem
and wants to avoid creating qcow2 file that would overcommit that available
space. Knowing the qcow2 overhead would allow it to compute that without
having to resort to over-cautious guesswork which needlessly leaves
space unused. Similarly when creating a file that has a backing file,
qcow2 does not allow use of preallocation, and openstack thus uses
fallocate after qemu has created the file in order to reserve the
space needed to allow for maximum possible growth of the qcow2 file.
oVirt stores qcow2 images inside block devices and it would be useful
to know maximum possible size in order to correctly size the block
device without having to resort to guesswork.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
