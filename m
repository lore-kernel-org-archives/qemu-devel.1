Received: from eggs.gnu.org ([2001:4830:134:3::10]:50246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUmWX-0007W6-DD
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 00:48:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUmWT-0007bh-9F
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 00:48:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUmWT-0007aE-0Z
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 00:48:29 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181205203737.9011-1-marcandre.lureau@redhat.com>
	<20181205203737.9011-6-marcandre.lureau@redhat.com>
Date: Thu, 06 Dec 2018 06:48:21 +0100
In-Reply-To: <20181205203737.9011-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 6 Dec 2018 00:37:35 +0400")
Message-ID: <87ftvbkxy2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 5/7] colo: check chardev can
 switch context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>, peterx@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

I'd like an Acked-by or Reviewed-by from Zhang Chen or Li Zhijian.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> COLO uses a worker context (iothread) to drive the chardev. All
> backends are not able to switch the context, let's report an error in
> this case.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  net/colo-compare.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index a39191d522..9156ab3349 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -957,6 +957,12 @@ static int find_and_check_chardev(Chardev **chr,
>          return 1;
>      }
>=20=20
> +    if (!qemu_chr_has_feature(*chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
> +        error_setg(errp, "chardev \"%s\" cannot switch context",
> +                   chr_name);
> +        return 1;
> +    }
> +
>      return 0;
>  }
