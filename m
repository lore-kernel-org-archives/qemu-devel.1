Received: from eggs.gnu.org ([2001:4830:134:3::10]:38962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fvmJB-0004Aa-7x
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fvmJA-0007ji-EU
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:30:05 -0400
References: <20180831145314.14736-1-marcandre.lureau@redhat.com>
	<20180831145314.14736-4-marcandre.lureau@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <721c3a96-60a3-0d74-80d6-586d5bb7a2e1@weilnetz.de>
Date: Fri, 31 Aug 2018 18:29:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180831145314.14736-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] RFC: delete PID file on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Am 31.08.2018 um 16:53 schrieb Marc-Andr=C3=A9 Lureau:
[...]
> +static const char *pid_file;
> +
> +static void qemu_unlink_pidfile(void)
> +{
> +    if (pid_file) {
> +        unlink(pid_file);
> +    }
> +}
> +
>  bool machine_init_done;
> =20
>  void qemu_add_machine_init_done_notifier(Notifier *notify)
> @@ -2927,7 +2936,6 @@ int main(int argc, char **argv, char **envp)
>      const char *vga_model =3D NULL;
>      const char *qtest_chrdev =3D NULL;
>      const char *qtest_log =3D NULL;
> -    const char *pid_file =3D NULL;
>      const char *incoming =3D NULL;
>      bool userconfig =3D true;
>      bool nographic =3D false;
> @@ -4000,6 +4008,7 @@ int main(int argc, char **argv, char **envp)
>          error_reportf_err(err, "cannot create PID file: ");
>          exit(1);
>      }
> +    atexit(qemu_unlink_pidfile);


Could qemu_unlink_pidfile be combined with qemu_run_exit_notifiers to
avoid an additional call of atexit from the same function (main)?

Even if there is support for 32 or more atexit calls, it might be good
to be a little bit more restrictive.

Regards
Stefan
