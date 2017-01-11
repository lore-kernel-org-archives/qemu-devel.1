Received: from eggs.gnu.org ([2001:4830:134:3::10]:49514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cRKQG-0007cJ-I6
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cRKQA-0006to-S0
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:02:44 -0500
Received: from mail-yw0-x232.google.com ([2607:f8b0:4002:c05::232]:36318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cRKQA-0006tZ-N3
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:02:38 -0500
Received: by mail-yw0-x232.google.com with SMTP id a10so476044252ywa.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 07:02:38 -0800 (PST)
MIME-Version: 1.0
References: <32da9f1f.9022.1598ccf96ce.Coremail.h158309@126.com>
In-Reply-To: <32da9f1f.9022.1598ccf96ce.Coremail.h158309@126.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 11 Jan 2017 15:02:26 +0000
Message-ID: <CAJ+F1CK8PwREJRVdBwFdt-nK-X1yE69Lg6Bzz4ouKjsVCnhcCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vhost-user: fix crash when chardev-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?6buE5reu?= <h158309@126.com>, qemu-devel@nongnu.org

Hi

On Wed, Jan 11, 2017 at 3:32 PM =E9=BB=84=E6=B7=AE <h158309@126.com> wrote:

> From: Huai Huang<h158309@126.com>
>
>
>
Could you describe a bit more the crash and provide a backtrace?


> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index f2d49ad..4037cf4 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -412,7 +412,6 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>          break;
>      case NET_CLIENT_DRIVER_VHOST_USER:
>          vhost_net =3D vhost_user_get_vhost_net(nc);
> -        assert(vhost_net);
>

This was recently added, in commit
1a5b68cee8a2b165ffd61b2e0641a4da3990f242.

How is it related?

I remember the rest of the vhost-user code expected get_vhost_net() to be
non-null, did that change?

         break;
>      default:
>          break;
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index b0595f8..4e54478 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -160,7 +160,10 @@ static void vhost_user_cleanup(NetClientState *nc)
>          qemu_chr_fe_release(s->chr);
>          s->chr =3D NULL;
>      }
> -
> +    if (s->watch) {
> +        g_source_remove(s->watch);
> +        s->watch =3D 0;
> +    }
>

Hmm, the socket didn't send a CLOSED event on remove?


>      qemu_purge_queued_packets(nc);
>  }
>
>
> @@ -192,7 +195,8 @@ static gboolean net_vhost_user_watch(GIOChannel *chan=
,
> GIOCondition cond,
>  {
>      VhostUserState *s =3D opaque;
>
>
> -    qemu_chr_disconnect(s->chr);
> +    if (s->chr)
> +        qemu_chr_disconnect(s->chr);
>

that looks outdated,

which version of qemu did you tested and patched?

thanks

>
>
>      return FALSE;
>  }

--=20
Marc-Andr=C3=A9 Lureau
