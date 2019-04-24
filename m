Received: from eggs.gnu.org ([209.51.188.92]:49209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJEEh-0003a2-D7
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJEEc-0003OA-8F
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:30:39 -0400
Date: Wed, 24 Apr 2019 10:30:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190424093014.GB31388@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<d3cdd199-0457-7255-9540-2bbe5555e079@redhat.com>
	<a9e5863e-cb05-11a6-03a8-89ee45febcc9@de.ibm.com>
	<03eb94f6-6f8f-0358-df00-bc487e5e3bff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03eb94f6-6f8f-0358-df00-bc487e5e3bff@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/10] s390x: new guest features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Wed, Apr 24, 2019 at 11:03:03AM +0200, David Hildenbrand wrote:
> On 24.04.19 10:40, Christian Borntraeger wrote:
> > 
> > 
> > On 23.04.19 14:11, David Hildenbrand wrote:
> >> On 18.04.19 13:31, Christian Borntraeger wrote:
> >>> Adding generation 15.
> >>>
> >>> Some interesting aspects:
> >>> - conditional SSKE and bpb are deprecated. This patch set addresses that
> >>>   for csske.
> >>> - no name yet for gen15, I suggest to use the assigned numbers and
> >>>   provide an alias later on. (I have split out this into a separate
> >>>   patch)
> >>>
> >>> Christian Borntraeger (10):
> >>>   linux header sync
> >>>   s390x/cpumodel: remove CSSKE from base model
> >>>   s390x/cpumodel: Miscellaneous-Instruction-Extensions Facility 3
> >>>   s390x/cpumodel: msa9 facility
> >>>   s390x/cpumodel: vector enhancements
> >>>   s390x/cpumodel: enhanced sort facility
> >>>   s390x/cpumodel: deflate
> >>>   s390x/cpumodel: add gen15 defintions
> >>>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines
> >>>   s390x/cpumodel: do not claim csske for expanded models in qmp
> >>>
> >>>  hw/s390x/s390-virtio-ccw.c      |  6 +++
> >>>  linux-headers/asm-s390/kvm.h    |  5 +-
> >>>  target/s390x/cpu_features.c     | 54 +++++++++++++++++++
> >>>  target/s390x/cpu_features.h     |  3 ++
> >>>  target/s390x/cpu_features_def.h | 49 +++++++++++++++++
> >>>  target/s390x/cpu_models.c       | 35 ++++++++++++
> >>>  target/s390x/cpu_models.h       |  1 +
> >>>  target/s390x/gen-features.c     | 94 ++++++++++++++++++++++++++++++++-
> >>>  target/s390x/kvm.c              | 18 +++++++
> >>>  9 files changed, 263 insertions(+), 2 deletions(-)
> >>>
> >>
> >> I guess to handle deprecation of CSSKE:
> >>
> >> 1. Remove it from the base + default model of the gen15, keep it in the
> >> max model. This is completely done in target/s390x/gen-features.c.
> >> Existing base models are not modified.
> >>
> >> 2. Add CSSKE to "ignored_base_feat", so fallback of gen15 to e.g. z14
> >> will work. We can backport this to distros/stable.
> > 
> > Yes, I have already implemented that, still doing some testing and polishinh.
> >>
> >>
> >> CPU model expansion:
> >>
> >> cpu_info_from_model() should already properly be based on the base
> >> features. "gen15" vs. "gen15,csske=on" should be automatically generated
> >> when expanding.
> >>
> >> CPU model baseline:
> >>
> >> s390_find_cpu_def() should make sure that CSSKE is basically ignored
> >> when determining maximum model, however it will properly be indicated if
> >> both models had the feature.
> >>
> >> CPU model comparison:
> >>
> >> Should work as expected. Availability of CSSKE will be considered when
> >> calculating the result.
> >>
> >> gen14,csske=on and gen15,csske=off will result in
> >> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE.
> >>
> >> gen14,csske=off and gen15,csske=off should result in
> >> CPU_MODEL_COMPARE_RESULT_SUBSET
> >>
> >> gen14,csske=on and gen15,csske=on should result in
> >> CPU_MODEL_COMPARE_RESULT_SUBSET
> >>
> >> Forward migration:
> >>
> >> Now, the only issue is when csske is actually turned of in future
> >> machines. We would e.g. have
> >>
> >> gen15,csske=on and gen16,csske=off
> >>
> >> While baselining will work correctly (gen15,csske=off), forward
> >> migration is broken (comparison will properly indicate
> >> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE), which is expected when ripping
> >> out features. Same applies to BPB.
> >>
> >>
> >> Your patch "[PATCH 10/10] s390x/cpumodel: do not claim csske for
> >> expanded models in qmp" tried to address this, however I am not really
> >> happy with this approach. We should not play such tricks when expanding
> >> the host model. "-cpu host" and "-cpu $expanded_host" would be
> >> different,
> > 
> > We discussed this some time ago and I think we agreed that for host passthrough
> > it is ok to be different that host-model (e.g. passing through the cpuid, passing
> > through all non-hypervisor managed features etc).
> 
> I remember the plan was to use the "max" model to do such stuff. E.g.
> -cpu max / no -cpu
> 
> Versus
> -cpu host
> 
> We can have features in "host" we don't have in "max". But "-cpu host"
> and it's expansion should look 100% the same.

I don't think that's the intended semantics of "max" vs "host".

The "max" CPU model is supposed to enable all features that are possible to
enable.

For KVM, thus "max" should be identical to "host".

For TCG, "max" should be everything that QEMU currently knows how to emulate.

Essentially think of "max" as a better name for "host", since "host" as
a name concept didn't make sense for TCG.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
