Received: from eggs.gnu.org ([2001:4830:134:3::10]:35956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXjxZ-0007ZO-Up
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXjxU-0004XA-4i
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:08:25 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:41614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXjxT-0004Wk-V5
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:08:20 -0400
Received: by mail-ot0-x241.google.com with SMTP id d19-v6so18221508oti.8
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 02:08:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622042437.14259-1-david@gibson.dropbear.id.au>
References: <20180622042437.14259-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 10:07:58 +0100
Message-ID: <CAFEAcA_qv=PEzDOh8FB5F-uhbbtHrr7nRWPjXehyjkmj_cJ-AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/23] ppc/pnv: introduce a new
 intc_create() operation to the chip model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On 22 June 2018 at 05:24, David Gibson <david@gibson.dropbear.id.au> wrote:
> From: C=C3=A9dric Le Goater <clg@kaod.org>
>
> On Power9, the thread interrupt presenter has a different type and is
> linked to the chip owning the cores.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/pnv.c         | 21 +++++++++++++++++++--
>  hw/ppc/pnv_core.c    | 18 +++++++++---------
>  include/hw/ppc/pnv.h |  1 +
>  3 files changed, 29 insertions(+), 11 deletions(-)

Hi; Coverity points out a bug (CID 1393617) in this patch
(which is commit d35aefa9ae150a):

> @@ -143,13 +144,12 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
>      void *obj;
>      int i, j;
>      char name[32];
> -    Object *xi;
> +    Object *chip;
>
> -    xi =3D object_property_get_link(OBJECT(dev), "xics", &local_err);
> -    if (!xi) {
> -        error_setg(errp, "%s: required link 'xics' not found: %s",
> -                   __func__, error_get_pretty(local_err));
> -        return;
> +    chip =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
> +    if (!chip) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "required link 'chip' not found: ");
>      }

We check for a NULL 'chip' pointer, but forget the 'return', so
execution will plough on through to the code below and eventually
dereference the NULL pointer and segfault.

thanks
-- PMM
