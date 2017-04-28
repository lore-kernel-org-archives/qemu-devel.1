Received: from eggs.gnu.org ([2001:4830:134:3::10]:49216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d479A-0006KJ-GH
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d4797-0008Gl-CB
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:45:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d4797-0008Fg-3H
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:45:21 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-3-eblake@redhat.com>
	<20170428080821.GB2085@work-vm>
Date: Fri, 28 Apr 2017 16:45:14 +0200
In-Reply-To: <20170428080821.GB2085@work-vm> (David Alan Gilbert's message of
	"Fri, 28 Apr 2017 09:08:22 +0100")
Message-ID: <87o9vgbngl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 2/4] shutdown: Prepare for use of an
 enum in reset/shutdown_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, alistair.francis@xilinx.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Eric Blake (eblake@redhat.com) wrote:
>> We want to track why a guest was shutdown; in particular, being able
>> to tell the difference between a guest request (such as ACPI request)
>> and host request (such as SIGINT) will prove useful to libvirt.
>> Since all requests eventually end up changing shutdown_requested in
>> vl.c, the logical change is to make that value track the reason,
>> rather than its current 0/1 contents.
>> 
>> Since command-line options control whether a reset request is turned
>> into a shutdown request instead, the same treatment is given to
>> reset_requested.
>> 
>> This patch adds a QAPI enum ShutdownCause that describes reasons
>> that a shutdown can be requested, and changes qemu_system_reset() to
>> pass the reason through, although for now it is not reported.  The
>> next patch will actually wire things up to modify events to report
>> data based on the reason, and to pass the correct enum value in from
>> various call-sites that can trigger a reset/shutdown.  Since QAPI
>> generates enums starting at 0, it's easier if we use a different
>> number as our sentinel that no request has happened yet.  Most of
>> the changes are in vl.c, but xen was using things externally.
>> 
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> 
>> ---
>> v4: s/ShutdownType/ShutdownCause/, no thanks to mingw header pollution
>> v3: new patch
>> ---
>>  qapi-schema.json        | 23 +++++++++++++++++++++++
>>  include/sysemu/sysemu.h |  2 +-
>>  vl.c                    | 44 ++++++++++++++++++++++++++++----------------
>>  hw/i386/xen/xen-hvm.c   |  9 ++++++---
>>  migration/colo.c        |  2 +-
>>  migration/savevm.c      |  2 +-
>>  6 files changed, 60 insertions(+), 22 deletions(-)
>> 
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 01b087f..a4ebdd1 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -2304,6 +2304,29 @@
>>  { 'command': 'system_powerdown' }
>> 
>>  ##
>> +# @ShutdownCause:
>> +#
>> +# Enumeration of various causes for shutdown.
>> +#
>> +# @host-qmp: Reaction to a QMP command, such as 'quit'
>> +# @host-signal: Reaction to a signal, such as SIGINT
>> +# @host-ui: Reaction to a UI event, such as closing the window
>> +# @host-replay: The host is replaying an earlier shutdown event
>> +# @host-error: Qemu encountered an error that prevents further use of the guest
>> +# @guest-shutdown: The guest requested a shutdown, such as via ACPI or
>> +#                  other hardware-specific action
>> +# @guest-reset: The guest requested a reset, and the command line
>> +#               response to a reset is to instead trigger a shutdown
>> +# @guest-panic: The guest panicked, and the command line response to
>> +#               a panic is to trigger a shutdown
>
> It's a little coarse grained;  is there anyway to pass platform specific information
> for debug?  I ask because I spent a while debugging a few bugs with unexpected
> resets and had to figure out which of x86's many reset causes triggered it.

Asking for more help with debugging is fair, but I think the need is
better served by tracepoints than by exposing even more detail in QMP,
where compatibility promises apply.
