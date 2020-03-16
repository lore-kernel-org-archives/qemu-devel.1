Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C64C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917F820409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZXroUZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917F820409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtO4-0002h3-CZ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDrQm-0000gk-Bd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDrQl-0006Ie-3X
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:13:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:47025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDrQk-0006An-RS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:13:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id w16so5277771wrv.13
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fYy21/Wq5VHJf5KD8Acsfl39ZYRkQMYTxTQsV0GxSJc=;
 b=dZXroUZvRSQFjPNBFpwRCjsDlEO1KvGU5ttck/bV38/TGKc1UgHWU1wgB60UUMMhlW
 BddIWFin8p8RMEDfmVWMe44eHV3LRIDCfTiDL7bLQuNh/g71LZWg6N37wq5HYLAkhxp6
 CqNxSJPqkplcz5gVuNp+KrTjarwqWv+S9U6tho4HxkzaNwCgaME/vYd7IzxHQSF1KVgw
 NxUSZ0aOjG1Xu9EAcnpMgQZUEj62NMwFe8FC8O+4TwS+1fiJNEepRzJdFvN3pEYuJpsN
 EzbU6r3UNdLVmXt0T7kwAxCVjqRV3fcPtxD7FIni2iA+ToupWPETWRuf3xJGEWoY1e08
 jXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fYy21/Wq5VHJf5KD8Acsfl39ZYRkQMYTxTQsV0GxSJc=;
 b=ob85X2xo/v6BNxNKuLYZ0oSVPlZV9MceLzovlMHZp48pndWYTPMObixRxWsdNYqmqM
 FmkHg60aVkyZlmc7qgwIAh+LCFRz7tItIhHpWVrF8lt3kYdKcdlLZcQtXd46u2s+SZoy
 ZgtN1wXbNto6fMKzUuFT6VAI8oGZVkYyhEEy/E2kErSSfZoIRBY6cYxvPxB9HcYkhuTp
 AaZHYzc+d3Py9i3tXOezEU1YUhpAq2dTR8dq3TjiVJacX1HXXTYVJaVEv01YRE1vnmim
 4p+hrqhnn5BbFczoXhA0DhQMPdxmlZeXEhVVMZlRqVlaHkv7t37XygZ9q7o/dARPtM/a
 +tyQ==
X-Gm-Message-State: ANhLgQ1zcR9vn7A01Qpad0a6F2f4tbzgPI5xYLvOuAy/Nm8qulIyVkgd
 Nll/BOBHtJwsgJvZZ8PvSFSSu63WPk6jObr5k3s=
X-Google-Smtp-Source: ADFU+vvJVPFGl37McKSmpL4NgSwg+0PlnP+RBgRQ2QNv1iCb7FeMMTfssyZFqPC3Y3a9uE83cUyvAoMTanQD5wLFT9M=
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr32326004wrs.96.1584371605896; 
 Mon, 16 Mar 2020 08:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-10-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-10-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 16:13:13 +0100
Message-ID: <CAJ+F1C+xxUmrjUaDfqD-4j+0BF=DfAomuqtu7jZqfg-p64j_Gg@mail.gmail.com>
Subject: Re: [PATCH v3 09/34] tests/test-qmp-event: Use qobject_is_equal()
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 15, 2020 at 3:48 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Locally defined helper qdict_cmp_simple() implements just enough of a
> comparison to serve here.  Replace it by qobject_is_equal(), which
> implements all of it.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/test-qmp-event.c | 66 +-----------------------------------------
>  1 file changed, 1 insertion(+), 65 deletions(-)
>
> diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
> index 430001e622..d64066139c 100644
> --- a/tests/test-qmp-event.c
> +++ b/tests/test-qmp-event.c
> @@ -28,73 +28,9 @@ typedef struct TestEventData {
>      QDict *expect;
>  } TestEventData;
>
> -typedef struct QDictCmpData {
> -    QDict *expect;
> -    bool result;
> -} QDictCmpData;
> -
>  TestEventData *test_event_data;
>  static GMutex test_event_lock;
>
> -/* Only compares bool, int, string */
> -static
> -void qdict_cmp_do_simple(const char *key, QObject *obj1, void *opaque)
> -
> -{
> -    QObject *obj2;
> -    QDictCmpData d_new, *d =3D opaque;
> -    int64_t val1, val2;
> -
> -    if (!d->result) {
> -        return;
> -    }
> -
> -    obj2 =3D qdict_get(d->expect, key);
> -    if (!obj2) {
> -        d->result =3D false;
> -        return;
> -    }
> -
> -    if (qobject_type(obj1) !=3D qobject_type(obj2)) {
> -        d->result =3D false;
> -        return;
> -    }
> -
> -    switch (qobject_type(obj1)) {
> -    case QTYPE_QBOOL:
> -        d->result =3D (qbool_get_bool(qobject_to(QBool, obj1)) =3D=3D
> -                     qbool_get_bool(qobject_to(QBool, obj2)));
> -        return;
> -    case QTYPE_QNUM:
> -        g_assert(qnum_get_try_int(qobject_to(QNum, obj1), &val1));
> -        g_assert(qnum_get_try_int(qobject_to(QNum, obj2), &val2));
> -        d->result =3D val1 =3D=3D val2;
> -        return;
> -    case QTYPE_QSTRING:
> -        d->result =3D g_strcmp0(qstring_get_str(qobject_to(QString, obj1=
)),
> -                              qstring_get_str(qobject_to(QString, obj2))=
) =3D=3D 0;
> -        return;
> -    case QTYPE_QDICT:
> -        d_new.expect =3D qobject_to(QDict, obj2);
> -        d_new.result =3D true;
> -        qdict_iter(qobject_to(QDict, obj1), qdict_cmp_do_simple, &d_new)=
;
> -        d->result =3D d_new.result;
> -        return;
> -    default:
> -        abort();
> -    }
> -}
> -
> -static bool qdict_cmp_simple(QDict *a, QDict *b)
> -{
> -    QDictCmpData d;
> -
> -    d.expect =3D b;
> -    d.result =3D true;
> -    qdict_iter(a, qdict_cmp_do_simple, &d);
> -    return d.result;
> -}
> -
>  void test_qapi_event_emit(test_QAPIEvent event, QDict *d)
>  {
>      QDict *t;
> @@ -115,7 +51,7 @@ void test_qapi_event_emit(test_QAPIEvent event, QDict =
*d)
>
>      qdict_del(d, "timestamp");
>
> -    g_assert(qdict_cmp_simple(d, test_event_data->expect));
> +    g_assert(qobject_is_equal(QOBJECT(d), QOBJECT(test_event_data->expec=
t)));
>
>  }
>
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

