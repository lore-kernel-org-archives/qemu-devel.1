Received: from eggs.gnu.org ([2001:4830:134:3::10]:47086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNzVj-0004Jz-0u
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNzVi-0003Gw-3I
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:38:51 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNzVh-0003Gn-Su
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:38:50 -0400
Received: by mail-wr0-x236.google.com with SMTP id r103so17614927wrb.0
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 03:38:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d947c58b-d388-c432-0f40-b019af88c60a@redhat.com>
References: <CAFEAcA90vjbr=CM9i9m7-PdN0NB=MV8W0+wsG9UrNNR+KENsmA@mail.gmail.com>
	<d947c58b-d388-c432-0f40-b019af88c60a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 11:38:28 +0100
Message-ID: <CAFEAcA8j2t+TTpqRRMxG489=gaxi_otgMKjw3TZEEhAiHz66+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 22 June 2017 at 11:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 22/06/2017 12:09, Peter Maydell wrote:
>> For instance, suppose my UART tries to write to the chardev but
>> can't, so it registers a callback with qemu_chr_fe_add_watch().
>> Then the user stops the VM. Does the chardev UI guarantee that
>> my callback won't get called until the user restarts the VM,
>> or does my callback function have to do something to say "don't
>> actually update the emulation state if we're stopped"?
>> If the user then restarts the VM, do I need to do something to
>> retry the chardev write?
>
> Currently, chardev code runs normally between stop and start.

I think that's rather counterintuitive -- as a user, if I've
stopped the VM I don't expect any of its device state to change.
Stopped should mean "simulation state doesn't change".

>> For migration, if we're migrating in the state where I have a
>> pending character I'd like to write to the chardev, what do I need
>> to do on the destination side? Do I need to call qemu_chr_fe_add_watch
>> in the post-load function, or is this too early and I need to do
>> something to call it when the destination VM is actually restarted?
>
> Post-load is fine.  There could be interesting interactions with
> interrupts, but these are not specific to character device backends
> (real-time clocks are another example).  So boards should create
> interrupt controllers and distributors as soon as possible.

This sounds wrong to me -- nobody should be asserting an
interrupt line during post-load, in the same way that nobody
should assert an interrupt line during reset. We don't have
any guarantees that the device on the other end of the line
has finished migration yet. I think we really need the
chardev backends to not start doing things until load has
finished and the VM has been restarted. (If we make "VM
stopped" mean "no chardev callbacks" then this would fall
out in the wash, though, since the callback registered in
post-load would only trigger on the following VM start.)

thanks
-- PMM
