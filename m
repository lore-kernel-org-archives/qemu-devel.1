Received: from eggs.gnu.org ([2001:4830:134:3::10]:43630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1elZN0-0000cy-IW
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1elZMx-0002ch-8H
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:07:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1elZMx-0002cX-3b
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:07:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38C208182D01
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 12:07:27 +0000 (UTC)
Date: Tue, 13 Feb 2018 13:07:22 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180213120722.3td5agrejd2t7hbo@sirius.home.kraxel.org>
References: <20180212222705.12718-1-bsd@redhat.com>
	<20180212222705.12718-4-bsd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212222705.12718-4-bsd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] usb-mtp: Support delete of mtp
 objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: qemu-devel@nongnu.org

> +#ifndef CONFIG_INOTIFY1
> +/* Assumes that children, if any, have been already freed */
> +static void usb_mtp_object_free_one(MTPState *s, MTPObject *o)
> +{
> +    assert(o->nchildren == 0);
> +    QTAILQ_REMOVE(&s->objects, o, next);
> +    g_free(o->name);
> +    g_free(o->path);
> +    g_free(o);
> +}
> +#endif

I'd suggest to move the #ifdef into the function, so it can be called
unconditinally.  Also #else /* not needed with inotify because ... */
would be nice.

> +#ifndef CONFIG_INOTIFY1
> +            usb_mtp_object_free_one(s, o);
> +#endif

These ifdefs can be dropped then.

> +        /* Mark store as RW */
> +        s->flags |= (1 << MTP_FLAG_WRITABLE);

Do we want a property to enable write support?

cheers,
  Gerd
