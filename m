Received: from eggs.gnu.org ([2001:4830:134:3::10]:46210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fAeUy-00046L-3o
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fAeUx-0008IL-0o
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:39:28 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fAeUw-0008He-Pm
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:39:26 -0400
Received: by mail-wr0-x243.google.com with SMTP id c14-v6so2969157wrd.4
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 09:39:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d8f2677fdb9c4d261b6c0f80ca0fd4ce5ef6efba.1524247455.git.tgolembi@redhat.com>
References: <d8f2677fdb9c4d261b6c0f80ca0fd4ce5ef6efba.1524247455.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 23 Apr 2018 18:39:24 +0200
Message-ID: <CAJ+F1CLL11fjy_a3D0LCmAqTXT027yadMKpOzCWDZ00m4bU6-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] test-qga: add trivial tests for some
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Fri, Apr 20, 2018 at 8:04 PM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolemb=
i@redhat.com> wrote:
> These commands did not get their tests in the original commits:
> - guest-get-host-name
> - guest-get-timezone
> - guest-get-users
>
> Trivial tests that mostly only call the commands were added.
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>


thank you:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/test-qga.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/tests/test-qga.c b/tests/test-qga.c
> index e6ab788f31..503f48bacf 100644
> --- a/tests/test-qga.c
> +++ b/tests/test-qga.c
> @@ -856,6 +856,54 @@ static void test_qga_guest_exec_invalid(gconstpointe=
r fix)
>      QDECREF(ret);
>  }
>
> +static void test_qga_guest_get_host_name(gconstpointer fix)
> +{
> +    const TestFixture *fixture =3D fix;
> +    QDict *ret, *val;
> +
> +    ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-get-host-name'}");
> +    g_assert_nonnull(ret);
> +    qmp_assert_no_error(ret);
> +
> +    val =3D qdict_get_qdict(ret, "return");
> +    g_assert(qdict_haskey(val, "host-name"));
> +
> +    QDECREF(ret);
> +}
> +
> +static void test_qga_guest_get_timezone(gconstpointer fix)
> +{
> +    const TestFixture *fixture =3D fix;
> +    QDict *ret, *val;
> +
> +    ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-get-timezone'}");
> +    g_assert_nonnull(ret);
> +    qmp_assert_no_error(ret);
> +
> +    /* Make sure there's at least offset */
> +    val =3D qdict_get_qdict(ret, "return");
> +    g_assert(qdict_haskey(val, "offset"));
> +
> +    QDECREF(ret);
> +}
> +
> +static void test_qga_guest_get_users(gconstpointer fix)
> +{
> +    const TestFixture *fixture =3D fix;
> +    QDict *ret;
> +    QList *val;
> +
> +    ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-get-users'}");
> +    g_assert_nonnull(ret);
> +    qmp_assert_no_error(ret);
> +
> +    /* There is not much to test here */
> +    val =3D qdict_get_qlist(ret, "return");
> +    g_assert_nonnull(val);
> +
> +    QDECREF(ret);
> +}
> +
>  static void test_qga_guest_get_osinfo(gconstpointer data)
>  {
>      TestFixture fixture;
> @@ -948,6 +996,12 @@ int main(int argc, char **argv)
>                           test_qga_guest_exec_invalid);
>      g_test_add_data_func("/qga/guest-get-osinfo", &fix,
>                           test_qga_guest_get_osinfo);
> +    g_test_add_data_func("/qga/guest-get-host-name", &fix,
> +                         test_qga_guest_get_host_name);
> +    g_test_add_data_func("/qga/guest-get-timezone", &fix,
> +                         test_qga_guest_get_timezone);
> +    g_test_add_data_func("/qga/guest-get-users", &fix,
> +                         test_qga_guest_get_users);
>
>      ret =3D g_test_run();
>
> --
> 2.17.0
>
>



--=20
Marc-Andr=C3=A9 Lureau
