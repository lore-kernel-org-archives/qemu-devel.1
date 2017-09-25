Received: from eggs.gnu.org ([2001:4830:134:3::10]:38289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dwcBV-00085o-Hw
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dwcBS-0000QE-6k
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dwcBS-0000PF-0z
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:49:02 -0400
Date: Mon, 25 Sep 2017 15:48:58 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <ffc5e790-253f-e622-1f49-21adad653cc4@msgid.tls.msk.ru>
Message-ID: <alpine.DEB.2.10.1709251548320.21187@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1706271456310.24648@sstabellini-ThinkPad-X260>
	<1498601083-11799-1-git-send-email-sstabellini@kernel.org>
	<8717f8c6-69e4-558e-64d2-f4361cd98594@msgid.tls.msk.ru>
	<ffc5e790-253f-e622-1f49-21adad653cc4@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] xen/disk: don't leak stack data via response ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Stefano Stabellini <sstabellini@kernel.org>, stefanha@gmail.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, Jan Beulich <jbeulich@suse.com>, qemu-devel@nongnu.org, stefanha@redhat.com

On Sun, 24 Sep 2017, Michael Tokarev wrote:
> 23.09.2017 19:05, Michael Tokarev wrote:
> > 28.06.2017 01:04, Stefano Stabellini wrote:
> >> Rather than constructing a local structure instance on the stack, fill
> >> the fields directly on the shared ring, just like other (Linux)
> >> backends do. Build on the fact that all response structure flavors are
> >> actually identical (aside from alignment and padding at the end).
> >>
> >> This is XSA-216.
> >>
> >> Reported by: Anthony Perard <anthony.perard@citrix.com>
> >> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> >> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> >> Acked-by: Anthony PERARD <anthony.perard@citrix.com>
> > 
> > Reportedly, after this patch, HVM DomUs running with qemu-system-i386
> > (note i386, not x86_64), are leaking memory and host is running out of
> > memory rather fast.  See for example https://bugs.debian.org/871702
> 
> Looks like this is a false alarm, the problem actually is with
> 04bf2526ce87f21b32c9acba1c5518708c243ad0 (exec: use qemu_ram_ptr_length
> to access guest ram) without f5aa69bdc3418773f26747ca282c291519626ece
> (exec: Add lock parameter to qemu_ram_ptr_length).
> 
> I applied only 04bf2526ce87f to 2.8, without realizing that we also
> need f5aa69bdc3418).
> 
> Now when I try to backport f5aa69bdc3418 to 2.8 (on top of 04bf2526ce87f),
> I face an interesting logic without also applying 1ff7c5986a515d2d936eba0
> (xen/mapcache: store dma information in revmapcache entries for debugging),
> the arguments for xen_map_cache in qemu_ram_ptr_length() in these two patches
> are quite fun.. :)

Sorry about that. Let me know if you need any help with those backport.
Thank you!

- Stefano
