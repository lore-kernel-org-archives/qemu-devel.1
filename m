Received: from eggs.gnu.org ([2001:4830:134:3::10]:52582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0TRd-00071Z-Ih
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0TRV-0000xk-Pw
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:17:41 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:11133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0TRV-0000vC-IB
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:17:33 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <22999.36984.558631.191104@mariner.uk.xensource.com>
Date: Fri, 6 Oct 2017 15:17:28 +0100
In-Reply-To: <892cb484-361b-f1c1-c294-6b5d7b5e92fb@citrix.com>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<892cb484-361b-f1c1-c294-6b5d7b5e92fb@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/*] xen: xen-domid-restrict improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Stefano  Stabellini <sstabellini@kernel.org>

Ross Lagerwall writes ("Re: [PATCH v2 0/*] xen: xen-domid-restrict improvements"):
> On 10/04/2017 05:18 PM, Ian Jackson wrote:
> > However, there are changes to qemu needed.  In particular
> > 
> >   * The -xen-domid-restrict option does not work properly right now.
> >     It only restricts a small subset of the descriptors qemu has open.
> >     I am introducing a new library call in the Xen libraries for this,
> >     xentoolcore_restrict_all.
...
> I'm testing your QEMU and Xen patch series and found that after being 
> restricted, QEMU fails to setup up the VGA memory properly which causes 
> a complete stall with stdvga. With cirrus it mostly works although it 
> seems to have reduced performance.

Thanks for your testing.

I admit that I didn't look at the VGA console of my guest.  I'm using
cirrus but my guest isn't using it very much.  I use the "serial"
console instead.

> I think it happens when the VM sets up the BAR some time after 
> xen_restrict() has been called. The failure comes from QEMU calling 
> xc_domain_add_to_physmap() which calls do_memory_op() and finally 
> xencall2(). But the underlying xencall fd has been replaced with /dev/null.

I think to fix this properly, we will need to add a dmop version of
XENMEM_add_to_physmap.  I don't propose to try to do that for Xen
4.10.  In the meantime I think this is good enough for "tech preview",
and provides a base to work on.

> There is a caveat when using -xen-domid-restrict and -chroot at the same 
> time. The restriction happens after chrooting, so the chroot directory 
> has to contain a valid /dev/null. This is a bit annoying and prevents 
> the chroot being on a "nodev" mount.

How annoying.  I will fix the relevant qemu patch to do the Xen
restrict before os_setup_post.

Ian.
