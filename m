Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F93C56202
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732382224B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IG2sc5Vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732382224B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVDBs-0001y7-DR
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 08:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVDAH-0000f2-7s
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVDAC-00043S-Uo
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603283058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVIXdICTvMYfC/wl2IfdU/D7lzNx3/n4agfLJPaiERA=;
 b=IG2sc5Vif76AyjNsHajB87ch/eCCvcCzKpIvCBq2NoA2gmrMEAVEdsGB8yz05LAWUrOofx
 9F8V0ZWwAUPJB2PH/lbps4wSVQafQG+5QYIEtotek0ikqCXc4DKGd0coU+zuE9UTlGI5rM
 wYsosDL6vhPDd4I1j1g1DFIfAUkrPnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-suv-ysLaMsOA3gDuJy1kZQ-1; Wed, 21 Oct 2020 08:24:16 -0400
X-MC-Unique: suv-ysLaMsOA3gDuJy1kZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62CBD64093
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 12:24:15 +0000 (UTC)
Received: from localhost (unknown [10.40.208.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB0E860C47;
 Wed, 21 Oct 2020 12:24:09 +0000 (UTC)
Date: Wed, 21 Oct 2020 14:24:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 03/12] qom: Make object_class_property_add_uint*_ptr()
 get offset
Message-ID: <20201021142408.72d2b92f@redhat.com>
In-Reply-To: <20201009160122.1662082-4-ehabkost@redhat.com>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
 <20201009160122.1662082-4-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  9 Oct 2020 12:01:13 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> The existing object_class_property_add_uint*_ptr() functions are
> not very useful, because they need a pointer to the property
> value, which can't really be provided before the object is
> created.
>=20
> Replace the pointer parameter in those functions with a
> `ptrdiff_t offset` parameter.
>=20
> Include a uint8 class property in check-qom-proplist unit tests,
> to ensure the feature is working.


Not sure I like approach, it's reinventing qdev pointer properties in QOM f=
orm.
I had an impression that Paolo wanted qdev pointer properties be gone
and replaced by something like link properties.

object_property_add_uintXX_ptr() were introduced as a quick hack,
when ACPI code generation was moved from Seabios, to avoid more
code shuffling in device models and adding more boiler plate in
form of custom setters/getters (the later didn't seem to bother
us everywhere else where we use object_[class_]property_add() ).
Then it spread little bit to another places.

I'd rather get rid of object_property_add_uintXX_ptr() API altogether
in favor of object_[class_]property_add() like it is used in other places
to handle intXX properties.
Adding helpers similar to object_property_add_bool() for intXX
could reduce boiler plate need for converting current instances of
_ptr(), and such helpers would also help with reducing boilerplate
for the rest of instances where object_[class_]property_add()
currently is used for dealing with integers.


> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  include/qom/object.h       |  8 ++++----
>  qom/object.c               | 36 +++++++++++++++++++++++-------------
>  tests/check-qom-proplist.c | 10 ++++++++--
>  3 files changed, 35 insertions(+), 19 deletions(-)
>=20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index d378f13a11..1634294e4f 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1747,7 +1747,7 @@ ObjectProperty *object_property_add_uint8_ptr(Objec=
t *obj, const char *name,
> =20
>  ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
>                                           const char *name,
> -                                         const uint8_t *v,
> +                                         ptrdiff_t offset,
>                                           ObjectPropertyFlags flags);
> =20
>  /**
> @@ -1768,7 +1768,7 @@ ObjectProperty *object_property_add_uint16_ptr(Obje=
ct *obj, const char *name,
> =20
>  ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
>                                            const char *name,
> -                                          const uint16_t *v,
> +                                          ptrdiff_t offset,
>                                            ObjectPropertyFlags flags);
> =20
>  /**
> @@ -1789,7 +1789,7 @@ ObjectProperty *object_property_add_uint32_ptr(Obje=
ct *obj, const char *name,
> =20
>  ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
>                                            const char *name,
> -                                          const uint32_t *v,
> +                                          ptrdiff_t offset,
>                                            ObjectPropertyFlags flags);
> =20
>  /**
> @@ -1810,7 +1810,7 @@ ObjectProperty *object_property_add_uint64_ptr(Obje=
ct *obj, const char *name,
> =20
>  ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
>                                            const char *name,
> -                                          const uint64_t *v,
> +                                          ptrdiff_t offset,
>                                            ObjectPropertyFlags flags);
> =20
>  /**
> diff --git a/qom/object.c b/qom/object.c
> index 17692ed5c3..bb32f5d3ad 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2450,13 +2450,22 @@ static char *object_get_type(Object *obj, Error *=
*errp)
>  }
> =20
>  typedef struct {
> -    /* Pointer to property value */
> -    void *ptr;
> +    bool is_offset;
> +    union {
> +        /* Pointer to property value.  Valid if is_offset=3Dfalse */
> +        void *ptr;
> +        /* Offset in Object struct.  Valid if is_offset=3Dtrue */
> +        ptrdiff_t offset;
> +    };
>  } PointerProperty;
> =20
>  static void *pointer_property_get_ptr(Object *obj, PointerProperty *prop=
)
>  {
> -    return prop->ptr;
> +    if (prop->is_offset) {
> +        return (void *)obj + prop->offset;
> +    } else {
> +        return prop->ptr;
> +    }
>  }
> =20
>  static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *=
name,
> @@ -2573,10 +2582,11 @@ object_class_property_add_uint_ptr(ObjectClass *o=
c, const char *name,
>                                     ObjectPropertyAccessor getter,
>                                     ObjectPropertyAccessor setter,
>                                     ObjectPropertyFlags flags,
> -                                   void *ptr)
> +                                   ptrdiff_t offset)
>  {
>      PointerProperty *prop =3D g_new0(PointerProperty, 1);
> -    prop->ptr =3D ptr;
> +    prop->is_offset =3D true;
> +    prop->offset =3D offset;
>      return object_class_property_add(oc, name, type,
>                                       (flags & OBJ_PROP_FLAG_READ) ? gett=
er : NULL,
>                                       (flags & OBJ_PROP_FLAG_WRITE) ? set=
ter : NULL,
> @@ -2597,13 +2607,13 @@ object_property_add_uint8_ptr(Object *obj, const =
char *name,
> =20
>  ObjectProperty *
>  object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name=
,
> -                                    const uint8_t *v,
> +                                    ptrdiff_t offset,
>                                      ObjectPropertyFlags flags)
>  {
>      return object_class_property_add_uint_ptr(klass, name, "uint8",
>                                                property_get_uint8_ptr,
>                                                property_set_uint8_ptr,
> -                                              flags, (void *)v);
> +                                              flags, offset);
>  }
> =20
>  ObjectProperty *
> @@ -2620,13 +2630,13 @@ object_property_add_uint16_ptr(Object *obj, const=
 char *name,
> =20
>  ObjectProperty *
>  object_class_property_add_uint16_ptr(ObjectClass *klass, const char *nam=
e,
> -                                     const uint16_t *v,
> +                                     ptrdiff_t offset,
>                                       ObjectPropertyFlags flags)
>  {
>      return object_class_property_add_uint_ptr(klass, name, "uint16",
>                                                property_get_uint16_ptr,
>                                                property_set_uint16_ptr,
> -                                              flags, (void *)v);
> +                                              flags, offset);
>  }
> =20
>  ObjectProperty *
> @@ -2643,13 +2653,13 @@ object_property_add_uint32_ptr(Object *obj, const=
 char *name,
> =20
>  ObjectProperty *
>  object_class_property_add_uint32_ptr(ObjectClass *klass, const char *nam=
e,
> -                                     const uint32_t *v,
> +                                     ptrdiff_t offset,
>                                       ObjectPropertyFlags flags)
>  {
>      return object_class_property_add_uint_ptr(klass, name, "uint32",
>                                                property_get_uint32_ptr,
>                                                property_set_uint32_ptr,
> -                                              flags, (void *)v);
> +                                              flags, offset);
>  }
> =20
>  ObjectProperty *
> @@ -2666,13 +2676,13 @@ object_property_add_uint64_ptr(Object *obj, const=
 char *name,
> =20
>  ObjectProperty *
>  object_class_property_add_uint64_ptr(ObjectClass *klass, const char *nam=
e,
> -                                     const uint64_t *v,
> +                                     ptrdiff_t offset,
>                                       ObjectPropertyFlags flags)
>  {
>      return object_class_property_add_uint_ptr(klass, name, "uint64",
>                                                property_get_uint64_ptr,
>                                                property_set_uint64_ptr,
> -                                              flags, (void *)v);
> +                                              flags, offset);
>  }
> =20
>  typedef struct {
> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> index 1b76581980..fba30c20b2 100644
> --- a/tests/check-qom-proplist.c
> +++ b/tests/check-qom-proplist.c
> @@ -61,6 +61,7 @@ struct DummyObject {
>      bool bv;
>      DummyAnimal av;
>      char *sv;
> +    uint8_t u8v;
>  };
> =20
>  struct DummyObjectClass {
> @@ -141,6 +142,9 @@ static void dummy_class_init(ObjectClass *cls, void *=
data)
>                                     &dummy_animal_map,
>                                     dummy_get_av,
>                                     dummy_set_av);
> +    object_class_property_add_uint8_ptr(cls, "u8v",
> +                                        offsetof(DummyObject, u8v),
> +                                        OBJ_PROP_FLAG_READWRITE);
>  }
> =20
> =20
> @@ -385,12 +389,14 @@ static void test_dummy_createlist(void)
>                     "bv", "yes",
>                     "sv", "Hiss hiss hiss",
>                     "av", "platypus",
> +                   "u8v", "42",
>                     NULL));
> =20
>      g_assert(err =3D=3D NULL);
>      g_assert_cmpstr(dobj->sv, =3D=3D, "Hiss hiss hiss");
>      g_assert(dobj->bv =3D=3D true);
>      g_assert(dobj->av =3D=3D DUMMY_PLATYPUS);
> +    g_assert_cmpint(dobj->u8v, =3D=3D, 42);
> =20
>      g_assert(object_resolve_path_component(parent, "dummy0")
>               =3D=3D OBJECT(dobj));
> @@ -531,7 +537,7 @@ static void test_dummy_iterator(void)
>  {
>      const char *expected[] =3D {
>          "type",                 /* inherited from TYPE_OBJECT */
> -        "sv", "av",             /* class properties */
> +        "sv", "av", "u8v",      /* class properties */
>          "bv"};                  /* instance property */
>      Object *parent =3D object_get_objects_root();
>      DummyObject *dobj =3D DUMMY_OBJECT(
> @@ -552,7 +558,7 @@ static void test_dummy_iterator(void)
> =20
>  static void test_dummy_class_iterator(void)
>  {
> -    const char *expected[] =3D { "type", "av", "sv" };
> +    const char *expected[] =3D { "type", "av", "sv", "u8v" };
>      ObjectPropertyIterator iter;
>      ObjectClass *klass =3D object_class_by_name(TYPE_DUMMY);
> =20


