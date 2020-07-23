Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A10C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E204220714
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8pjEuwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E204220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfm6-0000nd-7M
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 14:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyfjg-0006GJ-UY
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:14:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31649
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyfje-0007k9-W5
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595528066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7JSrOaxBt7jmd/iy3lVXLFwWbsAU5eJo6KE6sKIEDUo=;
 b=a8pjEuwtu4Yc9T4hl/py/daaSEhfW0vEU8tcQN8w23J9fM1W8yMaKJkgNSTYAfE4GlGAC5
 7B91hwyBxf79j6703+G82SffAs2uHY2EGcv4ouU4JeVgGnOz5E4GKmwRkUWAMgMJ5Xr3vE
 nVU+xVds42YlrFIYUcb37QZW9GTbrWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-ebOf09EeNiy8KqJ_Iuw-pw-1; Thu, 23 Jul 2020 14:14:14 -0400
X-MC-Unique: ebOf09EeNiy8KqJ_Iuw-pw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79B231932480
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 18:14:13 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAAE41009940;
 Thu, 23 Jul 2020 18:14:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] qom: reduce boilerplate required for declaring and
 defining objects
Date: Thu, 23 Jul 2020 19:14:06 +0100
Message-Id: <20200723181410.3145233-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To just duplicate the patch 2 message....=0D
=0D
When creating new QOM types, there is a lot of boilerplate code that=0D
must be repeated using a standard pattern. This is tedious to write=0D
and liable to suffer from subtle inconsistencies. Thus it would=0D
benefit from some simple automation.=0D
=0D
QOM was loosely inspired by GLib's GObject, and indeed GObject suffers=0D
from the same burden of boilerplate code, but has long provided a set of=0D
macros to eliminate this burden in the source implementation. More=0D
recently it has also provided a set of macros to eliminate this burden=0D
in the header declaration.=0D
=0D
In GLib there are the G_DECLARE_* and G_DEFINE_* family of macros=0D
for the header declaration and source implementation respectively:=0D
=0D
  https://developer.gnome.org/gobject/stable/chapter-gobject.html=0D
  https://developer.gnome.org/gobject/stable/howto-gobject.html=0D
=0D
This patch takes inspiration from GObject to provide the equivalent=0D
functionality for QOM.=0D
=0D
In the header file, instead of:=0D
=0D
    typedef struct MyDevice MyDevice;=0D
    typedef struct MyDeviceClass MyDeviceClass;=0D
=0D
    G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)=0D
=0D
    #define MY_DEVICE_GET_CLASS(void *obj) \=0D
            OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)=0D
    #define MY_DEVICE_CLASS(void *klass) \=0D
            OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)=0D
    #define MY_DEVICE(void *obj)=0D
            OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)=0D
=0D
    struct MyDeviceClass {=0D
        DeviceClass parent_class;=0D
    };=0D
=0D
We now have=0D
=0D
    OBJECT_DECLARE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)=0D
=0D
In cases where the class needs some virtual methods, it can be left=0D
to be implemented manually using=0D
=0D
    OBJECT_DECLARE_TYPE(MyDevice, my_device, MY_DEVICE)=0D
=0D
Note that these macros are including support for g_autoptr() for the=0D
object types, which is something previously only supported for variables=0D
declared as the base Object * type.=0D
=0D
Meanwhile in the source file, instead of:=0D
=0D
    static void my_device_finalize(Object *obj);=0D
    static void my_device_class_init(ObjectClass *oc, void *data);=0D
    static void my_device_init(Object *obj);=0D
=0D
    static const TypeInfo my_device_info =3D {=0D
        .parent =3D TYPE_DEVICE,=0D
        .name =3D TYPE_MY_DEVICE,=0D
        .instance_size =3D sizeof(MyDevice),=0D
        .instance_init =3D my_device_init,=0D
        .instance_finalize =3D my_device_finalize,=0D
        .class_size =3D sizeof(MyDeviceClass),=0D
        .class_init =3D my_device_class_init,=0D
    };=0D
=0D
    static void=0D
    my_device_register_types(void)=0D
    {=0D
        type_register_static(&my_device_info);=0D
    }=0D
    type_init(my_device_register_types);=0D
=0D
We now have=0D
=0D
    OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)=0D
=0D
Or, if a class needs to implement interfaces:=0D
=0D
    OBJECT_DEFINE_TYPE_WITH_INTERFACES(MyDevice, my_device, MY_DEVICE, DEVI=
CE,=0D
                                       { TYPE_USER_CREATABLE }, { NULL })=
=0D
=0D
Or, if a class needs to be abstract=0D
=0D
    OBJECT_DEFINE_ABSTRACT_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)=0D
=0D
IOW, in both cases the maintainer now only has to think about the=0D
interesting part of the code which implements useful functionality=0D
and avoids much of the boilerplate.=0D
=0D
=0D
Patches 3 and 4 illustrate the usage of the new macros, and by excluding=0D
the qom changes, and just looking at the crypto, the diffstat shows the=0D
benefits quite nicely:=0D
=0D
 crypto/secret.c                 | 24 ++++--------------------=0D
 crypto/secret_common.c          | 32 +++++++++-----------------------=0D
 crypto/secret_keyring.c         | 28 +++++++++-------------------=0D
 crypto/tlscreds.c               | 25 +++----------------------=0D
 crypto/tlscredsanon.c           | 23 ++++-------------------=0D
 crypto/tlscredspsk.c            | 25 +++++--------------------=0D
 crypto/tlscredsx509.c           | 29 ++++-------------------------=0D
 include/crypto/secret.h         | 11 ++---------=0D
 include/crypto/secret_common.h  | 13 ++-----------=0D
 include/crypto/secret_keyring.h | 18 ++----------------=0D
 include/crypto/tlscreds.h       | 13 ++-----------=0D
 include/crypto/tlscredsanon.h   | 14 ++------------=0D
 include/crypto/tlscredspsk.h    | 13 ++-----------=0D
 include/crypto/tlscredsx509.h   | 13 ++-----------=0D
 14 files changed, 52 insertions(+), 229 deletions(-)=0D
=0D
(The 'qom' file diffstat is misled by the large amount of API doc text=0D
 added).=0D
=0D
Daniel P. Berrang=C3=A9 (4):=0D
  qom: make object_ref/unref use a void * instead of Object *.=0D
  qom: provide convenient macros for declaring and defining types=0D
  crypto: use QOM macros for declaration/definition of secret types=0D
  crypto: use QOM macros for declaration/definition of TLS creds types=0D
=0D
 crypto/secret.c                 |  24 +--=0D
 crypto/secret_common.c          |  32 +---=0D
 crypto/secret_keyring.c         |  28 +---=0D
 crypto/tlscreds.c               |  25 +--=0D
 crypto/tlscredsanon.c           |  23 +--=0D
 crypto/tlscredspsk.c            |  25 +--=0D
 crypto/tlscredsx509.c           |  29 +---=0D
 include/crypto/secret.h         |  11 +-=0D
 include/crypto/secret_common.h  |  13 +-=0D
 include/crypto/secret_keyring.h |  18 +-=0D
 include/crypto/tlscreds.h       |  13 +-=0D
 include/crypto/tlscredsanon.h   |  14 +-=0D
 include/crypto/tlscredspsk.h    |  13 +-=0D
 include/crypto/tlscredsx509.h   |  13 +-=0D
 include/qom/object.h            | 281 +++++++++++++++++++++++++++++++-=0D
 qom/object.c                    |   6 +-=0D
 16 files changed, 335 insertions(+), 233 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


