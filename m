Received: from eggs.gnu.org ([2001:4830:134:3::10]:50136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6hVq-0002ha-Pr
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6hVn-0006tr-QO
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:59:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d6hVn-0006tj-Ji
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:59:27 -0400
Date: Fri, 5 May 2017 14:59:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170505175924.GL3482@thinpad.lan.raisama.net>
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-5-ehabkost@redhat.com>
	<20170504101638.coz6n5vc2d33bess@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170504101638.coz6n5vc2d33bess@eukaryote>
Subject: Re: [Qemu-devel] [PATCH 4/4] x86: Support feature=force on the
 command-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, May 04, 2017 at 12:16:38PM +0200, Kashyap Chamarthy wrote:
> On Tue, May 02, 2017 at 05:31:15PM -0300, Eduardo Habkost wrote:
> 
> Hi,
> 
> Yet to try this series, a small question in-line.
> 
> > Introduce a new CPUFeatureSetting QAPI data type, and use it to support
> > feature=force on -cpu.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
[...]
> > @@ -336,5 +340,13 @@ int main(int argc, char **argv)
> >                       "-machine accel=kvm:tcg -cpu max,mmx=off",
> >                       1, 0, "EDX", 23, false);
> >  
> > +    {
> > +    FeatureTestArgs *a;
> > +    a = add_feature_test("x86/cpuid/features/monitor-force",
> > +                         "-machine accel=kvm:tcg -cpu 486,monitor=force",
> 
> Following your above test example, should the 'force' boolean also work
> (understood: only for testing / debugging) as below, for a recognized
> CPUID flag, taking the example of 'INVPCID'?
> 
>   $ qemu-system-x86_64 [...] -cpu Haswell-noTSX,invpcid=force [...]

This would be valid syntax and would enable invpcid on CPUID,
yes. But on most cases this means you will get a broken VCPU
because the host won't virtualize the feature properly (if it
did, the feature would be reported as available in
GET_SUPPORTED_CPUID and "feature=on" would already work).

-- 
Eduardo
