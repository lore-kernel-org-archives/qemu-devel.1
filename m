Received: from eggs.gnu.org ([2001:4830:134:3::10]:55410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnQP6-0004I2-GK
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnQP3-00029D-Cf
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:29:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fnQP3-000283-64
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:29:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F87981663CE
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 15:29:36 +0000 (UTC)
Date: Wed, 8 Aug 2018 17:29:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180808172934.7a1ee4db@redhat.com>
In-Reply-To: <20180802111712.7c60e6df@redhat.com>
References: <20180710000024.542612-1-mst@redhat.com>
	<20180725143211.2fe32f43@redhat.com>
	<20180725153259-mutt-send-email-mst@kernel.org>
	<20180725175335.4b444e19@redhat.com>
	<20180726185019-mutt-send-email-mst@kernel.org>
	<20180802111712.7c60e6df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH hack dontapply v2 0/7] Dynamic _CST
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com

On Thu, 2 Aug 2018 11:18:08 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 26 Jul 2018 19:09:22 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Jul 25, 2018 at 05:53:35PM +0200, Igor Mammedov wrote:  
> > > On Wed, 25 Jul 2018 15:44:37 +0300
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >     
> > > > On Wed, Jul 25, 2018 at 02:32:11PM +0200, Igor Mammedov wrote:    
> > > > > On Tue, 10 Jul 2018 03:01:30 +0300
> > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > >       
> > > > > > Now that basic support for guest CPU PM is upstream, I started looking
> > > > > > for making it migrateable.  Since a VM can be migrated between different
> > > > > > hosts, PM info needs to change each time with move the VM to a different
> > > > > > host.      
> > > > > Considering notification is async, so there will be a window when
> > > > > guest will be using old Cstates on new host. What will happen if
> > > > > machine is migrated to host that doesn't support a Cstate
> > > > > that was used on source when guest was started?      
> > > > 
> > > > My testing shows mwait with a wrong hint works, presumably it just uses
> > > > a lot of power.
> > > >     
> > > > > > This adds infrastructure - based on Load/Unload - to support exactly
> > > > > > that: QEMU generates AML (changing it on migration) and stores it in
> > > > > > reserved memory, OSPM loads _CST from there on demand.      
> > > > > Cool and very tempting idea but I have 2 worries about this approach:
> > > > > 1. How well does it work with Windows based guests?
> > > > >    (I've tried something similar but generating new AML from AML itself
> > > > >     to get rid of our long if/else chains there to make up Notify target name.
> > > > >     I ditched it (unfortunately I don't recall why) )      
> > > > 
> > > > After trying it, I can tell you why - it's a horrid mess of
> > > > unreadable code, with arbitrary restraints on package
> > > > length etc.    
> > > in my case it was only 4 character NameString, but Windows probably
> > > wasn't happy or just ignored it.
> > > Considering recent development (TPM series) it might have been issue
> > > with SYSTEM_MEMORY not working properly if used as byte buffer field.
> > > 
> > > Even if it's an unreadable mess it's still stable mess and very constrained
> > > one within a single firmware blob that came from source.    
> > 
> > That's exectly the argument we had for keeping ACPI
> > generation in bios. It's just not an interface that scales.
> >   
> > > Hence it's more preferable than split brain in this series.
> > > 
> > > But I don't think we even need dynamic AML for _CST usecase at all,
> > > existing cpuhp interface should work just fine for it and should be
> > > simpler as all infrastructure is already there.    
> > 
> > Not sure I get what you mean. Could you post a patch?
> >   
> > > > > 2. (probably biggest issue) Loading dynamically generated AML
> > > > >    basically would make all AML code ABI, so that static AML
> > > > >    in RAM of old QEMU version would match dynamic generated
> > > > >    one on target side with new QEMU (/me generalizing approach beyond _CST support).
> > > > >    I'd try to keep our AML version less as much as possible
> > > > >    and go this route only if there is no other way to do it.      
> > > > 
> > > > That's a good point, thanks for bringing this up!
> > > > 
> > > > So it seems that we will need to define the ABI, yes. All AML code is
> > > > an over-statement though, there are specific entry points
> > > > we must maintain, right?    
> > > Well, I'm rather unsure what and where could break,
> > > hence I'm afraid of a new beast and it probably won't be easy
> > > to convince me that ABI would be able to keep things manageable
> > > and stable.
> > > Considering big amount of AML code that we already have
> > > I'm not confident eye balling during review and testing the latest
> > > firmware/qemu would be sufficient as we suddenly would have exploded
> > > test matrix where firmware in use is a mixed from old/and new parts.    
> > 
> > Well there's one exported method so far and it relies on one container
> > device in static table set which does not sound too hard to keep stable.
> > 
> > Given how simple the dynamic table is, how about just checking it
> > with a unit test? It is literally a single return statement.
> > If it returns a valid package, that is all that we
> > care about. I can write some firmware to test that constraint.
> > 
> >   
> > > > And that in the end isn't fundamentally different from the ABIs
> > > > mandated by the ACPI spec.
> > > > 
> > > > So I have these ideas to try to mitigate the issues:
> > > > - document the ABI (like we have in the ACPI spec)
> > > > - use a specific prefix for all external calls (like _ for ACPI spec ones)
> > > > - use a specific (different) prefix for all internal loaded calls (like
> > > >   [A-Z] for non-ACPI spec ones)    
> > > ACPI spec horrible mess and bad example (even committee isn't able to keep it consistent)
> > > but it's necessary evil (compared to no spec at all).
> > > Adding ABI requirement will complicate coding/reviewing for
> > > already complex AML compared to current non ABI way.
> > > Hence from maintainability POV we should stay away from this approach
> > > if there is a viable alternative.    
> > 
> > I agree. Not that I see one.  
> 
> I'll try to come up with a patch to make use of cpuhp registers
> to pass CST values and it's AML counterpart.
> Then you'd need to just wire it up to whatever means you use
> to get these values from host.
Posted a non dynamic variant
  [RFC PATCH 0/4] "pc: acpi: _CST support"
with uses conventional approach to compose _CST object
without opening AML to ABI issues

[...]
