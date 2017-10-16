Received: from eggs.gnu.org ([2001:4830:134:3::10]:50117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e491c-0006co-Mr
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e491Y-00051F-ND
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:18:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e491Y-00050m-Gf
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:17:56 -0400
Date: Mon, 16 Oct 2017 15:17:52 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171016171752.GK3246@localhost.localdomain>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-5-git-send-email-imammedo@redhat.com>
	<20171016165916.GI3246@localhost.localdomain>
	<4c14ed02-1f1c-a093-52ac-632f61a68a6f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, cohuck@redhat.com

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

Sounds like an interesting idea.  It would require ensuring it's
really safe to destroy current_machine/accel (and other global
state) and replace them with another object on the fly (which is
probably a nice goal by itself).

-- 
Eduardo
