Received: from eggs.gnu.org ([2001:4830:134:3::10]:43455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQp8A-0006UH-KH
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 02:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQp87-000230-9t
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 02:10:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dQp87-000224-1t
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 02:10:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14A73C0587F8
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 06:10:10 +0000 (UTC)
Date: Fri, 30 Jun 2017 14:10:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170630061005.GB24859@pxdev.xzpeter.org>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-10-git-send-email-peterx@redhat.com>
	<20170628190616.GN12152@localhost.localdomain>
	<878tkb68en.fsf@secure.mitica>
	<20170629030013.GB32268@pxdev.xzpeter.org>
	<20170629191849.GX12152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170629191849.GX12152@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v6 09/10] migration: merge
 enforce_config_section somewhat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jun 29, 2017 at 04:18:49PM -0300, Eduardo Habkost wrote:
> On Thu, Jun 29, 2017 at 11:00:13AM +0800, Peter Xu wrote:
> > On Thu, Jun 29, 2017 at 12:42:56AM +0200, Juan Quintela wrote:
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > 
> > > >
> > > > So, this is a case where a user-provided config option (-machine
> > > > enforce-config-section) should trigger a different default in another
> > > > class (migration.send-configuration).
> > > >
> > > > Also, the new default triggered by -machine has a very specific
> > > > priority:
> > > >
> > > > * AccelClass::global_props must not override "-machine enforce-config-section=on"
> > > > * MachineClass::compat_props must not override
> > > >   "-machine enforce-config-section=on"
> > > >
> > > > We must also decide in advance what should be result of:
> > > > * "-machine enforce-config-section=on -global migration.send-configuration=off"
> > > > * "-machine enforce-config-section=off -global migration.send-configuration=on"
> > > > * "-global migration.send-configuration=off -machine enforce-config-section=off"
> > > > * "-global migration.send-configuration=on -machine enforce-config-section=on"
> > 
> > Yes, this is considered before this patch: currently
> > enforce-config-section will have the highest priority in case if
> > someone used both of the old & new parameters for it (considering
> > "enforce-config-section" has the word "enforce" inside, it makes some
> > sense). While...
> > 
> > > 
> > > BOOM!!!!!
> > > 
> > > We use old configuration or new one.
> > 
> > ... I agree more with Juan here, that user should not really specify
> > these two parameters at the same time. If the user knows the new
> > parameter, he/she should know that the new one is obsoleting the old
> > one. And since even for that case this patch can handle it well (will
> > take -M param), I think it's okay.
> 
> If that's the intended result, it's OK to me.  But I think the
> relationship between enforce-config-section and
> migration.send-configuration should be documented in qemu-options.hx.
> And considering that this could break silently in future code
> refactoring, an automated test would be interesting (but not critical,
> as setting options contradicting each other is not a common scenario).
> 
> 
> > 
> > > 
> > > >
> > > > I'm not sure what we should decide about these 4 cases above, but I
> > > > believe it would be safer to encode that decision at the same place we
> > > > handle the priority between accel/machine/user globals:
> > > > register_global_properties() at vl.c.
> > > >
> > > >
> > > > Or maybe this extra complexity is a sign that we shouldn't try to add
> > > > extra magic to make -machine affect the "migration" object properties,
> > > > and keep the existing machine->enforce_config_section check in the
> > > > migration code?  I'm not sure.
> > > 
> > > Not sure there either.  I preffer doing it in a single place, but I am
> > > not the expert here.
> > 
> > IMHO it is not necessary to introduce such a thing in
> > register_global_properties(). AFAIU this is the only place where one
> > machine property can collapse with a global property? And it currently
> > only happens in migration codes. Actually it is well ordered, since we
> > init the migration object after register_global_properties(), so
> > everthing should possibly be fine. Introducing framework-level thing
> > for this may only make things more complicated imho.
> 
> True.  Considering we need to keep the "overrides everything else"
> semantics of enforce-config-section, your approach is not bad.
> 
> > 
> > After all we can remove all these one day when we can obsolete the
> > "enforce-config-section" parameter (maybe we should add one OBSOLETE
> > warning when the -M parameter is used).  Thanks,
> 
> I don't think we need a warning, but a documentation update is
> important, IMO.

Since the pull request has been merged already, I'll add some
documentation to qemu-options.hx for this in separate patch (and I'll
temporarily skip the unit test since I really think we should obsolete
the old parameter one day). Thanks!

-- 
Peter Xu
