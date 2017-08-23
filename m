Received: from eggs.gnu.org ([2001:4830:134:3::10]:35965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkXz1-0004zK-7I
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkXyy-0000Pj-6V
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:54:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkXyx-0000Pb-TG
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:54:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4740C04B954
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 15:54:14 +0000 (UTC)
Date: Wed, 23 Aug 2017 17:54:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170823175412.6259ca3a@nial.brq.redhat.com>
In-Reply-To: <20170823142426.GH27715@localhost.localdomain>
References: <20170816193218.GF3108@localhost.localdomain>
	<1502978877-127751-1-git-send-email-imammedo@redhat.com>
	<20170818174029.GA27715@localhost.localdomain>
	<20170821103241.2651a5bc@nial.brq.redhat.com>
	<20170823142426.GH27715@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target-i386: cpu: convert plus/minus
 properties to global properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, 23 Aug 2017 11:24:27 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Aug 21, 2017 at 10:32:41AM +0200, Igor Mammedov wrote:
> > On Fri, 18 Aug 2017 14:40:29 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >   
> > > On Thu, Aug 17, 2017 at 04:07:56PM +0200, Igor Mammedov wrote:  
> > > > Since
> > > >  (commit d4a606b3 i386: Don't override -cpu options on -cpu host/max)
> > > > it became possible to delete hack where it was necessary to
> > > > postpone applying plus/minus features to realize time
> > > > after max_features were applied to keep legacy +-feat
> > > > override semantics.
> > > > 
> > > > With above commit it's possible to convert +-feat to a set
> > > > of GlobalProperty items and keep +-feat override semantics,
> > > > these properties should be added to global list at the end
> > > > to override properties that were set with feat=on|off syntax.
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>    
> > > [...]  
> > > > +/* Parse "+feature,-feature,feature=foo" CPU feature string */
> > > >  static void x86_cpu_parse_featurestr(const char *typename, char *features,
> > > >                                       Error **errp)
> > > >  {
> > > > +    /* Compatibily hack to maintain legacy +-feat semantic,
> > > > +     * where +-feat overwrites any feature set by
> > > > +     * feat=on|feat even if the later is parsed after +-feat
> > > > +     * (i.e. "-x2apic,x2apic=on" will result in x2apic disabled)
> > > > +     */
> > > > +    GList *l, *plus_features = NULL, *minus_features = NULL;    
> > > 
> > > The warning about ambiguous CPU options exists since 2.8, I think
> > > this is a good opportunity to get rid of the "[+-]feat overrides
> > > feat=on|off" rule and simplify the parsing code.  Do you want to
> > > do this in the same patch?  
> > I'd prefer not to do it in this patch/series, as it's not related.
> > 
> > WE can do cleanups later on top.  
> 
> This is not a problem in this patch, but it is a problem when you
> create a generic cpu_legacy_parse_featurestr() function in
> another series.  We should remove that useless feature from the
> function before making it generic.  It has the additional benefit
> of making the resulting patch and code easier to review.
Removing means replacing warning with hard error, so that setups
that happen to use this combination would fail instead of silently
changing behavior.
So it won't actually simplify function but will cause side-effects
that weren't intended by this series.

As is in this series, I'm being rather conservative,
it's just replacing code duplication that exists in SPARC with x86 impl.
without behavioral change
(and even though it's in public header it's not really public API
that's why it's called legacy_foo() - to try preventing new usage).

If we decide to make it hard error, it would be better to do it separately.
I can post a patch on top if you insist, that would do it
so we could discuss there if it's ok to break users in 2 releases
or not but it should not hold this series as it's totally
orthogonal matter. (it also would be easier to revert patch
if we apply it but later decide to keep old ways).
