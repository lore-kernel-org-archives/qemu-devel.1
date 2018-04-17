Received: from eggs.gnu.org ([2001:4830:134:3::10]:53977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8SjM-0002XC-3D
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8SjK-0006C7-2R
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:41:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58942 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f8SjJ-0006Bb-S0
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:41:13 -0400
Date: Tue, 17 Apr 2018 17:41:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180417174110.1a7f1daf@redhat.com>
In-Reply-To: <20180417142739.GV29865@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<87zi21apkh.fsf@dusky.pond.sub.org>
	<20180417142739.GV29865@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/9] enable numa configuration before
 machine_init() from QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Tue, 17 Apr 2018 11:27:39 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Apr 17, 2018 at 04:13:34PM +0200, Markus Armbruster wrote:
> > Igor Mammedov <imammedo@redhat.com> writes:
> > 
> > [...]  
> > > Series allows to configure NUMA mapping at runtime using QMP
> > > interface. For that to happen it introduces a new '-preconfig' CLI option
> > > which allows to pause QEMU before machine_init() is run and
> > > adds new set-numa-node QMP command which in conjunction with
> > > query-hotpluggable-cpus allows to configure NUMA mapping for cpus.
> > >
> > > Later we can modify other commands to run early, for example device_add.
> > > I recall SPAPR had problem when libvirt started QEMU with -S and, while it's
> > > paused, added CPUs with device_add. Intent was to coldplug CPUs (but at that
> > > stage it's considered hotplug already), so SPAPR had to work around the issue.  
> > 
> > That instance is just stupidity / laziness, I think: we consider any
> > plug after machine creation a hot plug.  Real machines remain cold until
> > you press the power button.  Our virtual machines should remain cold
> > until they start running, i.e. with -S until the first "cont".
It probably would be too risky to change semantics of -S from hotplug to coldplug.
But even if we were easy it won't matter in case if dynamic configuration
done properly. More on it below.

> > I vaguely remember me asking this before, but your answer didn't make it
> > into this cover letter, which gives me a pretext to ask again instead of
> > looking it up in the archives: what exactly prevents us from keeping the
> > machine cold enough for numa configuration until the first "cont"?  
> 
> I also think this would be better, but it seems to be difficult
> in practice, see:
> http://mid.mail-archive.com/20180323210532.GD28161@localhost.localdomain

In addition to Eduardo's reply, here is what I've answered back
when you've asked question the 1st time (v2 late at -S pause point reconfig):
https://www.mail-archive.com/qemu-devel@nongnu.org/msg504140.html

In short:
I think it's wrong in general doing fixups after machine is build
instead of getting correct configuration before building machine.
That's going to be complex and fragile and might be hard to do at
all depending on what we are fixing up.

BTW this is an outdated version of series and there is a newer one v5
https://patchwork.ozlabs.org/cover/895315/
so pleases review it.

Short diff vs 1:
 - only limited(minimum) set of commands is available at preconfig stage for now
 - use QAPI schema to mark commands as preconfig enabled,
   so mgmt could see when it can use commands.
 - added preconfig runstate state-machine instead of adding more global variables
   to cleanly keep track of where QEMU is paused and what it's allowed to do
