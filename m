Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6EAC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3330B20767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRIxLRqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3330B20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHdR-0003w6-V3
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRHb2-0002jU-9N
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRHb0-0005Vy-Mi
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:47:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jRHb0-0005TZ-9k
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587570449;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jM41HvtLlJ0VkiCF0k5O9PUEaTcPkXsd52WfPyhYYuo=;
 b=fRIxLRqWTc6LEt6MyvxhY5AcTqwI3/XBuAuvmjKs+LcCzSc3jSQW9dWBnnRdKTCOYncH+F
 etkNB7SDnueiwow06zMo7pU6l/u1JrS3PwlFOknp6ccC2V3Dt7KIevk6elhiBHx+OPSRwB
 QO1xfi9RILR/O6c4kbFiny5uKygpO3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-Bqm8hmDcO4uCdBfUKbqYmQ-1; Wed, 22 Apr 2020 11:47:25 -0400
X-MC-Unique: Bqm8hmDcO4uCdBfUKbqYmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87B62DBA6;
 Wed, 22 Apr 2020 15:47:24 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E6AC5D706;
 Wed, 22 Apr 2020 15:47:23 +0000 (UTC)
Date: Wed, 22 Apr 2020 16:47:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Subject: Re: [RFC PATCH v2 5/5] test-crypto-secret: add 'syskey' object tests.
Message-ID: <20200422154720.GG587120@redhat.com>
References: <20200415222525.4022-1-alex-krasikov@yandex-team.ru>
 <20200415222525.4022-5-alex-krasikov@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200415222525.4022-5-alex-krasikov@yandex-team.ru>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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

