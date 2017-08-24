Received: from eggs.gnu.org ([2001:4830:134:3::10]:43844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkqPE-0003DK-5F
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkqPD-0002pi-21
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:34:36 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:37317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dkqPC-0002p5-TQ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:34:34 -0400
Received: by mail-vk0-x242.google.com with SMTP id c81so896712vkd.4
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 04:34:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503564371-26090-12-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-12-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 24 Aug 2017 13:34:33 +0200
Message-ID: <CAJ+F1CK3pn1_TJLURmeP0B9YakReDORCc5FxW8HKvoyYqJhjbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/16] qapi: Avoid unnecessary use of enum
 lookup table's sentinel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, Aug 24, 2017 at 10:46 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Currently, the FOO_lookup[] generated for QAPI enum types are
> terminated by a NULL sentinel.
>
> A future patch will generate enums with "holes".  NULL-termination
> will cease to work then.
>
> To prepare for that, replace "have we reached the sentinel?"
> predicates by "have we reached the FOO__MAX value?" predicates.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  monitor.c                          | 4 ++--
>  tests/test-qobject-input-visitor.c | 2 +-
>  tests/test-string-input-visitor.c  | 2 +-
>  ui/input-legacy.c                  | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index e0f8801..b45f55d 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3249,7 +3249,7 @@ void netdev_add_completion(ReadLineState *rs, int n=
b_args, const char *str)
>      }
>      len =3D strlen(str);
>      readline_set_completion_index(rs, len);
> -    for (i =3D 0; NetClientDriver_lookup[i]; i++) {
> +    for (i =3D 0; i < NET_CLIENT_DRIVER__MAX; i++) {
>          add_completion_option(rs, str, NetClientDriver_lookup[i]);
>      }
>  }
> @@ -3537,7 +3537,7 @@ void watchdog_action_completion(ReadLineState *rs, =
int nb_args, const char *str)
>          return;
>      }
>      readline_set_completion_index(rs, strlen(str));
> -    for (i =3D 0; WatchdogExpirationAction_lookup[i]; i++) {
> +    for (i =3D 0; i < WATCHDOG_EXPIRATION_ACTION__MAX; i++) {
>          add_completion_option(rs, str, WatchdogExpirationAction_lookup[i=
]);
>      }
>  }
> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
> index bcf0261..5bbfb65 100644
> --- a/tests/test-qobject-input-visitor.c
> +++ b/tests/test-qobject-input-visitor.c
> @@ -382,7 +382,7 @@ static void test_visitor_in_enum(TestInputVisitorData=
 *data,
>      Visitor *v;
>      EnumOne i;
>
> -    for (i =3D 0; EnumOne_lookup[i]; i++) {
> +    for (i =3D 0; i < ENUM_ONE__MAX; i++) {
>          EnumOne res =3D -1;
>
>          v =3D visitor_input_test_init(data, "%s", EnumOne_lookup[i]);
> diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-=
visitor.c
> index 79313a7..e7a7b80 100644
> --- a/tests/test-string-input-visitor.c
> +++ b/tests/test-string-input-visitor.c
> @@ -279,7 +279,7 @@ static void test_visitor_in_enum(TestInputVisitorData=
 *data,
>      Visitor *v;
>      EnumOne i;
>
> -    for (i =3D 0; EnumOne_lookup[i]; i++) {
> +    for (i =3D 0; i < ENUM_ONE__MAX; i++) {
>          EnumOne res =3D -1;
>
>          v =3D visitor_input_test_init(data, EnumOne_lookup[i]);
> diff --git a/ui/input-legacy.c b/ui/input-legacy.c
> index 7159747..a5f1e82 100644
> --- a/ui/input-legacy.c
> +++ b/ui/input-legacy.c
> @@ -61,7 +61,7 @@ int index_from_key(const char *key, size_t key_length)
>  {
>      int i;
>
> -    for (i =3D 0; QKeyCode_lookup[i] !=3D NULL; i++) {
> +    for (i =3D 0; i < Q_KEY_CODE__MAX; i++) {
>          if (!strncmp(key, QKeyCode_lookup[i], key_length) &&
>              !QKeyCode_lookup[i][key_length]) {
>              break;
> --
> 2.7.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
