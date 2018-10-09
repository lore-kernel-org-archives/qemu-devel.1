Received: from eggs.gnu.org ([2001:4830:134:3::10]:47499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9oIf-0006TR-2r
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9oId-0001BT-5z
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:27:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9oIc-00019b-SY
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:27:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id x12-v6so998627wru.8
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 02:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-12-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-12-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 13:27:16 +0400
Message-ID: <CAJ+F1CJ9p9Vib50dQ-x9TJ3BBzqaSFXXWrF97mdaHaNj76PAmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/31] migration: Fix
 !replay_can_snapshot() error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi
On Mon, Oct 8, 2018 at 9:33 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  save_snapshot() and load_snapshot() do that, and then
> fail without setting an error.  Wrong.  The HMP commands survive this
> unscathed, since hmp_handle_error() does nothing when no error has
> been set.  Callers main() (on behalf of -loadvm) and
> replay_vmstate_init() crash, but I'm not sure the error is possible
> there.
>
> Screwed up when commit 377b21ccea1 (v2.12.0) added incorrect error
> handling right next to correct examples.  Fix by calling error_setg()
> instead of error_report().
>
> Fixes: 377b21ccea1755a8b0dae822c29567c58dda6939
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  migration/savevm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 2d10e45582..5f8eb38676 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2414,8 +2414,8 @@ int save_snapshot(const char *name, Error **errp)
>      AioContext *aio_context;
>
>      if (!replay_can_snapshot()) {
> -        error_report("Record/replay does not allow making snapshot "
> -                     "right now. Try once more later.");
> +        error_setg(errp, "Record/replay does not allow making snapshot "
> +                   "right now. Try once more later.");
>          return ret;
>      }
>
> @@ -2611,8 +2611,8 @@ int load_snapshot(const char *name, Error **errp)
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>
>      if (!replay_can_snapshot()) {
> -        error_report("Record/replay does not allow loading snapshot "
> -                     "right now. Try once more later.");
> +        error_setg(errp, "Record/replay does not allow loading snapshot =
"
> +                   "right now. Try once more later.");
>          return -EINVAL;
>      }
>
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
