Received: from eggs.gnu.org ([2001:4830:134:3::10]:41440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eX5Gy-00027w-Ky
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eX5Gs-00062N-KL
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:09:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eX5Gs-00061R-EV
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:09:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BE2F8762C
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 13:09:21 +0000 (UTC)
Date: Thu, 4 Jan 2018 21:09:07 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180104130907.GR2557@xz-mi>
References: <20180104104336.2794-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180104104336.2794-1-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/3] chardev: convert leftover glib APIs
 to use dedicate gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu, Jan 04, 2018 at 06:43:33PM +0800, Peter Xu wrote:
> v3:
> - rename function to qemu_chr_timeout_add_ms() [Stefan]
> - add comment on return code [Stefan]
> - add comment in commit message on why change GSource name [Stefan]
>=20
> v2:
> - add r-bs
> - fix patch 3 on some s->ms conversion [Marc-Andr=C3=A9]
>=20
> There were existing work that tried to allow chardev to be run in a
> dedicated gcontext rather than the default main context/thread.
> Basically that work passed in the correct gcontext during
> g_source_attach().  However, I found something missing along the way,
> that some legacy glib APIs are used by chardev code which take the
> main context as default:
>=20
>    g_timeout_add_seconds
>    g_timeout_add
>    g_idle_add

Self NAK.

I just noticed something more critical: these calls are still managing
gsources using IDs rather than GSource objects.  That should not work,
especially if we want to remove these events using g_source_remove().
That can be fairly dangerous after OOB series merged.  I need to use
GSource objects to replace the tag IDs.

I'll prepare another version tomorrow.  Sorry for the troublesome.

>=20
> To fully allow the chardevs to be run in dedicated gcontext, we need
> to convert all these legacy APIs into g_source_attach() calls as well,
> with the correct gcontext passed in.
>=20
> This series tries to clean the rest of things up.
>=20
> I picked up patch 1 from monitor-oob series into this series (which is
> a missing of chardev frontend call fix for g_source_attach()), so that
> this series can be a complete fix.
>=20
> Please review.  Thanks,
>=20
> Peter Xu (3):
>   chardev: use backend chr context when watch for fe
>   chardev: let g_idle_add() be with chardev gcontext
>   chardev: introduce qemu_chr_timeout_add_ms()
>=20
>  chardev/char-fe.c      |  2 +-
>  chardev/char-pty.c     | 16 ++++++++--------
>  chardev/char-socket.c  |  6 ++++--
>  chardev/char.c         | 21 +++++++++++++++++++++
>  hw/char/terminal3270.c |  7 ++++---
>  include/chardev/char.h |  3 +++
>  6 files changed, 41 insertions(+), 14 deletions(-)
>=20
> --=20
> 2.14.3
>=20

--=20
Peter Xu
