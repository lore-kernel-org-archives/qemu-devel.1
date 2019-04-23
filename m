Received: from eggs.gnu.org ([209.51.188.92]:53886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hIpXZ-0001L7-QT
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hIpOJ-0004tZ-U0
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:58:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:32987)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hIpOJ-0004qi-LY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:58:55 -0400
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Tue, 23 Apr 2019 06:58:44 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78060D6618@shsmsx102.ccr.corp.intel.com>
References: <20190420191425.7d1dab82@luklap>
In-Reply-To: <20190420191425.7d1dab82@luklap>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] net/colo-compare.c: Fix a crash in COLO
 Primary.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lukas Straub <lukasstraub2@web.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> -----Original Message-----
> From: Lukas Straub [mailto:lukasstraub2@web.de]
> Sent: Sunday, April 21, 2019 1:14 AM
> To: qemu-devel@nongnu.org
> Cc: Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH v2] net/colo-compare.c: Fix a crash in COLO Primary.
>=20
> From: Lukas Straub <lukasstraub2@web.de> Because event_unhandled_count
> may be accessed concurrently, it needs to be protected by taking the lock=
.
> However the assert is outside the lock, probably causing it to read garba=
ge and
> aborting Qemu erroneously.
>=20
> The Bug only happens when running Qemu in COLO mode.
>=20
> This Patch fixes the following bug:
> https://bugs.launchpad.net/qemu/+bug/1824622
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Looks good for me.

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Zhang Chen

> ---
>  net/colo-compare.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> bf10526f05..fcb491121b 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -813,9 +813,8 @@ static void colo_compare_handle_event(void *opaque)
>          break;
>      }
>=20
> -    assert(event_unhandled_count > 0);
> -
>      qemu_mutex_lock(&event_mtx);
> +    assert(event_unhandled_count > 0);
>      event_unhandled_count--;
>      qemu_cond_broadcast(&event_complete_cond);
>      qemu_mutex_unlock(&event_mtx);
> --
> 2.20.1
