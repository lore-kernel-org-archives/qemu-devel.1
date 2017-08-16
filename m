Received: from eggs.gnu.org ([2001:4830:134:3::10]:49568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhuYR-0005DB-DI
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhuYO-00007R-Nv
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:23:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhuYO-000065-Hn
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:23:56 -0400
Date: Wed, 16 Aug 2017 11:23:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170816112349.5cf3c106.cohuck@redhat.com>
In-Reply-To: <451ff313-11c5-9f67-d7f1-a606c02efc79@redhat.com>
References: <451ff313-11c5-9f67-d7f1-a606c02efc79@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Crash when deleting the diag288 watchdog
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>

On Wed, 16 Aug 2017 07:05:37 +0200
Thomas Huth <thuth@redhat.com> wrote:

>  Hi,
> 
> I recently noticed that QEMU abort()s if you try to remove the diag288
> watchdog. For example:
> 
> $ qemu-system-s390x -nographic -nodefaults -S -monitor stdio
> QEMU 2.9.92 monitor - type 'help' for more information
> (qemu) device_add diag288,id=x
> (qemu) device_del x
> **
> ERROR:/home/thuth/devel/qemu/qdev-monitor.c:872:qdev_unplug: assertion
> failed: (hotplug_ctrl)
> Aborted (core dumped)
> 
> This is ugly, can we fix this somehow? For example, should the diag288
> device be hot-pluggable at all, or can it only be used via the
> "-watchdog" parameter instead? In the latter case, we could simply mark
> the device with "user_creatable = false", I guess?

I don't think the diag288 watchdog should be hotpluggable. IIUC, it is
simply present on z/VM (and I don't think it's different on LPAR, but I
could not find docs for that). So yes, user_creatable = false sounds
like the right thing to do.

Related: We currently only handle diag288 via kvm if I did not miss
something. It probably makes sense to wire it up for tcg as well.
