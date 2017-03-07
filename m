Received: from eggs.gnu.org ([2001:4830:134:3::10]:40393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1clCUJ-0000k2-Gr
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1clCUG-0006Ap-Cm
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:37:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1clCUG-0006Af-7C
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:37:00 -0500
Date: Tue, 7 Mar 2017 10:36:54 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170307103654.GD15368@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170303135150.12145-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170303135150.12145-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/4] qemu-img: add max-size subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

On Fri, Mar 03, 2017 at 09:51:46PM +0800, Stefan Hajnoczi wrote:
> RFCv1:
>  * Publishing patch series with just raw support, no qcow2 yet.  Please review
>    the command-line interface and let me know if you are happy with this
>    approach.
> 
> Users and management tools sometimes need to know the size required for a new
> disk image so that an LVM volume, SAN LUN, etc can be allocated ahead of time.
> Image formats like qcow2 have non-trivial metadata that makes it hard to
> estimate the exact size without knowledge of file format internals.
> 
> This patch series introduces a new qemu-img subcommand that calculates the
> required size for both image creation and conversion scenarios.
> 
> The conversion scenario is:
> 
>   $ qemu-img max-size -f raw -O qcow2 input.img
>   107374184448
> 
> Here an existing image file is taken and the output includes the space required
> for data from the input image file.
> 
> The creation scenario is:
> 
>   $ qemu-img max-size -O qcow2 --size 5G
>   196688

Hmm, so that appears to be indicating the amount of physical space that
a qcow2 image would take up before any data has been written to it.

That's not actually what I was thinking. I would like to know the maximum
possible physical space that a 5G qcow2 image would take up once data is
written to every sector. Obviously this is impossible to say if you allow
for internal snapshots, but I think it is fine to say that we ignore
internal snapshots for purposes of this command.

IOW, I would expect  something like:

$ qemu-img max-size -O qcow2 --size 5G
5905580032

(I just blindly assumed qcow2 metadata is a 10% overhead for sake of
illustrating the number here)


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
