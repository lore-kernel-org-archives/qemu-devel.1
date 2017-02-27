Received: from eggs.gnu.org ([2001:4830:134:3::10]:51896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciLVW-00065u-Sr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciLVV-00008k-Ko
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:38:30 -0500
Date: Mon, 27 Feb 2017 08:38:24 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170227133824.GE25637@localhost.localdomain>
References: <cover.1488180142.git.jcody@redhat.com>
	<08786526aec147544588ab3e885a984e7d0d1c69.1488180142.git.jcody@redhat.com>
	<20170227073613.GB25637@localhost.localdomain>
	<20170227093121.GD18219@redhat.com>
	<20170227131859.GD25637@localhost.localdomain>
	<20170227133046.GK18219@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170227133046.GK18219@redhat.com>
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

On Mon, Feb 27, 2017 at 01:30:46PM +0000, Daniel P. Berrange wrote:
> On Mon, Feb 27, 2017 at 08:18:59AM -0500, Jeff Cody wrote:
> > On Mon, Feb 27, 2017 at 09:31:21AM +0000, Daniel P. Berrange wrote:
> > > On Mon, Feb 27, 2017 at 02:36:13AM -0500, Jeff Cody wrote:
> > > > On Mon, Feb 27, 2017 at 02:30:41AM -0500, Jeff Cody wrote:
> > > > > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > > > > ---
> > > > >  qapi/block-core.json | 47 ++++++++++++++++++++++++++++++++++++++++++++---
> > > > >  1 file changed, 44 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > > > index 5f82d35..08a1419 100644
> > > > > --- a/qapi/block-core.json
> > > > > +++ b/qapi/block-core.json
> > > > > @@ -2111,6 +2111,7 @@
> > > > >  # @replication: Since 2.8
> > > > >  # @ssh: Since 2.8
> > > > >  # @iscsi: Since 2.9
> > > > > +# @rbd: Since 2.9
> > > > >  #
> > > > >  # Since: 2.0
> > > > >  ##
> > > > > @@ -2120,7 +2121,7 @@
> > > > >              'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
> > > > >              'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
> > > > >              'quorum', 'raw', 'replication', 'ssh', 'vdi', 'vhdx', 'vmdk',
> > > > > -            'vpc', 'vvfat' ] }
> > > > > +            'vpc', 'vvfat', 'rbd' ] }
> > > > >  
> > > > >  ##
> > > > >  # @BlockdevOptionsFile:
> > > > > @@ -2376,7 +2377,6 @@
> > > > >              'path': 'str',
> > > > >              '*user': 'str' } }
> > > > >  
> > > > > -
> > > > >  ##
> > > > >  # @BlkdebugEvent:
> > > > >  #
> > > > > @@ -2666,6 +2666,47 @@
> > > > >              '*timeout': 'int' } }
> > > > >  
> > > > >  ##
> > > > > +# @BlockdevOptionsRbd:
> > > > > +#
> > > > > +# @pool:               Ceph pool name
> > > > > +#
> > > > > +# @image:              Image name in the Ceph pool
> > > > > +#
> > > > > +# @conf:               # optional path to Ceph configuration file.  Values
> > > > > +#                      in the configuration file will be overridden by
> > > > > +#                      options specified via QAPI.
> > > > > +#
> > > > > +# @snapshot:           #optional Ceph snapshot name
> > > > > +#
> > > > > +# @rbd-id:             #optional Ceph id name
> > > > > +#
> > > > > +# @password-secret:    #optional The ID of a QCryptoSecret object providing
> > > > > +#                       the password for the login.
> > > > > +#
> > > > > +# @keyvalue-pairs:     #optional  string containing key/value pairs for
> > > > > +#                      additional Ceph configuration, not including "id" or "conf"
> > > > > +#                      options. This can be used to specify any of the options
> > > > > +#                      that Ceph supports.  The format is of the form:
> > > > > +#                           key1=value1:key2=value2:[...]
> > > > > +#
> > > > > +#                      Special characters such as ":" and "=" can be escaped
> > > > > +#                      with a '\' character, which means the QAPI needs an
> > > > > +#                      extra '\' character to pass the needed escape character.
> > > > > +#                      For example:
> > > > > +#                            "keyvalue-pairs": "mon_host=127.0.0.1\\:6321"
> > > > > +#
> > > > 
> > > > This is the key / value pair issue mentioned in the cover letter.  Encoding
> > > > all the options as a string like this is ugly.  What is the preference on
> > > > how to handle these via QAPI, when the actual key and value pairs could be
> > > > anything?   Talking with Markus on IRC, one option he mentioned was an array
> > > > of a generic struct of 'key' and 'value' pairs.
> > > > 
> > > > Do the libvirt folks have any interface preferences here?
> > > 
> > > IMHO, we should formally model each option that we need to be able to provide
> > > and *not* provide any generic passthrough feature in QAPI.
> > > 
> > > Particularly for the server hostname/port, we should have the same QAPI
> > > modelling approach that we did for other network protocols.
> > > 
> > >
> > 
> > That is a sane position to take, but the problem is I really have no idea
> > all the options to include or not include here.
> 
> Libvirt relies on the following
> 
>  - id             - to provide the username
>  - mon_host       - to provide the list of host+ports
>  - auth_supported - to provide the list of authentication schemes to try
>  - conf           - to proide the ceph config file
> 
> 
> > However, maybe it doesn't matter, at least for 2.9 - for the QAPI command,
> > we could drop the extra arguments completely (i.e., just drop the
> > keyvalue-pairs argument, above).  The extra options could still be set via a
> > config file passed in via 'conf', and in release > 2.9 we can gradually (or
> > not-so-gradually) add in additional options directly supported via QAPI.
> > 
> > The filename parsing would remain the same, for backwards compatibility, of
> > course.
> > 
> > Does this sound reasonable to you?
> 
> If we support the pieces libvirt needs, then I've no objection to dropping
> the rest.
> 

I'll add in mon_host and auth_supported, then.  Then we'll rely on the
config file for unlisted options, and revisit new options in later releases.

Thanks,
Jeff
