Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8AEC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 11:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67E220684
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 11:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkshryAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67E220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZvnj-0005Rc-KO
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 06:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iZvmO-0004qy-MN
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 06:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iZvmL-0000mp-4e
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 06:46:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36863
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iZvmK-0000ku-Ho
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 06:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574855199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/SKa/NB+ElS2Xk9FnNGIwp73cctKv0rBEf/CjVJqTw=;
 b=WkshryAgo4+vcnOJtEqLmxMCGcja7/TSeV54NdUPYmW1I+xMaSPOcxWHfgzFQl6jn5gUtv
 4LtCZoXsLqYJa1B4kp1CaQFkau2yTbxz89JDC93tNH2nsJqe9uc9f+pFnBzDpmEFzYyH5S
 4b7kg2lSi05nJIkGjfJyWW6V4T7cC+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-DkWwx4qROkG-CSQFBr_JCg-1; Wed, 27 Nov 2019 06:46:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D5A580183C;
 Wed, 27 Nov 2019 11:46:36 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0ED425C21B;
 Wed, 27 Nov 2019 11:46:23 +0000 (UTC)
Date: Wed, 27 Nov 2019 11:46:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 01/20] migration: Support QLIST migration
Message-ID: <20191127114621.GG3016@work-vm>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-2-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122182943.4656-2-eric.auger@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: DkWwx4qROkG-CSQFBr_JCg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Auger (eric.auger@redhat.com) wrote:
> Support QLIST migration using the same principle as QTAILQ:
> 94869d5c52 ("migration: migrate QTAILQ").
>=20
> The VMSTATE_QLIST_V macro has the same proto as VMSTATE_QTAILQ_V.
> The change mainly resides in QLIST RAW macros: QLIST_RAW_INSERT_HEAD
> and QLIST_RAW_REVERSE.
>=20
> Tests also are provided.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> ---
>=20
> v5 - v6:
> - by doing more advanced testing with virtio-iommu migration
>   I noticed this was broken. "prev" field was not set properly.
>   I improved the tests to manipulate both the next and prev
>   fields.
> - Removed Peter and Juan's R-b
> ---
>  include/migration/vmstate.h |  21 +++++
>  include/qemu/queue.h        |  39 +++++++++
>  migration/trace-events      |   5 ++
>  migration/vmstate-types.c   |  70 +++++++++++++++
>  tests/test-vmstate.c        | 170 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 305 insertions(+)
>=20
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index ac4f46a67d..08683d93c6 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -227,6 +227,7 @@ extern const VMStateInfo vmstate_info_tmp;
>  extern const VMStateInfo vmstate_info_bitmap;
>  extern const VMStateInfo vmstate_info_qtailq;
>  extern const VMStateInfo vmstate_info_gtree;
> +extern const VMStateInfo vmstate_info_qlist;
> =20
>  #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
>  /*
> @@ -796,6 +797,26 @@ extern const VMStateInfo vmstate_info_gtree;
>      .offset       =3D offsetof(_state, _field),                         =
         \
>  }
> =20
> +/*
> + * For migrating a QLIST
> + * Target QLIST needs be properly initialized.
> + * _type: type of QLIST element
> + * _next: name of QLIST_ENTRY entry field in QLIST element
> + * _vmsd: VMSD for QLIST element
> + * size: size of QLIST element
> + * start: offset of QLIST_ENTRY in QTAILQ element
> + */
> +#define VMSTATE_QLIST_V(_field, _state, _version, _vmsd, _type, _next)  =
\
> +{                                                                       =
 \
> +    .name         =3D (stringify(_field)),                              =
   \
> +    .version_id   =3D (_version),                                       =
   \
> +    .vmsd         =3D &(_vmsd),                                         =
   \
> +    .size         =3D sizeof(_type),                                    =
   \
> +    .info         =3D &vmstate_info_qlist,                              =
   \
> +    .offset       =3D offsetof(_state, _field),                         =
   \
> +    .start        =3D offsetof(_type, _next),                           =
   \
> +}
> +
>  /* _f : field name
>     _f_n : num of elements field_name
>     _n : num of elements
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index 4764d93ea3..4d4554a7ce 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -501,4 +501,43 @@ union {                                             =
                    \
>          QTAILQ_RAW_TQH_CIRC(head)->tql_prev =3D QTAILQ_RAW_TQE_CIRC(elm,=
 entry);  \
>  } while (/*CONSTCOND*/0)
> =20
> +#define QLIST_RAW_FIRST(head)                                           =
       \
> +        field_at_offset(head, 0, void *)
> +
> +#define QLIST_RAW_NEXT(elm, entry)                                      =
       \
> +        field_at_offset(elm, entry, void *)
> +
> +#define QLIST_RAW_PREVIOUS(elm, entry)                                  =
       \
