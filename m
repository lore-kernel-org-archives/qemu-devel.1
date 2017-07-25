Received: from eggs.gnu.org ([2001:4830:134:3::10]:52143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1da5ic-0000fP-4n
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1da5iY-0000ot-9N
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:42:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1da5iY-0000ob-26
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:42:06 -0400
Date: Tue, 25 Jul 2017 15:42:03 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <704764196.18988436.1501011723067.JavaMail.zimbra@redhat.com>
In-Reply-To: <alpine.DEB.2.10.1707251155460.22381@sstabellini-ThinkPad-X260>
References: <20170725171302.GK1587@perard.uk.xensource.com>
	<349062488.18968647.1501004879602.JavaMail.zimbra@redhat.com>
	<alpine.DEB.2.10.1707251102130.22381@sstabellini-ThinkPad-X260>
	<1327586655.18981029.1501008326637.JavaMail.zimbra@redhat.com>
	<alpine.DEB.2.10.1707251155460.22381@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU commit 04bf2526ce breaks use of xen-mapcache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xen.org, qemu-devel@nongnu.org


> > Thanks---however, after re-reading xen-mapcache.c, dma needs to be false
> > for unlocked mappings.
> 
> If there is a DMA operation already in progress, it means that we'll
> already have a locked mapping for it.

Yes, I only wanted to say that qemu_ram_ptr_length should pass dma=false
when called by address_space_*_continue (i.e. with locked=false).

Paolo

> When address_space_write_continue is called, which in turn would call
> qemu_map_ram_ptr, or qemu_ram_ptr_length(unlocked), if the start and
> size of the requested mapping matches the one of the previously created
> locked mapping, then a pointer to the locked mapping will be returned.
> 
> If they don't match, a new unlocked mapping will be created and a
> pointer to it will be returned. (Arguably the algorithm could be
> improved so that a new mapping is not created if the address and size
> are contained within the locked mapping. This is a missing optimization
> today.)
> 
> It doesn't matter if a new unlocked mapping is created, or if the locked
> mapping is returned, because the pointer returned by
> qemu_ram_ptr_length(unlocked) is only used to do the memcpy, and never
> again. So I don't think this is a problem.
> 
