Received: from eggs.gnu.org ([2001:4830:134:3::10]:52569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxtx5-0005AO-8n
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxtx1-0003R7-9P
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:27:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cxtx1-0003Qh-3C
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:27:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4364EEF0F
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 11:27:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170406131326.2418-1-quintela@redhat.com>
	<20170406131326.2418-3-quintela@redhat.com>
Date: Tue, 11 Apr 2017 13:27:07 +0200
In-Reply-To: <20170406131326.2418-3-quintela@redhat.com> (Juan Quintela's
	message of "Thu, 6 Apr 2017 15:13:23 +0200")
Message-ID: <87efwzb2wk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/5] qdev: Export qdev_hot_removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Cc: Paolo for additional qdev expertise.

Juan Quintela <quintela@redhat.com> writes:

> I need to move qdev_unplug to qdev-monitor in the following patch, and
> it needs access to this variable.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/core/qdev.c         | 2 +-
>  include/hw/qdev-core.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 6fa46b5..c26cf84 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -41,7 +41,7 @@
>  
>  bool qdev_hotplug = false;
>  static bool qdev_hot_added = false;
> -static bool qdev_hot_removed = false;
> +bool qdev_hot_removed = false;

Makes qdev_hot_added and qdev_hot_removed differently static, which is
weird.

The reason for this asymmetry is the asymmetry in how they get set:

* qdev_hot_added gets set .instance_init() method in device_initfn()
  when it runs after qdev_machine_creation_done().  It's called by
  qdev_device_add() via object_new()... then.

* qdev_hot_removed gets set directly in qdev_unplug(), not in the
  .instance_finalize() method device_finalize().

  Note that for some devices, qdev_unplug() only requests unplug.
  Actual unplug happens later, or even not at all.  device_finalize()
  runs on actual unplug.

Questions:

* Is setting qdev_hot_removed on unplug *requests* correct?  Or should
  it be set only on *actual* unplug?

* Can we avoid the asymmetry?  It's a bit ugly.

>  const VMStateDescription *qdev_get_vmsd(DeviceState *dev)
>  {
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index a96a913..f09b6b7 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -387,6 +387,7 @@ Object *qdev_get_machine(void);
>  void qdev_set_parent_bus(DeviceState *dev, BusState *bus);
>  
>  extern bool qdev_hotplug;
> +extern bool qdev_hot_removed;
>  
>  char *qdev_get_dev_path(DeviceState *dev);
