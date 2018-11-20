Received: from eggs.gnu.org ([2001:4830:134:3::10]:35675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1jv-0000KR-EB
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1js-0003iL-CM
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:35 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gP1js-0003i9-2s
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:32 -0500
Received: by mail-qk1-f196.google.com with SMTP id d19so1619191qkg.5
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 00:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20181115143124.19234-1-pbonzini@redhat.com>
	<20181115143124.19234-5-pbonzini@redhat.com>
In-Reply-To: <20181115143124.19234-5-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 12:50:20 +0400
Message-ID: <CAMxuvaw64Az+xwVi-=y96Cf9RsP6syo1kjFjnaSx+PBkdzt9OA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/10] vhost-user: support cross-endian
 vnet headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Bonzini, Paolo" <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>

Hi

On Thu, Nov 15, 2018 at 6:31 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> vhost-user already has a way to communicate the endianness of the guest
> via the vring endianness messages.  The vring endianness always matches
> the vnet header endianness so there is no need to do anything else in
> the backend.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  net/vhost-user.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index a39f9c9974..cd9659df87 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -172,6 +172,17 @@ static void net_vhost_user_cleanup(NetClientState *n=
c)
>      qemu_purge_queued_packets(nc);
>  }
>
> +static int vhost_user_set_vnet_endianness(NetClientState *nc,
> +                                          bool enable)
> +{
> +    /* Nothing to do.  If the server supports
> +     * VHOST_USER_PROTOCOL_F_CROSS_ENDIAN, it will get the
> +     * vnet header endianness from there.  If it doesn't, negotiation
> +     * fails.
> +     */
> +    return 0;
> +}
> +
>  static bool vhost_user_has_vnet_hdr(NetClientState *nc)
>  {
>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_USER);
> @@ -193,6 +204,8 @@ static NetClientInfo net_vhost_user_info =3D {
>          .cleanup =3D net_vhost_user_cleanup,
>          .has_vnet_hdr =3D vhost_user_has_vnet_hdr,
>          .has_ufo =3D vhost_user_has_ufo,
> +        .set_vnet_be =3D vhost_user_set_vnet_endianness,
> +        .set_vnet_le =3D vhost_user_set_vnet_endianness,
>  };
>
>  static gboolean net_vhost_user_watch(GIOChannel *chan, GIOCondition cond=
,
> --
> 2.19.1
>
>
