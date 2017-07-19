Received: from eggs.gnu.org ([2001:4830:134:3::10]:39622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXuvz-0003Wr-Lb
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 15:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXuvw-0005Hf-DQ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 15:46:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXuvw-0005H7-3h
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 15:46:56 -0400
Date: Wed, 19 Jul 2017 16:46:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170719194650.GL2757@localhost.localdomain>
References: <201707191247531805742@zte.com.cn>
	<20170719061651.GE2757@localhost.localdomain>
	<20170719121628.GI2103@work-vm>
	<20170719124147.GH2757@localhost.localdomain>
	<f870ca6c-a8fb-a88c-f171-a66f4158671d@redhat.com>
	<20170719150758.GK30084@redhat.com>
	<4558ee82-0214-cd91-1de9-8081b98ddb0b@redhat.com>
	<20170719183224.GI2757@localhost.localdomain>
	<20170719191748.GN3500@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170719191748.GN3500@work-vm>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: allow cpu index for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, wang.yi59@zte.com.cn, liu.yunh@zte.com.cn, qemu-devel@nongnu.org, "libvir-list@redhat.com" <libvir-list@redhat.com>, pbonzini@redhat.com, Liu.Jianjun3@zte.com.cn, rth@twiddle.net

On Wed, Jul 19, 2017 at 08:17:49PM +0100, Dr. David Alan Gilbert wrote:
> * Eduardo Habkost (ehabkost@redhat.com) wrote:
> > On Wed, Jul 19, 2017 at 10:17:36AM -0500, Eric Blake wrote:
> > > On 07/19/2017 10:07 AM, Daniel P. Berrange wrote:
> > > >> It doesn't.  Perhaps we should add that as a future libvirt-qemu.so API
> > > >> addition, although it's probably easier to just use QMP than HMP when
> > > >> using 'virsh qemu-monitor-command' if HMP doesn't do what you want.
> > > > 
> > > > Or special case the "cpu 1" command - ie notice that it is being
> > > > requested and don't execute 'human-montor-command'. Instead just
> > > > record the CPU index, and use that for future "human-monitor-command"
> > > > invokations, so we get full compat with the (dubious) stateful HMP
> > > > semantics that traditionally existed.
> > > 
> > > Is 'cpu' (and the followup commands affected by it) the only stateful
> > > HMP command pairing?  Is there a way to specify multiple HMP commands in
> > > a single human-monitor-command QMP call?
> > > 
> > > Indeed, tweaking qemu's human-monitor-command call to track the state
> > > might be cleaner than having libvirt have to tweak API to work around
> > > this wart of HMP.
> > 
> > The CPU index was the only state kept by the human monitor, and I
> > think it's by design that it stopped being considered "monitor
> > state" to be tracked, and became just an argument to
> > human-monitor-command.
> > 
> > It's true that it broke compatibility of
> >   "virsh qemu-monitor-command <domain> --hmp 'cpu <n>'",
> > when we moved to QMP, but this happened years ago, and it looks
> > like nobody was relying on it.  I don't see the point of trying
> > to emulate the previous stateful interface.
> 
> IMHO Yi's fix (once reworked) is the right fix - it removes the
> use of that piece of state, when the optional parameter is used.
> (OK, so it needs rework not to change that state and to
> come to some agreement as to what to use instead of cpu index number
> etc).

Agreed, as it helps us to keep the "virsh qemu-monitor-command"
interface simpler.  But we have 8 commands that use
mon_get_cpu(), we shouldn't fix only "info lapic".

-- 
Eduardo
