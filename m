Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC5FC2D0E5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1AB20733
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJ0QOz7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1AB20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIu3h-00053x-Ll
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jIu1s-0003yK-Hq
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jIu1q-0004ZL-Q8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:00:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jIu1q-0004Yu-L7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585573234;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiXFpwtyIFvOp9bpx3BPJHLPE2/PGEXiZ9/f4w+RWmw=;
 b=UJ0QOz7pRKMbRG6Fcfk3wq7QitvH0X0XxHTruTTihCsGNRrh9bq1TuJm5JHsW8+Ooj1PSK
 J9uOb70Znf8BgjnhC1tvHsFGxPqBsOdHq/31lU9ApsoHS80jZeCICGDOaaExQebpI7/MQq
 s+zXn+VF4fw/rr7ZWc83jqjlkWoS2s0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-SMwK4nNXPXiVsHb93G9hmQ-1; Mon, 30 Mar 2020 09:00:32 -0400
X-MC-Unique: SMwK4nNXPXiVsHb93G9hmQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D999A8010E5;
 Mon, 30 Mar 2020 13:00:30 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DC38D7694;
 Mon, 30 Mar 2020 13:00:28 +0000 (UTC)
Date: Mon, 30 Mar 2020 14:00:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Subject: Re: [RFC PATCH] crypto/secret: support fetching secrets from Linux
 keyring
Message-ID: <20200330130025.GN236854@redhat.com>
References: <20200328114014.6362-1-alex-krasikov@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200328114014.6362-1-alex-krasikov@yandex-team.ru>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 28, 2020 at 02:40:14PM +0300, Alexey Krasikov wrote:
> Add the ability for the secret object to obtain secret data from the
> Linux in-kernel key managment and retention facility, as an extra option
> to the existing ones: reading from a file or passing directly as a
> string.
>=20
> The secret is identified by the key serial number.  The upper layers
> need to instantiate the key and make sure the QEMU process has access
> rights to read it.

This looks like a generally useful concept to me, however, I think
it highlights a mistake in the original secrets design. We should
have had TYPE_QCRYPTO_SECRET be an abstract interface, and then
had subclasses  TYPE_QCRYPTO_SECRET_FILE, TYPE_QCRYPTO_SECRET_INLINE
Then we could add TYPE_QCRYPTO_SECRET_LINUX.

We can still mostly fix that mistake now though.

We can introduce a TYPE_QCRYPTO_SECRET_INTERFACE which defines
the generic interface. This interface just needs to define one
API entry point

    "char *get_data(QCryptoSecretInterface *secret)"

The current TYPE_QCRYPTO_SECRET can be the current impl of that
interface that returns the rawdata field.

Then we can add the new TYPE_QCRYPTO_SECRET_LINUX for the keyring
implementation that does the Linux specific magic. This will let
us easily compile out the Linux impl on platforms where it is not
available too.



