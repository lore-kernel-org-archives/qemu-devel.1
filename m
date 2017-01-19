Received: from eggs.gnu.org ([2001:4830:134:3::10]:55275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cU7xU-0004rc-01
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cU7xQ-0008Ds-Rh
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:20:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cU7xQ-0008Dd-MX
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:20:32 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F26817E9CC
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 08:20:31 +0000 (UTC)
Message-ID: <1484814026.15364.15.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 19 Jan 2017 09:20:26 +0100
In-Reply-To: <20170118160332.13390-24-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<20170118160332.13390-24-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 23/25] console: make screendump async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, armbru@redhat.com

On Mi, 2017-01-18 at 20:03 +0400, Marc-Andr=C3=A9 Lureau wrote:
> +    surface =3D qemu_console_surface(con);
> +
> +    /* FIXME: async save with coroutine? it would have to copy or
> lock
> +     * the surface. */
> +    ppm_save(filename, surface, &err);
> +

No need to lock or copy.

ppm_save() uses the pixman image (surface->image) only anyway, so
changing it to accept a pixman image instead of the surface is easy.

pixman images are reference counted, so you can just grab a reference
using pixman_image_ref() and run with it, without risking it'll be
released underneath your feet, then unref when done.

cheers,
  Gerd
