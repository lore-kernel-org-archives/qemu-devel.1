Received: from eggs.gnu.org ([2001:4830:134:3::10]:51466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmNNa-00016R-MS
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 12:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmNNZ-0004yy-Q6
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 12:59:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503938085-169486-1-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0f325bf7-c137-7f6e-5f70-10910a241d54@amsat.org>
Date: Mon, 28 Aug 2017 13:59:03 -0300
MIME-Version: 1.0
In-Reply-To: <1503938085-169486-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] ide: ahci: unparent children
 buses before freeing their memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, thuth@redhat.com, mst@redhat.com

On 08/28/2017 01:34 PM, Igor Mammedov wrote:
> Fixes read after freeing error reported
>    https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04243.html
>    Message-Id: <59a56959-ca12-ea75-33fa-ff07eba1b090@redhat.com>
> 
> ich9-ahci device creates ide buses and attaches them as QOM children
> at realize time, however it forgets to properly clean them up
> at unrealize time and frees memory containing these children,
> with following call-chain:
> 
>     qdev_device_add()
>       object_property_set_bool('realized', true)
>         device_set_realized()
>            ...
>            pci_qdev_realize() -> pci_ich9_ahci_realize() -> ahci_realize()
>                 ...
>                 s->dev = g_new0(AHCIDevice, ports);
>                 ...
>                    AHCIDevice *ad = &s->dev[i];
>                    ide_bus_new(&ad->port, sizeof(ad->port), qdev, i, 1);
>                    ^^^ creates bus in memory allocated by above gnew()
>                        and adds it as child propety to ahci device
>            ...
>            hotplug_handler_plug(); -> goto post_realize_fail;
>            pci_qdev_unrealize() -> pci_ich9_uninit() -> ahci_uninit()
>                ...
>                 g_free(s->dev);
>                 ^^^ free memory that holds children busses
> 
>            return with error from device_set_realized()
> 
> As result later when qdev_device_add() tries to unparent ich9-ahci
> after failed device_set_realized(),
>      object_unparent() -> object_property_del_child()
> iterates over existing QOM children including buses added by
> ide_bus_new() and tries to unparent them, which causes access to
> freed memory where they where located.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/ide/ahci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 406a1b5..ccbe091 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1495,6 +1495,7 @@ void ahci_uninit(AHCIState *s)
>   
>               ide_exit(s);
>           }
> +        object_unparent(OBJECT(&ad->port));
>       }
>   
>       g_free(s->dev);
> 
