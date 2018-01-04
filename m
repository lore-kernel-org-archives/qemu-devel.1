Received: from eggs.gnu.org ([2001:4830:134:3::10]:34018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eX6Xg-0001Hz-1x
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eX6XW-0002t7-Ky
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:30:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eX6XW-0002rX-BA
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:30:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B68EC0587C7
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 14:30:37 +0000 (UTC)
References: <20180104141835.17987-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f86c7066-828f-3aeb-aaaf-e62d2f4ca8e6@redhat.com>
Date: Thu, 4 Jan 2018 15:30:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180104141835.17987-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/3] chardev: convert leftover glib APIs
 to use dedicate gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 04/01/2018 15:18, Peter Xu wrote:
> v4:
> - replace all timers from gsource tag IDs into gsource objects,
>   otherwise g_source_remove() on that tag ID can errornously remove an
>   gsource from default main context rather than the timer itself.
>=20
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
>  chardev/char-pty.c     | 64 +++++++++++++++++++++++++-----------------=
--------
>  chardev/char-socket.c  | 28 ++++++++++++++--------
>  chardev/char.c         | 18 ++++++++++++++
>  hw/char/terminal3270.c | 28 ++++++++++++----------
>  include/chardev/char.h |  3 +++
>  6 files changed, 88 insertions(+), 55 deletions(-)
>=20

Queued, thanks.

Paolo
