Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCF0C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1392A20739
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4vOye+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1392A20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXhs-0005ha-0r
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXem-0002Mn-23
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:53:40 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:32904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXej-0004PU-JY
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:53:39 -0400
Received: by mail-ej1-x643.google.com with SMTP id 7so9560955ejm.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bYCZAdWch/WvI8UEIskB/v7wdKs4EwPvo16WxuP+vKw=;
 b=p4vOye+YPjyc5vmapOp0TPFY6+eUAZqr6mCQTJcSvP1LpP/9tgBaPG0os13ZKSDDOt
 NR+paz/sBzYfg6UifcRymFzp3NzEr+t+BdBFf3+fD3HgmFSaHSZw57eX/al7CTafNH0O
 ZP+kGQw8spgpS7B5Rg363A4luApRexzSKPrkWhK/kA8h1JxgdoBymdQ7aGE4ifODSWzr
 oZ0nTY8TNF9hmC1qRbh0UeN1vFK0IryvdhRnvAlgPJEiK/GYFy3SkJkNXs4sO8B/dJTq
 P+KHhOK8VAoTjXVOB5vuW98nn40DrE0VdXC5mYrGPS8PYzZauK/j+JCVfokycXMc6SyA
 HDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bYCZAdWch/WvI8UEIskB/v7wdKs4EwPvo16WxuP+vKw=;
 b=PB163k+vAbtWpKPh81cZOWm9LFO0VL/BMNe9ubFnz/5m6GHybv7RW/GSF7ar4R1Get
 7DJBScyastNF3Ej5cNeAeJ5U4HmxV9e2fjTe9vduDT/u7ulGmUwb0wBoCQPQQWx4Gsud
 SyUklkJ1kqaIvSe4tYoU5pb2oPIlj5CdYvvtcrrJqN5O012SNnQqxCO4+IOyTQUyKrty
 X8OtoDJYKpUHn2G4j1Sb0eWWoCiKqWHpUymvhcSfifJdekmFVrrnqlpKLuNFi9kRrHFT
 OsUtCazA4WGzpY8Z6uyE/56dGXBZN4klEPZJapJr+4SULswFCAW46g+YNTsP0gMkg8IJ
 B5hQ==
X-Gm-Message-State: AOAM5320+srdwdpjkITo6WXidbe51dehoE9IBbwQfhR+jcYBe+zTUt0W
 7yerbcgtMNtt+KoIpCn/h0jgEHKnEY+wFZERusc=
X-Google-Smtp-Source: ABdhPJxJsAfi0ByS+iGm1cD9qt+2AeldmTGo8UwqU03tWsmbckR5hU3rsRmvlznywuh2J0bORgYxr46lWqCadTTKfEw=
X-Received: by 2002:a17:906:f6cf:: with SMTP id
 jo15mr3395116ejb.105.1604076816163; 
 Fri, 30 Oct 2020 09:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-28-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-28-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 20:53:24 +0400
Message-ID: <CAJ+F1CLZSe4a6T0fpvnVV6HrpJbfFBoHq8c9vUxGTBiXTvQ6ug@mail.gmail.com>
Subject: Re: [PATCH 27/36] qdev: Reuse DEFINE_PROP in all DEFINE_PROP_* macros
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d1e5b105b2e63c96"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d1e5b105b2e63c96
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:23 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Instead of duplicating the code that sets name, info, offset,
> and does type checking, make DEFINE_PROP accept a variable number
> of arguments and reuse it in all DEFINE_PROP_* macros.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

neat! and clever? ;)
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/qdev-properties.h | 132 ++++++++++++-----------------------
>  1 file changed, 45 insertions(+), 87 deletions(-)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 3a7b4c8643..f9a4c132e7 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -62,73 +62,46 @@ extern const PropertyInfo qdev_prop_uuid;
>  extern const PropertyInfo qdev_prop_arraylen;
>  extern const PropertyInfo qdev_prop_link;
>
> -#define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
> +#define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
>          .name      =3D (_name),                                    \
>          .info      =3D &(_prop),                                   \
>          .offset    =3D offsetof(_state, _field)                    \
>              + type_check(_type, typeof_field(_state, _field)),   \
> +        __VA_ARGS__                                              \
>          }
>
> -#define DEFINE_PROP_SIGNED(_name, _state, _field, _defval, _prop, _type)
> { \
> -        .name      =3D (_name),                                         =
  \
> -        .info      =3D &(_prop),                                        =
  \
> -        .offset    =3D offsetof(_state, _field)                         =
  \
> -            + type_check(_type,typeof_field(_state, _field)),           =
\
> -        .set_default =3D true,                                          =
  \
> -        .defval.i  =3D (_type)_defval,                                  =
  \
> -        }
> +#define DEFINE_PROP_SIGNED(_name, _state, _field, _defval, _prop, _type)=
 \
