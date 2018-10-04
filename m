Received: from eggs.gnu.org ([2001:4830:134:3::10]:40927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83aR-0002Ca-GO
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83Yu-00084G-3S
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:07 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:35345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1g83Yt-00082O-Uu
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:04 -0400
Received: by mail-it1-f179.google.com with SMTP id p64-v6so13956367itp.0
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 06:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538652143.git.tgolembi@redhat.com>
	<b004cd17d0fa02ed169c5b101fdbbb7fa2b6b633.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <b004cd17d0fa02ed169c5b101fdbbb7fa2b6b633.1538652143.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 4 Oct 2018 17:20:50 +0400
Message-ID: <CAMxuvayviBgZXJJRiXNTd9Z2=tJZtkSjL-8RJODRM9NAtUufgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/11] qga-win: demystify namespace
 striping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tomas Golembiovsky <tgolembi@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Blake, Eric" <eblake@redhat.com>, sjubran@redhat.com, okrishtal@virtuozzo.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Thu, Oct 4, 2018 at 3:22 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@=
redhat.com> wrote:
>
> It was not obvious what exactly the cryptic string copying does to the
> GUID. This change makes the intent clearer.
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  qga/commands-win32.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index d0d969d0ce..82881aa749 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -507,7 +507,14 @@ static GuestPCIAddress *get_pci_info(char *guid, Err=
or **errp)
>      char dev_name[MAX_PATH];
>      char *buffer =3D NULL;
>      GuestPCIAddress *pci =3D NULL;
> -    char *name =3D g_strdup(&guid[4]);
> +    char *name =3D NULL;
> +
> +    if ((g_str_has_prefix(guid, "\\\\.\\") =3D=3D TRUE) ||
> +        (g_str_has_prefix(guid, "\\\\?\\") =3D=3D TRUE)) {
> +        name =3D g_strdup(&guid[4]);

I find "guid + 4" easier to read though

> +    } else {
> +        name =3D g_strdup(guid);
> +    }
>
>      if (!QueryDosDevice(name, dev_name, ARRAY_SIZE(dev_name))) {
>          error_setg_win32(errp, GetLastError(), "failed to get dos device=
 name");
> --
> 2.19.0
>
