Received: from eggs.gnu.org ([2001:4830:134:3::10]:32930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhz4c-0000BH-Mi
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 10:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhz4X-00084l-OE
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 10:13:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhz4X-00084Q-Gy
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 10:13:25 -0400
Date: Wed, 16 Aug 2017 16:13:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170816161319.1492937b.cohuck@redhat.com>
In-Reply-To: <1502892528-22618-1-git-send-email-thuth@redhat.com>
References: <1502892528-22618-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/watchdog/wdt_diag288: Mark diag288
 watchdog as non-hotpluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Wed, 16 Aug 2017 16:08:48 +0200
Thomas Huth <thuth@redhat.com> wrote:

> QEMU currently aborts when the user tries to hot-unplug a diag288
> device:
> 
> $ qemu-system-s390x -nographic -nodefaults -S -monitor stdio
> QEMU 2.9.92 monitor - type 'help' for more information
> (qemu) device_add diag288,id=x
> (qemu) device_del x
> **
> ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
> Aborted (core dumped)
> 
> The device is not designed as hot-pluggable (it should only be used
> via the "-watchdog" parameter), so let's simply remove the possibility
> to hotplug it to prevent that users can run into this ugly situation.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/watchdog/wdt_diag288.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
> index a7b64e2..47f2892 100644
> --- a/hw/watchdog/wdt_diag288.c
> +++ b/hw/watchdog/wdt_diag288.c
> @@ -121,6 +121,7 @@ static void wdt_diag288_class_init(ObjectClass *klass, void *data)
>      dc->realize = wdt_diag288_realize;
>      dc->unrealize = wdt_diag288_unrealize;
>      dc->reset = wdt_diag288_reset;
> +    dc->hotpluggable = false;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      dc->vmsd = &vmstate_diag288;
>      diag288->handle_timer = wdt_diag288_handle_timer;

Looks good. I'll queue it; I'll wire up diag288 for tcg as well.

Any more non-hotpluggable devices you found? :)
