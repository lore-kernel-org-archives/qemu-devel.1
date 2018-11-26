Received: from eggs.gnu.org ([2001:4830:134:3::10]:53554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gRDom-0004qR-7V
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:08:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gRDoh-0004ce-AS
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:08:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gRDoh-0004ZW-18
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:08:35 -0500
Date: Mon, 26 Nov 2018 12:08:20 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181126100819.GB5867@lap1>
References: <20181122121402.13764-1-yuval.shaia@oracle.com>
	<20181122121402.13764-11-yuval.shaia@oracle.com>
	<87bm6cnomg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm6cnomg.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v5 10/24] qapi: Define new QMP message for
 pvrdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com, yuval.shaia@oracle.com

On Mon, Nov 26, 2018 at 11:01:59AM +0100, Markus Armbruster wrote:
> Yuval Shaia <yuval.shaia@oracle.com> writes:
> 
> > pvrdma requires that the same GID attached to it will be attached to the
> > backend device in the host.
> >
> > A new QMP messages is defined so pvrdma device can broadcast any change
> > made to its GID table. This event is captured by libvirt which in turn
> > will update the GID table in the backend device.
> >
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > ---
> >  MAINTAINERS           |  1 +
> >  Makefile.objs         |  1 +
> >  qapi/qapi-schema.json |  1 +
> >  qapi/rdma.json        | 38 ++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 41 insertions(+)
> >  create mode 100644 qapi/rdma.json
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7b68080094..525bcdcf41 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2335,6 +2335,7 @@ F: hw/rdma/*
> >  F: hw/rdma/vmw/*
> >  F: docs/pvrdma.txt
> >  F: contrib/rdmacm-mux/*
> > +F: qapi/rdma.json
> >  
> >  Build and test automation
> >  -------------------------
> > diff --git a/Makefile.objs b/Makefile.objs
> > index 319f14d937..fe3566b797 100644
> > --- a/Makefile.objs
> > +++ b/Makefile.objs
> > @@ -1,5 +1,6 @@
> >  QAPI_MODULES = block-core block char common crypto introspect job migration
> >  QAPI_MODULES += misc net rocker run-state sockets tpm trace transaction ui
> > +QAPI_MODULES += rdma
> 
> Please keep the list of QAPI modules sorted, e.g. like this:
> 
>    QAPI_MODULES = block-core block char common crypto introspect job
>    QAPI_MODULES += migration misc net rdma rocker run-state sockets tpm
>    QAPI_MODULES += trace transaction ui

Sure, will do.

> 
> >  
> >  #######################################################################
> >  # Common libraries for tools and emulators
> > diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> > index 65b6dc2f6f..3bbdfcee84 100644
> > --- a/qapi/qapi-schema.json
> > +++ b/qapi/qapi-schema.json
> > @@ -86,6 +86,7 @@
> >  { 'include': 'char.json' }
> >  { 'include': 'job.json' }
> >  { 'include': 'net.json' }
> > +{ 'include': 'rdma.json' }
> >  { 'include': 'rocker.json' }
> >  { 'include': 'tpm.json' }
> >  { 'include': 'ui.json' }
> > diff --git a/qapi/rdma.json b/qapi/rdma.json
> > new file mode 100644
> > index 0000000000..804c68ab36
> > --- /dev/null
> > +++ b/qapi/rdma.json
> > @@ -0,0 +1,38 @@
> > +# -*- Mode: Python -*-
> > +#
> > +
> > +##
> > +# = RDMA device
> > +##
> > +
> > +##
> > +# @RDMA_GID_STATUS_CHANGED:
> > +#
> > +# Emitted when guest driver adds/deletes GID to/from device
> > +#
> > +# @netdev: RoCE Network Device name - char *
> > +#
> > +# @gid-status: Add or delete indication - bool
> > +#
> > +# @subnet-prefix: Subnet Prefix - uint64
> > +#
> > +# @interface-id : Interface ID - uint64
> > +#
> > +# Since: 3.2
> > +#
> > +# Example:
> > +#
> > +# <- {"timestamp": {"seconds": 1541579657, "microseconds": 986760},
> > +#     "event": "RDMA_GID_STATUS_CHANGED",
> > +#     "data":
> > +#         {"netdev": "bridge0",
> > +#         "interface-id": 15880512517475447892,
> > +#         "gid-status": true,
> > +#         "subnet-prefix": 33022}}
> > +#
> > +##
> > +{ 'event': 'RDMA_GID_STATUS_CHANGED',
> > +  'data': { 'netdev'        : 'str',
> > +            'gid-status'    : 'bool',
> > +            'subnet-prefix' : 'uint64',
> > +            'interface-id'  : 'uint64' } }
> 
> Preferably with Makefile.objs tidied up:
> Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks
