Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CADC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50AB1205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIYCzTDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AB1205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDwx1-0004qt-Fv
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDwwB-0004ML-8c
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDwwA-00088v-2c
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:06:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDww9-00084u-Uq
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584392773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHlTEizcnE9IkJ9bbnijF+nrMqDQa3fqSVdtO2OU7tc=;
 b=aIYCzTDie+6TOUn3ciJHQyhIEXeLkEVBLJNDsZzDIYaEQ/EOT0RjkgSGLpb44l+nebiM1+
 RQrd9wiA9hQRAH9fz4zXCXJlW8nH2uUhRVpRGTIbokbPU4OwnpWmvsJw0LLU84ttl9xv9Z
 1kVRELt1b4K4hKQ8bL2R86KPtbP2Ri8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-rqPsgrF4N_KgQTUBq8BnLg-1; Mon, 16 Mar 2020 17:06:09 -0400
X-MC-Unique: rqPsgrF4N_KgQTUBq8BnLg-1
Received: by mail-wm1-f69.google.com with SMTP id f9so3542472wme.7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 14:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BHhSp/olAeHu8RyDYl0CqwzIJcTAlMVsxZUqpaBDCeA=;
 b=g4mf2JSqlord7eignDp2h8DBANkvbmWus7lut0xbSChGjawv+FDRHk1bwtlP0Hm9R0
 g719IL2YkWuFYYdHboorPT3+RZZn7meAPjOzDKyTXGfkDZPZDaa8KjObaCnvd152vCtb
 hUkIe3PAxinR3MEY12JVXEWORwO3iYzG0jAVDCna4c4ODasMZl+hOaMGtDRAc5ktk+VS
 Ej36MzJ/Rr/0ok4Xjzvur9b4hLiqDKXn7dA30r6AIh8aezcTpgjpH8ykcojBcZnvYFs4
 AqyiJVLziYztG6RtMmTZRneeS7t89+sioDuh7UUqDazGyIThK7Cw5b0XfAO8cMv4kSCW
 JG5g==
X-Gm-Message-State: ANhLgQ0XyAUu7x6FhrUI33iRft/1Ga5UrqBJH8G7hLae1VesPA/ufaWW
 sLVAINQ4Cw8Y9yMD5IYrmCgmxdRRH2ktV9fCq5So7+xmpZPT+rXGP3gpdkoo9tn4PIdBJENNxKC
 rvfUbZDrEC4vlOds=
X-Received: by 2002:a1c:cc03:: with SMTP id h3mr1035944wmb.20.1584392767963;
 Mon, 16 Mar 2020 14:06:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuScut9+SN0K0zy4cqscaY3eaQZI/53AH/8zke1Z0THydVJLFCP/KSdKkP5I77dq7Z7j17wYg==
X-Received: by 2002:a1c:cc03:: with SMTP id h3mr1035919wmb.20.1584392767617;
 Mon, 16 Mar 2020 14:06:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac?
 ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
 by smtp.gmail.com with ESMTPSA id f12sm1105241wmh.4.2020.03.16.14.06.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 14:06:07 -0700 (PDT)
Subject: Re: [PATCH] scsi/qemu-pr-helper: Fix out-of-bounds access to
 trnptid_list[]
