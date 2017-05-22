Received: from eggs.gnu.org ([2001:4830:134:3::10]:44842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dCqQG-0001ft-Ks
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dCqQD-0001kg-HG
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:43:08 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:58070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dCqQD-0001jy-BD
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:43:05 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OQD004OZ53NNG40@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Mon, 22 May 2017 17:42:59 +0100 (BST)
Date: Mon, 22 May 2017 19:42:56 +0300
From: Alexey <a.perevalov@samsung.com>
Message-id: <20170522164256.GA5454@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <43617b5a-0fcc-d171-aa19-4a24a4007e35@redhat.com>
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512133146eucas1p2ba4841cabf508b66410fae6784952eaa@eucas1p2.samsung.com>
	<1494595886-30912-6-git-send-email-a.perevalov@samsung.com>
	<43617b5a-0fcc-d171-aa19-4a24a4007e35@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5 5/9] migration: introduce
 postcopy-blocktime capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, dgilbert@redhat.com, peterx@redhat.com

On Mon, May 22, 2017 at 11:20:13AM -0500, Eric Blake wrote:
> On 05/12/2017 08:31 AM, Alexey Perevalov wrote:
> > Right now it could be used on destination side to
> > enable vCPU blocktime calculation for postcopy live migration.
> > vCPU blocktime - it's time since vCPU thread was put into
> > interruptible sleep, till memory page was copied and thread awake.
> > 
> > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > ---
> >  include/migration/migration.h | 1 +
> >  migration/migration.c         | 9 +++++++++
> >  qapi-schema.json              | 5 ++++-
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> > 
> 
> > +++ b/qapi-schema.json
> > @@ -894,11 +894,14 @@
> >  # @release-ram: if enabled, qemu will free the migrated ram pages on the source
> >  #        during postcopy-ram migration. (since 2.9)
> >  #
> > +# @postcopy-blocktime: Calculate downtime for postcopy live migration (since 2.10)
> > +#
> >  # Since: 1.2
> >  ##
> >  { 'enum': 'MigrationCapability',
> >    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> > -           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'] }
> > +           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
> > +           'postcopy-blocktime'] }
> 
> Why does this need to be a capability that we have to turn on, and not
> something that is collected unconditionally? Is there a drawback to
> having the stat collection always enabled without a capability?
yes, it has a performance penalty
(runtime complexity O(n) + O(m), where n is vCPU number, m is number of memory
pages), but not so huge, compared to network
latencies, also memory usage, but no more than 0.03% of QEMU's total
memory.

> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



-- 

BR
Alexey
