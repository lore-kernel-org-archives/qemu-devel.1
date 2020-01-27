Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7A9C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3806120842
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZr+oeFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3806120842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw2Sl-0005lB-Cf
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iw2Ry-0004cl-9W
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iw2Rw-0005Ao-1x
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:21:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23174
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iw2Rv-000594-Oc
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580124059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6SpihdjISGLYgK/QPtmUIIAtc+zp1sgOqqudNT8jRsw=;
 b=WZr+oeFZeD8vm68B9hP4VknQ09aFlnchsbA7I96k9MO9eBsFlWlh0TnBdZNSrTAm4/+oSg
 Q8qUloTwNYrilQdopm14TQVO6kDSgjy5+edgDN+9I4w5hKBo+Ovgu63ExYvCq04dAUNKZ7
 8JolVUXbNyQ4JjiZR76ynWLvVi8WlXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-3ar4E2xLNcaLRbev7pV67g-1; Mon, 27 Jan 2020 06:20:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73C0118A6EC0;
 Mon, 27 Jan 2020 11:20:51 +0000 (UTC)
Received: from [10.36.118.65] (unknown [10.36.118.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A0DF60BF1;
 Mon, 27 Jan 2020 11:20:47 +0000 (UTC)
Subject: Re: [PATCH v6 2/2] s390: diagnose 318 info reset and migration support
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
 <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <380c4902-e67d-0aff-103d-18815b221ac4@redhat.com>
Date: Mon, 27 Jan 2020 12:20:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3ar4E2xLNcaLRbev7pV67g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[...]
> @@ -0,0 +1,85 @@
> +/*
> + * DIAGNOSE 0x318 functions for reset and migration
> + *
> + * Copyright IBM, Corp. 2019

Should be 2020 now.

[...]
> +static void s390_diag318_reset(DeviceState *dev)
> +{
> +    if (kvm_enabled())
> +        kvm_s390_set_diag318_info(0);
> +}
> +
> +static void s390_diag318_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->reset =3D s390_diag318_reset;
> +    dc->vmsd =3D &vmstate_diag318;
> +    dc->hotpluggable =3D false;
> +    /* Reason: Created automatically during machine instantiation */
> +    dc->user_creatable =3D false;
> +}
> +
> +static const TypeInfo s390_diag318_info =3D {
> +    .class_init =3D s390_diag318_class_init,
> +    .parent =3D TYPE_DEVICE,
> +    .name =3D TYPE_S390_DIAG318,
> +    .instance_size =3D sizeof(DIAG318State),
> +};
> +
> +static void s390_diag318_register_types(void)
> +{
> +    type_register_static(&s390_diag318_info);
> +}

Do we really need a new device? Can't we simply glue that extended state
to the machine state?

-> target/s390x/machine.c

> +
> +type_init(s390_diag318_register_types)
> diff --git a/hw/s390x/diag318.h b/hw/s390x/diag318.h
> new file mode 100644
> index 0000000..06d9f67
> --- /dev/null
> +++ b/hw/s390x/diag318.h
> @@ -0,0 +1,40 @@
> +/*
> + * DIAGNOSE 0x318 functions for reset and migration
> + *
> + * Copyright IBM, Corp. 2019
> + *
> + * Authors:
> + *  Collin Walling <walling@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t your
> + * option) any later version. See the COPYING file in the top-level dire=
ctory.
> + */
> +
> +#ifndef HW_DIAG318_H
> +#define HW_DIAG318_H
> +
> +#include "qemu/osdep.h"
> +#include "migration/vmstate.h"
> +#include "qom/object.h"
> +#include "hw/qdev-core.h"
> +
> +#define TYPE_S390_DIAG318 "diag318"
> +#define DIAG318(obj) \
> +    OBJECT_CHECK(DIAG318State, (obj), TYPE_S390_DIAG318)
> +
> +typedef struct DIAG318State {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    uint64_t info;
> +} DIAG318State;
> +
> +typedef struct DIAG318Class {
> +    /*< private >*/
> +    DeviceClass parent_class;
> +
> +    /*< public >*/
> +} DIAG318Class;
> +
> +#endif /* HW_DIAG318_H */
> \ No newline at end of file
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index e0e2813..d5b7a33 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -41,6 +41,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/s390x/tod.h"
>  #include "sysemu/sysemu.h"
> +#include "hw/s390x/diag318.h"
> =20
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>  {
> @@ -97,6 +98,7 @@ static const char *const reset_dev_types[] =3D {
>      "s390-sclp-event-facility",
>      "s390-flic",
>      "diag288",
> +    TYPE_S390_DIAG318,
>  };
> =20
>  static void subsystem_reset(void)
> @@ -237,6 +239,17 @@ static void s390_create_sclpconsole(const char *type=
, Chardev *chardev)
>      qdev_init_nofail(dev);
>  }
> =20
> +static void s390_init_diag318(void)
> +{
> +    Object *new =3D object_new(TYPE_S390_DIAG318);
> +    DeviceState *dev =3D DEVICE(new);
> +
> +    object_property_add_child(qdev_get_machine(), TYPE_S390_DIAG318,
> +                              new, NULL);
> +    object_unref(new);
> +    qdev_init_nofail(dev);
> +}
> +
>  static void ccw_init(MachineState *machine)
>  {
>      int ret;
> @@ -294,6 +307,9 @@ static void ccw_init(MachineState *machine)
> =20
>      /* init the TOD clock */
>      s390_init_tod();
> +
> +    /* init object used for migrating diag318 info */
> +    s390_init_diag318();
>  }
> =20
>  static void s390_cpu_plug(HotplugHandler *hotplug_dev,
> @@ -566,6 +582,7 @@ static void machine_set_loadparm(Object *obj, const c=
har *val, Error **errp)
>          ms->loadparm[i] =3D ' '; /* pad right with spaces */
>      }
>  }
> +

