Received: from eggs.gnu.org ([2001:4830:134:3::10]:40519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4TAe-000550-42
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4TAa-0003PY-W5
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:48:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e4TAa-0003Ox-O1
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:48:36 -0400
Date: Tue, 17 Oct 2017 15:48:27 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171017144827.GA31897@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-5-git-send-email-imammedo@redhat.com>
	<20171016165916.GI3246@localhost.localdomain>
	<4c14ed02-1f1c-a093-52ac-632f61a68a6f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c14ed02-1f1c-a093-52ac-632f61a68a6f@redhat.com>
Subject: Re: [Qemu-devel] [RFC 4/6] CLI: add -paused option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, david@gibson.dropbear.id.au

On Mon, Oct 16, 2017 at 07:01:01PM +0200, Paolo Bonzini wrote:
> On 16/10/2017 18:59, Eduardo Habkost wrote:
> >> +DEF("paused", HAS_ARG, QEMU_OPTION_paused, \
> >> +    "-paused [state=]postconf|preconf\n"
> >> +    "                postconf: pause QEMU after machine is initialized\n"
> >> +    "                preconf: pause QEMU before machine is initialized\n",
> >> +    QEMU_ARCH_ALL)
> > I would like to allow pausing before machine-type is selected, so
> > management could run query-machines before choosing a
> > machine-type.  Would that need a third "-pause" mode, or will we
> > be able to change "preconf" to pause before select_machine() is
> > called?
> > 
> > The same probably applies to other things initialized before
> > machine_run_board_init() that could be configurable using QMP,
> > including but not limited to:
> > * Accelerator configuration
> > * Registering global properties
> > * RAM size
> > * SMP/CPU configuration
> 
> Should (or could) "-M none" be changed in a backwards-compatible way to
> allow such preconfiguration?  For example
> 
>   qemu -M none -monitor stdio
>   (qemu) machine-set-options pc,accel=kvm
>   (qemu) c

Going down this route has pretty major implications for the way libvirt
manages QEMU, and support / debugging of it. When you look at the QEMU
command line libvirt uses it will be almost devoid of any useful info.
So it will be more involved job to figure out just how QEMU is configured.
This also means it is difficult to replicate the config that libvirt has
used, outside of libvirt for sake of debugging.

I also think it will have pretty significant performance implications
for QEMU startup. To configure a guest via the monitor is going to
require a huge number of monitor commands to be executed to replicate
what we traditionally configured via ARGV. While each monitor command
is not massively slow, the round-trip time of each command will quickly
add up to several 100 milliseconds, perhaps even seconds in the the
case of very large configs. 

Maybe we ultimately have no choice and this is inevitable, but I am
pretty wary of going in the direction of launching bare QEMU and
configuring everything via a huge number of monitor calls.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
