Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16538C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E352071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUdQWROB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E352071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41229 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ9Mp-0003oG-UL
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 03:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZ9MB-0003OM-AE
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZ9M8-0001Sb-Bq
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:04:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56541
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZ9M7-0001SB-Np
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574669062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zhMsJNiQGoLemZ39i80l5Ih6Cwk2llOHv5z0a/GC2I=;
 b=VUdQWROBdZNkV8/STlmQzXAxDNdK1V+mKa55k3GUvYt7qM5Ne/6scn4egOQeDHrHtKTLQH
 JqxCTy4wlCGkDXXAlx8+qOGEkVUo/xxMZSjK81VGfxBFTvjMVH+/FHyh71qCnx+U8Apdag
 61IPt66/K9QJcVvJPicuIOpmH/sb96s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-q8qk9MlSOgiLZw_EfjFurQ-1; Mon, 25 Nov 2019 03:04:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 596F2593A0;
 Mon, 25 Nov 2019 08:04:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A049819C70;
 Mon, 25 Nov 2019 08:04:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 241341138606; Mon, 25 Nov 2019 09:04:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v17 05/14] qapi: Add builtin type time
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-6-tao3.xu@intel.com>
Date: Mon, 25 Nov 2019 09:04:12 +0100
In-Reply-To: <20191122074826.1373-6-tao3.xu@intel.com> (Tao Xu's message of
 "Fri, 22 Nov 2019 15:48:17 +0800")
Message-ID: <87k17oidqb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: q8qk9MlSOgiLZw_EfjFurQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 jonathan.cameron@huawei.com, sw@weilnetz.de, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, jingqi.liu@intel.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> Add optional builtin type time, fallback is uint64. This type use
> qemu_strtotime_ns() for pre-converting time suffix to numbers.
>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>
> No changes in v17.
>
> Changes in v14:
>     - Drop time unit picosecond (Eric)
> ---
>  include/qapi/visitor-impl.h  |  4 ++++
>  include/qapi/visitor.h       |  8 ++++++++
>  qapi/opts-visitor.c          | 22 ++++++++++++++++++++++
>  qapi/qapi-visit-core.c       | 12 ++++++++++++
>  qapi/qobject-input-visitor.c | 18 ++++++++++++++++++
>  qapi/trace-events            |  1 +
>  scripts/qapi/schema.py       |  1 +
>  7 files changed, 66 insertions(+)

Missing: test coverage for the new built-in type.  I'm not asking for
much.  Suggest to match what's done for 'size' in qapi-schema-test.json.

Possibly missing: string-input-visitor, string-output-visitor implement
type_size().  Both lack test coverage, though.  Should any of them
implement type_time(), too?

