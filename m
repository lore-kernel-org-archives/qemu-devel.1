Received: from eggs.gnu.org ([2001:4830:134:3::10]:50782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwq7U-0001KE-2x
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwq7Q-00038B-5v
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:41:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwq7P-00037F-Vr
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:41:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18B0BC0587EF
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 13:41:46 +0000 (UTC)
Date: Tue, 26 Sep 2017 10:41:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170926134139.GM21016@localhost.localdomain>
References: <1504776162-31400-1-git-send-email-thuth@redhat.com>
	<20170921175650.GJ21016@localhost.localdomain>
	<1983cfd3-557a-c7ff-6fab-446efa6cf5d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1983cfd3-557a-c7ff-6fab-446efa6cf5d4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/core/qdev: Do not allow hot-plugging
 without hotplug controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Sep 26, 2017 at 12:05:47PM +0200, Thomas Huth wrote:
> On 21.09.2017 19:56, Eduardo Habkost wrote:
> > On Thu, Sep 07, 2017 at 11:22:42AM +0200, Thomas Huth wrote:
> >> qdev_unplug() bails out with an assertion if the user tries to device_del
> >> a hot-plugged device that does not have a hotplug controller. Unfortunately,
> >> our devices are all marked with hotpluggable = true by default (see the
> >> device_class_init() function in qdev.c), so it currently can happen that
> >> the user runs into this situation and QEMU gets terminated unexpectedly:
> >>
> >> $ qemu-system-aarch64 -M virt -nographic -nodefaults -monitor stdio -S
> >> QEMU 2.10.50 monitor - type 'help' for more information
> >> (qemu) device_add aux-to-i2c-bridge,id=x
> >> (qemu) device_del x
> >> **
> >> ERROR:qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
> >> Aborted (core dumped)
> >>
> >> Hotplugging devices without a hotplug controller does not make much sense,
> >> so we should disallow this during the device_add process already!
> >>
> >> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > 
> > I'm queueing this on machine-next.  We still want it even if we
> > apply the patch that changes TYPE_DEVICE to hotpluggable=false by
> > default, right?
> 
> OK, just to be sure: Please de-queue it again. As you already mentioned
> in another mail, there are situations where this does not work (e.g.
> when one hot-pluggable device wants to instantiate another hot-pluggable
> device internally).

I just dequeued it.

> 
> But maybe we could add the test for the availability of a hot-plug
> controller to qmp_device_add() instead? (I haven't had a closer look at
> that yet, though).

I'm unsure about this.  Now we know we have some devices that
work without a hotplug controller, so what's the reason
device_add must always require one?

-- 
Eduardo
