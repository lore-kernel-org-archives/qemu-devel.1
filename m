Received: from eggs.gnu.org ([209.51.188.92]:59132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzkpb-0003DV-RW
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzkpZ-000079-Ud
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:16:15 -0500
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:39796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzkpZ-00005D-Nk
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:16:13 -0500
Received: from player787.ha.ovh.net (unknown [10.109.146.20])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 3ECAD4659F
	for <qemu-devel@nongnu.org>; Fri,  1 Mar 2019 17:16:11 +0100 (CET)
Date: Fri, 1 Mar 2019 17:16:02 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190301171602.3f8fce74@bahia.lan>
In-Reply-To: <70418309-8593-44be-0549-8531a9ccaa2e@redhat.com>
References: <155144987334.126105.2493613675615671242.stgit@bahia.lan>
	<70418309-8593-44be-0549-8531a9ccaa2e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: Explicitly check machine support
 before using EVENT_CLASS_HOT_PLUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Fri, 1 Mar 2019 16:24:48 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 01/03/2019 15.17, Greg Kurz wrote:
> > Recent commit b8165118f52c "spapr: support memory unplug for qtest" broke
> > CPU hotplug tests for old machine types:
> > 
> > $ QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 ./tests/cpu-plug-test -m=slow
> > /ppc64/cpu-plug/pseries-3.1/device-add/2x3x1&maxcpus=6: OK
> > /ppc64/cpu-plug/pseries-2.12-sxxm/device-add/2x3x1&maxcpus=6: OK
> > /ppc64/cpu-plug/pseries-3.0/device-add/2x3x1&maxcpus=6: OK
> > /ppc64/cpu-plug/pseries-2.10/device-add/2x3x1&maxcpus=6: OK
> > /ppc64/cpu-plug/pseries-2.11/device-add/2x3x1&maxcpus=6: OK
> > /ppc64/cpu-plug/pseries-2.12/device-add/2x3x1&maxcpus=6: OK
> > /ppc64/cpu-plug/pseries-2.9/device-add/2x3x1&maxcpus=6: OK
> > /ppc64/cpu-plug/pseries-2.7/device-add/2x3x1&maxcpus=6: **
> > ERROR:/home/thuth/devel/qemu/hw/ppc/spapr_events.c:313:rtas_event_log_to_source: assertion failed: (source->enabled)
> > Broken pipe
> > /home/thuth/devel/qemu/tests/libqtest.c:143: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> > Aborted (core dumped)
> > 
> > The rtas_event_log_to_source() function is supposed to return the event
> > source to be used for a given event type. In the case of hotplug, it first
> > tries EVENT_CLASS_HOT_PLUG and, if the guest doesn't support it, it falls
> > back to EVENT_CLASS_EPOW.
> > 
> > This works well for machine types that enable EVENT_CLASS_HOT_PLUG. For
> > older machine types, this happened to work because they don't set the
> > OV5_HP_EVT bit in spapr->ov5. CAS hence logically keeps the bit cleared
> > in spapr->ov5_cas and we avoid the assert.
> > 
> > As shown by commit b8165118f52c, the logic is fragile and we need a
> > bigger hammer to ensure that rtas_event_log_to_source() doesn't go
> > down the EVENT_CLASS_HOT_PLUG path with older machine types.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr_events.c |   12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)  
> 
> Thanks, that fixes the problem for me!
> 
> Tested-by: Thomas Huth <thuth@redhat.com>

I realize I should have put this also:

Reported-by: Thomas Huth <thuth@redhat.com>

Cheers,

--
Greg
