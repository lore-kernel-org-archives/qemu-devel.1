Received: from eggs.gnu.org ([2001:4830:134:3::10]:40431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dk4bg-0000Di-HI
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dk4bb-0003iN-Kv
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:32:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dk4bb-0003hs-Eu
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:32:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AE51356F9
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 08:32:10 +0000 (UTC)
Date: Tue, 22 Aug 2017 04:32:08 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1341095109.1432760.1503390728412.JavaMail.zimbra@redhat.com>
In-Reply-To: <1503384739-17207-1-git-send-email-armbru@redhat.com>
References: <1503384739-17207-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qobject: Explain how QNum works, and why
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com



----- Original Message -----
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/qapi/qmp/qnum.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
> index 09d745c..9182129 100644
> --- a/include/qapi/qmp/qnum.h
> +++ b/include/qapi/qmp/qnum.h
> @@ -23,6 +23,27 @@ typedef enum {
>      QNUM_DOUBLE
>  } QNumKind;
> =20
> +/*
> + * QNum encapsulates how our dialect of JSON fills in the blanks left
> + * by the JSON specification (RFC 7159) regarding numbers.
> + *
> + * Conceptually, we treat number as an abstract type with three
> + * concrete subtypes: floating-point, signed integer, unsigned
> + * integer.  QNum implements this a discriminated union of double,
> + * int64_t, uint64_t.
> + *
> + * The JSON parser picks the subtype as follows.  If the number has a
> + * decimal point or an exponent, it is floating-point.  Else if it
> + * fits into int64_t, it's signed integer.  Else if it first into
> + * uint64_t, it's unsigned integer.  Else it's floating-point.
> + *
> + * Any number can serve as double: qnum_get_double() converts under
> + * the hood.
> + *
> + * An integer can serve as signed / unsigned integer as long as it is
> + * in range: qnum_get_try_int() / qnum_get_try_uint() check range and
> + * convert under the hood.
> + */
>  typedef struct QNum {
>      QObject base;
>      QNumKind kind;
> --
> 2.7.5
>=20
>=20
