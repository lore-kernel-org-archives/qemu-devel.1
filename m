Received: from eggs.gnu.org ([2001:4830:134:3::10]:47361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6DON-0007lF-Gs
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6DOI-0006S7-JF
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d6DOI-0006Rh-9q
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:49:42 -0400
Date: Thu, 4 May 2017 11:49:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170504114938.3c58ebf0@nial.brq.redhat.com>
In-Reply-To: <20170502203115.22233-5-ehabkost@redhat.com>
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue,  2 May 2017 17:31:15 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Introduce a new CPUFeatureSetting QAPI data type, and use it to support
> feature=force on -cpu.
commit message lacks rationale why it's needed.
I suspect that it's to enable forced mwait.
It would be nice to put here answer to what
motivated to write this patch and reference commit ids
of kernel patches if there are/needed any to make it work.

> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
[...]
> @@ -3717,25 +3727,46 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
>      X86CPU *cpu = X86_CPU(obj);
>      BitProperty *fp = opaque;
>      Error *local_err = NULL;
> -    bool value;
> +    CPUFeatureSetting *value = NULL;
>  
>      if (dev->realized) {
>          qdev_prop_set_after_realize(dev, name, errp);
>          return;
>      }
>  
> -    visit_type_bool(v, name, &value, &local_err);
> +    visit_type_CPUFeatureSetting(v, name, &value, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
>  
> -    if (value) {
> -        cpu->env.features[fp->w] |= fp->mask;
> -    } else {
> -        cpu->env.features[fp->w] &= ~fp->mask;
> +    switch (value->type) {
> +    case QTYPE_QBOOL:
> +        if (value->u.q_bool) {
> +            cpu->env.features[fp->w] |= fp->mask;
> +        } else {
> +            cpu->env.features[fp->w] &= ~fp->mask;
> +        }
> +        cpu->env.forced_features[fp->w] &= ~fp->mask;
> +        cpu->env.user_features[fp->w] |= fp->mask;
> +    break;
> +    case QTYPE_QSTRING:
> +        switch (value->u.q_enum) {
> +        case CPU_FEATURE_SETTING_ENUM_FORCE:
> +            cpu->env.features[fp->w] |= fp->mask;
> +            cpu->env.forced_features[fp->w] |= fp->mask;
> +        break;
> +        default:
> +            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name,
> +                       "CPUFeatureSetting");
> +        }
> +    break;
> +    default:
> +        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name,
> +                   "CPUFeatureSetting");
>      }
> -    cpu->env.user_features[fp->w] |= fp->mask;
that's the only place it was set and then used by x86_cpu_expand_features()
Is it correct to remove setter?


> +
> +    qapi_free_CPUFeatureSetting(value);
>  }
>  
>  static void x86_cpu_release_bit_prop(Object *obj, const char *name,
