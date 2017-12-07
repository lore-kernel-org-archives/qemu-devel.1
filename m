Received: from eggs.gnu.org ([2001:4830:134:3::10]:44709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eMzdw-0000GX-Rk
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eMzdt-0007AW-EZ
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:07:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eMzdt-00078K-8i
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:07:25 -0500
Date: Thu, 7 Dec 2017 15:07:19 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171207170719.GT3037@localhost.localdomain>
References: <CAFEAcA-auykOKQbNcoQooNGk7Vb3wt7TH7AMA689xEj22_6KcQ@mail.gmail.com>
	<20171207174832.42663bef@redhat.com>
	<CAFEAcA9o-LyKZBZwSoz3SSPCY-sjo9e011UWy1=EwJ4U9rWYsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9o-LyKZBZwSoz3SSPCY-sjo9e011UWy1=EwJ4U9rWYsg@mail.gmail.com>
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
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Dec 07, 2017 at 04:53:59PM +0000, Peter Maydell wrote:
> On 7 December 2017 at 16:48, Igor Mammedov <imammedo@redhat.com> wrote:
> > On Thu, 7 Dec 2017 16:05:50 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> >> Hi; I'm currently writing '-cpu max' support for ARM. For that I'd
> >> like to be able to do the "probe host kernel for its supported feature
> >> set" in the CPU object's instance-init function, but I'd like to do

I don't think instance_init is appropriate for that, as
object_free(object_new(t)) must be always safe to call and free
of side-effects for all types.  Wouldn't it work if you do that
on realize?


> >> it just once and cache the answer. Can I rely on something or other
> >> having the BQL or otherwise ensuring that two threads don't run
> >> the instance_init method in parallel (eg in a hotplug situation),
> >> or do I need to create and use my own mutex to protect the cached
> >> answer data?
> > considering cached data shouldn't change during qemu lifetime it
> > shouldn't be possible for instance_init() to clash at hotplug
> > time as object_new(cpu) calls serialized within monitor/qmp loop.
> 
> Right, that was my question -- are we guaranteed that anything
> that calls object_new(cpu) does it with a lock?

object_new() itself doesn't seem to be thread-safe (see
type_initialize()), so I'm pretty sure there shouldn't be any
object_new() calls in QEMU without the BQL being held.


> 
> > But why cpu's instance_init, we could cache host's value at
> > configure_accelerator() time (could be different depending on accel).
> 
> I don't know if I need the information at configure_accelerator()
> time (if you say "-cpu cortex-a57" then we don't need to bother
> probing). The first time I know if we want to probe is when a
> "-cpu host" CPU is created.
> 
> thanks
> -- PMM

-- 
Eduardo