> +    DEFINE_PROP(_name, _state, _field, _prop, _type,                    =
 \
> +                .set_default =3D true,                                  =
   \
> +                .defval.i    =3D (_type)_defval)
>
> -#define DEFINE_PROP_SIGNED_NODEFAULT(_name, _state, _field, _prop, _type=
)
> { \
> -        .name      =3D (_name),                                         =
  \
> -        .info      =3D &(_prop),                                        =
  \
> -        .offset    =3D offsetof(_state, _field)                         =
  \
> -            + type_check(_type, typeof_field(_state, _field)),          =
\
> -        }
> +#define DEFINE_PROP_SIGNED_NODEFAULT(_name, _state, _field, _prop, _type=
)
> \
> +    DEFINE_PROP(_name, _state, _field, _prop, _type)
>
> -#define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
> -        .name      =3D (_name),                                    \
> -        .info      =3D &(qdev_prop_bit),                           \
> -        .bitnr    =3D (_bit),                                      \
> -        .offset    =3D offsetof(_state, _field)                    \
> -            + type_check(uint32_t,typeof_field(_state, _field)), \
> -        .set_default =3D true,                                     \
> -        .defval.u  =3D (bool)_defval,                              \
> -        }
> +#define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval)   \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_bit, uint32_t, \
> +                .bitnr       =3D (_bit),                          \
> +                .set_default =3D true,                            \
> +                .defval.u    =3D (bool)_defval)
>
> -#define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop,
> _type) { \
> -        .name      =3D (_name),                                         =
  \
> -        .info      =3D &(_prop),                                        =
  \
> -        .offset    =3D offsetof(_state, _field)                         =
  \
> -            + type_check(_type, typeof_field(_state, _field)),          =
\
> -        .set_default =3D true,                                          =
  \
> -        .defval.u  =3D (_type)_defval,                                  =
  \
> -        }
> +#define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop,
> _type) \
> +    DEFINE_PROP(_name, _state, _field, _prop, _type,
>  \
> +                .set_default =3D true,
>  \
> +                .defval.u  =3D (_type)_defval)
>
> -#define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop,
> _type) { \
> -        .name      =3D (_name),                                         =
  \
> -        .info      =3D &(_prop),                                        =
  \
> -        .offset    =3D offsetof(_state, _field)                         =
  \
> -            + type_check(_type, typeof_field(_state, _field)),          =
\
> -        }
> +#define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop,
> _type) \
> +    DEFINE_PROP(_name, _state, _field, _prop, _type)
>
> -#define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {       =
\
> -        .name      =3D (_name),                                         =
  \
> -        .info      =3D &(qdev_prop_bit64),                              =
  \
> -        .bitnr    =3D (_bit),                                           =
  \
> -        .offset    =3D offsetof(_state, _field)                         =
  \
> -            + type_check(uint64_t, typeof_field(_state, _field)),       =
\
> -        .set_default =3D true,                                          =
  \
> -        .defval.u  =3D (bool)_defval,                                   =
  \
> -        }
> +#define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval)   \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_bit64, uint64_t, \
> +                .bitnr    =3D (_bit),                               \
> +                .set_default =3D true,                              \
> +                .defval.u  =3D (bool)_defval)
>
> -#define DEFINE_PROP_BOOL(_name, _state, _field, _defval) {       \
> -        .name      =3D (_name),                                    \
> -        .info      =3D &(qdev_prop_bool),                          \
> -        .offset    =3D offsetof(_state, _field)                    \
> -            + type_check(bool, typeof_field(_state, _field)),    \
> -        .set_default =3D true,                                     \
> -        .defval.u    =3D (bool)_defval,                            \
> -        }
> +#define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \
> +                .set_default =3D true,                         \
> +                .defval.u    =3D (bool)_defval)
>
>  #define PROP_ARRAY_LEN_PREFIX "len-"
>
> @@ -156,26 +129,19 @@ extern const PropertyInfo qdev_prop_link;
>   * It is the responsibility of the device deinit code to free the
>   * @_arrayfield memory.
>   */
> -#define DEFINE_PROP_ARRAY(_name, _state, _field,                        =
\
> -                          _arrayfield, _arrayprop, _arraytype) {        =
\
> -        .name =3D (PROP_ARRAY_LEN_PREFIX _name),                        =
  \
> -        .info =3D &(qdev_prop_arraylen),                                =
  \
> -        .set_default =3D true,                                          =
  \
> -        .defval.u =3D 0,                                                =
  \
> -        .offset =3D offsetof(_state, _field)                            =
  \
> -            + type_check(uint32_t, typeof_field(_state, _field)),       =
\
> -        .arrayinfo =3D &(_arrayprop),                                   =
  \
> -        .arrayfieldsize =3D sizeof(_arraytype),                         =
  \
> -        .arrayoffset =3D offsetof(_state, _arrayfield),                 =
  \
> -        }
> +#define DEFINE_PROP_ARRAY(_name, _state, _field,               \
> +                          _arrayfield, _arrayprop, _arraytype) \
> +    DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),                 \
> +                _state, _field, qdev_prop_arraylen, uint32_t,  \
> +                .set_default =3D true,                           \
> +                .defval.u =3D 0,                                 \
> +                .arrayinfo =3D &(_arrayprop),                    \
> +                .arrayfieldsize =3D sizeof(_arraytype),          \
> +                .arrayoffset =3D offsetof(_state, _arrayfield))
>
> -#define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type) {     =
\
> -        .name =3D (_name),                                              =
  \
