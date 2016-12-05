Received: from eggs.gnu.org ([2001:4830:134:3::10]:56445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cE0eo-0003yN-Sl
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cE0ek-0001qN-Uw
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:18:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cE0ek-0001py-Eo
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:18:38 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F2C65455E
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 21:18:37 +0000 (UTC)
Date: Mon, 5 Dec 2016 16:18:35 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20161205211835.GE18745@localhost.localdomain>
References: <1478105438-20883-1-git-send-email-prasanna.kalever@redhat.com>
	<1478105438-20883-2-git-send-email-prasanna.kalever@redhat.com>
	<fcfed634-f073-4fe9-ff90-c3ae09b0dec3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcfed634-f073-4fe9-ff90-c3ae09b0dec3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.8 v3 1/3] block/gluster: fix QMP to
 match debug option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, qemu-devel@nongnu.org, vbellur@redhat.com

On Mon, Dec 05, 2016 at 03:10:32PM -0600, Eric Blake wrote:
> On 11/02/2016 11:50 AM, Prasanna Kumar Kalever wrote:
> > The QMP definition of BlockdevOptionsGluster:
> > { 'struct': 'BlockdevOptionsGluster',
> >   'data': { 'volume': 'str',
> >             'path': 'str',
> >             'server': ['GlusterServer'],
> >             '*debug-level': 'int',
> >             '*logfile': 'str' } }
> > 
> > But instead of 'debug-level we have exported 'debug' as the option for choosing
> > debug level of gluster protocol driver.
> > 
> > This patch fix QMP definition BlockdevOptionsGluster
> > s/debug-level/debug/
> > 
> > Suggested-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> > ---
> >  block/gluster.c      | 34 +++++++++++++++++-----------------
> >  qapi/block-core.json |  4 ++--
> >  2 files changed, 19 insertions(+), 19 deletions(-)
> > 
> > @@ -787,17 +787,17 @@ static int qemu_gluster_open(BlockDriverState *bs,  QDict *options,
> >  
> >      filename = qemu_opt_get(opts, GLUSTER_OPT_FILENAME);
> >  
> > -    s->debug_level = qemu_opt_get_number(opts, GLUSTER_OPT_DEBUG,
> > +    s->debug = qemu_opt_get_number(opts, GLUSTER_OPT_DEBUG,
> >                                           GLUSTER_DEBUG_DEFAULT);
> 
> Indentation is now off.  That's minor, a maintainer could fix it on commit.
> 
> > @@ -1010,14 +1010,14 @@ static int qemu_gluster_create(const char *filename,
> >      char *tmp = NULL;
> >  
> >      gconf = g_new0(BlockdevOptionsGluster, 1);
> > -    gconf->debug_level = qemu_opt_get_number_del(opts, GLUSTER_OPT_DEBUG,
> > +    gconf->debug = qemu_opt_get_number_del(opts, GLUSTER_OPT_DEBUG,
> >                                                   GLUSTER_DEBUG_DEFAULT);
> 
> and again
> 
> > +++ b/qapi/block-core.json
> > @@ -2195,7 +2195,7 @@
> >  #
> >  # @server:      gluster servers description
> >  #
> > -# @debug-level: #optional libgfapi log level (default '4' which is Error)
> > +# @debug:       #optional libgfapi log level (default '4' which is Error)
> >  #
> >  # @logfile:     #optional libgfapi log file (default /dev/stderr) (Since 2.8)
> >  #
> > @@ -2205,7 +2205,7 @@
> >    'data': { 'volume': 'str',
> >              'path': 'str',
> >              'server': ['GlusterServer'],
> > -            '*debug-level': 'int',
> > +            '*debug': 'int',
> 
> This changes what introspection shows. We already declared that
> blockdev-add is not stable in 2.7, and made some radical changes in 2.8
> that are visible through introspection.  But we WANT to avoid any more
> backwards-incompatible changes beyond 2.8, so on that grounds, this HAS
> to go in to 2.8 if it is going in at all (otherwise, we have
> inconsistent naming between QMP and the command line that we have to
> document and keep forevermore).
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 




Thanks,

Applied the series to my block branch, with Eric's indent suggestions fixed:

git://github.com/codyprime/qemu-kvm-jtc.git block

-Jeff
