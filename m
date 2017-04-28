Received: from eggs.gnu.org ([2001:4830:134:3::10]:53708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d47On-0003Ze-61
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d47Oi-0008AE-Vx
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:01:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-4-eblake@redhat.com>
Date: Fri, 28 Apr 2017 17:01:12 +0200
In-Reply-To: <20170428021317.24711-4-eblake@redhat.com> (Eric Blake's message
	of "Thu, 27 Apr 2017 21:13:16 -0500")
Message-ID: <87h918bmpz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 3/4] shutdown: Add source information to
 SHUTDOWN and RESET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, Yongbok Kim <yongbok.kim@imgtec.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, "open list:Block layer core" <qemu-block@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, alistair.francis@xilinx.com, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Igor Mammedov <imammedo@redhat.com>, Cornelia Hu ck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, "open list:Old World" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Eric Blake <eblake@redhat.com> writes:

> Libvirt would like to be able to distinguish between a SHUTDOWN
> event triggered solely by guest request and one triggered by a
> SIGTERM or other action on the host.  While qemu_kill_report() is
> already able to tell whether a shutdown was triggered by a host
> signal (but NOT by a host UI event, such as clicking the X on
> the window), that information was then lost after being printed
> to stderr.  The previous patch prepped things to use an enum
> internally; now it's time to wire it up through all callers, and
> to extend the SHUTDOWN and RESET events to report the details.
>
> Enhance the shutdown request path to take a parameter of which
> way it is being triggered, and update ALL callers.  It would have
> been less churn to keep the common case with no arguments as
> meaning guest-triggered, and only modified the host-triggered
> code paths, via a wrapper function, but then we'd still have to
> audit that I didn't miss any host-triggered spots; changing the
> signature forces us to double-check that I correctly categorized
> all callers.
>
> Since command line options can change whether a guest reset request
> causes an actual reset vs. a shutdown, it's easy to also add the
> information to the RESET event, even though libvirt has not yet
> expressed a need to know that.
>
> For the moment, we keep the enum ShutdownCause for internal use
> only, and merely expose a single boolean of 'guest':true|false
> to the QMP client; this is because we don't yet have evidence that
> the further distinctions will be useful, or whether the addition
> of new enum members would cause problems to clients coded to an
> older version of the enum.
>
> Update expected iotest outputs to match the new data.
>
> Here is output from 'virsh qemu-monitor-event --loop' with the
> patch installed:
>
> event SHUTDOWN at 1492639680.731251 for domain fedora_13: {"guest":true}
> event STOP at 1492639680.732116 for domain fedora_13: <null>
> event SHUTDOWN at 1492639680.732830 for domain fedora_13: {"guest":false}
>
> Note that libvirt runs qemu with -no-quit: the first SHUTDOWN event
> was triggered by an action I took directly in the guest (shutdown -h),
> at which point qemu stops the vcpus and waits for libvirt to do any
> final cleanups; the second SHUTDOWN event is the result of libvirt
> sending SIGTERM now that it has completed cleanup.
>
> The replay driver needs a followup patch if we want to be able to
> faithfully replay the difference between a host- and guest-initiated
> shutdown (for now, the replayed event is always attributed to host).

I'd prefer to get this right from the start, but that requires input
from replay guys.

Scandalously, replay/ is not covered by MAINTAINERS.
scripts/get_maintainers.pl blames it on Pavel Dovgalyuk (cc'ed), and git
shows recent activity.  Pavel, please post a suitable patch to
MAINTAINERS, and please help us figure out what to do about replaying
reset here.

> See also https://bugzilla.redhat.com/1384007
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
