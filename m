Received: from eggs.gnu.org ([2001:4830:134:3::10]:35191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfny8-0000Fm-4J
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfny7-000877-2U
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:25:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cfny6-00086x-Sk
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:25:30 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2A10C05AA52
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 13:25:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170206132835.9440-1-marcandre.lureau@redhat.com>
Date: Mon, 20 Feb 2017 14:25:27 +0100
In-Reply-To: <20170206132835.9440-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 6 Feb 2017 17:28:35 +0400")
Message-ID: <877f4lyoxk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-option: reject empty number value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> When no number is provided, return an invalid number error.
> (note: this may break some users relying on default 0 value)
>
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1417864
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  util/qemu-option.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 3467dc2397..89afa4b2c3 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -150,7 +150,7 @@ static void parse_option_number(const char *name, con=
st char *value,
>=20=20
>      if (value !=3D NULL) {
>          number =3D strtoull(value, &postfix, 0);
> -        if (*postfix !=3D '\0') {
> +        if (*postfix !=3D '\0' || postfix =3D=3D value) {
>              error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name, "a numb=
er");
>              return;
>          }

My "[PATCH 09/24] QemuOpts: Fix to reject numbers that overflow
uint64_t" is a more comprehensive fix, even though I missed this case
both in the tests and the commit message.  I'll take care of that in v2.

Thanks!