To: Christophe de Dinechin <dinechin@redhat.com>, qemu-devel@nongnu.org
References: <20200228150059.2644362-1-dinechin@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <af3ed677-90ca-4499-5c23-b869d38ae75a@redhat.com>
Date: Mon, 16 Mar 2020 22:06:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228150059.2644362-1-dinechin@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/02/20 16:00, Christophe de Dinechin wrote:
> Compile error reported by gcc 10.0.1:
>=20
> scsi/qemu-pr-helper.c: In function =E2=80=98multipath_pr_out=E2=80=99:
> scsi/qemu-pr-helper.c:523:32: error: array subscript <unknown> is outside=
 array bounds of =E2=80=98struct transportid *[0]=E2=80=99 [-Werror=3Darray=
-bounds]
>   523 |             paramp.trnptid_list[paramp.num_transportid++] =3D id;
>       |             ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from scsi/qemu-pr-helper.c:36:
> /usr/include/mpath_persist.h:168:22: note: while referencing =E2=80=98trn=
ptid_list=E2=80=99
>   168 |  struct transportid *trnptid_list[];
>       |                      ^~~~~~~~~~~~
> scsi/qemu-pr-helper.c:424:35: note: defined here =E2=80=98paramp=E2=80=99
>   424 |     struct prout_param_descriptor paramp;
>       |                                   ^~~~~~
>=20
> This highlights an actual implementation issue in function multipath_pr_o=
ut.
> The variable paramp is declared with type `struct prout_param_descriptor`=
,
> which is a struct terminated by an empty array in mpath_persist.h:
>=20
>         struct transportid *trnptid_list[];
>=20
> That empty array was filled with code that looked like that:
>=20
>         trnptid_list[paramp.descr.num_transportid++] =3D id;
>=20
> This is an actual out-of-bounds access.

The fix unfortunately causes a compilation warning-turned-error because=20
of a flexible array member in the middle of a struct.  The simplest fix=20
is just to malloc the struct:

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 0101322..65a8261 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -421,15 +421,13 @@ static int multipath_pr_out(int fd, const uint8_t *cd=
b, uint8_t *sense,
     int rq_servact =3D cdb[1];
     int rq_scope =3D cdb[2] >> 4;
     int rq_type =3D cdb[2] & 0xf;
-    struct
-    {
-        struct prout_param_descriptor descr;
-        struct transportid *trnptid_list_storage[MPATH_MX_TIDS];
-    } paramp;
-    struct transportid **trnptid_list =3D paramp.descr.trnptid_list;
+    g_autofree struct prout_param_descriptor *paramp =3D NULL;
     char transportids[PR_HELPER_DATA_SIZE];
     int r;
=20
+    paramp =3D g_malloc0(sizeof(struct prout_param_descriptor)
+=09=09       + sizeof(struct transportid *) * MPATH_MX_TIDS);
+
     if (sz < PR_OUT_FIXED_PARAM_SIZE) {
         /* Illegal request, Parameter list length error.  This isn't fatal=
;
          * we have read the data, send an error without closing the socket=
.
@@ -459,10 +457,9 @@ static int multipath_pr_out(int fd, const uint8_t *cdb=
, uint8_t *sense,
      * used by libmpathpersist (which, of course, will immediately
      * do the opposite).
      */
-    memset(&paramp, 0, sizeof(paramp));
-    memcpy(&paramp.descr.key, &param[0], 8);
-    memcpy(&paramp.descr.sa_key, &param[8], 8);
-    paramp.descr.sa_flags =3D param[20];
+    memcpy(&paramp->key, &param[0], 8);
+    memcpy(&paramp->sa_key, &param[8], 8);
+    paramp->sa_flags =3D param[20];
     if (sz > PR_OUT_FIXED_PARAM_SIZE) {
         size_t transportid_len;
         int i, j;
@@ -525,13 +522,13 @@ static int multipath_pr_out(int fd, const uint8_t *cd=
b, uint8_t *sense,
                 return CHECK_CONDITION;
             }
=20
-            assert(paramp.descr.num_transportid < MPATH_MX_TIDS);
-            trnptid_list[paramp.descr.num_transportid++] =3D id;
+            assert(paramp->num_transportid < MPATH_MX_TIDS);
+            paramp->trnptid_list[paramp->num_transportid++] =3D id;
         }
     }
=20
     r =3D mpath_persistent_reserve_out(fd, rq_servact, rq_scope, rq_type,
-                                     &paramp.descr, noisy, verbose);
+                                     paramp, noisy, verbose);
     return mpath_reconstruct_sense(fd, r, sense);
 }
 #endif


