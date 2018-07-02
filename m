Received: from eggs.gnu.org ([2001:4830:134:3::10]:38568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fa6J1-0007z2-RX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fa6Iy-0004w3-NQ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:24:19 -0400
Date: Mon, 2 Jul 2018 18:24:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180702212411.GG7451@localhost.localdomain>
References: <153052169663.619548.17452930454532662595.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153052169663.619548.17452930454532662595.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: compute default value of
 "hpt-max-page-size" later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>

On Mon, Jul 02, 2018 at 10:54:56AM +0200, Greg Kurz wrote:
> It is currently not possible to run a pseries-2.12 or older machine
> with HV KVM. QEMU prints the following and exits right away.
> 
> qemu-system-ppc64: KVM doesn't support for base page shift 34
> 
> The "hpt-max-page-size" capability was recently added to spapr to hide
> host configuration details from HPT mode guests. Its default value for
> newer machine types is 64k.
> 
> For backwards compatibility, pseries-2.12 and older machine types need
> a different value. This is handled as usual in a class init function.
> The default value is 16G, ie, all page sizes supported by POWER7 and
> newer CPUs, but HV KVM requires guest pages to be hpa contiguous as
> well as gpa contiguous. The default value is the page size used to
> back the guest RAM in this case.
> 
> Unfortunately kvmppc_hpt_needs_host_contiguous_pages()->kvm_enabled() is
> called way before KVM init and returns false, even if the user requested
> KVM. We thus end up selecting 16G, which isn't supported by HV KVM. The
> default value must be set during machine init, because we can safely
> assume that KVM is initialized at this point.
> 
> We fix this by moving the logic to default_caps_with_cpu(). Since the
> user cannot pass cap-hpt-max-page-size=0, we set the default to 0 in
> the pseries-2.12 class init function and use that as a flag to do the
> real work.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