On Thu, Apr 16, 2020 at 01:25:25AM +0300, Alexey Krasikov wrote:
> * test_secret_seckey_bad_key_access_right() is not working yet.
>   We don't know yet if this due a bag in the Linux kernel or
>   whether it's normal syscall behavior.
>   We've requested information from kernel maintainer.
>=20
> Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> ---
>  tests/test-crypto-secret.c | 138 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>=20
> diff --git a/tests/test-crypto-secret.c b/tests/test-crypto-secret.c
> index 13fc6c4c75..6b17fe3a81 100644
> --- a/tests/test-crypto-secret.c
> +++ b/tests/test-crypto-secret.c
> @@ -22,8 +22,10 @@
> =20
>  #include "crypto/init.h"
>  #include "crypto/secret.h"
> +#include "crypto/linux_keyring.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
> +#include <keyutils.h>
> =20
>  static void test_secret_direct(void)
>  {
> @@ -125,6 +127,132 @@ static void test_secret_indirect_emptyfile(void)
>  }
> =20
> =20
> +#define DESCRIPTION "qemu_test_secret"
> +#define PAYLOAD "Test Payload"
> +
> +
> +static void test_secret_seckey_good(void)
> +{
> +    char key_str[16];
> +    Object *sec;
> +    key_serial_t key =3D add_key("user", DESCRIPTION, PAYLOAD,
> +                               strlen(PAYLOAD), KEY_SPEC_PROCESS_KEYRING=
);
> +
> +    g_assert(key >=3D 0);
> +
> +    snprintf(key_str, sizeof(key_str), "0x%08x", key);
> +    sec =3D object_new_with_props(
> +        TYPE_QCRYPTO_SECRET_LINUX_KEYRING,
> +        object_get_objects_root(),
> +        "sec0",
> +        &error_abort,
> +        "serial", key_str,
> +        NULL);
> +
> +    assert(0 <=3D keyctl_unlink(key, KEY_SPEC_PROCESS_KEYRING));
> +    char *pw =3D qcrypto_secret_lookup_as_utf8("sec0",
> +                                             &error_abort);
> +    g_assert_cmpstr(pw, =3D=3D, PAYLOAD);
> +
> +    object_unparent(sec);
> +    g_free(pw);
> +}
> +
> +
> +static void test_secret_seckey_revoked_key(void)
> +{
> +    char key_str[16];
> +    Object *sec;
> +    key_serial_t key =3D add_key("user", DESCRIPTION, PAYLOAD,
> +                               strlen(PAYLOAD), KEY_SPEC_PROCESS_KEYRING=
);
> +    g_assert(key >=3D 0);
> +    g_assert_false(keyctl_revoke(key));
> +
> +    snprintf(key_str, sizeof(key_str), "0x%08x", key);
> +    sec =3D object_new_with_props(
> +        TYPE_QCRYPTO_SECRET_LINUX_KEYRING,
> +        object_get_objects_root(),
> +        "sec0",
> +        NULL,
> +        "serial", key_str,
> +        NULL);
> +
> +    g_assert(errno =3D=3D EKEYREVOKED);
> +    g_assert(sec =3D=3D NULL);
> +
> +    keyctl_unlink(key, KEY_SPEC_PROCESS_KEYRING);
> +}
> +
> +
> +static void test_secret_seckey_expired_key(void)
> +{
> +    char key_str[16];
> +    Object *sec;
> +    key_serial_t key =3D add_key("user", DESCRIPTION, PAYLOAD,
> +                               strlen(PAYLOAD), KEY_SPEC_PROCESS_KEYRING=
);
> +    g_assert(key >=3D 0);
> +    g_assert_false(keyctl_set_timeout(key, 1));
> +    sleep(1);
> +
> +    snprintf(key_str, sizeof(key_str), "0x%08x", key);
> +    sec =3D object_new_with_props(
> +        TYPE_QCRYPTO_SECRET_LINUX_KEYRING,
> +        object_get_objects_root(),
> +        "sec0",
> +        NULL,
> +        "serial", key_str,
> +        NULL);
> +
> +    g_assert(errno =3D=3D EKEYEXPIRED);
> +    g_assert(sec =3D=3D NULL);
> +
> +    keyctl_unlink(key, KEY_SPEC_PROCESS_KEYRING);
> +}
> +
> +
> +static void test_secret_seckey_bad_serial_key(void)
> +{
> +    Object *sec;
> +
> +    sec =3D object_new_with_props(
> +        TYPE_QCRYPTO_SECRET,
> +        object_get_objects_root(),
> +        "sec0",
> +        NULL,
> +        "serial", "1",
> +        NULL);
> +
> +    g_assert(errno =3D=3D ENOKEY);
> +    g_assert(sec =3D=3D NULL);
> +}
> +
> +
> +static void test_secret_seckey_bad_key_access_right(void)
> +{
> +    char key_str[16];
> +    Object *sec;
> +    key_serial_t key =3D add_key("user", DESCRIPTION, PAYLOAD,
> +                               strlen(PAYLOAD), KEY_SPEC_PROCESS_KEYRING=
);
> +    g_assert(key >=3D 0);
> +    g_assert_false(keyctl_setperm(key, KEY_POS_ALL & (~KEY_POS_READ)));
> +
> +    snprintf(key_str, sizeof(key_str), "0x%08x", key);
> +
> +    sec =3D object_new_with_props(
> +        TYPE_QCRYPTO_SECRET_LINUX_KEYRING,
> +        object_get_objects_root(),
> +        "sec0",
> +        NULL,
> +        "serial", key_str,
> +        NULL);
> +
> +    g_assert(errno =3D=3D EACCES);
> +    g_assert(sec =3D=3D NULL);
> +
> +    keyctl_unlink(key, KEY_SPEC_PROCESS_KEYRING);
> +}
> +
> +
>  static void test_secret_noconv_base64_good(void)
>  {
>      Object *sec =3D object_new_with_props(
> @@ -425,6 +553,16 @@ int main(int argc, char **argv)
>                      test_secret_indirect_badfile);
>      g_test_add_func("/crypto/secret/indirect/emptyfile",
>                      test_secret_indirect_emptyfile);
> +    g_test_add_func("/crypto/secret/seckey/good",
> +                    test_secret_seckey_good);
> +    g_test_add_func("/crypto/secret/seckey/revoked_key",
> +                    test_secret_seckey_revoked_key);
> +    g_test_add_func("/crypto/secret/seckey/expired_key",
> +                    test_secret_seckey_expired_key);
> +    g_test_add_func("/crypto/secret/seckey/bad_serial_key",
> +                    test_secret_seckey_bad_serial_key);
> +    g_test_add_func("/crypto/secret/seckey/bad_key_access_right",
> +                    test_secret_seckey_bad_key_access_right);

Again, we'll need to make this all conditional based on the result
of a configure check to avoid breaking non-Linux.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


