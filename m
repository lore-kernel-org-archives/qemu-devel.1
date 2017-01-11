Received: from eggs.gnu.org ([2001:4830:134:3::10]:42163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cRI8T-0001OP-Ui
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 07:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cRI8O-0008Tv-Uy
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 07:36:13 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:58289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cRI8O-0008Tk-OW
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 07:36:08 -0500
Date: Wed, 11 Jan 2017 12:35:52 +0000
From: Julian Brown <julian@codesourcery.com>
Message-ID: <20170111123552.1873cb3b@squid.athome>
In-Reply-To: <CAFEAcA-EQ-e39uv1rnTUb5SwDZzPrHUfhydY5hzc8CrP4NhX_w@mail.gmail.com>
References: <cover.1481121503.git.julian@codesourcery.com>
	<b7f0904f00d135f9b2760b8881dbc9ead23cedbf.1481121503.git.julian@codesourcery.com>
	<CAFEAcA-EQ-e39uv1rnTUb5SwDZzPrHUfhydY5hzc8CrP4NhX_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] Add cfgend parameter for ARM CPU
 selection.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 5 Jan 2017 17:17:13 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> > +    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
> > +                             &error_abort);
> > +
> > +    qdev_prop_set_globals(DEVICE(obj));
> > +
> > +    if (object_property_get_bool(obj, "cfgend", NULL)) {
> > +        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> > +            cpu->reset_sctlr |= SCTLR_EE;
> > +        } else {
> > +            cpu->reset_sctlr |= SCTLR_B;
> > +        }
> > +    }  
> 
> Can we just implement this property the same way we do all
> our existing ones, ie just call qdev_property_add_static()
> here, and then look at the property value in arm_cpu_realizefn() ?
> I'm not clear what the call to qdev_prop_set_globals() is
> needed for.

...

> > @@ -765,15 +782,20 @@ static ObjectClass
> > *arm_cpu_class_by_name(const char *cpu_model) return NULL;
> >      }
> >
> > -    cpuname = g_strsplit(cpu_model, ",", 1);
> > +    cpuname = g_strsplit(cpu_model, ",", 2);
> >      typename = g_strdup_printf("%s-" TYPE_ARM_CPU, cpuname[0]);
> >      oc = object_class_by_name(typename);
> > -    g_strfreev(cpuname);
> > -    g_free(typename);
> >      if (!oc || !object_class_dynamic_cast(oc, TYPE_ARM_CPU) ||
> >          object_class_is_abstract(oc)) {
> > +        g_strfreev(cpuname);
> > +        g_free(typename);
> >          return NULL;
> >      }
> > +
> > +    cc = CPU_CLASS(oc);
> > +    cc->parse_features(typename, cpuname[1], &error_fatal);
> > +    g_strfreev(cpuname);
> > +  
> 
> I'm also not clear why this needs to change -- the existing code works
> for all of our current properties.

I'm a little confused, I think -- these changes seemed to be necessary
to allow the parsing of the command-line syntax you suggested earlier
(-mcpu=foo,cfgend=bar):

http://lists.nongnu.org/archive/html/qemu-devel/2016-11/msg00660.html

The qdev_prop_set_globals function calls back into arm/cpu.c to do the
actual parsing, IIRC.

Can the existing properties be set like that via the command line?
AFAICT they're only used to communicate settings from the machine
models (integratorcp, and so on) to the CPU initialisation code, and
are never exposed to the user.

Did I miss something? (I think the g_strsplit call with 1 as its third
argument is a no-op. Actually maybe that was supposed to be -1?)

Thanks,

Julian
