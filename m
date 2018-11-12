Received: from eggs.gnu.org ([2001:4830:134:3::10]:35710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gM8Nk-000801-B4
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gM8Nc-0005k0-IV
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:19:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gM8NS-0005ZO-8w
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:19:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 253CF30832E3
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 09:19:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181110111623.31356-1-marcandre.lureau@redhat.com>
Date: Mon, 12 Nov 2018 10:19:18 +0100
In-Reply-To: <20181110111623.31356-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sat, 10 Nov 2018 15:16:23 +0400")
Message-ID: <871s7qfyax.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] edid: silence a stringop-overflow warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Simplify the code that doesn't need strncpy() since length of string
> is already computed.
>
> /home/elmarco/src/qemu/hw/display/edid-generate.c: In function 'edid_desc=
_text':
> /home/elmarco/src/qemu/hw/display/edid-generate.c:168:5: error: 'strncpy'=
 specified bound depends on the length of the source argument [-Werror=3Dst=
ringop-overflow=3D]
>      strncpy((char *)(desc + 5), text, len);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qemu/hw/display/edid-generate.c:164:11: note: length co=
mputed here
>      len =3D strlen(text);
>            ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/edid-generate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
> index bdf5e1d4d4..77d9127344 100644
> --- a/hw/display/edid-generate.c
> +++ b/hw/display/edid-generate.c
> @@ -165,7 +165,7 @@ static void edid_desc_text(uint8_t *desc, uint8_t typ=
e,
>      if (len > 12) {
>          len =3D 12;
>      }
> -    strncpy((char *)(desc + 5), text, len);
> +    memcpy(desc + 5, text, len);
>      desc[5 + len] =3D '\n';
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
