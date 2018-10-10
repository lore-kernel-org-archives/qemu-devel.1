Received: from eggs.gnu.org ([2001:4830:134:3::10]:46989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gA6FE-0008UH-37
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 00:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gA6FA-0006rB-24
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 00:37:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gA6F9-0006qF-Rc
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 00:37:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7CC2369C9
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 04:37:06 +0000 (UTC)
Date: Wed, 10 Oct 2018 12:37:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181010043700.GO18728@xz-x1>
References: <20181009131251.721-1-marcandre.lureau@redhat.com>
	<20181009131251.721-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181009131251.721-5-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] monitor: check if chardev can switch
 gcontext for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Oct 09, 2018 at 05:12:49PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Note: this patch will conflict with Peter "[PATCH v9 3/6] monitor:
> remove "x-oob", turn oob on by default", but can be trivially updated.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index a25514490a..c175cf6f0d 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4550,9 +4550,10 @@ void monitor_init(Chardev *chr, int flags)
>      bool use_oob =3D flags & MONITOR_USE_OOB;
> =20
>      if (use_oob) {
> -        if (CHARDEV_IS_MUX(chr)) {
> +        if (!qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
>              error_report("Monitor out-of-band is not supported with "
> -                         "MUX typed chardev backend");
> +                         "%s typed chardev backend",
> +                         object_get_typename(OBJECT(chr)));

This seems a bit confusing to me at the first glance since we forbid
mux because not all frontends are ready to run outside main loop (and
now we have mon_iothread so it'll be odd too to run anything
non-monitor on that too...), rather than whether the backend can
dynamically switch its context.

I'm not sure, but do you mean you want to disable oob for backends
like spice or braille?  I just noticed that it seems even legal if we
pipe a qmp monitor with a windows mouse...

I believe in all cases the commit message can be enhanced on
explaining "why" of this patch. :)

Regards,

--=20
Peter Xu
