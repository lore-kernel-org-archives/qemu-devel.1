Received: from eggs.gnu.org ([2001:4830:134:3::10]:33229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPlK3-0002k4-3V
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPlJz-00050I-4o
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:58:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50054 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fPlJy-0004zh-Vr
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:58:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AE5C402178A
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 08:58:34 +0000 (UTC)
Date: Mon, 4 Jun 2018 10:58:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180604085830.awobv45jz4nyrcx2@sirius.home.kraxel.org>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601162749.27406-10-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 09/12] Add vhost-input-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

> +#define TYPE_VHOST_USER_INPUT_PCI "vhost-user-input-pci"

Patch $subject mismatch.

> +struct VHostUserInput {
> +    VirtIOInput                       parent_obj;
> +
> +    VhostUserBackend                  *vhost;
> +};

Nothing input specific here ...

> +static void vhost_input_change_active(VirtIOInput *vinput)
> +{
> +    VHostUserInput *vhi = VHOST_USER_INPUT(vinput);
> +
> +    if (!vhi->vhost) {
> +        return;
> +    }
> +
> +    if (vinput->active) {
> +        vhost_user_backend_start(vhi->vhost);
> +    } else {
> +        vhost_user_backend_stop(vhi->vhost);
> +    }
> +}

... and here ...

> +static const VMStateDescription vmstate_vhost_input = {
> +    .name = "vhost-user-input",
> +    .unmigratable = 1,
> +};

... and here ...

> +static void vhost_input_is_busy(const Object *obj, const char *name,
> +                                Object *val, Error **errp)
> +{
> +    VHostUserInput *vhi = VHOST_USER_INPUT(obj);
> +
> +    if (vhi->vhost) {
> +        error_setg(errp, "can't use already busy vhost-user");
> +    } else {
> +        qdev_prop_allow_set_link_before_realize(obj, name, val, errp);
> +    }
> +}

... likewise ...

So, maybe it makes sense to have a abstact base class for vhost-user
devices?  And possibly move the vhost-backend code to the base class
then?

cheers,
  Gerd
