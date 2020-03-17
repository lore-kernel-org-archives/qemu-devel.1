Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46085C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF62206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZKrVGPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF62206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8bv-0004iw-7y
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jE8aw-00049l-PU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jE8av-0008Rb-QL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:33:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jE8av-0008NW-Jo
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:33:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id r7so15195672wmg.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sXAUQaew6U/yeeHyfSwsvuPaFAuDs6QQqqmnz8Zr5II=;
 b=XZKrVGPUukeIHVqV/AGuMU+uaBUW+5kYlICva5UguP9LRPyv7wiRqPBlXa4PigZjyS
 QFZiNU/ZAesz/PCiYMQQ+XM9fNmV8kG6zrtz4mJwagXopv5WmbXTFqrfmKzO6PGgQxNA
 JmWryjuZS9BJDDpHe27lB59PbYBNTET/LBE3fRiVFkBZkee8BxOo1UWBUFlUvGS9f18h
 HgD5zbahZM5aSMsWGQu0J9Zi2+V1Zf8kmeRP25nNoVn6fQpxjFY24nzRgQavxZqHkvAU
 HCx+a34CYbPlkOmTuAru+2EABDn0if5QGxjvsuNQ3r3I8kCxCg5MxzMJ4HpFQ4mSa/G9
 hmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sXAUQaew6U/yeeHyfSwsvuPaFAuDs6QQqqmnz8Zr5II=;
 b=ZkmaY58IzP/QSWExgLsE3ik36tSjQwoed17x4l/jed2L7q11y7QG/XKqxjoABvTwTA
 cE+9JSFrf91rTyZbjdFIq+vSPsHc0G3MI0e3yRmqtaBFL4BoyKwd16N7TG9HBWOBnVQi
 rt0GkQaoTre23F/x6HmQVxjZrdLIwWnwEqZ9UCkRN0cF1Hkh+Rw0yUj3XZUEuDsL4xMn
 U4kmqJm/nfV/UBsa1zPMIcD63Ku2GmnMkjhNDIBscfX0TNHVCc5quCmgWPIhKLnvIcRt
 vrLTruLBJBwIzA6Wd4NBifou/CRTV86/8wziSu2rYKNu4KmRyop5uwtqoJBbYuuVltNH
 YuGA==
X-Gm-Message-State: ANhLgQ0NPFm4flLs/MlbWIsv1c0Oc48rEokBHUSF9JW+mETg40cOHklc
 PPPAnzPthJ65aNs03igm2KByMpceSCuRs/YmUFBqYwRQM0U=
X-Google-Smtp-Source: ADFU+vs/KAe+DGqfeMmO02rJpTle/XvOI5rk1WdkU+Ne7zoiDh64WtC26h640mngR6Z2DauhHHvDSyDOlariBX43yc8=
X-Received: by 2002:a1c:1fc9:: with SMTP id f192mr4513274wmf.4.1584437584529; 
 Tue, 17 Mar 2020 02:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200317092241.31660-1-armbru@redhat.com>
In-Reply-To: <20200317092241.31660-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Mar 2020 10:32:52 +0100
Message-ID: <CAJ+F1C+kkY-vqY2vQ2iWNW0_N0hcWszQuuas5UxdCcjP5sQA=A@mail.gmail.com>
Subject: Re: [PATCH] qom-qmp-cmds: Fix another memory leak in qmp_object_add()
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 10:23 AM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> When user_creatable_add_type() fails, qmp_object_add() returns both
> its error and the usual empty QDict success value.  The QMP core
> handles the error, and ignores the success value, leaking it.  Exposed
> by qmp-cmd-test case /x86_64/qmp/object-add-without-props, and duly
> reported both by ASan and valgrind.
>
> To plug the leak, set the success value only on success.
>
> Fixes: 5f07c4d60d091320186e7b0edaf9ed2cc16b2d1e
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qom/qom-qmp-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 435193b036..6bd137ccbf 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -287,8 +287,8 @@ void qmp_object_add(QDict *qdict, QObject **ret_data,=
 Error **errp)
>      visit_free(v);
>      if (obj) {
>          object_unref(obj);
> +        *ret_data =3D QOBJECT(qdict_new());
>      }
> -    *ret_data =3D QOBJECT(qdict_new());
>  }
>
>  void qmp_object_del(const char *id, Error **errp)
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

