Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19167C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D397E20767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJEFHOS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D397E20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHcM-00039E-2A
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRHaK-0002T6-81
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRHaI-0004sP-MK
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:46:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54218
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jRHaG-0004qv-SU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587570402;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J6rwUkyqTLyTYchbHOTdKVSU9+eVXRRF1sbrkFJcvtU=;
 b=CJEFHOS5OqtUBiBj6N+Y5+qd5IYmtl+erojt47x+1DxcZ2DQ2exQMojxyDC+tktelfAUsC
 v1Fc+w+60xObtkwyyTYzUt4h2tsoiUQj9pSnOIjJ88eG+o4OotxnZ95EBCY1debwABj9Nb
 E2YD+qYGLVDlrveqY/93G9ZVr8YNOF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-u--OVmeLPQ6SCU2G9D8wlQ-1; Wed, 22 Apr 2020 11:46:35 -0400
X-MC-Unique: u--OVmeLPQ6SCU2G9D8wlQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F37E1922965;
 Wed, 22 Apr 2020 15:46:34 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0437B1000327;
 Wed, 22 Apr 2020 15:46:32 +0000 (UTC)
Date: Wed, 22 Apr 2020 16:46:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Subject: Re: [RFC PATCH v2 4/5] crypto/linux_keyring: add 'syskey' secret
 object.
Message-ID: <20200422154630.GF587120@redhat.com>
References: <20200415222525.4022-1-alex-krasikov@yandex-team.ru>
 <20200415222525.4022-4-alex-krasikov@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200415222525.4022-4-alex-krasikov@yandex-team.ru>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Thu, Apr 16, 2020 at 01:25:24AM +0300, Alexey Krasikov wrote:
> * Add the ability for the secret object to obtain secret data from the
>   Linux in-kernel key managment and retention facility, as an extra optio=
n
>   to the existing ones: reading from a file or passing directly as a
>   string.
>=20
>   The secret is identified by the key serial number.  The upper layers
>   need to instantiate the key and make sure the QEMU process has access
>   rights to read it.
>=20
> Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> ---
>  crypto/Makefile.objs           |   1 +
>  crypto/linux_keyring.c         | 140 +++++++++++++++++++++++++++++++++
>  include/crypto/linux_keyring.h |  38 +++++++++
>  3 files changed, 179 insertions(+)
>  create mode 100644 crypto/linux_keyring.c
>  create mode 100644 include/crypto/linux_keyring.h

Can we call these  secret_keyring.{c,h}

> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index 3ae0dfd1a4..7fc354a8d5 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -19,6 +19,7 @@ crypto-obj-y +=3D tlscredspsk.o
>  crypto-obj-y +=3D tlscredsx509.o
>  crypto-obj-y +=3D tlssession.o
>  crypto-obj-y +=3D secret_interface.o
> +crypto-obj-y +=3D linux_keyring.o

I'd expect to see a configure check for deciding whether or not
to build the keyring code, and then have $(CONFIG_SECRET_KEYRING)
variable used here.