> +        field_at_offset(elm, entry + sizeof(void *), void *)
> +
> +#define QLIST_RAW_FOREACH(elm, head, entry)                             =
       \
> +        for ((elm) =3D *QLIST_RAW_FIRST(head);                          =
         \
> +             (elm);                                                     =
       \
> +             (elm) =3D *QLIST_RAW_NEXT(elm, entry))
> +
> +#define QLIST_RAW_INSERT_HEAD(head, elm, entry) do {                    =
       \
> +        void *first =3D *QLIST_RAW_FIRST(head);                         =
         \
> +        *QLIST_RAW_FIRST(head) =3D elm;                                 =
         \
> +        *QLIST_RAW_PREVIOUS(elm, entry) =3D QLIST_RAW_FIRST(head);      =
         \
> +        if (first) {                                                    =
       \
> +            *QLIST_RAW_NEXT(elm, entry) =3D first;                      =
         \
> +            *QLIST_RAW_PREVIOUS(first, entry) =3D QLIST_RAW_NEXT(elm, en=
try);    \
> +        } else {                                                        =
       \
> +            *QLIST_RAW_NEXT(elm, entry) =3D NULL;                       =
         \
> +        }                                                               =
       \
> +} while (0)
> +
> +#define QLIST_RAW_REVERSE(head, elm, entry) do {                        =
       \
> +        void *iter =3D *QLIST_RAW_FIRST(head), *prev =3D NULL, *next;   =
           \
> +        while (iter) {                                                  =
       \
> +            next =3D *QLIST_RAW_NEXT(iter, entry);                      =
         \
> +            *QLIST_RAW_PREVIOUS(iter, entry) =3D QLIST_RAW_NEXT(next, en=
try);    \
> +            *QLIST_RAW_NEXT(iter, entry) =3D prev;                      =
         \
> +            prev =3D iter;                                              =
         \
> +            iter =3D next;                                              =
         \
> +        }                                                               =
       \
> +        *QLIST_RAW_FIRST(head) =3D prev;                                =
         \
> +        *QLIST_RAW_PREVIOUS(prev, entry) =3D QLIST_RAW_FIRST(head);     =
         \
