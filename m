Received: from eggs.gnu.org ([2001:4830:134:3::10]:41845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDEtP-0000EM-0C
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDEtO-0008Ty-5a
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:23:06 -0500
Date: Fri, 10 Nov 2017 14:23:00 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171110192300.GC17844@flamenco>
References: <1509734853-3014-1-git-send-email-cota@braap.org>
	<20171107201545.GA32606@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171107201545.GA32606@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] hw: add .min_cpus and .default_cpus fields
 to machine_class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

On Tue, Nov 07, 2017 at 18:15:45 -0200, Eduardo Habkost wrote:
> On Fri, Nov 03, 2017 at 02:47:33PM -0400, Emilio G. Cota wrote:
> > @@ -4330,12 +4330,34 @@ int main(int argc, char **argv, char **envp)
> >      smp_parse(qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
> >  
> >      machine_class->max_cpus = machine_class->max_cpus ?: 1; /* Default to UP */
> > +    machine_class->min_cpus = machine_class->min_cpus ?: 1;
> > +    machine_class->default_cpus = machine_class->default_cpus ?: 1;
> > +
> > +    /* if -smp is not set, default to mc->default_cpus */
> > +    if (!smp_cpus) {
> > +        smp_cpus = machine_class->default_cpus;
> > +        max_cpus = machine_class->default_cpus;
> > +    }
> 
> I suggest doing this before smp_parse(), so any validation of
> smp_cpus inside smp_parse will apply to the value we're setting
> here (e.g. the replay_add_blocker() call in smp_parse() will
> work).
(snip)
> > +    if (max_cpus < machine_class->min_cpus) {
> 
> smp_parse() already ensures max_cpus >= smp_cpus, and you are
> already checking if smp_cpus < machine_class->min_cpus above.  Is
> it really possible to trigger this error message?
> 
> Except for that, the patch looks good to me.

Both very good points! I've modified the patch accordingly.

Thanks,

		Emilio
