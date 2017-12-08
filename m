Received: from eggs.gnu.org ([2001:4830:134:3::10]:53982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eNIVv-0000gR-Ru
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eNIVt-0007ZC-72
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:16:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eNIVt-0007YS-0l
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:16:25 -0500
Date: Fri, 8 Dec 2017 14:16:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171208141618.11e60846@redhat.com>
In-Reply-To: <CAFEAcA9Uh9f3UddCNiB3u6BD9Qg=sUMDmMYYn1+sryiJUMOFYg@mail.gmail.com>
References: <CAFEAcA-auykOKQbNcoQooNGk7Vb3wt7TH7AMA689xEj22_6KcQ@mail.gmail.com>
	<20171207174832.42663bef@redhat.com>
	<CAFEAcA9o-LyKZBZwSoz3SSPCY-sjo9e011UWy1=EwJ4U9rWYsg@mail.gmail.com>
	<20171207170719.GT3037@localhost.localdomain>
	<CAFEAcA9fzkedj_VLeTaK-WOTLGk1RinyadRmR5FaJ44KOAQU3w@mail.gmail.com>
	<CAFEAcA9Uh9f3UddCNiB3u6BD9Qg=sUMDmMYYn1+sryiJUMOFYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] in a device or CPU instance init/realize,
 can I rely on something having the BQL or equivalent?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, 7 Dec 2017 17:26:53 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 7 December 2017 at 17:13, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 7 December 2017 at 17:07, Eduardo Habkost <ehabkost@redhat.com> wrote:  
> >> On Thu, Dec 07, 2017 at 04:53:59PM +0000, Peter Maydell wrote:  
> >>> On 7 December 2017 at 16:48, Igor Mammedov <imammedo@redhat.com> wrote:  
> >>> > On Thu, 7 Dec 2017 16:05:50 +0000
> >>> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >>> >  
> >>> >> Hi; I'm currently writing '-cpu max' support for ARM. For that I'd
> >>> >> like to be able to do the "probe host kernel for its supported feature
> >>> >> set" in the CPU object's instance-init function, but I'd like to do  
> >>
> >> I don't think instance_init is appropriate for that, as
> >> object_free(object_new(t)) must be always safe to call and free
> >> of side-effects for all types.  Wouldn't it work if you do that
> >> on realize?  
> >
> > I think we need the information before realize, but I'll double
> > check.  
> 
> We do need the information before realize, because the probe
> is what tells us what feature bits we need to set, and the
> ARM instance_post_init hook needs to look at those to determine
> eg which other feature bits to set and which QOM properties to
> expose as a result, and all that has to happen at init time,
> not realize time.
maybe it could be modeled after  kvm_ppc_register_host_cpu_type(),
i.e. create type with necessary feature bits set at cpu's class
init time (sort of combo of what ppc and x86 do).

i.e. one caches host's feature bits at cpu_class_init time and
then loads applies them to object instance at instance init time,
like in x86_cpu_initfn()->x86_cpu_load_def().

TBH:
 I do not recall why we have x86 max/host cpu types do feature
 loading at realize time instead of at class init like the rest
 of static cpu types.


> thanks
> -- PMM
