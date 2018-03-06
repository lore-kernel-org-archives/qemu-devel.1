Received: from eggs.gnu.org ([2001:4830:134:3::10]:51276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etCjE-0002Ud-Q0
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etCjD-0007GR-RE
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:34:04 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etCjD-0007Fe-MF
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:34:03 -0500
Received: by mail-ot0-x242.google.com with SMTP id w38so18310294ota.8
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:34:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306132430.32110-1-berrange@redhat.com>
References: <20180306132430.32110-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 13:33:42 +0000
Message-ID: <CAFEAcA95xt-9MJHcRC7WovEB3W259_eFD7Q8v_pG5rGh3L7oCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] misc: don't use hwaddr as a type in trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 6 March 2018 at 13:24, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> Use types that are defined by QEMU in trace events caused build failures
> for the UST trace backend:
>
>   In file included from trace-ust-all.c:13:0:
>   trace-ust-all.h:11844:206: error: unknown type name =E2=80=98hwaddr=E2=
=80=99
>
> It only knows about C built-in types, and any types that are pulled in
> from includs of qemu-common.h and lttng/tracepoint.h. This does not
> include the 'hwaddr' type, so replace it with a uint64_t which is what
> exec/hwaddr.h defines 'hwaddr' as. This fixes the build failure
> introduced by
>
>   commit 9eb8040c2d2b38e1a40bb6129b1b668fa178fcab
>   Author: Peter Maydell <peter.maydell@linaro.org>
>   Date:   Fri Mar 2 10:45:39 2018 +0000
>
>     hw/misc/tz-ppc: Model TrustZone peripheral protection controller
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

Oops.

> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -92,8 +92,8 @@ tz_ppc_cfg_sec_resp(int level) "TZ PPC: cfg_sec_resp =
=3D %d"
>  tz_ppc_irq_enable(int level) "TZ PPC: int_enable =3D %d"
>  tz_ppc_irq_clear(int level) "TZ PPC: int_clear =3D %d"
>  tz_ppc_update_irq(int level) "TZ PPC: setting irq line to %d"
> -tz_ppc_read_blocked(int n, hwaddr offset, bool secure, bool user) "TZ PP=
C: port %d offset 0x%" HWADDR_PRIx " read (secure %d user %d) blocked"
> -tz_ppc_write_blocked(int n, hwaddr offset, bool secure, bool user) "TZ P=
PC: port %d offset 0x%" HWADDR_PRIx " write (secure %d user %d) blocked"
> +tz_ppc_read_blocked(int n, uint64_t offset, bool secure, bool user) "TZ =
PPC: port %d offset 0x%" HWADDR_PRIx " read (secure %d user %d) blocked"
> +tz_ppc_write_blocked(int n, uint64_t offset, bool secure, bool user) "TZ=
 PPC: port %d offset 0x%" HWADDR_PRIx " write (secure %d user %d) blocked"


If the type isn't "hwaddr" then HWADDR_PRIx is the wrong
format string macro -- those should change to PRIx64.

thanks
-- PMM
