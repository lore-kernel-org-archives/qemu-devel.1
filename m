Received: from eggs.gnu.org ([2001:4830:134:3::10]:42298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eoQoN-0000c5-0d
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 04:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eoQoJ-0004hJ-TT
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 04:35:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35108 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eoQoJ-0004hF-O6
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 04:35:35 -0500
Date: Wed, 21 Feb 2018 09:35:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180221093524.GH17096@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180220225904.16129-1-bsd@redhat.com>
	<20180220225904.16129-5-bsd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180220225904.16129-5-bsd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/5] usb-mtp: Introduce write support
 for MTP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, kraxel@redhat.com

On Tue, Feb 20, 2018 at 05:59:03PM -0500, Bandan Das wrote:
> Allow write operations on behalf of the initiator. The
> precursor to write is the sending of the write metadata
> that consists of the ObjectInfo dataset. This patch introduces
> a flag that is set when the responder is ready to receive
> write data based on a previous SendObjectInfo operation by
> the initiator (The SendObjectInfo implementation is in a
> later patch)
> 
> Signed-off-by: Bandan Das <bsd@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 150 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 5ef77f3e9f..9b51708614 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -47,6 +47,7 @@ enum mtp_code {
>      CMD_GET_OBJECT_INFO            = 0x1008,
>      CMD_GET_OBJECT                 = 0x1009,
>      CMD_DELETE_OBJECT              = 0x100b,
> +    CMD_SEND_OBJECT                = 0x100d,
>      CMD_GET_PARTIAL_OBJECT         = 0x101b,
>      CMD_GET_OBJECT_PROPS_SUPPORTED = 0x9801,
>      CMD_GET_OBJECT_PROP_DESC       = 0x9802,
> @@ -63,9 +64,11 @@ enum mtp_code {
>      RES_INVALID_STORAGE_ID         = 0x2008,
>      RES_INVALID_OBJECT_HANDLE      = 0x2009,
>      RES_INVALID_OBJECT_FORMAT_CODE = 0x200b,
> +    RES_STORE_FULL                 = 0x200c,
>      RES_STORE_READ_ONLY            = 0x200e,
>      RES_PARTIAL_DELETE             = 0x2012,
>      RES_SPEC_BY_FORMAT_UNSUPPORTED = 0x2014,
> +    RES_INVALID_OBJECTINFO         = 0x2015,
>      RES_INVALID_PARENT_OBJECT      = 0x201a,
>      RES_INVALID_PARAMETER          = 0x201d,
>      RES_SESSION_ALREADY_OPEN       = 0x201e,
> @@ -183,6 +186,14 @@ struct MTPState {
>      int          inotifyfd;
>      QTAILQ_HEAD(events, MTPMonEntry) events;
>  #endif
> +    /* Responder is expecting a write operation */
> +    bool write_pending;
> +    struct {
> +        uint32_t parent_handle;
> +        uint16_t format;
> +        uint32_t size;
> +        char *filename;
> +    } dataset;
>  };
>  
>  #define TYPE_USB_MTP "usb-mtp"
> @@ -804,6 +815,7 @@ static MTPData *usb_mtp_get_device_info(MTPState *s, MTPControl *c)
>          CMD_GET_OBJECT_HANDLES,
>          CMD_GET_OBJECT_INFO,
>          CMD_DELETE_OBJECT,
> +        CMD_SEND_OBJECT,

Seems we should not advertize this for readonly devices.

>          CMD_GET_OBJECT,
>          CMD_GET_PARTIAL_OBJECT,
>          CMD_GET_OBJECT_PROPS_SUPPORTED,
> @@ -1378,6 +1390,14 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
>          nres = 1;
>          res0 = data_in->length;
>          break;
> +    case CMD_SEND_OBJECT:
> +        if (!s->write_pending) {
> +            usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO,
> +                                 c->trans, 0, 0, 0, 0);
> +            return;
> +        }
> +        s->data_out = usb_mtp_data_alloc(c);
> +        return;
>      case CMD_GET_OBJECT_PROPS_SUPPORTED:
>          if (c->argv[0] != FMT_UNDEFINED_OBJECT &&
>              c->argv[0] != FMT_ASSOCIATION) {
> @@ -1472,12 +1492,126 @@ static void usb_mtp_cancel_packet(USBDevice *dev, USBPacket *p)
>      fprintf(stderr, "%s\n", __func__);
>  }
>  
> +static void usb_mtp_write_data(MTPState *s)
> +{
> +    MTPData *d = s->data_out;
> +    MTPObject *parent =
> +        usb_mtp_object_lookup(s, s->dataset.parent_handle);
> +    char *path = NULL;
> +    int rc = -1;
> +    mode_t mask = 0644;
> +
> +    assert(d != NULL);
> +


Somewhere in here should surely be validating the "readonly" flag.

> +    if (parent == NULL || !s->write_pending) {
> +        usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
> +                             0, 0, 0, 0);
> +        return;
> +    }
> +

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
