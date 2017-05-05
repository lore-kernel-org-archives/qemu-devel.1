Received: from eggs.gnu.org ([2001:4830:134:3::10]:55871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d6Yjy-0003U7-E4
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d6Yjv-0004YZ-7Q
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:37:30 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42865
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d6Yju-0004OC-W9
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:37:27 -0400
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-4-eblake@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1fb98d19-fb1d-831f-7eb1-cabcc15b3884@ilande.co.uk>
Date: Fri, 5 May 2017 09:36:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170428021317.24711-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel <qemu-devel@nongnu.org>

On 28/04/17 03:13, Eric Blake wrote:

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
> 
> See also https://bugzilla.redhat.com/1384007
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

For the SPARC part:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
