Received: from eggs.gnu.org ([2001:4830:134:3::10]:51872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dNzuG-0006pe-Ow
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dNzuD-00006c-KS
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:04:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dNzuD-00006O-BC
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:04:09 -0400
Date: Thu, 22 Jun 2017 12:04:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170622110402.GB2100@work-vm>
References: <CAFEAcA90vjbr=CM9i9m7-PdN0NB=MV8W0+wsG9UrNNR+KENsmA@mail.gmail.com>
	<d947c58b-d388-c432-0f40-b019af88c60a@redhat.com>
	<CAFEAcA8j2t+TTpqRRMxG489=gaxi_otgMKjw3TZEEhAiHz66+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8j2t+TTpqRRMxG489=gaxi_otgMKjw3TZEEhAiHz66+g@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu_chr_fe_add_watch interaction with VM
 start/stop/migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 22 June 2017 at 11:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> >
> > On 22/06/2017 12:09, Peter Maydell wrote:
> >> For instance, suppose my UART tries to write to the chardev but
> >> can't, so it registers a callback with qemu_chr_fe_add_watch().
> >> Then the user stops the VM. Does the chardev UI guarantee that
> >> my callback won't get called until the user restarts the VM,
> >> or does my callback function have to do something to say "don't
> >> actually update the emulation state if we're stopped"?
> >> If the user then restarts the VM, do I need to do something to
> >> retry the chardev write?
> >
> > Currently, chardev code runs normally between stop and start.
> 
> I think that's rather counterintuitive -- as a user, if I've
> stopped the VM I don't expect any of its device state to change.
> Stopped should mean "simulation state doesn't change".

Yes and stuff breaks unless you're very careful (e.g. a23a6d18)
- make sure you don't change RAM state when the guest is stopped
and you should at least survive migration.

> >> For migration, if we're migrating in the state where I have a
> >> pending character I'd like to write to the chardev, what do I need
> >> to do on the destination side? Do I need to call qemu_chr_fe_add_watch
> >> in the post-load function, or is this too early and I need to do
> >> something to call it when the destination VM is actually restarted?
> >
> > Post-load is fine.  There could be interesting interactions with
> > interrupts, but these are not specific to character device backends
> > (real-time clocks are another example).  So boards should create
> > interrupt controllers and distributors as soon as possible.
> 
> This sounds wrong to me -- nobody should be asserting an
> interrupt line during post-load, in the same way that nobody
> should assert an interrupt line during reset. We don't have
> any guarantees that the device on the other end of the line
> has finished migration yet.

I remember someone added something to impose an order to get interrupt
controllers loaded before PCI devices etc - I thought it was ARM interrupt
controller related but I can't find it.

But yes, we've had bugs associated with this type of misordering
in the past;  they're normally terrible to debug because
they can depend on timing, especially if the thing that's
loaded in the post-load starts a timer and the issue is whether
the timer fires before or after the other devices or loaded
and or before the VM starts running. (Replace 'timer' with
'chardev' and 'fires' with 'a character is received)

> I think we really need the
> chardev backends to not start doing things until load has
> finished and the VM has been restarted. (If we make "VM
> stopped" mean "no chardev callbacks" then this would fall
> out in the wash, though, since the callback registered in
> post-load would only trigger on the following VM start.)

That depends on what the chardev is doing;
if it's a chardev to a monitor or something not directly
updating guest state then you'd probably want it to start.
What about chardev's for networking stuff?

Dave

> thanks
> -- PMM
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
