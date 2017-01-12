Received: from eggs.gnu.org ([2001:4830:134:3::10]:54422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRf9d-0006Y5-Pq
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRf9b-000118-Vo
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:10:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRf9b-00010o-Pq
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:10:55 -0500
Date: Thu, 12 Jan 2017 11:10:53 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170112131053.GA27893@thinpad.lan.raisama.net>
References: <20170111173457.30455-1-lersek@redhat.com>
	<20170111173457.30455-3-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170111173457.30455-3-lersek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 wave 1 2/4] fw-cfg: turn
 FW_CFG_FILE_SLOTS into a device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, "Gabriel L. Somlo" <somlo@cmu.edu>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Jan 11, 2017 at 06:34:55PM +0100, Laszlo Ersek wrote:
[...]
>  static Property fw_cfg_io_properties[] = {
>      DEFINE_PROP_UINT32("iobase", FWCfgIoState, iobase, -1),
>      DEFINE_PROP_UINT32("dma_iobase", FWCfgIoState, dma_iobase, -1),
>      DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled,
>                       true),
> +    DEFINE_PROP_UINT16("file_slots", FWCfgIoState, parent_obj.file_slots,
> +                       FW_CFG_FILE_SLOTS_MIN),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -1027,6 +1066,13 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)

I'm not sure what is more important here: following the QOM
property name convention using "-" instead of "_", or being
consistent with the other existing properties.

In either case, we could add a "x-" prefix to indicate it is not
supposed to be configured directly by the user.

[...]
> @@ -1063,6 +1109,8 @@ static Property fw_cfg_mem_properties[] = {
>      DEFINE_PROP_UINT32("data_width", FWCfgMemState, data_width, -1),
>      DEFINE_PROP_BOOL("dma_enabled", FWCfgMemState, parent_obj.dma_enabled,
>                       true),
> +    DEFINE_PROP_UINT16("file_slots", FWCfgMemState, parent_obj.file_slots,
> +                       FW_CFG_FILE_SLOTS_MIN),

It looks like you can add the property to the TYPE_FW_CFG parent
class instead of duplicating it on the subclasses. The existing
"dma_enabled" property could be moved there as well.

-- 
Eduardo
