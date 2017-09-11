Received: from eggs.gnu.org ([2001:4830:134:3::10]:36854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1drDKH-0007v1-8V
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1drDKC-0006Ln-FN
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:15:49 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23639
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1drDKB-0006JT-Ms
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:15:44 -0400
References: <20170909083001.17451-1-maozy.fnst@cn.fujitsu.com>
	<CAJ+F1CJPnc0OwhzP6_XYzW3L83_UAC_EAVR6A89wtzASTGOUcg@mail.gmail.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <1d475fb0-7e29-9857-74e6-6beb477ba802@cn.fujitsu.com>
Date: Mon, 11 Sep 2017 09:13:24 +0800
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJPnc0OwhzP6_XYzW3L83_UAC_EAVR6A89wtzASTGOUcg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] usb/dev-smartcard-reader: convert to
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>



On 09/09/2017 05:20 PM, Marc-André Lureau wrote:
> Hi
>
> On Sat, Sep 9, 2017 at 10:33 AM Mao Zhongyi <maozy.fnst@cn.fujitsu.com <mailto:maozy.fnst@cn.fujitsu.com>> wrote:
>
>     Convert CCID Device to realize and rename the ccid_card_init()
>     to ccid_card_realize().
>
>     Cc: Gerd Hoffmann <kraxel@redhat.com <mailto:kraxel@redhat.com>>
>     Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com <mailto:maozy.fnst@cn.fujitsu.com>>
>     ---
>      hw/usb/dev-smartcard-reader.c | 18 ++++++++----------
>      1 file changed, 8 insertions(+), 10 deletions(-)
>
>     diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
>     index bef1f03..27cd48d 100644
>     --- a/hw/usb/dev-smartcard-reader.c
>     +++ b/hw/usb/dev-smartcard-reader.c
>     @@ -1306,27 +1306,25 @@ static int ccid_card_exit(DeviceState *qdev)
>          return 0;
>      }
>
>     -static int ccid_card_init(DeviceState *qdev)
>     +static void ccid_card_realize(DeviceState *qdev, Error **errp)
>      {
>          CCIDCardState *card = CCID_CARD(qdev);
>          USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
>          USBCCIDState *s = USB_CCID_DEV(dev);
>     -    int ret = 0;
>
>          if (card->slot != 0) {
>     -        warn_report("usb-ccid supports one slot, can't add %d",
>     +        error_setg(errp, "usb-ccid supports one slot, can't add %d",
>                          card->slot);
>     -        return -1;
>     +        return;
>          }
>          if (s->card != NULL) {
>     -        warn_report("usb-ccid card already full, not adding");
>     -        return -1;
>     +        error_setg(errp, "usb-ccid card already full, not adding");
>     +        return;
>          }
>     -    ret = ccid_card_initfn(card);
>     -    if (ret == 0) {
>     +
>     +    if (!ccid_card_initfn(card)) {
>              s->card = card;
>          }
>
>
> You should set an error here, or the caller won't be aware of card init error anymore. Best would be to convert ccid_card_initfn() and callbacks to take an Error **.

Thanks for the info, I will.

--
Mao

>
>     -    return ret;
>      }
>
>      static void ccid_realize(USBDevice *dev, Error **errp)
>     @@ -1496,7 +1494,7 @@ static void ccid_card_class_init(ObjectClass *klass, void *data)
>      {
>          DeviceClass *k = DEVICE_CLASS(klass);
>          k->bus_type = TYPE_CCID_BUS;
>     -    k->init = ccid_card_init;
>     +    k->realize = ccid_card_realize;
>          k->exit = ccid_card_exit;
>          k->props = ccid_props;
>      }
>     --
>     2.9.4
>
>
>
>
> --
> Marc-André Lureau