unrelated change.

>  static inline void s390_machine_initfn(Object *obj)
>  {
>      object_property_add_bool(obj, "aes-key-wrap",
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index f57ce7b..636348c 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -15,6 +15,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qapi/error.h"
> +#include "qemu/error-report.h"
>  #include "cpu.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/boards.h"
> @@ -22,6 +23,7 @@
>  #include "hw/s390x/event-facility.h"
>  #include "hw/s390x/s390-pci-bus.h"
>  #include "hw/s390x/ipl.h"
> +#include "kvm_s390x.h"
> =20
>  static inline SCLPDevice *get_sclp_device(void)
>  {
> @@ -37,10 +39,19 @@ static void prepare_cpu_entries(SCLPDevice *sclp, CPU=
Entry *entry, int *count)
>  {
>      MachineState *ms =3D MACHINE(qdev_get_machine());
>      uint8_t features[SCCB_CPU_FEATURE_LEN] =3D { 0 };
> +    int max_entries;
>      int i;
> =20
> +    /* Calculate the max number of CPU entries that can be stored in the=
 SCCB */
> +    max_entries =3D (SCCB_SIZE - offsetof(ReadInfo, entries)) / sizeof(C=
PUEntry);
> +
>      s390_get_feat_block(S390_FEAT_TYPE_SCLP_CPU, features);
>      for (i =3D 0, *count =3D 0; i < ms->possible_cpus->len; i++) {
> +        if (*count =3D=3D max_entries) {
> +            warn_report("Configuration only supports a max of %d CPU ent=
ries.",
> +                        max_entries);

I remember that "the sclp response will be limited to 247 CPUs if the
feature is one". So we should have a double layout and make max_entries
depending on s390_has_feat().

Regarding the message, I'd probably do a "Due to the current CPU model,
some CPUs might be hidden from the VM (SCLP)."

A VM could still manually probe for others.

Thanks!

--=20
Thanks,

David / dhildenb


