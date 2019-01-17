Received: from eggs.gnu.org ([209.51.188.92]:49504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkACf-0007qN-8g
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkACe-0005ep-9E
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:07:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gkACd-0005Vn-FU
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:07:36 -0500
Date: Thu, 17 Jan 2019 16:06:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190117160657.GD11022@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190117153321.29749-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117153321.29749-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Expand 'qemu-img info' to show
 protocol details
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com

On Thu, Jan 17, 2019 at 09:33:18AM -0600, Eric Blake wrote:
> Posting this now to get feedback on the general idea; it would still
> need to be polished into a form I'd feel happy committing, including
> reworking 'qemu-nbd --list' to reuse the new NBD-specific QAPI type.
> 
> Based-on: <20190112175812.27068-1-eblake@redhat.com>
> [0/19 nbd: add qemu-nbd --list]
> 
> Examples with this applied:
> $ ./qemu-img info file
> image: file
> file format: qcow2
> virtual size: 1.0M (1048576 bytes)
> disk size: 672K
> cluster_size: 65536
> Format specific information:
>     compat: 1.1
>     lazy refcounts: false
>     refcount bits: 16
>     corrupt: false
> Protocol specific information:
>     write zero: true
>     discard zero: true
>     discard: true
>     align: 1
> $ qemu-nbd file &
> $ ./qemu-img info nbd://localhost:10809
> image: nbd://localhost:10809
> file format: raw
> virtual size: 1.0M (1048576 bytes)
> disk size: unavailable
> Protocol specific information:
>     flags:
>     active contexts:
>         [0]:
>             name: base:allocation
>             id: 0
>     unknown flags: 1260

One thing that occurs to me is that the qemu-img info output data is
getting larger & larger over time. Especially with LUKS, the format
specific data is quite huge. Adding protocol specific info makes it
larger again.

In retrospect, IMHO, it would have been nice to not show the format
specific info by default, requiring a --verbose arg. Assuming we don't
want to change default behaviour though, we might as well show protocol
specific info by default too.

I wonder though if we could benefit from a '-b' / '--brief' arg to make
it switch to show only the short common metadata, for people who want a
more concise output.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
