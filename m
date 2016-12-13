Received: from eggs.gnu.org ([2001:4830:134:3::10]:57737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGmTL-0002qk-67
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGmTH-0008Bm-9h
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:46:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cGmTH-0008Bd-1N
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:46:15 -0500
Date: Tue, 13 Dec 2016 10:46:12 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161213124612.GP3808@thinpad.lan.raisama.net>
References: <1480713496-11213-1-git-send-email-ehabkost@redhat.com>
	<1480713496-11213-15-git-send-email-ehabkost@redhat.com>
	<87lgvkrwhx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgvkrwhx.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-2.9 14/17] qapi: add
 static/migration-safe info to query-cpu-model-expansion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, libvir-list@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jiri Denemark <jdenemar@redhat.com>

On Tue, Dec 13, 2016 at 10:47:38AM +0100, Markus Armbruster wrote:
> I'm not familiar with CPU model expansion, but here goes anyway.
> 
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On x86, "-cpu host" enables some features that can't be
> > represented by a static CPU model definition: cache info
> > passthrough ("host-cache-info") and PMU passthrough ("pmu"). This
> > means a type=static expansion of "host" can't include those
> > features.
> >
> > A type=full expansion of "host", on the other hand, can include
> > those features, but then the returned data won't be a static CPU
> > model representation.
> >
> > Add a note to the documentation explaining that when using CPU
> > models that include non-migration-safe features, users need to
> > choose being precision and safety: a precise expansion of the CPU
> 
> s/being/between/
> 
> > model (full) won't be safe (static), (because they would include
> 
> s/they/it/

Oops. Thanks!

> 
> > pmu=on and host-cache-info=on), and a safe (static) expansion of
> > the CPU model won't be precise.
> >
> > Architectures where CPU model expansion is always migration-safe
> > (e.g. s390x) can simply do what they already do, and set
> > 'migration-safe' and 'static' to true.
> 
> This patch does that exactly for s390x.  The next patch looks like it
> does something for x86.  What about other targets?  I recommend to have
> this commit message explain briefly what this patch does, what later
> patches in this series do, and what's left for later (if anything).

s390x is the only architecture implementing
query-cpu-model-expansion by now.

I will add a comment clarifying that, anyway.

> 
> > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: libvir-list@redhat.com
> > Cc: Jiri Denemark <jdenemar@redhat.com>
> > Cc: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  qapi-schema.json          | 25 ++++++++++++++++++++++++-
> >  target-s390x/cpu_models.c |  4 ++++
> >  2 files changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/qapi-schema.json b/qapi-schema.json
> > index 8d113f8..a102534 100644
> > --- a/qapi-schema.json
> > +++ b/qapi-schema.json
> > @@ -3291,6 +3291,15 @@
> >  #        migration-safe, but allows tooling to get an insight and work with
> >  #        model details.
> >  #
> > +# Note: When a non-migration-safe CPU model is expanded in static mode, some
> > +# features enabled by the CPU model may be omitted, because they can't be
> > +# implemented by a static CPU model definition (e.g. cache info passthrough and
> > +# PMU passthrough in x86). If you need an accurate representation of the
> > +# features enabled by a non-migration-safe CPU model, use @full. If you need a
> > +# static representation that will keep ABI compatibility even when changing QEMU
> > +# version or machine-type, use @static (but keep in mind that some features may
> > +# be omitted).
> > +#
> >  # Since: 2.8.0
> >  ##
> >  { 'enum': 'CpuModelExpansionType',
> > @@ -3304,10 +3313,24 @@
> >  #
> >  # @model: the expanded CpuModelInfo.
> >  #
> > +# @migration-safe: the expanded CPU model in @model is a migration-safe
> > +#                  CPU model. See @CpuDefinitionInfo.migration-safe.
> > +#                  If expansion type was @static, this is always true.
> > +#                  (since 2.9)
> > +#
> > +# @static: the expanded CPU model in @model is a static CPU model.
> > +#          See @CpuDefinitionInfo.static. If expansion type was @static,
> > +#          this is always true.
> > +#          (since 2.9)
> > +#
> > +# query-cpu-model-expansion with static expansion type should always
> > +# return a static and migration-safe expansion.
> > +#
> >  # Since: 2.8.0
> >  ##
> >  { 'struct': 'CpuModelExpansionInfo',
> > -  'data': { 'model': 'CpuModelInfo' } }
> > +  'data': { 'model': 'CpuModelInfo', 'static': 'bool',
> > +            'migration-safe': 'bool' } }
> >  
> >  
> >  ##
> > diff --git a/target-s390x/cpu_models.c b/target-s390x/cpu_models.c
> > index 5b66d33..f934add 100644
> > --- a/target-s390x/cpu_models.c
> > +++ b/target-s390x/cpu_models.c
> > @@ -448,6 +448,10 @@ CpuModelExpansionInfo *arch_query_cpu_model_expansion(CpuModelExpansionType type
> >      /* convert it back to a static representation */
> >      expansion_info = g_malloc0(sizeof(*expansion_info));
> >      expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
> > +
> > +    /* We always expand to a static and migration-safe CpuModelInfo */
> > +    expansion_info->q_static = true;
> > +    expansion_info->migration_safe = true;
> >      cpu_info_from_model(expansion_info->model, &s390_model, delta_changes);
> >      return expansion_info;
> >  }

-- 
Eduardo
