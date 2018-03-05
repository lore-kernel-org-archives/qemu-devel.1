Received: from eggs.gnu.org ([2001:4830:134:3::10]:45861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1esobY-0001Qc-3g
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1esobV-0007re-0J
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:48:32 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1esobU-0007rW-RO
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:48:28 -0500
Received: by mail-qt0-f195.google.com with SMTP id j4so19927299qth.8
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 03:48:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305065040.10353-2-peterx@redhat.com>
References: <20180305065040.10353-1-peterx@redhat.com>
	<20180305065040.10353-2-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 5 Mar 2018 12:48:27 +0100
Message-ID: <CAMxuvazSk=YL9boVBbJ6vb74zRXqEasPnp60Aj_JbjAbn=7i0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9] vl: export machine_init_done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

Hi

On Mon, Mar 5, 2018 at 7:50 AM, Peter Xu <peterx@redhat.com> wrote:
> We have that variable but not exported.  Export that so modules can have
> a way to poke on whether machine init has finished.

Which modules?

> Meanwhile, set that up even before calling the notifiers, so that
> notifiers who may depend on this field will get a correct answer.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/sysemu/sysemu.h   | 2 ++
>  stubs/machine-init-done.c | 2 ++
>  vl.c                      | 4 ++--
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 77bb3da582..3f0f35610b 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -86,6 +86,8 @@ void qemu_system_guest_panicked(GuestPanicInformation *=
info);
>  void qemu_add_exit_notifier(Notifier *notify);
>  void qemu_remove_exit_notifier(Notifier *notify);
>
> +extern bool machine_init_done;
> +
>  void qemu_add_machine_init_done_notifier(Notifier *notify);
>  void qemu_remove_machine_init_done_notifier(Notifier *notify);
>
> diff --git a/stubs/machine-init-done.c b/stubs/machine-init-done.c
> index 9a0d62514f..4121f1709b 100644
> --- a/stubs/machine-init-done.c
> +++ b/stubs/machine-init-done.c
> @@ -2,6 +2,8 @@
>  #include "qemu-common.h"
>  #include "sysemu/sysemu.h"
>
> +bool machine_init_done =3D true;
> +
>  void qemu_add_machine_init_done_notifier(Notifier *notify)
>  {
>  }
> diff --git a/vl.c b/vl.c
> index a33ac008fb..57777e8d47 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2712,7 +2712,7 @@ static void qemu_run_exit_notifiers(void)
>      notifier_list_notify(&exit_notifiers, NULL);
>  }
>
> -static bool machine_init_done;
> +bool machine_init_done;
>
>  void qemu_add_machine_init_done_notifier(Notifier *notify)
>  {
> @@ -2729,8 +2729,8 @@ void qemu_remove_machine_init_done_notifier(Notifie=
r *notify)
>
>  static void qemu_run_machine_init_done_notifiers(void)
>  {
> -    notifier_list_notify(&machine_init_done_notifiers, NULL);
>      machine_init_done =3D true;
> +    notifier_list_notify(&machine_init_done_notifiers, NULL);
>  }
>
>  static const QEMUOption *lookup_opt(int argc, char **argv,
> --
> 2.14.3
>
