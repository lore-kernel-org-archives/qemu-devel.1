Received: from eggs.gnu.org ([2001:4830:134:3::10]:34449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dZZRc-0003xO-Ce
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dZZRZ-0008V7-4k
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:14:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dZZRY-0008Ut-SE
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:14:25 -0400
Date: Mon, 24 Jul 2017 11:14:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170724111419.720aa168@nial.brq.redhat.com>
In-Reply-To: <1500813971-82408-1-git-send-email-peng.hao2@zte.com.cn>
References: <1500813971-82408-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2] vhost: fix a migration failed because
 of vhost region merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: mst@redhat.com, Wang Yechao <wang.yechao255@zte.com.cn>, qemu-devel@nongnu.org

On Sun, 23 Jul 2017 20:46:11 +0800
Peng Hao <peng.hao2@zte.com.cn> wrote:

> When a guest that has several hotplugged dimms is migrated, on
> destination it will fail to resume. Because regions on source
> are merged and on destination the order of realizing devices
> is different from on source with dimms, so when part of devices
> are realizd some region can not be merged.That may be more than
> vhost slot limit.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  hw/mem/pc-dimm.c        | 2 +-
>  include/sysemu/sysemu.h | 1 +
>  vl.c                    | 5 +++++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index ea67b46..13f3db5 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -101,7 +101,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
>          goto out;
>      }
>  
> -    if (!vhost_has_free_slot()) {
> +    if (!vhost_has_free_slot() && qemu_is_machine_init_done()) {
>          error_setg(&local_err, "a used vhost backend has no free"
>                                 " memory slots left");
that doesn't fix issue,
   1st: number of used entries is changing after machine_init_done() is called
        as regions continue to mapped/unmapped during runtime
   2nd: it brings regression and allows to start QEMU with number memory
        regions more than supported by backend, which combined with missing
        error handling in vhost will lead to qemu crashes or obscure bugs in
        guest breaking vhost enabled drivers.
        i.e. patch undoes what were fixed by
        https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg00789.html


>          goto out;
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index b213696..48228ad 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -88,6 +88,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info);
>  void qemu_add_exit_notifier(Notifier *notify);
>  void qemu_remove_exit_notifier(Notifier *notify);
>  
> +bool qemu_is_machine_init_done(void);
>  void qemu_add_machine_init_done_notifier(Notifier *notify);
>  void qemu_remove_machine_init_done_notifier(Notifier *notify);
>  
> diff --git a/vl.c b/vl.c
> index fb6b2ef..43aee22 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2681,6 +2681,11 @@ static void qemu_run_exit_notifiers(void)
>  
>  static bool machine_init_done;
>  
> +bool qemu_is_machine_init_done(void)
> +{
> +    return machine_init_done;
> +}
> +
>  void qemu_add_machine_init_done_notifier(Notifier *notify)
>  {
>      notifier_list_add(&machine_init_done_notifiers, notify);
