Received: from eggs.gnu.org ([2001:4830:134:3::10]:55685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f6wBQ-0007jS-Q7
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 06:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f6wBL-0002VO-V1
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 06:43:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f6wBL-0002Uu-QM
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 06:43:51 -0400
Received: by mail-it0-f65.google.com with SMTP id b5-v6so2643953itj.1
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 03:43:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180412061108.10875-1-peterx@redhat.com>
References: <20180412061108.10875-1-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Apr 2018 12:43:49 +0200
Message-ID: <CAMxuvaxKq-xQnMr=ab2qBDKoUSSqN+tMZFH+uwz_kHHs3MZJXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Apr 12, 2018 at 8:11 AM, Peter Xu <peterx@redhat.com> wrote:
> In the future the monitor iothread may be accessing the cur_mon as
> well (via monitor_qmp_dispatch_one()).  Before we introduce a real
> Out-Of-Band command, let's convert the cur_mon variable to be a
> per-thread variable to make sure there won't be a race between threads.
>
> Note that thread variables are not initialized to a valid value when new
> thread is created.  However for our case we don't need to set it up,
> since the cur_mon variable is only used in such a pattern:
>
>   old_mon =3D cur_mon;
>   cur_mon =3D xxx;
>   (do something, read cur_mon if necessary in the stack)
>   cur_mon =3D old_mon;
>
> It plays a role as stack variable, so no need to be initialized at all.
> We only need to make sure the variable won't be changed unexpectedly by
> other threads.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> v3:
> - fix code style warning from patchew
> v2:
> - drop qemu-thread changes
> ---
>  include/monitor/monitor.h | 2 +-
>  monitor.c                 | 2 +-
>  stubs/monitor.c           | 2 +-
>  tests/test-util-sockets.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index d6ab70cae2..2ef5e04b37 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -6,7 +6,7 @@
>  #include "qapi/qapi-types-misc.h"
>  #include "qemu/readline.h"
>
> -extern Monitor *cur_mon;
> +extern __thread Monitor *cur_mon;
>
>  /* flags for monitor_init */
>  /* 0x01 unused */
> diff --git a/monitor.c b/monitor.c
> index 39f8ee17ba..c90c31b6b3 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -266,7 +266,7 @@ static mon_cmd_t info_cmds[];
>
>  QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
>
> -Monitor *cur_mon;
> +__thread Monitor *cur_mon;
>
>  static QEMUClockType event_clock_type =3D QEMU_CLOCK_REALTIME;
>
> diff --git a/stubs/monitor.c b/stubs/monitor.c
> index e018c8f594..3890771bb5 100644
> --- a/stubs/monitor.c
> +++ b/stubs/monitor.c
> @@ -3,7 +3,7 @@
>  #include "qemu-common.h"
>  #include "monitor/monitor.h"
>
> -Monitor *cur_mon =3D NULL;
> +__thread Monitor *cur_mon;
>
>  int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
>  {
> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
> index acadd85e8f..6195a3ac36 100644
> --- a/tests/test-util-sockets.c
> +++ b/tests/test-util-sockets.c
> @@ -69,7 +69,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Er=
ror **errp)
>   * stubs/monitor.c is defined, to make sure monitor.o is discarded
>   * otherwise we get duplicate syms at link time.
>   */
> -Monitor *cur_mon;
> +__thread Monitor *cur_mon;
>  void monitor_init(Chardev *chr, int flags) {}
>
>
> --
> 2.14.3
>
