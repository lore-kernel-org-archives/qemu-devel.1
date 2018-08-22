Received: from eggs.gnu.org ([2001:4830:134:3::10]:36318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsXqB-0002dS-OR
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 14:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsXq7-0003Ib-5R
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 14:26:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fsXq6-0003Hy-RA
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 14:26:42 -0400
References: <20180822180259.26365-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <82e691b4-c2fe-5b68-91d8-ab2dd90ce691@redhat.com>
Date: Wed, 22 Aug 2018 13:26:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180822180259.26365-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RFC: chardev: mark the calls that allow an
 implicit mux monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>

On 08/22/2018 01:02 PM, Marc-Andr=C3=A9 Lureau wrote:
> This is mostly for readability of the code. Let's make it clear which
> callers can create an implicit monitor when the chardev is muxed.
>=20
> This will also enforce a safer behaviour, as we don't really support
> creating monitor anywhere/anytime at the moment.
>=20
> There are documented cases, such as: -serial/-parallel/-virtioconsole
> and to less extent -debugcon.
>=20
> Less obvious and questionnable ones are -gdb and Xen console. Add a

s/questionnable/questionable/

> FIXME note for those, but keep the support for now.
>=20
> Other qemu_chr_new() callers either have a fixed parameter/filename
> string, or do preliminary checks on the string (such as slirp), or do
> not need it, such as -qtest.
>=20
> On a related note, the list of monitor creation places:
>=20
> - the chardev creators listed above: all from command line (except
>    perhaps Xen console?)
>=20
> - -gdb & hmp gdbserver will create a "GDB monitor command" chardev
>    that is wired to an HMP monitor.
>=20
> - -mon command line option
>=20
>>From this short study, I would like to think that a monitor may only
> be created in the main thread today, though I remain skeptical :)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   include/chardev/char.h | 18 +++++++++++++++++-
>   chardev/char.c         | 21 +++++++++++++++++----
>   gdbstub.c              |  6 +++++-
>   hw/char/xen_console.c  |  5 ++++-
>   vl.c                   |  8 ++++----
>   5 files changed, 47 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 6f0576e214..be2b9b817e 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -105,6 +105,7 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
>    * @qemu_chr_new:
>    *
>    * Create a new character backend from a URI.
> + * Do not implicitely initialize a monitor if the chardev is muxed.

s/implicitely/implicitly/

>    *
>    * @label the name of the backend
>    * @filename the URI
> @@ -113,6 +114,19 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts=
,
>    */
>   Chardev *qemu_chr_new(const char *label, const char *filename);
>  =20
> +/**
> + * @qemu_chr_new_mux_mon:
> + *
> + * Create a new character backend from a URI.
> + * Implicitely initialize a monitor if the chardev is muxed.

and again

> +++ b/gdbstub.c
> @@ -2038,7 +2038,11 @@ int gdbserver_start(const char *device)
>               sigaction(SIGINT, &act, NULL);
>           }
>   #endif
> -        chr =3D qemu_chr_new_noreplay("gdb", device);
> +        /*
> +         * FIXME: it's a bit weird to allow using a mux chardev here
> +         * and setup implicitely a monitor. We may want to break this.

s/setup implicitely/implicitly set up/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
