Received: from eggs.gnu.org ([209.51.188.92]:58802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hE8uP-00053M-Ag
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hE8uO-0005Lm-HL
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hE8uO-0005Km-8h
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:48:40 -0400
Date: Wed, 10 Apr 2019 10:48:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190410084830.hiesbi6aumiwsdfk@sirius.home.kraxel.org>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
	<20190409161009.6322-18-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409161009.6322-18-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 17/20] console: make screendump
 asynchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

> +static void qmp_screendump_finish(QemuConsole *con, struct qmp_screendump *dump)
> +{
> +    Error *err = NULL;
> +    DisplaySurface *surface;
> +    Monitor *prev_mon = cur_mon;

Why this is needed?

> +        /*
> +         * FIXME: async save with coroutine? it would have to copy or
> +         * lock the surface.
> +         */
> +        ppm_save(dump->filename, surface, &err);

DisplaySurface is just a thin layer above pixman images these days.
Pixman images are reference counted, so you can
pixman_image_ref(surface->image) to make sure it doesn't disappear
underneath you, then pass the pixman image to ppm_save.

cheers,
  Gerd
