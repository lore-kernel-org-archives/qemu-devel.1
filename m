Received: from eggs.gnu.org ([209.51.188.92]:33511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gyc7G-0001j5-L8
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gyc7B-0001A9-NI
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:45:43 -0500
MIME-Version: 1.0
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-4-armbru@redhat.com>
In-Reply-To: <20190225183757.27378-4-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Feb 2019 13:45:13 +0100
Message-ID: <CAJ+F1CL-JmpC=MavsVk+-60Yn69O69tt9qXaqBQU0Lf+1irhfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/6] vl: Fix latent bug with -global
 and onboard devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Mon, Feb 25, 2019 at 7:41 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> main() registers the user's -global only after we create the machine
> object, i.e. too late for devices created in the machine's
> .instance_init().
>
> Fortunately, we know the bug is only latent: the commit before
> previous fixed a bug that would've crashed any attempt to create a
> device in an .instance_init().
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index c50c2d6178..e3fdce410f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2939,17 +2939,6 @@ static void user_register_global_props(void)
>                        global_init_func, NULL, NULL);
>  }
>
> -/*
> - * Note: we should see that these properties are actually having a
> - * priority: accel < machine < user. This means e.g. when user
> - * specifies something in "-global", it'll always be used with highest
> - * priority than either machine/accelerator compat properties.
> - */
> -static void register_global_properties(MachineState *ms)
> -{
> -    user_register_global_props();
> -}
> -
>  int main(int argc, char **argv, char **envp)
>  {
>      int i;
> @@ -3943,6 +3932,8 @@ int main(int argc, char **argv, char **envp)
>       */
>      loc_set_none();
>
> +    user_register_global_props();
> +
>      replay_configure(icount_opts);
>
>      if (incoming && !preconfig_exit_requested) {
> @@ -4248,12 +4239,6 @@ int main(int argc, char **argv, char **envp)
>                       machine_class->name, machine_class->deprecation_rea=
son);
>      }
>
> -    /*
> -     * Register all the global properties, including accel properties,
> -     * machine properties, and user-specified ones.
> -     */
> -    register_global_properties(current_machine);
> -
>      /*
>       * Migration object can only be created after global properties
>       * are applied correctly.
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau
