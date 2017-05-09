Received: from eggs.gnu.org ([2001:4830:134:3::10]:60920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d83VZ-0002c9-L0
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d83VT-0004zE-PV
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:40:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d83VT-0004y7-GI
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:40:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170508211953.28017-1-eblake@redhat.com>
	<20170508211953.28017-3-eblake@redhat.com>
Date: Tue, 09 May 2017 13:40:37 +0200
In-Reply-To: <20170508211953.28017-3-eblake@redhat.com> (Eric Blake's message
	of "Mon, 8 May 2017 16:19:50 -0500")
Message-ID: <87wp9qp8ay.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 2/5] shutdown: Prepare for use of an
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
> other reasons; this patch includes FIXMEs to point such places out.

If you need to respin the patch for some other reason, consider
replacing FIXME by TODO, because nothing's actually broken here.

>
> qemu_system_reset() trades its 'bool report' parameter for a
> 'ShutdownCause reason', with all non-zero values having the same
> effect; this lets us get rid of the weird #defines for VMRESET_*
> as synonyms for bools.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
