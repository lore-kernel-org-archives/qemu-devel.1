Received: from eggs.gnu.org ([2001:4830:134:3::10]:57979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT1ZC-00080B-SN
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT1ZC-0006cp-3N
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:55:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51206 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fT1ZB-0006c6-Ug
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:55:46 -0400
Date: Wed, 13 Jun 2018 10:55:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180613105543.32e58e99@redhat.com>
In-Reply-To: <20180612144922.GJ7451@localhost.localdomain>
References: <20180608205830.308627-1-mst@redhat.com>
	<20180612145605.50f64965@redhat.com>
	<20180612155708-mutt-send-email-mst@kernel.org>
	<20180612155803.4ca0d137@redhat.com>
	<20180612144922.GJ7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC untested PATCH] i386/cpu: make -cpu host
 support monitor/mwait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 12 Jun 2018 11:49:22 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Jun 12, 2018 at 03:58:03PM +0200, Igor Mammedov wrote:
> [...]
> > > > > +    if (xcc->host_cpuid_required && enable_cpu_pm) {
> > > > > +        host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
> > > > > +                   &cpu->mwait.ecx, &cpu->mwait.edx);
> > > > > +    }    
[...]
> > > > also max_x86_cpu_initfn() might be better place for filling it up.  
> 
> Why?
I've missed 'enable_cpu_pm' which is probably a property,
so yep it can't go into initfn.

However if we not going to migrate this state or use outside of
cpu_x86_cpuid(), I don't see why we should add it to X86CPU state
and keep around.
We can query it on demand from cpu_x86_cpuid() like we do for
PMU leaf.
