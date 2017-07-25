Received: from eggs.gnu.org ([2001:4830:134:3::10]:59686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1da4Fw-0000cb-KA
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1da4Ft-0001DH-E3
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1da4Ft-0001CH-86
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:08:25 -0400
Date: Tue, 25 Jul 2017 11:08:21 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <349062488.18968647.1501004879602.JavaMail.zimbra@redhat.com>
Message-ID: <alpine.DEB.2.10.1707251102130.22381@sstabellini-ThinkPad-X260>
References: <20170725171302.GK1587@perard.uk.xensource.com>
	<349062488.18968647.1501004879602.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] QEMU commit 04bf2526ce breaks use of xen-mapcache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xen.org, qemu-devel@nongnu.org

On Tue, 25 Jul 2017, Paolo Bonzini wrote:
> > Hi,
> > 
> > Commits 04bf2526ce (exec: use qemu_ram_ptr_length to access guest ram)
> > start using qemu_ram_ptr_length() instead of qemu_map_ram_ptr().
> > That result in calling xen_map_cache() with lock=true, but this mapping
> > is never invalidated.
> > So QEMU use more and more RAM until it stop working for a reason or an
> > other. (crash if host have little RAM or stop emulating but no crash)
> > 
> > I don't know if calling xen_invalidate_map_cache_entry() in
> > address_space_read_continue() and address_space_write_continue() is the
> > right answer.  Is there something better to do ?
> 
> I think it's correct for dma to be true... maybe add a lock argument to
> qemu_ram_ptr_length, so that make address_space_{read,write}_continue can
> pass 0 and everyone else passes 1?

I think that is a great suggestion. That way, the difference between
locked mappings and unlocked mappings would be explicit, rather than
relying on callers to use qemu_map_ram_ptr for unlocked mappings and
qemu_ram_ptr_length for locked mappings. And there aren't that many
callers of qemu_ram_ptr_length, so adding a parameter wouldn't be an
issue.
