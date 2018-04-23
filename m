Received: from eggs.gnu.org ([2001:4830:134:3::10]:45484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAcSO-0005CA-Fe
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAcSL-0004kR-9E
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:28:40 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:19905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAcSK-0004gD-Um
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:28:37 -0400
Date: Mon, 23 Apr 2018 15:28:22 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180423142822.GA1980@perard>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-6-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1524156319-11465-6-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 05/16] xen: defer call to xen_restrict
 until just before os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Apr 19, 2018 at 05:45:08PM +0100, Ian Jackson wrote:
> We need to restrict *all* the control fds that qemu opens.  Looking in
> /proc/PID/fd shows there are many; their allocation seems scattered
> throughout Xen support code in qemu.
> 
> We must postpone the restrict call until roughly the same time as qemu
> changes its uid, chroots (if applicable), and so on.
> 
> There doesn't seem to be an appropriate hook already.  The RunState
> change hook fires at different times depending on exactly what mode
> qemu is operating in.
> 
> And it appears that no-one but the Xen code wants a hook at this phase
> of execution.  So, introduce a bare call to a new function
> xen_setup_post, just before os_setup_post.  Also provide the
> appropriate stub for when Xen compilation is disabled.
> 
> We do the restriction before rather than after os_setup_post, because
> xen_restrict may need to open /dev/null, and os_setup_post might have
> called chroot.
> 
> Currently this does not work with migration, because when running as
> the Xen device model qemu needs to signal to the toolstack that it is
> ready.  It currently does this using xenstore, and for incoming
> migration (but not for ordinary startup) that happens after
> os_setup_post.
> 
> It is correct that this happens late: we want the incoming migration
> stream to be processed by a restricted qemu.  The fix for this will be
> to do the startup notification a different way, without using
> xenstore.  (QMP is probably a reasonable choice.)
> 
> So for now this restriction feature cannot be used in conjunction with
> migration.  (Note that this is not a regression in this patch, because
> previously the -xen-restrict-domid call was, in fact, simply
> ineffective!)  We will revisit this in the Xen 4.11 release cycle.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
