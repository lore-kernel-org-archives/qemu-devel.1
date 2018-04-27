Received: from eggs.gnu.org ([2001:4830:134:3::10]:52450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC3BP-000756-OQ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC3BP-00026O-0T
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:13:03 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:44677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC3BO-00026C-Ra
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:13:02 -0400
Received: by mail-ot0-x234.google.com with SMTP id g7-v6so1943328otj.11
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:13:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312091405.19610-14-kraxel@redhat.com>
References: <20180312091405.19610-1-kraxel@redhat.com>
	<20180312091405.19610-14-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 14:12:41 +0100
Message-ID: <CAFEAcA-_SdGVKt_a9AWB1BQt569m2mvPopdTJeDJdgXn_JEN8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

> +        } else {
> +            trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id,
> +                                               dmabuf->width, dmabuf->height);
> +            /* note: spice server will close the fd, so hand over a dup */
> +            spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
> +                                 dmabuf->width, dmabuf->height,
> +                                 dmabuf->stride, dmabuf->fourcc, false);
> +        }

Coverity complains about this, because it doesn't know that
spice_qxl_gl_scanout() closes the fd it's passed. Is it
worth adding something to our coverity model to indicate this?
(Coverity complained in CID 1390616, which I have marked as a
false-positive for now.)

thanks
-- PMM
