Received: from eggs.gnu.org ([2001:4830:134:3::10]:55038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1esn3m-0005SC-5J
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1esn3h-0005WD-Gp
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:09:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1esn3h-0005Vp-BR
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:09:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0A35402314E
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 10:09:28 +0000 (UTC)
Date: Mon, 5 Mar 2018 11:09:28 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180305100928.dg5h77wsoadwl42p@sirius.home.kraxel.org>
References: <1520243276-30197-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520243276-30197-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] Allow to specify a display device ID
 and head whith the screendump command
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
> +void qmp_screendump(const char *filename, bool has_device, const char *device,
> +                    bool has_head, int64_t head, Error **errp)
>  {
>      QemuConsole *con = qemu_console_lookup_by_index(0);

This initialization can be dropped ...

>      DisplaySurface *surface;
>  
> -    if (con == NULL) {
> -        error_setg(errp, "There is no QemuConsole I can screendump from.");
> -        return;
> +    if (has_device) {
> +        con = qemu_console_lookup_by_device_name(device, has_head ? head : 0,
> +                                                 errp);
> +        if (!con) {
> +            return;
> +        }
> +    } else {
> +        if (has_head) {
> +            error_setg(errp, "'head' must be specified together with 'device'");
> +            return;
> +        }
> +        con = qemu_console_lookup_by_index(0);

... because it is called here now.

Otherwise looks fine now.

cheers,
  Gerd
