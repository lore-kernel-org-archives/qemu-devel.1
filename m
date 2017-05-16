Received: from eggs.gnu.org ([2001:4830:134:3::10]:34598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAY24-0003QT-Ji
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAY21-0000UF-6V
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:40:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAY20-0000Tw-Tw
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:40:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170515214114.15442-1-eblake@redhat.com>
	<20170515214114.15442-3-eblake@redhat.com>
Date: Tue, 16 May 2017 10:40:04 +0200
In-Reply-To: <20170515214114.15442-3-eblake@redhat.com> (Eric Blake's message
	of "Mon, 15 May 2017 16:41:11 -0500")
Message-ID: <877f1hgpp7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 2/5] shutdown: Prepare for use of an
 enum in reset/shutdown_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, alistair.francis@xilinx.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

Eric Blake <eblake@redhat.com> writes:

> We want to track why a guest was shutdown; in particular, being able
> to tell the difference between a guest request (such as ACPI request)
> and host request (such as SIGINT) will prove useful to libvirt.
> Since all requests eventually end up changing shutdown_requested in
> vl.c, the logical change is to make that value track the reason,
> rather than its current 0/1 contents.
>
> Since command-line options control whether a reset request is turned
> into a shutdown request instead, the same treatment is given to
> reset_requested.
>
> This patch adds an internal enum ShutdownCause that describes reasons
> that a shutdown can be requested, and changes qemu_system_reset() to
> pass the reason through, although for now nothing is actually changed
> with regards to what gets reported.  The enum could be exported via
> QAPI at a later date, if deemed necessary, but for now, there has not
> been a request to expose that much detail to end clients.
>
> For the most part, we turn 0 into SHUTDOWN_CAUSE_NONE, and 1 into
> SHUTDOWN_CAUSE_HOST_ERROR; the only specific case where we have enough
> information right now to use a different value is when we are reacting
> to a host signal.  It will take a further patch to edit all call-sites
> that can trigger a reset or shutdown request to properly pass in any
> other reasons; this patch includes TODOs to point such places out.
>
> qemu_system_reset() trades its 'bool report' parameter for a
> 'ShutdownCause reason', with all non-zero values having the same
> effect; this lets us get rid of the weird #defines for VMRESET_*
> as synonyms for bools.

This paragraph could perhaps be merged with the other one on
qemu_system_reset(), but it's not worth a respin.

>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v9: one more stray FIXME
> v8: s/FIXME/TODO/, include SHUTDOWN_CAUSE__MAX now rather than later,
> tweak comment on GUEST_SHUTDOWN to mention suspend
> v7: drop 'bool report' from qemu_system_reset(), reorder enum to put
> HOST_ERROR == 1, improve commit message
> v6: make ShutdownCause internal-only, add SHUTDOWN_CAUSE_NONE so that
> comparison to 0 still works, tweak initial FIXME values
> v5: no change
> v4: s/ShutdownType/ShutdownCause/, no thanks to mingw header pollution
> v3: new patch
> ---
>  include/sysemu/sysemu.h | 23 ++++++++++++++++-----
>  vl.c                    | 53 ++++++++++++++++++++++++++++++-------------------
>  hw/i386/xen/xen-hvm.c   |  7 +++++--
>  migration/colo.c        |  2 +-
>  migration/savevm.c      |  2 +-
>  5 files changed, 58 insertions(+), 29 deletions(-)
>
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 15656b7..52102fd 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -33,8 +33,21 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
>  void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
>  void vm_state_notify(int running, RunState state);
>
> -#define VMRESET_SILENT   false
> -#define VMRESET_REPORT   true
> +/* Enumeration of various causes for shutdown. */
> +typedef enum ShutdownCause {
> +    SHUTDOWN_CAUSE_NONE,          /* No shutdown request pending */
> +    SHUTDOWN_CAUSE_HOST_ERROR,    /* An error prevents further use of guest */
> +    SHUTDOWN_CAUSE_HOST_QMP,      /* Reaction to a QMP command, like 'quit' */
> +    SHUTDOWN_CAUSE_HOST_SIGNAL,   /* Reaction to a signal, such as SIGINT */
> +    SHUTDOWN_CAUSE_HOST_UI,       /* Reaction to UI event, like window close */
> +    SHUTDOWN_CAUSE_GUEST_SHUTDOWN,/* Guest shutdown/suspend request, via
> +                                     ACPI or other hardware-specific means */
> +    SHUTDOWN_CAUSE_GUEST_RESET,   /* Guest reset request, and command line
> +                                     turns that into a shutdown */
> +    SHUTDOWN_CAUSE_GUEST_PANIC,   /* Guest panicked, and command line turns
> +                                     that into a shutdown */
> +    SHUTDOWN_CAUSE__MAX,

The __ is a bit odd for handwritten code, but it matches QAPI-generated
code.  Okay.

> +} ShutdownCause;
>
>  void vm_start(void);
>  int vm_prepare_start(void);

Reviewed-by: Markus Armbruster <armbru@redhat.com>
