Received: from eggs.gnu.org ([2001:4830:134:3::10]:59646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8Sqq-0000kj-Q3
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8Sqp-0006wT-V2
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:44:28 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170508211953.28017-1-eblake@redhat.com>
	<20170508211953.28017-4-eblake@redhat.com>
	<87inlap7k1.fsf@dusky.pond.sub.org>
	<81782139-d66d-72d4-c228-9dd9073a33b9@redhat.com>
Date: Wed, 10 May 2017 16:44:12 +0200
In-Reply-To: <81782139-d66d-72d4-c228-9dd9073a33b9@redhat.com> (Eric Blake's
	message of "Tue, 9 May 2017 09:07:26 -0500")
Message-ID: <87fugcwz43.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 3/5] shutdown: Add source information to
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, alistair.francis@xilinx.com, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>, Paul Burton <paul.burton@imgtec.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, "open list:Old World" <qemu-ppc@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Eric Blake <eblake@redhat.com> writes:

> On 05/09/2017 06:56 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> Time to wire up all the call sites that request a shutdown or
>>> reset to use the enum added in the previous patch.
>>>
>>> It would have been less churn to keep the common case with no
>>> arguments as meaning guest-triggered, and only modified the
>>> host-triggered code paths, via a wrapper function, but then we'd
>>> still have to audit that I didn't miss any host-triggered spots;
>>> changing the signature forces us to double-check that I correctly
>>> categorized all callers.
>>>
>>> Since command line options can change whether a guest reset request
>>> causes an actual reset vs. a shutdown, it's easy to also add the
>>> information to reset requests.
>>>
>>> Replay adds a FIXME to preserve the cause across the replay stream,
>>> that will be tackled in the next patch.
>>>
>
>>> @@ -569,7 +569,7 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
>>>          default:
>>>              if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
>>>                  qapi_event_send_suspend_disk(&error_abort);
>>> -                qemu_system_shutdown_request();
>>> +                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>> 
>> I'm fine with using SHUTDOWN_CAUSE_GUEST_SHUTDOWN for suspend, but have
>> you considered SHUTDOWN_CAUSE_GUEST_SUSPEND?
>
> It was easy to do
> s/qemu_system_shutdown_request()/qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN)/
> for all hw/ files.  Harder would be picking a difference between
> _SHUTDOWN and a new _SUSPEND. I can do it if hardware owners want the
> distinction; but remember that this series will intentionally NOT expose
> that distinction to QMP, so I don't know how much it will buy us.

Understand.  What about clarifying SHUTDOWN_CAUSE_GUEST_SHUTDOWN's
comment

    /* Guest requested shutdown, such as via
       ACPI or other hardware-specific means */

by adding something like "(including suspend)"?  Can do on commit, we
just have to agree on a specific working.

[...]
