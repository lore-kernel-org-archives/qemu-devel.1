Received: from eggs.gnu.org ([209.51.188.92]:38466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goRfM-0008Kg-Pg
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goRfL-0008Nv-Jy
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:34:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1goRfL-0008N1-Ay
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:34:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F557806B6
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 11:34:54 +0000 (UTC)
Date: Tue, 29 Jan 2019 11:34:47 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190129113447.GD2650@work-vm>
References: <20190128170321.16936-1-dgilbert@redhat.com>
	<20190128170321.16936-3-dgilbert@redhat.com>
	<743a07c4-0c9f-8b51-f792-7132e82dc0dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <743a07c4-0c9f-8b51-f792-7132e82dc0dc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/9] migration: Add announce parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, berrange@redhat.com

* Eric Blake (eblake@redhat.com) wrote:
> On 1/28/19 11:03 AM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Add migration parameters that control RARP/GARP announcement timeouts.
> > 
> > Based on earlier patches by myself and
> >   Vladislav Yasevich <vyasevic@redhat.com>
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> 
> > +++ b/qapi/migration.json
> > @@ -6,6 +6,7 @@
> >  ##
> >  
> >  { 'include': 'common.json' }
> > +{ 'include': 'net.json' }
> >  
> >  ##
> >  # @MigrationStats:
> > @@ -480,6 +481,18 @@
> >  #
> >  # Migration parameters enumeration
> >  #
> > +# @announce-initial: Inital delay (in ms) before sending the first announce
> 
> s/Inital/Initial/ [2]

Fixed.

> > +#          (Since 4.0)
> > +#
> > +# @announce-max: Maximum delay (in ms) between packets in the announcment
> > +#          (Since 4.0)
> > +#
> > +# @announce-rounds: Number of self-announce packets sent after migration
> > +#          (Since 4.0)
> > +#
> > +# @announce-step: Increase in delay (in ms) between subsequent packets in
> > +#          the announcement (Since 4.0)
> > +#
> 
> The new parameters are optional below [1]; should they have a default
> value documented, and are there any constraints such that if you set
> one, you must set all four to match the previous' patch having all four
> be non-optional?

I think this is just the same as all the other migration-parameters
isn't it?  It's the way that the 'migrate-set-parameters' command allows
you to set an individual parameter without changing the others; it's
not about defaults, just that whatever setting you currently have
doesn't change.

> 
> > @@ -653,7 +681,11 @@
> >  # TODO either fuse back into MigrationParameters, or make
> >  # MigrationParameters members mandatory
> >  { 'struct': 'MigrateSetParameters',
> > -  'data': { '*compress-level': 'int',
> > +  'data': { '*announce-initial': 'size',
> > +            '*announce-max': 'size',
> > +            '*announce-rounds': 'size',
> > +            '*announce-step': 'size',
> > +            '*compress-level': 'int',
> 
> [1] mentioned above
> 
> >              '*compress-threads': 'int',
> >              '*compress-wait-thread': 'bool',
> >              '*decompress-threads': 'int',
> > @@ -692,6 +724,18 @@
> >  #
> >  # The optional members aren't actually optional.
> >  #
> > +# @announce-initial: Inital delay (in ms) before sending the first announce
> > +#          (Since 4.0)
> 
> [2] again
> 
Fixed.
> 
> > @@ -769,7 +813,11 @@
> >  # Since: 2.4
> >  ##
> >  { 'struct': 'MigrationParameters',
> > -  'data': { '*compress-level': 'uint8',
> > +  'data': { '*announce-initial': 'size',
> > +            '*announce-max': 'size',
> > +            '*announce-rounds': 'size',
> > +            '*announce-step': 'size',
> > +            '*compress-level': 'uint8',
> 
> [1] again
> 
> >              '*compress-threads': 'uint8',
> >              '*compress-wait-thread': 'bool',
> >              '*decompress-threads': 'uint8',
> > @@ -785,7 +833,7 @@
> >              '*x-multifd-page-count': 'uint32',
> >              '*xbzrle-cache-size': 'size',
> >  	    '*max-postcopy-bandwidth': 'size',
> > -            '*max-cpu-throttle':'uint8'} }
> > +            '*max-cpu-throttle':'uint8' } }
> 
> Why the whitespace churn?

Removed (although I think the extra space is cleaner).

Dave


> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
