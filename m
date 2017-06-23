Received: from eggs.gnu.org ([2001:4830:134:3::10]:59041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dONx2-0007T1-5T
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dONwx-00032p-An
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:44:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dONwx-00032I-51
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:44:35 -0400
Date: Fri, 23 Jun 2017 09:44:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170623124422.GB11773@localhost.localdomain>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-13-rkagan@virtuozzo.com>
	<20170614135325.GI5016@thinpad.lan.raisama.net>
	<20170614162355.GA20211@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614162355.GA20211@rkaganb.sw.ru>
Subject: Re: [Qemu-devel] [PATCH 12/23] hyperv: make HvSintRoute
 reference-counted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed, Jun 14, 2017 at 07:23:56PM +0300, Roman Kagan wrote:
> On Wed, Jun 14, 2017 at 10:53:25AM -0300, Eduardo Habkost wrote:
> > On Tue, Jun 06, 2017 at 09:19:37PM +0300, Roman Kagan wrote:
> > > Multiple entities (e.g. VMBus devices) can use the same SINT route.  To
> > > make their lives easier in maintaining SINT route ownership, make it
> > > reference-counted.  Adjust the respective API names accordingly.
> > > 
> > > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> > 
> > Isn't it easier to reuse existing refcounting infrastructure
> > here?  Is it overkill to make it a QOM object? (struct Object has
> > 40 bytes)
> 
> Normally the guests use a sint route per cpu or less.  So no, the space
> overhead is not an issue.
> 
> I also wanted to reuse regular QOM refcounting so I QOM-ified it at
> first.  However, while hammering out the design, I found no appropriate
> place in the QOM hierachy where to stick these objects so we dropped the
> idea.
> 
> If I get your proposal right you suggest to leave it unattached instead.
> That should probably work; however, looking at all the boilerplate code
> this would entail, including OBJECT casts, I'm not sure it would save
> anything.  Do you think it's worth reworking into QOM?

I just noticed I didn't reply to this, sorry.  I'm also not sure it is
worth reworking into QOM, so I guess it's up to you.

About placing the object in the QOM hierarchy, I don't think that would
be a problem.  Objects without a parent are safer, as long as reference
counting is properly tracked.

About the OBJECT casts, I guess that's a common issue.  I'm considering
proposing making object_ref()/object_unref() macros that use OBJECT()
automatically.

-- 
Eduardo
