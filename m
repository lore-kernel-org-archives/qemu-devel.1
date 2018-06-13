Received: from eggs.gnu.org ([2001:4830:134:3::10]:60947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT1mq-00074n-CP
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT1mn-0004VM-60
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:09:52 -0400
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:40853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fT1mm-0004Tz-Vt
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:09:49 -0400
Received: from player762.ha.ovh.net (unknown [10.109.105.97])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 6597C107C33
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 11:09:47 +0200 (CEST)
Date: Wed, 13 Jun 2018 11:09:39 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180613110939.28d30cf0@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20180613065707.30766-3-david@gibson.dropbear.id.au>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] pnv: Add missing error check during
 cpu realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Wed, 13 Jun 2018 16:57:02 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> In pnv_core_realize() we call two functions with an Error * parameter in
> succession, which means if they both cause errors we'll lose the first one.

Not exactly. The error code doesn't allow that and QEMU will abort.

static void error_setv(Error **errp,
                       const char *src, int line, const char *func,
                       ErrorClass err_class, const char *fmt, va_list ap,
                       const char *suffix)
{
    Error *err;
    int saved_errno = errno;

    if (errp == NULL) {
        return;
    }
    assert(*errp == NULL);


> Add an extra test/escape to fix this.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/pnv_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 13ad7d9e04..efb68226bb 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -173,6 +173,9 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>  
>          snprintf(name, sizeof(name), "thread[%d]", i);
>          object_property_add_child(OBJECT(pc), name, obj, &local_err);
> +        if (local_err) {
> +            goto err;
> +        }
>          object_property_add_alias(obj, "core-pir", OBJECT(pc),
>                                    "pir", &local_err);
>          if (local_err) {

Hmm... the current error path seems to assume failures to be
caused by object_property_add_child(). It hence unparents the
previously parented CPUs, but not the current one. So we'll
miss one call to object_unparent() if object_property_add_alias()
fails.
