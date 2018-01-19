Received: from eggs.gnu.org ([2001:4830:134:3::10]:37601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecWVG-0005BJ-Uc
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecWVC-0007ax-NA
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:14:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecWVC-0007aB-EC
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:14:38 -0500
Date: Fri, 19 Jan 2018 11:14:30 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119131430.GR5292@localhost.localdomain>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<1516203816-19374-21-git-send-email-imammedo@redhat.com>
	<20180118014846.GM627@localhost.localdomain>
	<20180118111035.3ab0a533@redhat.com>
	<20180118191809.GB5292@localhost.localdomain>
	<20180119111439.0feb4f5a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180119111439.0feb4f5a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 20/24] machine: drop MachineState::cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jan 19, 2018 at 11:14:39AM +0100, Igor Mammedov wrote:
> On Thu, 18 Jan 2018 17:18:09 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Thu, Jan 18, 2018 at 11:10:35AM +0100, Igor Mammedov wrote:
> > > On Wed, 17 Jan 2018 23:48:46 -0200
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >   
> > > > On Wed, Jan 17, 2018 at 04:43:32PM +0100, Igor Mammedov wrote:  
> > > > > The last user of it was machine type 'none', which used field
> > > > > to create CPU id user requested it on CLI with -cpu option.
> [...]
> 
> > It looks like default_cpu_type is being overloaded for two
> > different roles: 1) specifying the default CPU type; 2) finding
> > the arch-specific class to be used to parse -cpu.
> > 
> > In the case of null-machine, these two roles conflict with each
> > other.  I believe we can find other solutions instead of this
> > hack that involves lying on MachineClass::default_cpu_type (and
> > then having to work around the lie on machine_none_init()).
> > 
> > I see multiple options: adding a new MachineClass field for that
> > (e.g.  resolving_cpu_type, which defaults to default_cpu_type if
> > NULL); moving the CPU parsing code to arch_init.c (so it could
> > use CPU_RESOLVING_TYPE or something similar); adding a optional
> > MachineClass::parse_cpu_model hook.  We could even try to get rid
> > of CPUClass::parse_features completely
> Adding hooks just for the sake on null-machine seems to be overkill,
> I'd go for arch_init.c but it won't work for linux-user, how about
> exec.c as following:
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 93bd546..0185589 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -661,8 +661,7 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model);
> [...]
> 
> diff --git a/exec.c b/exec.c
> index d28fc0c..4543f06 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -817,6 +817,29 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
>  #endif
>  }
>  
> +const char *parse_cpu_model(const char *cpu_model)
> +{
> +    ObjectClass *oc;
> +    CPUClass *cc;
> +    gchar **model_pieces;
> +    const char *cpu_type;
> +
> +    model_pieces = g_strsplit(cpu_model, ",", 2);
> +
> +    oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
> +    if (oc == NULL) {
> +        error_report("unable to find CPU model '%s'", model_pieces[0]);
> +        g_strfreev(model_pieces);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    cpu_type = object_class_get_name(oc);
> +    cc = CPU_CLASS(oc);
> +    cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
> +    g_strfreev(model_pieces);
> +    return cpu_type;
> +}

Sounds good to me.  Only two comments:

This looks like duplication of cpu_parse_cpu_model().  Should
this function body be replaced with:
  cpu_parse_cpu_model(CPU_RESOLVING_TYPE, cpu_model)
?

I would move this to arch_init.c, because that's where existing
target-dependent initialization code lives.


> [...]

-- 
Eduardo
