Received: from eggs.gnu.org ([2001:4830:134:3::10]:54319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciNCt-0000R4-Bz
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciNCs-0002Br-Ax
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:27:23 -0500
Date: Mon, 27 Feb 2017 10:27:15 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170227152715.GF25637@localhost.localdomain>
References: <cover.1488180142.git.jcody@redhat.com>
	<08786526aec147544588ab3e885a984e7d0d1c69.1488180142.git.jcody@redhat.com>
	<20170227134547.GM18219@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170227134547.GM18219@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] block/rbd: Add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com

On Mon, Feb 27, 2017 at 01:45:47PM +0000, Daniel P. Berrange wrote:
> On Mon, Feb 27, 2017 at 02:30:41AM -0500, Jeff Cody wrote:
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  qapi/block-core.json | 47 ++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 44 insertions(+), 3 deletions(-)
> > 
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 5f82d35..08a1419 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -2111,6 +2111,7 @@
> >  # @replication: Since 2.8
> >  # @ssh: Since 2.8
> >  # @iscsi: Since 2.9
> > +# @rbd: Since 2.9
> >  #
> >  # Since: 2.0
> >  ##
> > @@ -2120,7 +2121,7 @@
> >              'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
> >              'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
> >              'quorum', 'raw', 'replication', 'ssh', 'vdi', 'vhdx', 'vmdk',
> > -            'vpc', 'vvfat' ] }
> > +            'vpc', 'vvfat', 'rbd' ] }
> >  
> >  ##
> >  # @BlockdevOptionsFile:
> > @@ -2376,7 +2377,6 @@
> >              'path': 'str',
> >              '*user': 'str' } }
> >  
> > -
> >  ##
> >  # @BlkdebugEvent:
> >  #
> > @@ -2666,6 +2666,47 @@
> >              '*timeout': 'int' } }
> >  
> >  ##
> > +# @BlockdevOptionsRbd:
> > +#
> > +# @pool:               Ceph pool name
> > +#
> > +# @image:              Image name in the Ceph pool
> > +#
> > +# @conf:               # optional path to Ceph configuration file.  Values
> > +#                      in the configuration file will be overridden by
> > +#                      options specified via QAPI.
> > +#
> > +# @snapshot:           #optional Ceph snapshot name
> > +#
> > +# @rbd-id:             #optional Ceph id name
> 
> BTW, I think I'd suggest 'user' or 'username' for this, since that is the more
> common terminology we seem to use for other block drivers
>

OK, I will go with 'user' instead of 'rbd-id'.

I think that fits with the usage terminology in rados_create()
documentation as well:

    int rados_create(rados_t * cluster, const char *const id)

    [...]

    Parameters
       * cluster: where to store the handle
       * id: the user to connect as (i.e. admin, not client.admin)

-Jeff