>  crypto-obj-y +=3D secret.o
>  crypto-obj-y +=3D pbkdf.o
>  crypto-obj-$(CONFIG_NETTLE) +=3D pbkdf-nettle.o
> diff --git a/crypto/linux_keyring.c b/crypto/linux_keyring.c
> new file mode 100644
> index 0000000000..7950d4c12d
> --- /dev/null
> +++ b/crypto/linux_keyring.c
> @@ -0,0 +1,140 @@
> +#ifdef __NR_keyctl
> +
> +#include "qemu/osdep.h"
> +#include <asm/unistd.h>
> +#include <linux/keyctl.h>
> +#include "qapi/error.h"
> +#include "qom/object_interfaces.h"
> +#include "trace.h"
> +#include "crypto/linux_keyring.h"
> +
> +
> +static inline
> +long keyctl_read(key_serial_t key, uint8_t *buffer, size_t buflen)
> +{
> +    return syscall(__NR_keyctl, KEYCTL_READ, key, buffer, buflen, 0);
> +}
> +
> +
> +static
> +long keyctl_read_alloc(key_serial_t key, uint8_t **buffer)
> +{
> +    uint8_t *loc_buf;
> +    long retcode =3D keyctl_read(key, NULL, 0);
> +    if (retcode <=3D 0) {
> +        return retcode;
> +    }
> +    loc_buf =3D g_malloc(retcode);

We generally prefer  g_new0 to guarantee zero-initialization

> +    retcode =3D keyctl_read(key, loc_buf, retcode);
> +
> +    if (retcode >=3D 0) {
> +        *buffer =3D loc_buf;
> +    } else {
> +        g_free(loc_buf);
> +    }
> +    return retcode;
> +}
> +
> +
> +static void
> +qcrypto_secret_linux_load_data(Object   *obj,
> +                               uint8_t  **output,
> +                               size_t   *outputlen,
> +                               Error    **errp)
> +{
> +    QCryptoSecretLinuxKeyring *secret =3D QCRYPTO_SECRET_LINUX_KEYRING(o=
bj);
> +    uint8_t  *buffer =3D NULL;
> +    long     retcode;
> +
> +    *output    =3D NULL;
> +    *outputlen =3D 0;
> +
> +    if (secret->serial) {
> +        retcode =3D keyctl_read_alloc(secret->serial, &buffer);
> +        if (retcode < 0) {
> +          error_setg_errno(errp, errno,
> +                     "Unable to read serial key %08x",
> +                     secret->serial);
> +          return;
> +        } else {
> +          *outputlen =3D retcode;
> +          *output    =3D buffer;
> +        }

IMHO, we should just be passing outputlen & output straight
into keyctl_read_alloc, except then I think keyctl_read_alloc
is pointless. So just inline its logic into this method.

> +    } else {
> +      error_setg(errp, "Either 'serial' must be provided");

Indent is a bit off, and the error message text doesn't make sense

Just use

 "'serial' parameter must be provided"

> +    }
> +}
> +
> +
> +static void
> +qcrypto_secret_prop_set_key(Object     *obj,   Visitor *v,
> +                            const char *name,  void    *opaque,
> +                            Error      **errp)
> +{
> +    QCryptoSecretLinuxKeyring *secret =3D QCRYPTO_SECRET_LINUX_KEYRING(o=
bj);
> +    int32_t value;
> +    visit_type_int32(v, name, &value, errp);
> +    if (!value) {
> +        error_setg(errp, "The 'serial' should be not equal 0");
> +    }
> +    secret->serial =3D value;
> +}
> +
> +
> +static void
> +qcrypto_secret_prop_get_key(Object     *obj,   Visitor *v,
> +                            const char *name,  void    *opaque,
> +                            Error      **errp)
> +{
> +    QCryptoSecretLinuxKeyring *secret =3D QCRYPTO_SECRET_LINUX_KEYRING(o=
bj);
> +    int32_t value =3D secret->serial;
> +    visit_type_int32(v, name, &value, errp);
> +}
> +
> +
> +static void
> +qcrypto_secret_linux_complete(UserCreatable *uc, Error **errp)
> +{
> +    object_property_set_bool(OBJECT(uc), true, "loaded", errp);
> +}
> +
> +
> +static void
> +qcrypto_secret_linux_class_init(ObjectClass *oc, void *data)
> +{
> +    QCryptoSecretCommonClass *sic =3D QCRYPTO_SECRET_COMMON_CLASS(oc);
> +    sic->load_data =3D qcrypto_secret_linux_load_data;
> +
> +    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> +    ucc->complete =3D qcrypto_secret_linux_complete;
> +
> +    object_class_property_add(oc, "serial", "key_serial_t",
> +                                  qcrypto_secret_prop_get_key,
> +                                  qcrypto_secret_prop_set_key,
> +                                  NULL, NULL, NULL);
> +}
> +
> +
> +static const TypeInfo qcrypto_secret_info =3D {
> +    .parent        =3D TYPE_QCRYPTO_SECRET_COMMON,
> +    .name          =3D TYPE_QCRYPTO_SECRET_LINUX_KEYRING,
> +    .instance_size =3D sizeof(QCryptoSecretLinuxKeyring),
> +    .class_size    =3D sizeof(QCryptoSecretLinuxKeyringClass),
> +    .class_init    =3D qcrypto_secret_linux_class_init,
> +    .interfaces    =3D (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +
> +static void
> +qcrypto_secret_register_types(void)
> +{
> +    type_register_static(&qcrypto_secret_info);
> +}
> +
> +
> +type_init(qcrypto_secret_register_types);
> +
> +#endif /* __NR_keyctl */
> diff --git a/include/crypto/linux_keyring.h b/include/crypto/linux_keyrin=
g.h
> new file mode 100644
> index 0000000000..2618b34444
> --- /dev/null
> +++ b/include/crypto/linux_keyring.h
> @@ -0,0 +1,38 @@
> +#ifndef QCRYPTO_SECRET_LINUX_KEYRING_H
> +#define QCRYPTO_SECRET_LINUX_KEYRING_H
> +
> +#ifdef __NR_keyctl
> +
> +#include "qapi/qapi-types-crypto.h"
> +#include "qom/object.h"
> +#include "crypto/secret_interface.h"
> +
> +#define TYPE_QCRYPTO_SECRET_LINUX_KEYRING "syskey"
> +#define QCRYPTO_SECRET_LINUX_KEYRING(obj) \
> +    OBJECT_CHECK(QCryptoSecretLinuxKeyring, (obj), \
> +                 TYPE_QCRYPTO_SECRET_LINUX_KEYRING)
> +#define QCRYPTO_SECRET_LINUX_KEYRING_CLASS(class) \
> +    OBJECT_CLASS_CHECK(QCryptoSecretLinuxKeyringClass, \
> +                       (class), TYPE_QCRYPTO_SECRET_LINUX_KEYRING)
> +#define QCRYPTO_SECRET_LINUX_KEYRING_GET_CLASS(class) \
> +    OBJECT_GET_CLASS(QCryptoSecretLinuxKeyringClass, \
> +                     (class), TYPE_QCRYPTO_SECRET_LINUX_KEYRING)
> +
> +typedef struct QCryptoSecretLinux QCryptoSecretLinux;
> +typedef struct QCryptoSecretLinuxClass QCryptoSecretLinuxClass;
> +
> +typedef int32_t key_serial_t;

IMHO, just use the int32_t type inline throughout, and skip the
key_serial_t , as this typename clashes with typenames I see
in /usr/include

> +
> +typedef struct QCryptoSecretLinuxKeyring {
> +    QCryptoSecretCommon  parent;
> +    key_serial_t         serial;
> +} QCryptoSecretLinuxKeyring;
> +
> +
> +typedef struct QCryptoSecretLinuxKeyringClass {
> +    QCryptoSecretCommonClass  parent;
> +} QCryptoSecretLinuxKeyringClass;
> +
> +#endif /* __NR_keyctl */
> +
> +#endif /* QCRYPTO_SECRET_LINUX_KEYRING_H */

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


