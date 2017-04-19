Received: from eggs.gnu.org ([2001:4830:134:3::10]:47867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0tjM-0006OR-PV
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0tjF-00086U-Qz
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:49:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d0tjF-00085k-Hz
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:49:21 -0400
Date: Wed, 19 Apr 2017 14:49:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170419174918.GW25239@thinpad.lan.raisama.net>
References: <1490700426-222115-1-git-send-email-agraf@suse.de>
	<20170413173625.GG27126@thinpad.lan.raisama.net>
	<149254928069.7320.7406236070784019013@loki>
	<75cd49eb-7a78-ef86-9df4-8962228c8285@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75cd49eb-7a78-ef86-9df4-8962228c8285@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] i386: Allow cpuid bit override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Apr 18, 2017 at 04:19:10PM -0500, Eric Blake wrote:
> On 04/18/2017 04:01 PM, Michael Roth wrote:
> >>> @@ -3706,8 +3707,17 @@ static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
> >>>      X86CPU *cpu = X86_CPU(obj);
> >>>      BitProperty *fp = opaque;
> >>>      uint32_t f = cpu->env.features[fp->w];
> >>> +    uint32_t ff = cpu->forced_features[fp->w];
> >>>      bool value = (f & fp->mask) == fp->mask;
> >>> -    visit_type_bool(v, name, &value, errp);
> >>> +    bool forced = (ff & fp->mask) == fp->mask;
> >>> +    char str[] = "force";
> >>> +    char *strval = str;
> >>> +
> >>> +    if (forced) {
> >>> +        visit_type_str(v, name, &strval, errp);
> >>> +    } else {
> >>> +        visit_type_bool(v, name, &value, errp);
> >>
> >> Interesting approach. This means we keep returning a boolean
> >> value on the property getter (which is important to not break
> >> compatibility), but return a string in case the feature was set
> >> to "force".
> >>
> >> We probably should update the 'type' field of the property, as it
> >> won't be a real "bool" property anymore.
> >>
> >> I won't say I love that solution, but it seems to work. I'm CCing
> >> the QAPI maintainers to see what they think about it.
> 
> Use of a formal QAPI alternate type seems reasonable here.
> 
> >>
> >> (For reference: in the v1 thread I have suggested introducing a
> >> new enum type in the QAPI schema, but this would break
> >> compatibility with existing management code that expects the
> >> property to return a boolean value [like the users of
> >> query-cpu-model-expansion]).
> 
> >>> @@ -3724,7 +3735,15 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
> >>>          return;
> >>>      }
> >>>  
> >>> -    visit_type_bool(v, name, &value, &local_err);
> >>> +    visit_type_str(v, name, &strval, &local_err);
> >>> +    if (!local_err && !strcmp(strval, "force")) {
> >>> +        value = true;
> >>> +        cpu->forced_features[fp->w] |= fp->mask;
> >>> +    } else {
> >>> +        local_err = NULL;
> >>> +        visit_type_bool(v, name, &value, &local_err);
> >>> +    }
> >>
> >> I'm not sure this is valid usage of the visitor API. If the
> >> visit_type_str() call succeeds, isn't the visitor allowed to
> >> consume the original value, and return something completely
> >> different when visit_type_bool() is called?
> > 
> 
> Better would be defining the QAPI alternate type:
> 
> { 'enum': 'Force', 'data': ['force']}
> { 'alternate': 'BoolOrForce',
>   'data': { 'b': 'bool', 's': 'Force' } }
> 
> then given a BoolOrForce *state; declaration, you do either:
> 
> state->type = QTYPE_QBOOL;
> state->u.b = true;
> 
> or
> 
> state->type = QTYPE_QSTRING;
> state->u.s = FORCE_FORCE;
> 
> and then call visit_type_BoolOrForce(..., &state ...)
> 
> Qcow2OverlapChecks is an example of an alternate in use, if that helps.

Wow, this is wonderful. I will take a look. Thanks!

> [...]

-- 
Eduardo
