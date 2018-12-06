Received: from eggs.gnu.org ([2001:4830:134:3::10]:40384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUn11-0003qZ-0e
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUmq9-0002RY-N7
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:08:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUmq7-0002K7-IE
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:08:49 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181205203737.9011-1-marcandre.lureau@redhat.com>
	<20181205203737.9011-5-marcandre.lureau@redhat.com>
Date: Thu, 06 Dec 2018 07:08:23 +0100
In-Reply-To: <20181205203737.9011-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 6 Dec 2018 00:37:34 +0400")
Message-ID: <87bm5zkx0o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 4/7] monitor: check if chardev
 can switch gcontext for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>, peterx@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

One more question...

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Not all backends are able to switch gcontext. Those backends cannot
> drive a OOB monitor (the monitor would then be blocking on main
> thread).
>
> For example, ringbuf, spice, or more esoteric input chardevs like
> braille or MUX.

These chardevs don't provide QEMU_CHAR_FEATURE_GCONTEXT.

> We currently forbid MUX because not all frontends are ready to run
> outside main loop. Extend to add a context-switching feature check.

Why check CHARDEV_IS_MUX() when chardev-mux already fails the
qemu_char_feature_gcontext(chr, QEMU_CHAR_FEATURE_GCONTEXT) check?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 79afe99079..25cf4223e8 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4562,9 +4562,11 @@ void monitor_init(Chardev *chr, int flags)
>      bool use_oob =3D flags & MONITOR_USE_OOB;
>=20=20
>      if (use_oob) {
> -        if (CHARDEV_IS_MUX(chr)) {
> +        if (CHARDEV_IS_MUX(chr) ||
> +            !qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
>              error_report("Monitor out-of-band is not supported with "
> -                         "MUX typed chardev backend");
> +                         "%s typed chardev backend",
> +                         object_get_typename(OBJECT(chr)));
>              exit(1);
>          }
>          if (use_readline) {
