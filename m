Received: from eggs.gnu.org ([2001:4830:134:3::10]:37475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkWaA-0006lZ-FF
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkWa6-0000M7-8i
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:24:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkWa6-0000Lb-2R
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:24:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07C0A4E4D3
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 14:24:29 +0000 (UTC)
Date: Wed, 23 Aug 2017 11:24:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170823142426.GH27715@localhost.localdomain>
References: <20170816193218.GF3108@localhost.localdomain>
	<1502978877-127751-1-git-send-email-imammedo@redhat.com>
	<20170818174029.GA27715@localhost.localdomain>
	<20170821103241.2651a5bc@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170821103241.2651a5bc@nial.brq.redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Aug 21, 2017 at 10:32:41AM +0200, Igor Mammedov wrote:
> On Fri, 18 Aug 2017 14:40:29 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Thu, Aug 17, 2017 at 04:07:56PM +0200, Igor Mammedov wrote:
> > > Since
> > >  (commit d4a606b3 i386: Don't override -cpu options on -cpu host/max)
> > > it became possible to delete hack where it was necessary to
> > > postpone applying plus/minus features to realize time
> > > after max_features were applied to keep legacy +-feat
> > > override semantics.
> > > 
> > > With above commit it's possible to convert +-feat to a set
> > > of GlobalProperty items and keep +-feat override semantics,
> > > these properties should be added to global list at the end
> > > to override properties that were set with feat=on|off syntax.
> > > 
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> > [...]
> > > +/* Parse "+feature,-feature,feature=foo" CPU feature string */
> > >  static void x86_cpu_parse_featurestr(const char *typename, char *features,
> > >                                       Error **errp)
> > >  {
> > > +    /* Compatibily hack to maintain legacy +-feat semantic,
> > > +     * where +-feat overwrites any feature set by
> > > +     * feat=on|feat even if the later is parsed after +-feat
> > > +     * (i.e. "-x2apic,x2apic=on" will result in x2apic disabled)
> > > +     */
> > > +    GList *l, *plus_features = NULL, *minus_features = NULL;  
> > 
> > The warning about ambiguous CPU options exists since 2.8, I think
> > this is a good opportunity to get rid of the "[+-]feat overrides
> > feat=on|off" rule and simplify the parsing code.  Do you want to
> > do this in the same patch?
> I'd prefer not to do it in this patch/series, as it's not related.
> 
> WE can do cleanups later on top.

This is not a problem in this patch, but it is a problem when you
create a generic cpu_legacy_parse_featurestr() function in
another series.  We should remove that useless feature from the
function before making it generic.  It has the additional benefit
of making the resulting patch and code easier to review.

-- 
Eduardo
