Received: from eggs.gnu.org ([2001:4830:134:3::10]:48899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eC4go-00045B-6r
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eC4gk-00027W-Js
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:17:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eC4gk-000278-D8
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:17:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3723F4AFC
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 14:17:13 +0000 (UTC)
Date: Tue, 7 Nov 2017 15:17:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171107151705.34ae33a7.cohuck@redhat.com>
In-Reply-To: <1509617407-21191-3-git-send-email-thuth@redhat.com>
References: <1509617407-21191-1-git-send-email-thuth@redhat.com>
	<1509617407-21191-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] qdev: Check for the availability of
 a hotplug controller before adding a device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, david@redhat.com

On Thu,  2 Nov 2017 11:10:06 +0100
Thomas Huth <thuth@redhat.com> wrote:

> The qdev_unplug() function contains a g_assert(hotplug_ctrl) statement,
> so QEMU crashes when the user tries to device_add + device_del a device
> that does not have a corresponding hotplug controller. This could be
> provoked for a couple of devices in the past (see commit 4c93950659487c7ad
> or 84ebd3e8c7d4fe955 for example), and can currently for example also be
> triggered like this:
> 
> $ s390x-softmmu/qemu-system-s390x -M none -nographic 
> QEMU 2.10.50 monitor - type 'help' for more information
> (qemu) device_add qemu-s390x-cpu,id=x
> (qemu) device_del x
> **
> ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
> Aborted (core dumped)
> 
> So devices clearly need a hotplug controller when they should be usable
> with device_add.
> The code in qdev_device_add() already checks whether the bus has a proper
> hotplug controller, but for devices that do not have a corresponding bus,
> there is no appropriate check available yet. In that case we should check
> whether the machine itself provides a suitable hotplug controller and
> refuse to plug the device if none is available.
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/core/qdev.c         | 28 ++++++++++++++++++++--------
>  include/hw/qdev-core.h |  1 +
>  qdev-monitor.c         |  5 +++++
>  3 files changed, 26 insertions(+), 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
