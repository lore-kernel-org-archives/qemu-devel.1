Received: from eggs.gnu.org ([2001:4830:134:3::10]:53229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC3FC-0002jM-OF
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC3F6-0003Hy-Or
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:16:58 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:39469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC3F6-0003Hq-JR
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:16:52 -0400
Received: by mail-ot0-x241.google.com with SMTP id l12-v6so1967936oth.6
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:16:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312091405.19610-14-kraxel@redhat.com>
References: <20180312091405.19610-1-kraxel@redhat.com>
	<20180312091405.19610-14-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 14:16:31 +0100
Message-ID: <CAFEAcA8XWcJfjgeNRg4j7yMwPx2fNmjxL3qEgnkX8qJrUHQb5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 13/14] spice: add cursor_dmabuf support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 12 March 2018 at 09:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Add support for cursor dmabufs.  qemu has to render the cursor for
> that, so in case a cursor is present qemu allocates a new dmabuf, blits
> the scanout, blends in the pointer and passes on the new dmabuf to
> spice-server.  Without cursor qemu continues to simply pass on the
> scanout dmabuf as-is.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-id: 20180308090618.30147-4-kraxel@redhat.com
> +static void qemu_spice_gl_cursor_position(DisplayChangeListener *dcl,
> +                                          uint32_t pos_x, uint32_t pos_y=
)
> +{
> +    SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
> +
> +    ssd->ptr_x =3D pos_x;
> +    ssd->ptr_y =3D pos_y;

Is it safe to write to these fields of ssd without holding
ssd->lock ? Coverity thinks it might not be (CID 1390631) because
we do take the lock to update them in display_mouse_set().

thanks
-- PMM
