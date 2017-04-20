Received: from eggs.gnu.org ([2001:4830:134:3::10]:51563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d1Kzh-00006U-8u
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 18:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d1Kzf-0006AY-TZ
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 18:56:09 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <53bc367e-df07-be34-25c5-dbf0b3ee174e@redhat.com>
References: <20170419222258.13415-1-eblake@redhat.com>
	<87k26fffxa.fsf@dusky.pond.sub.org>
	<1adf2797-b86a-00be-bb98-658ee8d0a55d@redhat.com>
	<87lgqv833h.fsf@dusky.pond.sub.org>
	<53bc367e-df07-be34-25c5-dbf0b3ee174e@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 20 Apr 2017 15:55:35 -0700
Message-ID: <CAKmqyKNftan_4zYRsNyOPG-PkM+iYKDxUC5_950pZyfrYSK3Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] event: Add source information to
 SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Scott Wood <scottwood@freescale.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair.francis@xilinx.com>, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, "open list:New World" <qemu-ppc@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On Thu, Apr 20, 2017 at 12:05 PM, Eric Blake <eblake@redhat.com> wrote:
> On 04/20/2017 11:18 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 04/20/2017 06:59 AM, Markus Armbruster wrote:
>>>
>>>>
>>>> No objection to Alistair's idea to turn this into an enumeration.
>>>
>>> Question - should the enum be more than just 'guest' and 'host'?  For
>>> example, my patch proves that we have a lot of places that handle
>>> complimentary machine commands to reset and shutdown, and that whether
>>> 'reset' triggers a reset (and the guest keeps running as if rebooted) or
>>> a shutdown is then based on the command-line arguments given to qemu.
>>> So having the enum differentiate between 'guest-reset' and
>>> 'guest-shutdown' would be a possibility, if we want the enum to have
>>> additional states.
>>
>> I don't know.  What I do know is that we better get the enum right:
>> while adding members is backwards-compatible, changing the member sent
>> for a specific trigger is not.  If we want to reserve the option to do
>> that anyway, we need suitable documentation.
>
> Or even this idea:
>
> { 'enum': 'ShutdownCause', 'data': [ 'shutdown', 'reset', 'panic' ] }
> { 'event': 'SHUTDOWN',
>   'data': { 'guest': 'bool', '*cause': 'ShutdownCause' } }
>
> where the enum can grow as we come up with ever more reasons worth
> exposing (maybe even 'qmp', 'gui' and 'interrupt' are reasonable causes
> for a host shutdown).  Our promise would be that 'guest' never changes
> for an existing shutdown reason, but that 'cause' may become more
> refined over time if someone expresses a need for having the distinction.
>
> Thoughts?

I'm not a fan of the 'guest' bool. I do see that it helps with
maintaining backwards compatibility but I think we would be better off
just getting the reasons right in the first place.

What about something that can grow in the future? We start with a
general guest shutdown that is always there and then as we add new
reasons things can be moved to use the new method or continue to use
the general one.

SHUTDOWN_HOST
SHUTDOWN_HOST_GUI
/* This is always a backwards compatible fall-back
 * Maybe this could be SHUTDOWN_GUEST_UNKNOWN instead?
 */
SHUTDOWN_GUEST_GENERAL
SHUTDOWN_GUEST_HALT
SHUTDOWN_GUEST_RESET
...

That way we can guarantee the base coverage but still expand more
specific reasons in the future.

I guess the only problem is that then the reasons aren't always
reliable then as we could introduce a new reason and something gets
stuck using the general fall back.

Thanks,

Alistair

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
