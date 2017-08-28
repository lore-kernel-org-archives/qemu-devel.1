Received: from eggs.gnu.org ([2001:4830:134:3::10]:39379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmTKh-0001No-As
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 19:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmTKg-0007Cj-1g
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 19:20:39 -0400
References: <1503543783-17192-1-git-send-email-thuth@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <085793af-0342-c36e-53fd-e30eb23ef722@redhat.com>
Date: Mon, 28 Aug 2017 19:20:27 -0400
MIME-Version: 1.0
In-Reply-To: <1503543783-17192-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/ide/microdrive: Mark the
 dscm1xxxx device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org



On 08/23/2017 11:03 PM, Thomas Huth wrote:
> QEMU currently aborts with an assertion message when the user is trying
> to remove a dscm1xxxx again:
> 
> $ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
> QEMU 2.9.93 monitor - type 'help' for more information
> (qemu) device_add dscm1xxxx,id=xyz
> (qemu) device_del xyz
> **
> ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
> Aborted (core dumped)
> 
> Looks like this device has to be wired up in code and is not meant
> to be hot-pluggable, so let's mark it with user_creatable = false.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/ide/microdrive.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
> index e3fd30e..17917c0 100644
> --- a/hw/ide/microdrive.c
> +++ b/hw/ide/microdrive.c
> @@ -575,12 +575,15 @@ PCMCIACardState *dscm1xxxx_init(DriveInfo *dinfo)
>  static void dscm1xxxx_class_init(ObjectClass *oc, void *data)
>  {
>      PCMCIACardClass *pcc = PCMCIA_CARD_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
>  
>      pcc->cis = dscm1xxxx_cis;
>      pcc->cis_len = sizeof(dscm1xxxx_cis);
>  
>      pcc->attach = dscm1xxxx_attach;
>      pcc->detach = dscm1xxxx_detach;
> +    /* Reason: Needs to be wired-up in code, see dscm1xxxx_init() */
> +    dc->user_creatable = false;
>  }
>  
>  static const TypeInfo dscm1xxxx_type_info = {
> 

OK; I'll look into Paolo's suggestion as a further fix, but whether or
not we treat this property as a hint, it should be set anyway as you say.

Reviewed-by: John Snow <jsnow@redhat.com>

Thanks, applied to my IDE tree:

https://github.com/jnsnow/qemu/commits/ide
https://github.com/jnsnow/qemu.git

--js