>=20
> Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> ---
>  crypto/secret.c         | 88 +++++++++++++++++++++++++++++++++++++++--
>  include/crypto/secret.h |  3 ++
>  2 files changed, 88 insertions(+), 3 deletions(-)
>=20
> diff --git a/crypto/secret.c b/crypto/secret.c
> index 1cf0ad0ce8..2e8be6241c 100644
> --- a/crypto/secret.c
> +++ b/crypto/secret.c
> @@ -19,6 +19,8 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include <asm/unistd.h>
> +#include <linux/keyctl.h>
>  #include "crypto/secret.h"
>  #include "crypto/cipher.h"
>  #include "qapi/error.h"
> @@ -28,6 +30,40 @@
>  #include "trace.h"
> =20
> =20
> +static inline
> +long keyctl_read(key_serial_t key, uint8_t *buffer, size_t buflen)
> +{
> +#ifdef __NR_keyctl
> +    return syscall(__NR_keyctl, KEYCTL_READ, key, buffer, buflen, 0);
> +#else
> +    errno =3D ENOSYS;
> +    return -1;
> +#endif
> +}
> +
> +static
> +long keyctl_read_alloc(key_serial_t key, uint8_t **buffer)
> +{
> +    uint8_t *loc_buf;
> +    long retcode =3D keyctl_read(key, NULL, 0);
> +    if (retcode < 0) {
> +        return retcode;
> +    }
> +    loc_buf =3D g_malloc(retcode + 1);
> +    retcode =3D keyctl_read(key, loc_buf, retcode + 1);
> +   /*
> +    * We don't have key operations locks between syscalls.
> +    * For example, the key could have been removed or expired.
> +    */
> +    if (retcode >=3D 0) {
> +        loc_buf[retcode] =3D '\0';
> +        *buffer =3D loc_buf;
> +    } else {
> +        g_free(loc_buf);
> +    }
> +    return retcode;
> +}
> +
>  static void
>  qcrypto_secret_load_data(QCryptoSecret *secret,
>                           uint8_t **output,
> @@ -41,10 +77,28 @@ qcrypto_secret_load_data(QCryptoSecret *secret,
>      *output =3D NULL;
>      *outputlen =3D 0;
> =20
> -    if (secret->file) {
> +    if (secret->syskey) {
> +        uint8_t *buffer =3D NULL;
> +        long retcode;
> +        if (secret->data || secret->file) {
> +            error_setg(errp,
> +                       "'syskey', 'file' and 'data' are mutually exclusi=
ve");
> +            return;
> +        }
> +        retcode =3D keyctl_read_alloc(secret->syskey, &buffer);
> +        if (retcode < 0) {
> +            error_setg_errno(errp, errno,
> +                       "Unable to read serial key %08x",
> +                       secret->syskey);
> +            return;
> +        } else {
> +            *outputlen =3D retcode;
> +            *output =3D buffer;
> +        }
> +    } else if (secret->file) {
>          if (secret->data) {
>              error_setg(errp,
> -                       "'file' and 'data' are mutually exclusive");
> +                       "'syskey', 'file' and 'data' are mutually exclusi=
ve");
>              return;
>          }
>          if (!g_file_get_contents(secret->file, &data, &length, &gerr)) {
> @@ -60,7 +114,8 @@ qcrypto_secret_load_data(QCryptoSecret *secret,
>          *outputlen =3D strlen(secret->data);
>          *output =3D (uint8_t *)g_strdup(secret->data);
>      } else {
> -        error_setg(errp, "Either 'file' or 'data' must be provided");
> +        error_setg(errp,
> +                   "Either 'syskey' or 'file' or 'data' must be provided=
");
>      }
>  }
> =20
> @@ -298,6 +353,29 @@ qcrypto_secret_prop_get_file(Object *obj,
>  }
> =20
> =20
> +static void
> +qcrypto_secret_prop_set_syskey(Object *obj, Visitor *v,
> +                               const char *name, void *opaque,
> +                               Error **errp)
> +{
> +    QCryptoSecret *secret =3D QCRYPTO_SECRET(obj);
> +    int32_t value;
> +    visit_type_int32(v, name, &value, errp);
> +    secret->syskey =3D value;
> +}
> +
> +
> +static void
> +qcrypto_secret_prop_get_syskey(Object *obj, Visitor *v,
> +                               const char *name, void *opaque,
> +                               Error **errp)
> +{
> +    QCryptoSecret *secret =3D QCRYPTO_SECRET(obj);
> +    int32_t value =3D secret->syskey;
> +    visit_type_int32(v, name, &value, errp);
> +}
> +
> +
>  static void
>  qcrypto_secret_prop_set_iv(Object *obj,
>                             const char *value,
> @@ -384,6 +462,10 @@ qcrypto_secret_class_init(ObjectClass *oc, void *dat=
a)
>                                    qcrypto_secret_prop_get_file,
>                                    qcrypto_secret_prop_set_file,
>                                    NULL);
> +    object_class_property_add(oc, "syskey", "key_serial_t",
> +                                  qcrypto_secret_prop_get_syskey,
> +                                  qcrypto_secret_prop_set_syskey,
> +                                  NULL, NULL, NULL);
>      object_class_property_add_str(oc, "keyid",
>                                    qcrypto_secret_prop_get_keyid,
>                                    qcrypto_secret_prop_set_keyid,
> diff --git a/include/crypto/secret.h b/include/crypto/secret.h
> index 5e07e29bae..9d350e35ed 100644
> --- a/include/crypto/secret.h
> +++ b/include/crypto/secret.h
> @@ -31,6 +31,8 @@
>  typedef struct QCryptoSecret QCryptoSecret;
>  typedef struct QCryptoSecretClass QCryptoSecretClass;
> =20
> +typedef int32_t key_serial_t;
> +
>  /**
>   * QCryptoSecret:
>   *
> @@ -125,6 +127,7 @@ struct QCryptoSecret {
>      QCryptoSecretFormat format;
>      char *data;
>      char *file;
> +    key_serial_t syskey;
>      char *keyid;
>      char *iv;
>  };
> --=20
> 2.17.1
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


