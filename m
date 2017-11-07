Received: from eggs.gnu.org ([2001:4830:134:3::10]:38907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asierra@xes-inc.com>) id 1eC5g7-0007hM-Ra
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asierra@xes-inc.com>) id 1eC5g2-00068T-0w
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:20:39 -0500
Received: from xes-mad.com ([216.165.139.220]:14437 helo=mail.xes-mad.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asierra@xes-inc.com>) id 1eC5g1-00068D-Sq
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:20:33 -0500
Date: Tue, 7 Nov 2017 09:20:32 -0600 (CST)
From: Aaron Sierra <asierra@xes-inc.com>
Message-ID: <1997067362.187762.1510068032954.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <c97adeea-32ee-269c-2a88-b011e8a294fa@vivier.eu>
References: <492245211.936616.1510023015797.JavaMail.zimbra@xes-inc.com>
	<c97adeea-32ee-269c-2a88-b011e8a294fa@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: Support explicit targets for
 PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel <qemu-devel@nongnu.org>

----- Original Message -----
> From: "Laurent Vivier" <laurent@vivier.eu>
> Sent: Tuesday, November 7, 2017 3:24:52 AM

> Le 07/11/2017 =E0 03:50, Aaron Sierra a =E9crit :
>> Enable building PowerPC targets supporting a specific CPU, without
>> having to set QEMU_CPU via the environment. For example these build
>> targets (and many more) become available:
>>=20
>> qemu-ppc.e500mc qemu-ppc.e500v2 qemu-ppc.e5500 qemu-ppc.e600
>> qemu-ppc.e6500
>>=20
>> These (statically compiled) binaries have proven useful for
>> emulating PowerPC CPUs within Docker containers, where it's hard to
>> reliably define environment variables that are available for every
>> process.
>>=20
>=20
> An other idea would be to extract the default cpu from argv[0].
>
> We don't change the default CPU at compile time, but we check the binary
> name:
> - if it's qemu-ppc, let's use the default cpu for qemu-ppc
> - if it's not qemu-ppc, but something like qemu-ppc.XXX, let's set the
> CPU to XXX. For instance "qemu-ppc.e600" will be a shortcut for
> "qemu-ppc -cpu e600". [1]
>=20
> I think it's easy to implement and don't change the default behavior of
> qemu. And you can use hardlink to define several binaries with different
> defaults (like busybox)

Laurent,

I had that thought, too, as being the cleanest and simplest to implement,
but it didn't work out as a practical solution. Having execution depend
on the name of the file would require a lot of tuning of magics, masks,
and interpreters in /proc/sys/fs/binfmt_misc to get the behavior that I
depend on. It would require one entry per binary.

With the implementation that I've proposed, I only need two fairly generic
entries (ppc and ppc64) stock from Ubuntu's qemu-user-static package.
With Docker it's trivial to bind <any_path>/qemu-ppc.e500mc to
/usr/bin/qemu-ppc-static within the container. Which gives me complete
control over how the container is emulated.

-Aaron S.

>=20
> Thanks,
> Laurent
>=20
> [1] something like:
>=20
> -- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -4165,6 +4165,7 @@ static void usage(int exitcode)
> static int parse_args(int argc, char **argv)
> {
>     const char *r;
> +    const char *cpuname;
>     int optind;
>     const struct qemu_argument *arginfo;
>=20
> @@ -4179,6 +4180,11 @@ static int parse_args(int argc, char **argv)
>         }
>     }
>=20
> +    cpuname =3D strrchr(argv[0], '.');
> +    if (cpuname && cpuname[1] !=3D 0) {
> +        cpu_model =3D strdup(cpuname + 1);
> +    }
> +
>     optind =3D 1;
>     for (;;) {
>          if (optind >=3D argc) {
