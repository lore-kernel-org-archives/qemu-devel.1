Received: from eggs.gnu.org ([2001:4830:134:3::10]:33558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTu7h-0002Ov-W0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTu7d-0007iz-Vk
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:34:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTu7d-0007iV-PP
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:34:09 -0500
Date: Wed, 18 Jan 2017 15:34:06 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170118173406.GF3491@thinpad.lan.raisama.net>
References: <20170117010204.4909-1-ehabkost@redhat.com>
	<309bd499-204d-df07-aa99-9a999cfecabc@linux.vnet.ibm.com>
	<20170118170049.GB3491@thinpad.lan.raisama.net>
	<45e82b29-1ebe-3f34-0cc1-35d60c6044da@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45e82b29-1ebe-3f34-0cc1-35d60c6044da@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 0/9] i386:
 query-cpu-model-expansion test script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, "Collin L. Walling" <walling@linux.vnet.ibm.com>

On Wed, Jan 18, 2017 at 12:09:28PM -0500, Jason J. Herne wrote:
> On 01/18/2017 12:00 PM, Eduardo Habkost wrote:
> > On Tue, Jan 17, 2017 at 10:22:10AM -0500, Jason J. Herne wrote:
> > > On 01/16/2017 08:01 PM, Eduardo Habkost wrote:
> > > > This is a follow-up to the series that implements
> > > > query-cpu-model-expansion. Before including the test script, the
> > > > series has some fixes to allow the results of
> > > > query-cpu-model-expansion to be used in the QEMU command-line.
> > > > 
> > > > The script probably will work on s390x too, but I couldn't test
> > > > it yet.
> > > > 
> > > 
> > > Eduardo,
> > > 
> > > This test seems to mostly work on s390. The only issue I ran into is
> > > querying host model using tcg only. s390 requires kvm to query the host
> > > model. Perhaps we could just skip the tcg host test case on s390?
> > 
> > We could still try to test "host", but add it to a greylist where
> > errors returned by query-cpu-model-expansion can be non-fatal.
> > query-cpu-model-expansion model="host" can also fail with KVM if
> > the host doesn't support CPU models.
> > 
> 
> David had the idea to just support -cpu host for tcg. We could do that.
> In the meantime, I'm ok with your greylist idea too. This would allow the
> script to work properly on s390 right from the start, and we can remove the
> greylist when s390 supports specifying -cpu host for tcg.

I believe we will still need to ignore query-cpu-model-expansion
errors on some cases, otherwise the test script will fail on
hosts where KVM doesn't support CPU models in KVM.

But we probably don't need a hardcoded greylist, anyway: we could
just make the error non-fatal in case the CPU model is not
reported as migration-safe in query-cpu-definitions.

But I was wondering:

1) Isn't "-cpu host" the default CPU model on s390x on KVM,
   even if the host doesn't support CPU models?

2) Is it really correct to return an error on
   "query-cpu-model-expansion model=host type=full" if the host
   doesn't support CPU models?

   What if it just returned { name: "host", props: {} }
   on those cases, meaning that the CPU model is valid and
   usable, but QEMU is unable to provide extra information about
   it.

-- 
Eduardo
