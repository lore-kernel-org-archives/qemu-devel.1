Received: from eggs.gnu.org ([2001:4830:134:3::10]:34298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fJIDa-00058Y-Ol
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fJIDZ-00051C-1R
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:41:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41296 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fJIDY-00050O-Rm
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:41:12 -0400
Date: Thu, 17 May 2018 14:41:09 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20180517124109.GJ17734@vader>
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180515113348.10516-2-zyimin@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.ibm.com>
Cc: qemu-devel@nongnu.org, jtomko@redhat.com, jferlan@redhat.com, berrange@redhat.com, borntraeger@de.ibm.com, fiuczy@linux.ibm.com

On 15/05/2018 - 19:33:48, Yi Min Zhao wrote:
> If CONFIG_SECCOMP is undefined, the option 'elevateprivileges' remains
> compiled. This would make libvirt set the corresponding capability and
> then trigger the guest startup fails. So this patch excludes the code
> regarding seccomp staff if CONFIG_SECCOMP is undefined.

Just a sugestion for the next patch you send: If it's a single patch, you=
 don't
need to format it with a cover-letter. Just put all the description in th=
e body,
or if you need to add a text that shouldn't be included in the commit mes=
sage,
just add it after the "---" after Signed-off-by.

>=20
> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> ---
>  vl.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/vl.c b/vl.c
> index 806eec2ef6..b22d158f5f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -257,6 +257,7 @@ static QemuOptsList qemu_rtc_opts =3D {
>      },
>  };
> =20
> +#ifdef CONFIG_SECCOMP
>  static QemuOptsList qemu_sandbox_opts =3D {
>      .name =3D "sandbox",
>      .implied_opt_name =3D "enable",
> @@ -285,6 +286,7 @@ static QemuOptsList qemu_sandbox_opts =3D {
>          { /* end of list */ }
>      },
>  };
> +#endif
> =20
>  static QemuOptsList qemu_option_rom_opts =3D {
>      .name =3D "option-rom",
> @@ -1041,10 +1043,10 @@ static int bt_parse(const char *opt)
>      return 1;
>  }
> =20
> +#ifdef CONFIG_SECCOMP
>  static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      if (qemu_opt_get_bool(opts, "enable", false)) {
> -#ifdef CONFIG_SECCOMP
>          uint32_t seccomp_opts =3D QEMU_SECCOMP_SET_DEFAULT
>                  | QEMU_SECCOMP_SET_OBSOLETE;
>          const char *value =3D NULL;
> @@ -1114,14 +1116,11 @@ static int parse_sandbox(void *opaque, QemuOpts=
 *opts, Error **errp)
>                           "in the kernel");
>              return -1;
>          }
> -#else
> -        error_report("seccomp support is disabled");
> -        return -1;
> -#endif

Any reason not to keep the error message on the new #endif location?

>      }
> =20
>      return 0;
>  }
> +#endif
> =20
>  static int parse_name(void *opaque, QemuOpts *opts, Error **errp)
>  {
> @@ -3074,7 +3073,9 @@ int main(int argc, char **argv, char **envp)
>      qemu_add_opts(&qemu_mem_opts);
>      qemu_add_opts(&qemu_smp_opts);
>      qemu_add_opts(&qemu_boot_opts);
> +#ifdef CONFIG_SECCOMP
>      qemu_add_opts(&qemu_sandbox_opts);
> +#endif
>      qemu_add_opts(&qemu_add_fd_opts);
>      qemu_add_opts(&qemu_object_opts);
>      qemu_add_opts(&qemu_tpmdev_opts);
> @@ -4071,10 +4072,12 @@ int main(int argc, char **argv, char **envp)
>          exit(1);
>      }
> =20
> +#ifdef CONFIG_SECCOMP
>      if (qemu_opts_foreach(qemu_find_opts("sandbox"),
>                            parse_sandbox, NULL, NULL)) {
>          exit(1);
>      }
> +#endif
> =20
>      if (qemu_opts_foreach(qemu_find_opts("name"),
>                            parse_name, NULL, NULL)) {
> --=20
> Yi Min
>=20

I just wanted a review from J=C3=A1n, since he is the author of the origi=
nal libvirt
patch. Does this breaks libvirt logic in any way? If not, ACK on this pat=
ch.
