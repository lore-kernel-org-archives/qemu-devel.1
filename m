Received: from eggs.gnu.org ([2001:4830:134:3::10]:38972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC5zV-0000XQ-I6
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC5zU-0001vr-Hu
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:12:57 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:39236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC5zU-0001vb-BR
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:12:56 -0400
Received: by mail-oi0-x236.google.com with SMTP id n65-v6so2043722oig.6
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 09:12:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521515720-612046-32-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
	<1521515720-612046-32-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 17:12:34 +0100
Message-ID: <CAFEAcA_kuyWHnqhcA-Zo5+q4u48dDLv4nxrEm5fFcbjZh9U6KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 31/50] vhost+postcopy: Register shared
 ufd with postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 20 March 2018 at 03:17, Michael S. Tsirkin <mst@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Register the UFD that comes in as the response to the 'advise' method
> with the postcopy code.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

> @@ -835,8 +847,14 @@ static int vhost_user_postcopy_advise(struct vhost_d=
ev *dev, Error **errp)
>          error_setg(errp, "%s: Failed to get ufd", __func__);
>          return -1;
>      }
> +    fcntl(ufd, F_SETFL, O_NONBLOCK);

Hi; this would probably be more neatly done with
       qemu_set_nonblock(ufd);
unless you really wanted to clear the other fd flags.
Among other things, it avoids Coverity producing a complaint
that we didn't check the fcntl return value (though we seem
to assume it can't fail in general, hence qemu_set_nonblock()
returning NULL.) -- CID1390601, which I've marked as false-positive.

> -    /* TODO: register ufd with userfault thread */
> +    /* register ufd with userfault thread */
> +    u->postcopy_fd.fd =3D ufd;
> +    u->postcopy_fd.data =3D dev;
> +    u->postcopy_fd.handler =3D vhost_user_postcopy_fault_handler;
> +    u->postcopy_fd.idstr =3D "vhost-user"; /* Need to find unique name *=
/
> +    postcopy_register_shared_ufd(&u->postcopy_fd);
>      return 0;
>  }

thanks
-- PMM