>
> diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
> index 8ccb3b6c20..e0979563c7 100644
> --- a/include/qapi/visitor-impl.h
> +++ b/include/qapi/visitor-impl.h
> @@ -88,6 +88,10 @@ struct Visitor
>      void (*type_size)(Visitor *v, const char *name, uint64_t *obj,
>                        Error **errp);
> =20
> +    /* Optional; fallback is type_uint64() */
> +    void (*type_time)(Visitor *v, const char *name, uint64_t *obj,
> +                      Error **errp);
> +
>      /* Must be set */
>      void (*type_bool)(Visitor *v, const char *name, bool *obj, Error **e=
rrp);
> =20
> diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
> index c5b23851a1..22242e706f 100644
> --- a/include/qapi/visitor.h
> +++ b/include/qapi/visitor.h
> @@ -554,6 +554,14 @@ void visit_type_int64(Visitor *v, const char *name, =
int64_t *obj,
>  void visit_type_size(Visitor *v, const char *name, uint64_t *obj,
>                       Error **errp);
> =20
> +/*
> + * Visit a uint64_t value.
> + * Like visit_type_uint64(), except that some visitors may choose to
> + * recognize numbers with timeunit suffix, such as "ns", "us" "ms" and "=
s".
> + */

Overspecifies what implementations may do.  Let's use
visit_type_size()'s contract here:

   /*
    * Visit a uint64_t value.
    * Like visit_type_uint64(), except that some visitors may choose to
    * recognize additional syntax, such as suffixes for easily scaling
    * values.
    */

> +void visit_type_time(Visitor *v, const char *name, uint64_t *obj,
> +                     Error **errp);
> +
>  /*
>   * Visit a boolean value.
>   *
> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index 5fe0276c1c..59b575f0fc 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -526,6 +526,27 @@ opts_type_size(Visitor *v, const char *name, uint64_=
t *obj, Error **errp)
>      processed(ov, name);
>  }
> =20
> +static void
> +opts_type_time(Visitor *v, const char *name, uint64_t *obj, Error **errp=
)
> +{
> +    OptsVisitor *ov =3D to_ov(v);
> +    const QemuOpt *opt;
> +    int err;
> +
> +    opt =3D lookup_scalar(ov, name, errp);
> +    if (!opt) {
> +        return;
> +    }
> +
> +    err =3D qemu_strtotime_ns(opt->str ? opt->str : "", NULL, obj);
> +    if (err < 0) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
> +                   "a time value");
> +        return;
> +    }
> +
> +    processed(ov, name);
> +}
> =20
>  static void
>  opts_optional(Visitor *v, const char *name, bool *present)
> @@ -573,6 +594,7 @@ opts_visitor_new(const QemuOpts *opts)
>      ov->visitor.type_int64  =3D &opts_type_int64;
>      ov->visitor.type_uint64 =3D &opts_type_uint64;
>      ov->visitor.type_size   =3D &opts_type_size;
> +    ov->visitor.type_time   =3D &opts_type_time;
>      ov->visitor.type_bool   =3D &opts_type_bool;
>      ov->visitor.type_str    =3D &opts_type_str;
> =20
> diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
> index 5365561b07..ac8896455c 100644
> --- a/qapi/qapi-visit-core.c
> +++ b/qapi/qapi-visit-core.c
> @@ -277,6 +277,18 @@ void visit_type_size(Visitor *v, const char *name, u=
int64_t *obj,
>      }
>  }
> =20
> +void visit_type_time(Visitor *v, const char *name, uint64_t *obj,
> +                     Error **errp)
> +{
> +    assert(obj);
> +    trace_visit_type_time(v, name, obj);
> +    if (v->type_time) {
> +        v->type_time(v, name, obj, errp);
> +    } else {
> +        v->type_uint64(v, name, obj, errp);
> +    }
> +}
> +
>  void visit_type_bool(Visitor *v, const char *name, bool *obj, Error **er=
rp)
>  {
>      assert(obj);
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index 32236cbcb1..e476fe0d16 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -627,6 +627,23 @@ static void qobject_input_type_size_keyval(Visitor *=
v, const char *name,
>      }
>  }
> =20
> +static void qobject_input_type_time_keyval(Visitor *v, const char *name,
> +                                           uint64_t *obj, Error **errp)
> +{
> +    QObjectInputVisitor *qiv =3D to_qiv(v);
> +    const char *str =3D qobject_input_get_keyval(qiv, name, errp);
> +
> +    if (!str) {
> +        return;
> +    }
> +
> +    if (qemu_strtotime_ns(str, NULL, obj) < 0) {
> +        /* TODO report -ERANGE more nicely */
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                   full_name(qiv, name), "time");
> +    }
> +}
> +
>  static void qobject_input_optional(Visitor *v, const char *name, bool *p=
resent)
>  {
>      QObjectInputVisitor *qiv =3D to_qiv(v);
> @@ -708,6 +725,7 @@ Visitor *qobject_input_visitor_new_keyval(QObject *ob=
j)
>      v->visitor.type_any =3D qobject_input_type_any;
>      v->visitor.type_null =3D qobject_input_type_null;
>      v->visitor.type_size =3D qobject_input_type_size_keyval;
> +    v->visitor.type_time =3D qobject_input_type_time_keyval;
>      v->keyval =3D true;
> =20
>      return &v->visitor;
> diff --git a/qapi/trace-events b/qapi/trace-events
> index 5eb4afa110..c4605a7ccc 100644
> --- a/qapi/trace-events
> +++ b/qapi/trace-events
> @@ -29,6 +29,7 @@ visit_type_int16(void *v, const char *name, int16_t *ob=
j) "v=3D%p name=3D%s obj=3D%p"
>  visit_type_int32(void *v, const char *name, int32_t *obj) "v=3D%p name=
=3D%s obj=3D%p"
>  visit_type_int64(void *v, const char *name, int64_t *obj) "v=3D%p name=
=3D%s obj=3D%p"
>  visit_type_size(void *v, const char *name, uint64_t *obj) "v=3D%p name=
=3D%s obj=3D%p"
> +visit_type_time(void *v, const char *name, uint64_t *obj) "v=3D%p name=
=3D%s obj=3D%p"
>  visit_type_bool(void *v, const char *name, bool *obj) "v=3D%p name=3D%s =
obj=3D%p"
>  visit_type_str(void *v, const char *name, char **obj) "v=3D%p name=3D%s =
obj=3D%p"
>  visit_type_number(void *v, const char *name, void *obj) "v=3D%p name=3D%=
s obj=3D%p"
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index cf0045f34e..210be64909 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -855,6 +855,7 @@ class QAPISchema(object):
>                    ('uint32', 'int',     'uint32_t'),
>                    ('uint64', 'int',     'uint64_t'),
>                    ('size',   'int',     'uint64_t'),
> +                  ('time',   'int',     'uint64_t'),
>                    ('bool',   'boolean', 'bool'),
>                    ('any',    'value',   'QObject' + pointer_suffix),
>                    ('null',   'null',    'QNull' + pointer_suffix)]:


