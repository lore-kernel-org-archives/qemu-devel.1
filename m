Received: from eggs.gnu.org ([2001:4830:134:3::10]:36626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3nHZ-0001OM-Uz
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 13:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3nHZ-0002pc-2d
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 13:32:45 -0400
Date: Thu, 27 Apr 2017 14:32:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170427173235.GI3482@thinpad.lan.raisama.net>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-8-git-send-email-imammedo@redhat.com>
	<20170412210239.GC27126@thinpad.lan.raisama.net>
	<20170419131458.59e2d00e@nial.brq.redhat.com>
	<20170426122138.GU3482@thinpad.lan.raisama.net>
	<20170427151406.57fbfa79@nial.brq.redhat.com>
	<20170427163225.GE3482@thinpad.lan.raisama.net>
	<20170427192523.296713a6@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170427192523.296713a6@Igors-MacBook-Pro.local>
Subject: Re: [Qemu-devel] [PATCH for-2.10 07/23] pc: add node-id property to
 CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Thu, Apr 27, 2017 at 07:25:23PM +0200, Igor Mammedov wrote:
[...]
> > >  #
> > >  # A discriminated record of NUMA options. (for OptsVisitor)
> > >  #
> > > +# For 'cpu' type as arguments use a set of cpu properties returned
> > > +# by query-hotpluggable-cpus[].props, where node-id could be used
> > > +# to override default node mapping. Since: 2.10
> > > +#
> > >  # Since: 2.1
> > >  ##
> > >  { 'union': 'NumaOptions',
> > >    'base': { 'type': 'NumaOptionsType' },
> > >    'discriminator': 'type',
> > >    'data': {
> > > -    'node': 'NumaNodeOptions' }}
> > > +    'node': 'NumaNodeOptions',
> > > +    'cpu' : 'CpuInstanceProperties' }}
> > 
> > I worry about not being able to add extra options to "-numa cpu"
> > in the future without affecting HotpluggableCPU.props too. Being
> > able to document the semantics of -numa cpu inside a dedicated
> > NumaCpuOptions struct would be nice too.
> > 
> > I believe this can be addressed by defing "NumaCpuOptions" with
> > "CpuInstanceProperties" as base:
> > 
> >  { 'union': 'NumaOptions',
> >    'base': { 'type': 'NumaOptionsType' },
> >    'discriminator': 'type',
> >    'data': {
> >      'node': 'NumaNodeOptions',
> >      'cpu' : 'NumaCpuOptions' }}
> > 
> > ##
> > # Options for -numa cpu,...
> > #
> > # "-numa cpu" accepts the same set of cpu properties returned by
> > # query-hotpluggable-cpus[].props, where node-id could be used to
> > # override default node mapping.
> > #
> > # Since: 2.10
> > ##
> > { 'struct': 'NumaCpuOptions',
> >   'base': 'CpuInstanceProperties' }
> is it inheritance or encapsulation?

If I understood the docs correctly, it's inheritance. I didn't
test it, though.

> if it's encapsulation, wouldn't look nice, but we can
> duplicate fields from CpuInstanceProperties in NumaCpuOptions
> like you proposed below and marshal them into CpuInstanceProperties
> inside of parse_numa() where needed.

I think inheritance will work. But if it doesn't, I don't mind
either: we can duplicate the fields like you suggest, or use
CpuInstanceProperties directly like you did above.

-- 
Eduardo
