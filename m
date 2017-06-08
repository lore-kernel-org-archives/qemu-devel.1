Received: from eggs.gnu.org ([2001:4830:134:3::10]:59683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIzld-0006o4-D7
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIzla-0000GQ-7p
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:54:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIzlZ-0000GC-VO
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:54:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F307C05251D
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 15:54:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-7-marcandre.lureau@redhat.com>
Date: Thu, 08 Jun 2017 17:54:27 +0200
In-Reply-To: <20170607163635.17635-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 7 Jun 2017 20:35:58 +0400")
Message-ID: <87efuu5vbg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/43] qapi: merge QInt and QFloat in
 QNum
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

> We would like to use a same QObject type to represent numbers, whether
> they are int, uint, or floats. Getters will allow some compatibility
> between the various types if the number fits other representations.
>
> Add a few more tests while at it.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
> diff --git a/blockdev.c b/blockdev.c
> index 892d768574..154c95d402 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -334,9 +334,11 @@ static bool parse_stats_intervals(BlockAcctStats *st=
ats, QList *intervals,
>              break;
>          }
>=20=20
> -        case QTYPE_QINT: {
> -            int64_t length =3D qint_get_int(qobject_to_qint(entry->value=
));
> -            if (length > 0 && length <=3D UINT_MAX) {
> +        case QTYPE_QNUM: {
> +            int64_t length;
> +
> +            if (qnum_get_try_int(qobject_to_qnum(entry->value), &length)=
 &&
> +                length > 0 && length <=3D UINT_MAX) {
>                  block_acct_add_interval(stats, (unsigned) length);
>              } else {
>                  error_setg(errp, "Invalid interval length: %" PRId64, le=
ngth);

Less churn and a bit more legible:

  +        case QTYPE_QNUM: {
  +            int64_t length =3D qnum_get_int(qobject_to_qint(entry->value=
));
  +
  +            if (length > 0 && length <=3D UINT_MAX) {

Aborts when entry->value doesn't fit into int64_t, but that's no worse
than before.

[...]
> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
> index 3a6ce2226c..9e3d4aa7e5 100644
> --- a/tests/test-qobject-input-visitor.c
> +++ b/tests/test-qobject-input-visitor.c
> @@ -164,9 +164,9 @@ static void test_visitor_in_int_overflow(TestInputVis=
itorData *data,
>      Error *err =3D NULL;
>      Visitor *v;
>=20=20
> -    /* this will overflow a Qint/int64, so should be deserialized into
> -     * a QFloat/double field instead, leading to an error if we pass it
> -     * to visit_type_int. confirm this.
> +    /* this will overflow a QNUM_I64, so should be deserialized into a

Wing both ends and start with a capital letter, please:

  +    /*
  +     * This will overflow a QNUM_I64, so should be deserialized into a

> +     * QNUM_DOUBLE field instead, leading to an error if we pass it to
> +     * visit_type_int. confirm this.

Humor me:

        * visit_type_int().  Confirm this.

>       */
>      v =3D visitor_input_test_init(data, "%f", DBL_MAX);
>=20=20
[...]

With these minor touch-ups:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
