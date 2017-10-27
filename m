Received: from eggs.gnu.org ([2001:4830:134:3::10]:50366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=466efc5b4=Ian.Jackson@citrix.com>)
	id 1e81hQ-0003kv-9D
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=466efc5b4=Ian.Jackson@citrix.com>)
	id 1e81hM-0004rW-4v
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:17:12 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:33113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=466efc5b4=Ian.Jackson@citrix.com>)
	id 1e81hL-0004q4-UF
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:17:08 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23027.1942.14349.815707@mariner.uk.xensource.com>
Date: Fri, 27 Oct 2017 11:16:54 +0100
In-Reply-To: <alpine.DEB.2.10.1710261525120.3086@sstabellini-ThinkPad-X260>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
	<1508506702-17704-6-git-send-email-ian.jackson@eu.citrix.com>
	<alpine.DEB.2.10.1710261525120.3086@sstabellini-ThinkPad-X260>
Subject: Re: [Qemu-devel] [PATCH v5.1 6/8] xen: destroy_hvm_domain: Try
 xendevicemodel_shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org

Stefano Stabellini writes ("Re: [PATCH v5.1 6/8] xen: destroy_hvm_domain: Try xendevicemodel_shutdown"):
> On Fri, 20 Oct 2017, Ian Jackson wrote:
> > xc_interface_open etc. is not going to work if we have dropped
> > privilege, but xendevicemodel_shutdown will if everything is new
> > enough.
> > 
> > xendevicemodel_shutdown is only availabe in Xen 4.10 and later, so
> > provide a stub for earlier versions.
...
> > +    if (xen_dmod) {
> > +        rc = xendevicemodel_shutdown(xen_dmod, xen_domid, reason);
> > +        if (!rc) {
> > +            return;
> > +        }
> > +        perror("xendevicemodel_shutdown failed");
> 
> I don't think is a good idea to print an error because this is actually
> a normal condition when QEMU is build and run against an older Xen.
> Users might get confused when looking at the logs.

Oh.  Yes.  I wrote this before I provided the fallback stub in
xen_common.h, and therefore before I properly understood the approach
taken to fallbacks.  The fallback logic here is not correct.

> But it would be correct to print an error if errno != ENOTTY.

Indeed.

I have changed it to read like this:

    if (xen_dmod) {
        rc = xendevicemodel_shutdown(xen_dmod, xen_domid, reason);
        if (!rc) {
            return;
        }
        if (errno != ENOTTY /* old Xen */)
            perror("xendevicemodel_shutdown failed");
        /* well, try the old thing then */
    }

Thanks,
Ian.
