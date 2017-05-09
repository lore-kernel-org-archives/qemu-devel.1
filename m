Received: from eggs.gnu.org ([2001:4830:134:3::10]:39833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d83vy-0000X5-Vw
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d83vu-0006zq-9q
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:08:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170508211953.28017-1-eblake@redhat.com>
	<20170508211953.28017-6-eblake@redhat.com>
Date: Tue, 09 May 2017 14:07:53 +0200
In-Reply-To: <20170508211953.28017-6-eblake@redhat.com> (Eric Blake's message
	of "Mon, 8 May 2017 16:19:53 -0500")
Message-ID: <87a86mp71i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 5/5] shutdown: Expose bool cause in
 SHUTDOWN and RESET events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, alistair.francis@xilinx.com

Eric Blake <eblake@redhat.com> writes:

> Libvirt would like to be able to distinguish between a SHUTDOWN
> event triggered solely by guest request and one triggered by a
> SIGTERM or other action on the host.  While qemu_kill_report() was
> already able to give different output to stderr based on whether a
> shutdown was triggered by a host signal (but NOT by a host UI event,
> such as clicking the X on the window), that information was then
> lost to management.  The previous patches improved things to use an
> enum throughout all callsites, so now we have something ready to
> expose through QMP.
>
> Note that for now, the decision was to expose ONLY a boolean,
> rather than promoting ShutdownCause to a QAPI enum; this is because
> libvirt has not expressed an interest in anything finer-grained.
> We can still add additional details, in a backwards-compatible
> manner, if a need later arises (if the addition happens before 2.10,
> we can replace the bool with an enum; otherwise, the enum will have
> to be in addition to the bool).
>
> Update expected iotest outputs to match the new data (complete
> coverage of the affected tests is obtained by -raw, -qcow2, and -nbd).
>
> Here is output from 'virsh qemu-monitor-event --loop' with the
> patch installed:
>
> event SHUTDOWN at 1492639680.731251 for domain fedora_13: {"guest":true}
> event STOP at 1492639680.732116 for domain fedora_13: <null>
> event SHUTDOWN at 1492639680.732830 for domain fedora_13: {"guest":false}
>
> Note that libvirt runs qemu with -no-quit: the first SHUTDOWN event

Do you mean -no-shutdown?

> was triggered by an action I took directly in the guest (shutdown -h),
> at which point qemu stops the vcpus and waits for libvirt to do any
> final cleanups; the second SHUTDOWN event is the result of libvirt
> sending SIGTERM now that it has completed cleanup.

The double shutdown is a bit weird.  To avoid it, we'd have to
distinguish between guest shutdown and QEMU termination.  shutdown -h in
the guest triggers termination only when QEMU is configured that way.
SIGTERM triggers shutdown only when the guest is running.  The result
would be neater, but I'm not sure it's worth the extra effort.

> See also https://bugzilla.redhat.com/1384007
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v7: rebase to context
> v6: split out from 'shutdown: Add source information to SHUTDOWN and RESET'
> ---
>  qapi/event.json            | 17 +++++++++++++----
>  vl.c                       |  8 ++++----
>  tests/qemu-iotests/071.out |  4 ++--
>  tests/qemu-iotests/081.out |  2 +-
>  tests/qemu-iotests/087.out | 12 ++++++------
>  tests/qemu-iotests/094.out |  2 +-
>  tests/qemu-iotests/117.out |  2 +-
>  tests/qemu-iotests/119.out |  2 +-
>  tests/qemu-iotests/120.out |  2 +-
>  tests/qemu-iotests/140.out |  2 +-
>  tests/qemu-iotests/143.out |  2 +-
>  tests/qemu-iotests/156.out |  2 +-
>  12 files changed, 33 insertions(+), 24 deletions(-)
>
> diff --git a/qapi/event.json b/qapi/event.json
> index e80f3f4..6d22b02 100644
> --- a/qapi/event.json
> +++ b/qapi/event.json
> @@ -10,6 +10,10 @@
>  # Emitted when the virtual machine has shut down, indicating that qemu is
>  # about to exit.
>  #
> +# @guest: If true, the shutdown was triggered by a guest request (such as
> +# a guest-initiated ACPI shutdown request or other hardware-specific action)
> +# rather than a host request (such as sending qemu a SIGINT). (since 2.10)
> +#
>  # Note: If the command-line option "-no-shutdown" has been specified, qemu will
>  # not exit, and a STOP event will eventually follow the SHUTDOWN event
>  #
> @@ -17,11 +21,11 @@
>  #
>  # Example:
>  #
> -# <- { "event": "SHUTDOWN",
> +# <- { "event": "SHUTDOWN", "data": { "guest": true },
>  #      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
>  #
>  ##
> -{ 'event': 'SHUTDOWN' }
> +{ 'event': 'SHUTDOWN', 'data': { 'guest': 'bool' } }
>
>  ##
>  # @POWERDOWN:
> @@ -44,15 +48,20 @@
>  #
>  # Emitted when the virtual machine is reset
>  #
> +# @guest: If true, the reset was triggered by a guest request (such as
> +# a guest-initiated ACPI reboot request or other hardware-specific action)
> +# rather than a host request (such as the QMP command system_reset).
> +# (since 2.10)
> +#
>  # Since: 0.12.0
>  #
>  # Example:
>  #
> -# <- { "event": "RESET",
> +# <- { "event": "RESET", "data": { "guest": false },
>  #      "timestamp": { "seconds": 1267041653, "microseconds": 9518 } }
>  #
>  ##
> -{ 'event': 'RESET' }
> +{ 'event': 'RESET', 'data': { 'guest': 'bool' } }
>
>  ##
>  # @STOP:
> diff --git a/vl.c b/vl.c
> index 65487d9..5fd0e8f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1705,8 +1705,8 @@ void qemu_system_reset(ShutdownCause reason)
>          qemu_devices_reset();
>      }
>      if (reason) {
> -        /* FIXME update event based on reason */
> -        qapi_event_send_reset(&error_abort);
> +        qapi_event_send_reset(reason >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN,
> +                              &error_abort);

Exploits enum ordering.  A comment in the enum definition warning not to
reorder its members would be in order.  Defining a suitable predicate
right next to it would do, too.

>      }
>      cpu_synchronize_all_post_reset();
>  }
> @@ -1863,8 +1863,8 @@ static bool main_loop_should_exit(void)
>      request = qemu_shutdown_requested();
>      if (request) {
>          qemu_kill_report();
> -        /* FIXME update event based on request */
> -        qapi_event_send_shutdown(&error_abort);
> +        qapi_event_send_shutdown(request >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN,
> +                                 &error_abort);
>          if (no_shutdown) {
>              vm_stop(RUN_STATE_SHUTDOWN);
>          } else {
[...]

With at least the -no-quit in the commit message fixed (assuming it
needs fixing):

Reviewed-by: Markus Armbruster <armbru@redhat.com>