> -        .info =3D &(qdev_prop_link),                                    =
  \
> -        .offset =3D offsetof(_state, _field)                            =
  \
> -            + type_check(_ptr_type, typeof_field(_state, _field)),      =
\
> -        .link_type  =3D _type,                                          =
  \
> -        }
> +#define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type)     \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_link, _ptr_type,     \
> +                .link_type  =3D _type)
>
>  #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
>      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
> @@ -197,19 +163,11 @@ extern const PropertyInfo qdev_prop_link;
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
>  #define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
>      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, uint32_t)
> -#define DEFINE_PROP_UUID(_name, _state, _field) {                  \
> -        .name      =3D (_name),                                      \
> -        .info      =3D &qdev_prop_uuid,                              \
> -        .offset    =3D offsetof(_state, _field)                      \
> -            + type_check(QemuUUID, typeof_field(_state, _field)),  \
> -        .set_default =3D true,                                       \
> -        }
> -#define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) {        \
> -        .name      =3D (_name),                                      \
> -        .info      =3D &qdev_prop_uuid,                              \
> -        .offset    =3D offsetof(_state, _field)                      \
> -            + type_check(QemuUUID, typeof_field(_state, _field)),  \
> -        }
> +#define DEFINE_PROP_UUID(_name, _state, _field)                      \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID,     \
> +                .set_default =3D true)
> +#define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID)
>
>  #define DEFINE_PROP_END_OF_LIST()               \
>      {}
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d1e5b105b2e63c96
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIEZyaSwgT2N0
IDMwLCAyMDIwIGF0IDI6MjMgQU0gRWR1YXJkbyBIYWJrb3N0ICZsdDs8YSBocmVmPSJtYWlsdG86
ZWhhYmtvc3RAcmVkaGF0LmNvbSI+ZWhhYmtvc3RAcmVkaGF0LmNvbTwvYT4mZ3Q7IHdyb3RlOjxi
cj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4
IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFk
ZGluZy1sZWZ0OjFleCI+SW5zdGVhZCBvZiBkdXBsaWNhdGluZyB0aGUgY29kZSB0aGF0IHNldHMg
bmFtZSwgaW5mbywgb2Zmc2V0LDxicj4NCmFuZCBkb2VzIHR5cGUgY2hlY2tpbmcsIG1ha2UgREVG
SU5FX1BST1AgYWNjZXB0IGEgdmFyaWFibGUgbnVtYmVyPGJyPg0Kb2YgYXJndW1lbnRzIGFuZCBy
ZXVzZSBpdCBpbiBhbGwgREVGSU5FX1BST1BfKiBtYWNyb3MuPGJyPg0KPGJyPg0KU2lnbmVkLW9m
Zi1ieTogRWR1YXJkbyBIYWJrb3N0ICZsdDs8YSBocmVmPSJtYWlsdG86ZWhhYmtvc3RAcmVkaGF0
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmVoYWJrb3N0QHJlZGhhdC5jb208L2E+Jmd0Ozxicj48L2Js
b2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5uZWF0ISBhbmQgY2xldmVyPyA7KTxicj48L2Rp
dj48ZGl2PjxkaXY+UmV2aWV3ZWQtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSAmbHQ7PGEgaHJlZj0i
bWFpbHRvOm1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1hcmNh
bmRyZS5sdXJlYXVAcmVkaGF0LmNvbTwvYT4mZ3Q7PC9kaXY+PGRpdj48YnI+PC9kaXY+wqA8L2Rp
dj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAw
cHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1s
ZWZ0OjFleCI+DQotLS08YnI+DQpDYzogUGFvbG8gQm9uemluaSAmbHQ7PGEgaHJlZj0ibWFpbHRv
OnBib256aW5pQHJlZGhhdC5jb20iIHRhcmdldD0iX2JsYW5rIj5wYm9uemluaUByZWRoYXQuY29t
PC9hPiZndDs8YnI+DQpDYzogJnF1b3Q7RGFuaWVsIFAuIEJlcnJhbmfDqSZxdW90OyAmbHQ7PGEg
aHJlZj0ibWFpbHRvOmJlcnJhbmdlQHJlZGhhdC5jb20iIHRhcmdldD0iX2JsYW5rIj5iZXJyYW5n
ZUByZWRoYXQuY29tPC9hPiZndDs8YnI+DQpDYzogRWR1YXJkbyBIYWJrb3N0ICZsdDs8YSBocmVm
PSJtYWlsdG86ZWhhYmtvc3RAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmVoYWJrb3N0QHJl
ZGhhdC5jb208L2E+Jmd0Ozxicj4NCkNjOiA8YSBocmVmPSJtYWlsdG86cWVtdS1kZXZlbEBub25n
bnUub3JnIiB0YXJnZXQ9Il9ibGFuayI+cWVtdS1kZXZlbEBub25nbnUub3JnPC9hPjxicj4NCi0t
LTxicj4NCsKgaW5jbHVkZS9ody9xZGV2LXByb3BlcnRpZXMuaCB8IDEzMiArKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj4NCsKgMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2VydGlv
bnMoKyksIDg3IGRlbGV0aW9ucygtKTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3
L3FkZXYtcHJvcGVydGllcy5oIGIvaW5jbHVkZS9ody9xZGV2LXByb3BlcnRpZXMuaDxicj4NCmlu
ZGV4IDNhN2I0Yzg2NDMuLmY5YTRjMTMyZTcgMTAwNjQ0PGJyPg0KLS0tIGEvaW5jbHVkZS9ody9x
ZGV2LXByb3BlcnRpZXMuaDxicj4NCisrKyBiL2luY2x1ZGUvaHcvcWRldi1wcm9wZXJ0aWVzLmg8
YnI+DQpAQCAtNjIsNzMgKzYyLDQ2IEBAIGV4dGVybiBjb25zdCBQcm9wZXJ0eUluZm8gcWRldl9w
cm9wX3V1aWQ7PGJyPg0KwqBleHRlcm4gY29uc3QgUHJvcGVydHlJbmZvIHFkZXZfcHJvcF9hcnJh
eWxlbjs8YnI+DQrCoGV4dGVybiBjb25zdCBQcm9wZXJ0eUluZm8gcWRldl9wcm9wX2xpbms7PGJy
Pg0KPGJyPg0KLSNkZWZpbmUgREVGSU5FX1BST1AoX25hbWUsIF9zdGF0ZSwgX2ZpZWxkLCBfcHJv
cCwgX3R5cGUpIHsgXDxicj4NCisjZGVmaW5lIERFRklORV9QUk9QKF9uYW1lLCBfc3RhdGUsIF9m
aWVsZCwgX3Byb3AsIF90eXBlLCAuLi4pIHvCoCBcPGJyPg0KwqAgwqAgwqAgwqAgwqAubmFtZcKg
IMKgIMKgID0gKF9uYW1lKSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAgwqAuaW5mb8KgIMKgIMKgID0gJmFtcDso
X3Byb3ApLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgLm9mZnNldMKgIMKgID0gb2Zmc2V0b2YoX3N0YXRlLCBf
ZmllbGQpwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgKyB0eXBlX2NoZWNrKF90eXBlLCB0eXBlb2ZfZmllbGQoX3N0YXRlLCBfZmllbGQpKSzC
oCDCoFw8YnI+DQorwqAgwqAgwqAgwqAgX19WQV9BUkdTX1/CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KwqAg
wqAgwqAgwqAgwqB9PGJyPg0KPGJyPg0KLSNkZWZpbmUgREVGSU5FX1BST1BfU0lHTkVEKF9uYW1l
LCBfc3RhdGUsIF9maWVsZCwgX2RlZnZhbCwgX3Byb3AsIF90eXBlKSB7IFw8YnI+DQotwqAgwqAg
wqAgwqAgLm5hbWXCoCDCoCDCoCA9IChfbmFtZSkswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKg
IC5pbmZvwqAgwqAgwqAgPSAmYW1wOyhfcHJvcCkswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoCAu
b2Zmc2V0wqAgwqAgPSBvZmZzZXRvZihfc3RhdGUsIF9maWVsZCnCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgKyB0eXBlX2No
ZWNrKF90eXBlLHR5cGVvZl9maWVsZChfc3RhdGUsIF9maWVsZCkpLMKgIMKgIMKgIMKgIMKgIMKg
XDxicj4NCi3CoCDCoCDCoCDCoCAuc2V0X2RlZmF1bHQgPSB0cnVlLMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQot
wqAgwqAgwqAgwqAgLmRlZnZhbC5pwqAgPSAoX3R5cGUpX2RlZnZhbCzCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKg
IH08YnI+DQorI2RlZmluZSBERUZJTkVfUFJPUF9TSUdORUQoX25hbWUsIF9zdGF0ZSwgX2ZpZWxk
LCBfZGVmdmFsLCBfcHJvcCwgX3R5cGUpIFw8YnI+DQorwqAgwqAgREVGSU5FX1BST1AoX25hbWUs
IF9zdGF0ZSwgX2ZpZWxkLCBfcHJvcCwgX3R5cGUswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5zZXRfZGVmYXVsdCA9IHRydWUs
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBc
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5kZWZ2YWwuacKgIMKgID0gKF90eXBlKV9k
ZWZ2YWwpPGJyPg0KPGJyPg0KLSNkZWZpbmUgREVGSU5FX1BST1BfU0lHTkVEX05PREVGQVVMVChf
bmFtZSwgX3N0YXRlLCBfZmllbGQsIF9wcm9wLCBfdHlwZSkgeyBcPGJyPg0KLcKgIMKgIMKgIMKg
IC5uYW1lwqAgwqAgwqAgPSAoX25hbWUpLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoCAuaW5m
b8KgIMKgIMKgID0gJmFtcDsoX3Byb3ApLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgLm9mZnNl
dMKgIMKgID0gb2Zmc2V0b2YoX3N0YXRlLCBfZmllbGQpwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgICsgdHlwZV9jaGVjayhf
dHlwZSwgdHlwZW9mX2ZpZWxkKF9zdGF0ZSwgX2ZpZWxkKSkswqAgwqAgwqAgwqAgwqAgXDxicj4N
Ci3CoCDCoCDCoCDCoCB9PGJyPg0KKyNkZWZpbmUgREVGSU5FX1BST1BfU0lHTkVEX05PREVGQVVM
VChfbmFtZSwgX3N0YXRlLCBfZmllbGQsIF9wcm9wLCBfdHlwZSkgXDxicj4NCivCoCDCoCBERUZJ
TkVfUFJPUChfbmFtZSwgX3N0YXRlLCBfZmllbGQsIF9wcm9wLCBfdHlwZSk8YnI+DQo8YnI+DQot
I2RlZmluZSBERUZJTkVfUFJPUF9CSVQoX25hbWUsIF9zdGF0ZSwgX2ZpZWxkLCBfYml0LCBfZGVm
dmFsKSB7wqAgXDxicj4NCi3CoCDCoCDCoCDCoCAubmFtZcKgIMKgIMKgID0gKF9uYW1lKSzCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0K
LcKgIMKgIMKgIMKgIC5pbmZvwqAgwqAgwqAgPSAmYW1wOyhxZGV2X3Byb3BfYml0KSzCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAgwqAgLmJp
dG5ywqAgwqAgPSAoX2JpdCkswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoCAub2Zmc2V0wqAgwqAgPSBvZmZz
ZXRvZihfc3RhdGUsIF9maWVsZCnCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgICsgdHlwZV9jaGVjayh1aW50MzJfdCx0eXBlb2ZfZmllbGQoX3N0
YXRlLCBfZmllbGQpKSwgXDxicj4NCi3CoCDCoCDCoCDCoCAuc2V0X2RlZmF1bHQgPSB0cnVlLMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxi
cj4NCi3CoCDCoCDCoCDCoCAuZGVmdmFsLnXCoCA9IChib29sKV9kZWZ2YWwswqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoCB9PGJy
Pg0KKyNkZWZpbmUgREVGSU5FX1BST1BfQklUKF9uYW1lLCBfc3RhdGUsIF9maWVsZCwgX2JpdCwg
X2RlZnZhbCnCoCDCoFw8YnI+DQorwqAgwqAgREVGSU5FX1BST1AoX25hbWUsIF9zdGF0ZSwgX2Zp
ZWxkLCBxZGV2X3Byb3BfYml0LCB1aW50MzJfdCwgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAuYml0bnLCoCDCoCDCoCDCoD0gKF9iaXQpLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLnNldF9kZWZhdWx0
ID0gdHJ1ZSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5kZWZ2YWwudcKgIMKgID0gKGJvb2wpX2RlZnZhbCk8
YnI+DQo8YnI+DQotI2RlZmluZSBERUZJTkVfUFJPUF9VTlNJR05FRChfbmFtZSwgX3N0YXRlLCBf
ZmllbGQsIF9kZWZ2YWwsIF9wcm9wLCBfdHlwZSkgeyBcPGJyPg0KLcKgIMKgIMKgIMKgIC5uYW1l
wqAgwqAgwqAgPSAoX25hbWUpLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoCAuaW5mb8KgIMKg
IMKgID0gJmFtcDsoX3Byb3ApLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgLm9mZnNldMKgIMKg
ID0gb2Zmc2V0b2YoX3N0YXRlLCBfZmllbGQpwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgICsgdHlwZV9jaGVjayhfdHlwZSwg
dHlwZW9mX2ZpZWxkKF9zdGF0ZSwgX2ZpZWxkKSkswqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDC
oCDCoCDCoCAuc2V0X2RlZmF1bHQgPSB0cnVlLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAg
LmRlZnZhbC51wqAgPSAoX3R5cGUpX2RlZnZhbCzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKgIH08YnI+DQorI2Rl
ZmluZSBERUZJTkVfUFJPUF9VTlNJR05FRChfbmFtZSwgX3N0YXRlLCBfZmllbGQsIF9kZWZ2YWws
IF9wcm9wLCBfdHlwZSkgXDxicj4NCivCoCDCoCBERUZJTkVfUFJPUChfbmFtZSwgX3N0YXRlLCBf
ZmllbGQsIF9wcm9wLCBfdHlwZSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLnNldF9kZWZhdWx0ID0gdHJ1ZSzCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLmRlZnZhbC51wqAgPSAoX3R5cGUpX2RlZnZhbCk8
YnI+DQo8YnI+DQotI2RlZmluZSBERUZJTkVfUFJPUF9VTlNJR05FRF9OT0RFRkFVTFQoX25hbWUs
IF9zdGF0ZSwgX2ZpZWxkLCBfcHJvcCwgX3R5cGUpIHsgXDxicj4NCi3CoCDCoCDCoCDCoCAubmFt
ZcKgIMKgIMKgID0gKF9uYW1lKSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAgwqAgLmluZm/CoCDC
oCDCoCA9ICZhbXA7KF9wcm9wKSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKgIC5vZmZzZXTCoCDC
oCA9IG9mZnNldG9mKF9zdGF0ZSwgX2ZpZWxkKcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCArIHR5cGVfY2hlY2soX3R5cGUs
IHR5cGVvZl9maWVsZChfc3RhdGUsIF9maWVsZCkpLMKgIMKgIMKgIMKgIMKgIFw8YnI+DQotwqAg
wqAgwqAgwqAgfTxicj4NCisjZGVmaW5lIERFRklORV9QUk9QX1VOU0lHTkVEX05PREVGQVVMVChf
bmFtZSwgX3N0YXRlLCBfZmllbGQsIF9wcm9wLCBfdHlwZSkgXDxicj4NCivCoCDCoCBERUZJTkVf
UFJPUChfbmFtZSwgX3N0YXRlLCBfZmllbGQsIF9wcm9wLCBfdHlwZSk8YnI+DQo8YnI+DQotI2Rl
ZmluZSBERUZJTkVfUFJPUF9CSVQ2NChfbmFtZSwgX3N0YXRlLCBfZmllbGQsIF9iaXQsIF9kZWZ2
YWwpIHvCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAgwqAgLm5hbWXCoCDCoCDCoCA9IChfbmFt
ZSkswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgIC5pbmZvwqAgwqAgwqAgPSAmYW1wOyhxZGV2
X3Byb3BfYml0NjQpLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgLmJpdG5ywqAgwqAgPSAoX2JpdCkswqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBc
PGJyPg0KLcKgIMKgIMKgIMKgIC5vZmZzZXTCoCDCoCA9IG9mZnNldG9mKF9zdGF0ZSwgX2ZpZWxk
KcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCArIHR5cGVfY2hlY2sodWludDY0X3QsIHR5cGVvZl9maWVsZChfc3RhdGUsIF9m
aWVsZCkpLMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoCAuc2V0X2RlZmF1bHQgPSB0cnVl
LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgLmRlZnZhbC51wqAgPSAoYm9vbClfZGVmdmFs
LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
XDxicj4NCi3CoCDCoCDCoCDCoCB9PGJyPg0KKyNkZWZpbmUgREVGSU5FX1BST1BfQklUNjQoX25h
bWUsIF9zdGF0ZSwgX2ZpZWxkLCBfYml0LCBfZGVmdmFsKcKgIMKgXDxicj4NCivCoCDCoCBERUZJ
TkVfUFJPUChfbmFtZSwgX3N0YXRlLCBfZmllbGQsIHFkZXZfcHJvcF9iaXQ2NCwgdWludDY0X3Qs
IFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLmJpdG5ywqAgwqAgPSAoX2JpdCkswqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIC5zZXRfZGVmYXVsdCA9IHRydWUswqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAuZGVmdmFsLnXCoCA9IChib29sKV9kZWZ2YWwpPGJyPg0KPGJyPg0KLSNkZWZpbmUgREVGSU5F
X1BST1BfQk9PTChfbmFtZSwgX3N0YXRlLCBfZmllbGQsIF9kZWZ2YWwpIHvCoCDCoCDCoCDCoFw8
YnI+DQotwqAgwqAgwqAgwqAgLm5hbWXCoCDCoCDCoCA9IChfbmFtZSkswqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDC
oCAuaW5mb8KgIMKgIMKgID0gJmFtcDsocWRldl9wcm9wX2Jvb2wpLMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgLm9mZnNldMKgIMKgID0g
b2Zmc2V0b2YoX3N0YXRlLCBfZmllbGQpwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCArIHR5cGVfY2hlY2soYm9vbCwgdHlwZW9mX2ZpZWxkKF9z
dGF0ZSwgX2ZpZWxkKSkswqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoCAuc2V0X2RlZmF1bHQgPSB0
cnVlLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXDxicj4NCi3CoCDCoCDCoCDCoCAuZGVmdmFsLnXCoCDCoCA9IChib29sKV9kZWZ2YWwswqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDC
oCB9PGJyPg0KKyNkZWZpbmUgREVGSU5FX1BST1BfQk9PTChfbmFtZSwgX3N0YXRlLCBfZmllbGQs
IF9kZWZ2YWwpwqAgwqAgwqBcPGJyPg0KK8KgIMKgIERFRklORV9QUk9QKF9uYW1lLCBfc3RhdGUs
IF9maWVsZCwgcWRldl9wcm9wX2Jvb2wsIGJvb2wsIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgLnNldF9kZWZhdWx0ID0gdHJ1ZSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLmRlZnZhbC51wqAgwqAgPSAo
Ym9vbClfZGVmdmFsKTxicj4NCjxicj4NCsKgI2RlZmluZSBQUk9QX0FSUkFZX0xFTl9QUkVGSVgg
JnF1b3Q7bGVuLSZxdW90Ozxicj4NCjxicj4NCkBAIC0xNTYsMjYgKzEyOSwxOSBAQCBleHRlcm4g
Y29uc3QgUHJvcGVydHlJbmZvIHFkZXZfcHJvcF9saW5rOzxicj4NCsKgICogSXQgaXMgdGhlIHJl
c3BvbnNpYmlsaXR5IG9mIHRoZSBkZXZpY2UgZGVpbml0IGNvZGUgdG8gZnJlZSB0aGU8YnI+DQrC
oCAqIEBfYXJyYXlmaWVsZCBtZW1vcnkuPGJyPg0KwqAgKi88YnI+DQotI2RlZmluZSBERUZJTkVf
UFJPUF9BUlJBWShfbmFtZSwgX3N0YXRlLCBfZmllbGQswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBfYXJyYXlmaWVsZCwgX2FycmF5cHJvcCwgX2FycmF5dHlwZSkge8KgIMKgIMKgIMKgIFw8YnI+
DQotwqAgwqAgwqAgwqAgLm5hbWUgPSAoUFJPUF9BUlJBWV9MRU5fUFJFRklYIF9uYW1lKSzCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKgIC5p
bmZvID0gJmFtcDsocWRldl9wcm9wX2FycmF5bGVuKSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKgIC5zZXRfZGVmYXVs
dCA9IHRydWUswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoCAuZGVmdmFsLnUgPSAwLMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgLm9mZnNldCA9IG9mZnNldG9mKF9zdGF0
ZSwgX2ZpZWxkKcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgKyB0eXBlX2NoZWNrKHVpbnQzMl90LCB0eXBlb2ZfZmll
bGQoX3N0YXRlLCBfZmllbGQpKSzCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAgwqAgLmFycmF5
aW5mbyA9ICZhbXA7KF9hcnJheXByb3ApLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoCAuYXJyYXlmaWVsZHNp
emUgPSBzaXplb2YoX2FycmF5dHlwZSkswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgIC5hcnJheW9mZnNldCA9IG9mZnNldG9mKF9zdGF0
ZSwgX2FycmF5ZmllbGQpLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDC
oCDCoCDCoCB9PGJyPg0KKyNkZWZpbmUgREVGSU5FX1BST1BfQVJSQVkoX25hbWUsIF9zdGF0ZSwg
X2ZpZWxkLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBfYXJyYXlmaWVsZCwgX2FycmF5cHJvcCwgX2FycmF5dHlwZSkg
XDxicj4NCivCoCDCoCBERUZJTkVfUFJPUCgoUFJPUF9BUlJBWV9MRU5fUFJFRklYIF9uYW1lKSzC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
X3N0YXRlLCBfZmllbGQsIHFkZXZfcHJvcF9hcnJheWxlbiwgdWludDMyX3QswqAgXDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAuc2V0X2RlZmF1bHQgPSB0cnVlLMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAuZGVmdmFsLnUgPSAwLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAuYXJyYXlpbmZvID0gJmFt
cDsoX2FycmF5cHJvcCkswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAuYXJyYXlmaWVsZHNpemUgPSBzaXplb2YoX2FycmF5dHlwZSks
wqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAuYXJyYXlvZmZz
ZXQgPSBvZmZzZXRvZihfc3RhdGUsIF9hcnJheWZpZWxkKSk8YnI+DQo8YnI+DQotI2RlZmluZSBE
RUZJTkVfUFJPUF9MSU5LKF9uYW1lLCBfc3RhdGUsIF9maWVsZCwgX3R5cGUsIF9wdHJfdHlwZSkg
e8KgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoCAubmFtZSA9IChfbmFtZSkswqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgXDxicj4NCi3CoCDCoCDCoCDCoCAuaW5mbyA9ICZhbXA7KHFkZXZfcHJvcF9saW5rKSzCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJy
Pg0KLcKgIMKgIMKgIMKgIC5vZmZzZXQgPSBvZmZzZXRvZihfc3RhdGUsIF9maWVsZCnCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgICsgdHlwZV9jaGVjayhfcHRyX3R5cGUsIHR5cGVvZl9maWVsZChfc3RhdGUsIF9maWVs
ZCkpLMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgLmxpbmtfdHlwZcKgID0gX3R5cGUswqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoCB9PGJyPg0KKyNkZWZpbmUgREVGSU5FX1BST1BfTElO
SyhfbmFtZSwgX3N0YXRlLCBfZmllbGQsIF90eXBlLCBfcHRyX3R5cGUpwqAgwqAgwqBcPGJyPg0K
K8KgIMKgIERFRklORV9QUk9QKF9uYW1lLCBfc3RhdGUsIF9maWVsZCwgcWRldl9wcm9wX2xpbmss
IF9wdHJfdHlwZSzCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLmxpbmtf
dHlwZcKgID0gX3R5cGUpPGJyPg0KPGJyPg0KwqAjZGVmaW5lIERFRklORV9QUk9QX1VJTlQ4KF9u
LCBfcywgX2YsIF9kKcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCsKg
IMKgIMKgREVGSU5FX1BST1BfVU5TSUdORUQoX24sIF9zLCBfZiwgX2QsIHFkZXZfcHJvcF91aW50
OCwgdWludDhfdCk8YnI+DQpAQCAtMTk3LDE5ICsxNjMsMTEgQEAgZXh0ZXJuIGNvbnN0IFByb3Bl
cnR5SW5mbyBxZGV2X3Byb3BfbGluazs8YnI+DQrCoCDCoCDCoERFRklORV9QUk9QX1NJR05FRChf
biwgX3MsIF9mLCBfZCwgcWRldl9wcm9wX29uX29mZl9hdXRvLCBPbk9mZkF1dG8pPGJyPg0KwqAj
ZGVmaW5lIERFRklORV9QUk9QX1NJWkUzMihfbiwgX3MsIF9mLCBfZCnCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQrCoCDCoCDCoERFRklORV9QUk9QX1VOU0lHTkVEKF9u
LCBfcywgX2YsIF9kLCBxZGV2X3Byb3Bfc2l6ZTMyLCB1aW50MzJfdCk8YnI+DQotI2RlZmluZSBE
RUZJTkVfUFJPUF9VVUlEKF9uYW1lLCBfc3RhdGUsIF9maWVsZCkge8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgLm5hbWXCoCDCoCDCoCA9IChfbmFtZSkswqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj4NCi3CoCDCoCDCoCDCoCAuaW5mb8KgIMKgIMKgID0gJmFtcDtxZGV2X3Byb3BfdXVpZCzCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKg
IMKgIC5vZmZzZXTCoCDCoCA9IG9mZnNldG9mKF9zdGF0ZSwgX2ZpZWxkKcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgKyB0eXBlX2NoZWNr
KFFlbXVVVUlELCB0eXBlb2ZfZmllbGQoX3N0YXRlLCBfZmllbGQpKSzCoCBcPGJyPg0KLcKgIMKg
IMKgIMKgIC5zZXRfZGVmYXVsdCA9IHRydWUswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgIH08YnI+DQot
I2RlZmluZSBERUZJTkVfUFJPUF9VVUlEX05PREVGQVVMVChfbmFtZSwgX3N0YXRlLCBfZmllbGQp
IHvCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKgIC5uYW1lwqAgwqAgwqAgPSAoX25hbWUp
LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+DQotwqAgwqAgwqAgwqAgLmluZm/CoCDCoCDCoCA9ICZhbXA7cWRldl9wcm9wX3V1aWQs
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDC
oCDCoCDCoCAub2Zmc2V0wqAgwqAgPSBvZmZzZXRvZihfc3RhdGUsIF9maWVsZCnCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgICsgdHlwZV9j
aGVjayhRZW11VVVJRCwgdHlwZW9mX2ZpZWxkKF9zdGF0ZSwgX2ZpZWxkKSkswqAgXDxicj4NCi3C
oCDCoCDCoCDCoCB9PGJyPg0KKyNkZWZpbmUgREVGSU5FX1BST1BfVVVJRChfbmFtZSwgX3N0YXRl
LCBfZmllbGQpwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCBE
RUZJTkVfUFJPUChfbmFtZSwgX3N0YXRlLCBfZmllbGQsIHFkZXZfcHJvcF91dWlkLCBRZW11VVVJ
RCzCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLnNldF9kZWZhdWx0ID0g
dHJ1ZSk8YnI+DQorI2RlZmluZSBERUZJTkVfUFJPUF9VVUlEX05PREVGQVVMVChfbmFtZSwgX3N0
YXRlLCBfZmllbGQpIFw8YnI+DQorwqAgwqAgREVGSU5FX1BST1AoX25hbWUsIF9zdGF0ZSwgX2Zp
ZWxkLCBxZGV2X3Byb3BfdXVpZCwgUWVtdVVVSUQpPGJyPg0KPGJyPg0KwqAjZGVmaW5lIERFRklO
RV9QUk9QX0VORF9PRl9MSVNUKCnCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQrCoCDCoCDC
oHt9PGJyPg0KLS0gPGJyPg0KMi4yOC4wPGJyPg0KPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPjwv
ZGl2PjxiciBjbGVhcj0iYWxsIj48YnI+LS0gPGJyPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFp
bF9zaWduYXR1cmUiPk1hcmMtQW5kcsOpIEx1cmVhdTxicj48L2Rpdj48L2Rpdj4NCg==
--000000000000d1e5b105b2e63c96--