> +} while (0)
> +
>  #endif /* QEMU_SYS_QUEUE_H */
> diff --git a/migration/trace-events b/migration/trace-events
> index 6dee7b5389..e0a33cffca 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -76,6 +76,11 @@ get_gtree_end(const char *field_name, const char *key_=
vmsd_name, const char *val
>  put_gtree(const char *field_name, const char *key_vmsd_name, const char =
*val_vmsd_name, uint32_t nnodes) "%s(%s/%s) nnodes=3D%d"
>  put_gtree_end(const char *field_name, const char *key_vmsd_name, const c=
har *val_vmsd_name, int ret) "%s(%s/%s) %d"
> =20
> +get_qlist(const char *field_name, const char *vmsd_name, int version_id)=
 "%s(%s v%d)"
> +get_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
> +put_qlist(const char *field_name, const char *vmsd_name, int version_id)=
 "%s(%s v%d)"
> +put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
> +
>  # qemu-file.c
>  qemu_file_fclose(void) ""
> =20
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 7236cf92bc..1eee36773a 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -843,3 +843,73 @@ const VMStateInfo vmstate_info_gtree =3D {
>      .get  =3D get_gtree,
>      .put  =3D put_gtree,
>  };
> +
> +static int put_qlist(QEMUFile *f, void *pv, size_t unused_size,
> +                     const VMStateField *field, QJSON *vmdesc)
> +{
> +    const VMStateDescription *vmsd =3D field->vmsd;
> +    /* offset of the QTAILQ entry in a QTAILQ element*/
> +    size_t entry_offset =3D field->start;
> +    void *elm;
> +    int ret;
> +
> +    trace_put_qlist(field->name, vmsd->name, vmsd->version_id);
> +    QLIST_RAW_FOREACH(elm, pv, entry_offset) {
> +        qemu_put_byte(f, true);
> +        ret =3D vmstate_save_state(f, vmsd, elm, vmdesc);
> +        if (ret) {
> +            error_report("%s: failed to save %s (%d)", field->name,
> +                         vmsd->name, ret);
> +            return ret;
> +        }
> +    }
> +    qemu_put_byte(f, false);
> +    trace_put_qlist_end(field->name, vmsd->name);
> +
> +    return 0;
> +}
> +
> +static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
> +                     const VMStateField *field)
> +{
> +    int ret =3D 0;
> +    const VMStateDescription *vmsd =3D field->vmsd;
> +    /* size of a QLIST element */
> +    size_t size =3D field->size;
> +    /* offset of the QLIST entry in a QLIST element */
> +    size_t entry_offset =3D field->start;
> +    int version_id =3D field->version_id;
> +    void *elm;
> +
> +    trace_get_qlist(field->name, vmsd->name, vmsd->version_id);
> +    if (version_id > vmsd->version_id) {
> +        error_report("%s %s",  vmsd->name, "too new");
> +        return -EINVAL;
> +    }
> +    if (version_id < vmsd->minimum_version_id) {
> +        error_report("%s %s",  vmsd->name, "too old");
> +        return -EINVAL;
> +    }
> +
> +    while (qemu_get_byte(f)) {
> +        elm =3D g_malloc(size);
> +        ret =3D vmstate_load_state(f, vmsd, elm, version_id);
> +        if (ret) {
> +            error_report("%s: failed to load %s (%d)", field->name,
> +                         vmsd->name, ret);
> +            g_free(elm);
> +            return ret;
> +        }
> +        QLIST_RAW_INSERT_HEAD(pv, elm, entry_offset);
> +    }
> +    QLIST_RAW_REVERSE(pv, elm, entry_offset);

Can you explain why you need to do a REVERSE on the loaded list,
rather than using doing a QLIST_INSERT_AFTER to always insert at
the end?

Other than that it looks good.

Dave

> +    trace_get_qlist_end(field->name, vmsd->name);
> +
> +    return ret;
> +}
> +
> +const VMStateInfo vmstate_info_qlist =3D {
> +    .name =3D "qlist",
> +    .get  =3D get_qlist,
> +    .put  =3D put_qlist,
> +};
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index 1e5be1d4ff..9660f932b9 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -926,6 +926,28 @@ static const VMStateDescription vmstate_domain =3D {
>      }
>  };
> =20
> +/* test QLIST Migration */
> +
> +typedef struct TestQListElement {
> +    uint32_t  id;
> +    QLIST_ENTRY(TestQListElement) next;
> +} TestQListElement;
> +
> +typedef struct TestQListContainer {
> +    uint32_t  id;
> +    QLIST_HEAD(, TestQListElement) list;
> +} TestQListContainer;
> +
> +static const VMStateDescription vmstate_qlist_element =3D {
> +    .name =3D "test/queue list",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(id, TestQListElement),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_iommu =3D {
>      .name =3D "iommu",
>      .version_id =3D 1,
> @@ -939,6 +961,18 @@ static const VMStateDescription vmstate_iommu =3D {
>      }
>  };
> =20
> +static const VMStateDescription vmstate_container =3D {
> +    .name =3D "test/container/qlist",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(id, TestQListContainer),
> +        VMSTATE_QLIST_V(list, TestQListContainer, 1, vmstate_qlist_eleme=
nt,
> +                        TestQListElement, next),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  uint8_t first_domain_dump[] =3D {
>      /* id */
>      0x00, 0x0, 0x0, 0x6,
> @@ -1229,6 +1263,140 @@ static void test_gtree_load_iommu(void)
>      qemu_fclose(fload);
>  }
> =20
> +static uint8_t qlist_dump[] =3D {
> +    0x00, 0x00, 0x00, 0x01, /* container id */
> +    0x1, /* start of a */
> +    0x00, 0x00, 0x00, 0x0a,
> +    0x1, /* start of b */
> +    0x00, 0x00, 0x0b, 0x00,
> +    0x1, /* start of c */
> +    0x00, 0x0c, 0x00, 0x00,
> +    0x1, /* start of d */
> +    0x0d, 0x00, 0x00, 0x00,
> +    0x0, /* end of list */
> +    QEMU_VM_EOF, /* just to ensure we won't get EOF reported prematurely=
 */
> +};
> +
> +static TestQListContainer *alloc_container(void)
> +{
> +    TestQListElement *a =3D g_malloc(sizeof(TestQListElement));
> +    TestQListElement *b =3D g_malloc(sizeof(TestQListElement));
> +    TestQListElement *c =3D g_malloc(sizeof(TestQListElement));
> +    TestQListElement *d =3D g_malloc(sizeof(TestQListElement));
> +    TestQListContainer *container =3D g_malloc(sizeof(TestQListContainer=
));
> +
> +    a->id =3D 0x0a;
> +    b->id =3D 0x0b00;
> +    c->id =3D 0xc0000;
> +    d->id =3D 0xd000000;
> +    container->id =3D 1;
> +
> +    QLIST_INIT(&container->list);
> +    QLIST_INSERT_HEAD(&container->list, d, next);
> +    QLIST_INSERT_HEAD(&container->list, c, next);
> +    QLIST_INSERT_HEAD(&container->list, b, next);
> +    QLIST_INSERT_HEAD(&container->list, a, next);
> +    return container;
> +}
> +
> +static void free_container(TestQListContainer *container)
> +{
> +    TestQListElement *iter, *tmp;
> +
> +    QLIST_FOREACH_SAFE(iter, &container->list, next, tmp) {
> +        QLIST_REMOVE(iter, next);
> +        g_free(iter);
> +    }
> +    g_free(container);
> +}
> +
> +static void compare_containers(TestQListContainer *c1, TestQListContaine=
r *c2)
> +{
> +    TestQListElement *first_item_c1, *first_item_c2;
> +
> +    while (!QLIST_EMPTY(&c1->list)) {
> +        first_item_c1 =3D QLIST_FIRST(&c1->list);
> +        first_item_c2 =3D QLIST_FIRST(&c2->list);
> +        assert(first_item_c2);
> +        assert(first_item_c1->id =3D=3D first_item_c2->id);
> +        QLIST_REMOVE(first_item_c1, next);
> +        QLIST_REMOVE(first_item_c2, next);
> +        g_free(first_item_c1);
> +        g_free(first_item_c2);
> +    }
> +    assert(QLIST_EMPTY(&c2->list));
> +}
> +
> +/*
> + * Check the prev & next fields are correct by doing list
> + * manipulations on the container. We will do that for both
> + * the source and the destination containers
> + */
> +static void manipulate_container(TestQListContainer *c)
> +{
> +     TestQListElement *prev, *iter =3D QLIST_FIRST(&c->list);
> +     TestQListElement *elem;
> +
> +     elem =3D g_malloc(sizeof(TestQListElement));
> +     elem->id =3D 0x12;
> +     QLIST_INSERT_AFTER(iter, elem, next);
> +
> +     elem =3D g_malloc(sizeof(TestQListElement));
> +     elem->id =3D 0x13;
> +     QLIST_INSERT_HEAD(&c->list, elem, next);
> +
> +     while (iter) {
> +        prev =3D iter;
> +        iter =3D QLIST_NEXT(iter, next);
> +     }
> +
> +     elem =3D g_malloc(sizeof(TestQListElement));
> +     elem->id =3D 0x14;
> +     QLIST_INSERT_BEFORE(prev, elem, next);
> +
> +     elem =3D g_malloc(sizeof(TestQListElement));
> +     elem->id =3D 0x15;
> +     QLIST_INSERT_AFTER(prev, elem, next);
> +
> +     QLIST_REMOVE(prev, next);
> +     g_free(prev);
> +}
> +
> +static void test_save_qlist(void)
> +{
> +    TestQListContainer *container =3D alloc_container();
> +
> +    save_vmstate(&vmstate_container, container);
> +    compare_vmstate(qlist_dump, sizeof(qlist_dump));
> +    free_container(container);
> +}
> +
> +static void test_load_qlist(void)
> +{
> +    QEMUFile *fsave, *fload;
> +    TestQListContainer *orig_container =3D alloc_container();
> +    TestQListContainer *dest_container =3D g_malloc0(sizeof(TestQListCon=
tainer));
> +    char eof;
> +
> +    QLIST_INIT(&dest_container->list);
> +
> +    fsave =3D open_test_file(true);
> +    qemu_put_buffer(fsave, qlist_dump, sizeof(qlist_dump));
> +    g_assert(!qemu_file_get_error(fsave));
> +    qemu_fclose(fsave);
> +
> +    fload =3D open_test_file(false);
> +    vmstate_load_state(fload, &vmstate_container, dest_container, 1);
> +    eof =3D qemu_get_byte(fload);
> +    g_assert(!qemu_file_get_error(fload));
> +    g_assert_cmpint(eof, =3D=3D, QEMU_VM_EOF);
> +    manipulate_container(orig_container);
> +    manipulate_container(dest_container);
> +    compare_containers(orig_container, dest_container);
> +    free_container(orig_container);
> +    free_container(dest_container);
> +}
> +
>  typedef struct TmpTestStruct {
>      TestStruct *parent;
>      int64_t diff;
> @@ -1353,6 +1521,8 @@ int main(int argc, char **argv)
>      g_test_add_func("/vmstate/gtree/load/loaddomain", test_gtree_load_do=
main);
>      g_test_add_func("/vmstate/gtree/save/saveiommu", test_gtree_save_iom=
mu);
>      g_test_add_func("/vmstate/gtree/load/loadiommu", test_gtree_load_iom=
mu);
> +    g_test_add_func("/vmstate/qlist/save/saveqlist", test_save_qlist);
> +    g_test_add_func("/vmstate/qlist/load/loadqlist", test_load_qlist);
>      g_test_add_func("/vmstate/tmp_struct", test_tmp_struct);
>      g_test_run();
> =20
> --=20
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


