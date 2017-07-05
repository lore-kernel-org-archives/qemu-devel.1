Received: from eggs.gnu.org ([2001:4830:134:3::10]:46379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dSkxE-0000Gr-Or
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dSkxA-0001qd-RD
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dSkxA-0001pS-HE
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:06:52 -0400
Date: Wed, 5 Jul 2017 11:06:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170705140649.GW12152@localhost.localdomain>
References: <1499049848-18012-1-git-send-email-peterx@redhat.com>
	<1499049848-18012-4-git-send-email-peterx@redhat.com>
	<874lussk0x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lussk0x.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 3/4] doc: add item for "-M
 enforce-config-section"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Greg Kurz <groug@kaod.org>

(CCing Greg, the original author of the code that added the
enforce-config-section option)

On Tue, Jul 04, 2017 at 10:06:54AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > It's never documented, and now we have one more parameter for it (which
> > means this one can be obsolete in the future). Document it properly.
> >
> > Although now when enforce-config-section is set, it'll override the
> > other "-global" parameter, that is not necessarily a rule. Forbid that
> > usage in the document.
> >
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  qemu-options.hx | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 297bd8a..927c51f 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -85,6 +85,14 @@ Enables or disables NVDIMM support. The default is off.
> >  @item s390-squash-mcss=on|off
> >  Enables or disables squashing subchannels into the default css.
> >  The default is off.
> > +@item enforce-config-section=on|off
> > +Decides whether we will send the configuration section when doing
> > +migration. By default, it is turned on. We can set this to off to
> > +explicitly disable it. Note: this parameter will be obsolete soon,
> > +please use "-global migration.send-configuration=on|off" instead.
> 
> Please say "... is deprecated, please use ...", to make it visible in
> "git-grep -i deprecat".
> 
> > +"enforce-config-section" cannot be used together with "-global
> > +migration.send-configuration". If it happens, the behavior is
> > +undefined.
> 
> Nasty.  Could we catch and reject such invalid usage?

Actually, the machine option will override
migration.send-configuration=off, and I don't believe we will break that
rule.  Documenting that behavior (but warning that it is deprecated)
sounds easier than adding extra code to detect the conflicting options.

We can simply replace "is undefined"  with "enforce-config-section will
override migration.send-configuration, but enforce-config-section is
deprecated".

I don't think anybody is relying on that option. If nobody is using it,
we can remove its code soon if we make it trigger a warning.
Machine-type compatibility code is already using
migration.send-configuration instead.

-- 
Eduardo
