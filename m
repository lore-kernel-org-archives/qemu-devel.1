Received: from eggs.gnu.org ([2001:4830:134:3::10]:55801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1esktf-0004s8-A1
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 02:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1esktc-0002PM-5g
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 02:50:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35192 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1esktc-0002OM-0s
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 02:50:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9CAF8182D3A
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 07:50:54 +0000 (UTC)
Date: Mon, 5 Mar 2018 08:50:53 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180305075053.o3pporh23eeq3wdz@sirius.home.kraxel.org>
References: <1520234280-19410-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520234280-19410-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Allow to specify a display ID whith the
 screendump command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

> -void qmp_screendump(const char *filename, Error **errp)
> +void qmp_screendump(const char *filename, bool has_id, const char *id,
> +                    Error **errp)
>  {
>      QemuConsole *con = qemu_console_lookup_by_index(0);
>      DisplaySurface *surface;
> +    DeviceState *dev;
> +
> +    if (has_id) {
> +        dev = qdev_find_recursive(sysbus_get_default(), id);
> +        if (!dev) {
> +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> +                      "Device '%s' not found", id);
> +            return;
> +        }
> +        con = qemu_console_lookup_by_device(dev, 0);

I'd suggest to name this 'device', because this is what it actually is.
While being at it you should also add a 'head' parameter (second arg of
qemu_console_lookup_by_device()), for devices like virtio-vga which can
support multiple heads.

>      if (con == NULL) {
>          error_setg(errp, "There is no QemuConsole I can screendump from.");

This might also be refined to say something like 'device $name is not a
display device' in case qemu_console_lookup_by_device() failed.

> -- 
> 1.8.3.1
> 
