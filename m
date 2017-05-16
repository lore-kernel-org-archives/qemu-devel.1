Received: from eggs.gnu.org ([2001:4830:134:3::10]:37161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAYAu-0006X6-1r
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAYAt-0003f6-0V
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:49:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170515214114.15442-1-eblake@redhat.com>
	<20170515214114.15442-6-eblake@redhat.com>
Date: Tue, 16 May 2017 10:49:23 +0200
In-Reply-To: <20170515214114.15442-6-eblake@redhat.com> (Eric Blake's message
	of "Mon, 15 May 2017 16:41:14 -0500")
Message-ID: <87tw4lfap8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 5/5] shutdown: Expose bool cause in
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
> to be in addition to the bool); this patch merely adds a helper
> shutdown_caused_by_guest() to map the internal enum into the
> external boolean.
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
> Note that libvirt runs qemu with -no-shutdown: the first SHUTDOWN event
> was triggered by an action I took directly in the guest (shutdown -h),
> at which point qemu stops the vcpus and waits for libvirt to do any
> final cleanups; the second SHUTDOWN event is the result of libvirt
> sending SIGTERM now that it has completed cleanup.  Libvirt is already
> smart enough to only feed the first qemu SHUTDOWN event to the end user
> (remember, virsh qemu-monitor-event is a low-level debugging interface
> that is explicitly unsupported by libvirt, so it sees things that normal
> end users do not); changing qemu to emit SHUTDOWN only once is outside
> the scope of this series.
>
> See also https://bugzilla.redhat.com/1384007
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
