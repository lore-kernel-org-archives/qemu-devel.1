Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81565C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4402075F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulshVSaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4402075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNy6i-0004Xd-Hl
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 08:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNy5j-000457-0r
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 08:53:47 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNy5f-0003uG-W5
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 08:53:46 -0400
Received: by mail-wm1-x341.google.com with SMTP id t17so2942222wmi.4
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 05:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=wX8YJOOhJPz+HBM5iE0NEmzbkebOnmFyheSL/0UVZLc=;
 b=ulshVSaDLfM5KCZUgIGCOcoRouzLMRUtWqFe8HXsS4srI2P0iEiwaGc750u+cj4pbA
 IzwcVi8b4QZQTIIqtEaamQNy0+KbG4lzLOvjI3KBBWCY5MwF+L8IM2AyszNlVZF8I/I4
 MO6ehZUAIauGXR6sFdC1dss3NvPRvzA9GonJtl6XvTHEsImqhbaliKcXgXH9GVq+hnaM
 cjeNtNM5VItQ5rhWtFkUyL1Z0dsAvEP/Nr28AORM04VUr+V2O1cdzycB3hy3ja32k1WZ
 ujazuTbZg/V+4l9ZQlbwEzJdLux1YaKtkXYnLR1fTT5CA6fsf4YSAG3icIECX3S00eyv
 Sjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=wX8YJOOhJPz+HBM5iE0NEmzbkebOnmFyheSL/0UVZLc=;
 b=nPQRgRzWQE4z3Uf+rrz2TWPmikh9XOIZnBMrbM1DGDVxXJltMbEeniD+aRgzsgyQE7
 OxE14cswkpAcOQ8BciZRZiMw0up+dLmcQOLgsOSBp9Y0BY79QW2+i5b8Z7bAT4HeoI/d
 dw0tCbrtcNqcH7VajcQ/HsFwqmJaNjKLZMvWLRVPD73xMrhtqQ//3YrUynFBX2yDr9Yy
 P51kBD6u2x0ISLNq18V7LgxdGChpZW+WEh0KPr9MAVBSzVY2437/I+BHx6UUVdWhb7i6
 EAcpPZFk/opZlqO9CvOH58DolIbePQtESvISN6XkMX7F84mlDLv3tYAZwlfTyfMZo6P6
 imSQ==
X-Gm-Message-State: AOAM532pX1YxNUx2wyNOD8FPSKzpSH0yl+lF76jIL6w9F5zBwJdaPN5l
 fZp2Gxadcmih2/ZhOgwFJHNyNA==
X-Google-Smtp-Source: ABdhPJz9UWesfgpN14EzXfWjEKQI/cql39gYHPG/38ANucYFam1aPrb/vOr8msSPyuf+4ggawwKYUQ==
X-Received: by 2002:a7b:c090:: with SMTP id r16mr8508691wmh.56.1601556822022; 
 Thu, 01 Oct 2020 05:53:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h16sm9366125wre.87.2020.10.01.05.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 05:53:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B57121FF7E;
 Thu,  1 Oct 2020 13:53:39 +0100 (BST)
References: <160137726426.31007.12061315974029139983.stgit@pasha-ThinkPad-X280>
 <160137728185.31007.9248844824207037822.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v6 03/14] qcow2: introduce icount field for snapshots
In-reply-to: <160137728185.31007.9248844824207037822.stgit@pasha-ThinkPad-X280>
Date: Thu, 01 Oct 2020 13:53:39 +0100
Message-ID: <87d022nm3w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:

> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> This patch introduces the icount field for saving within the snapshot.
> It is required for navigation between the snapshots in record/replay mode.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Acked-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2-snapshot.c |    7 +++++++
>  block/qcow2.h          |    3 +++
>  docs/interop/qcow2.txt |    5 +++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
> index 9b68690f56..d68b25e0c5 100644
> --- a/block/qcow2-snapshot.c
> +++ b/block/qcow2-snapshot.c
> @@ -164,6 +164,12 @@ static int qcow2_do_read_snapshots(BlockDriverState =
*bs, bool repair,
>              sn->disk_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
>          }
>=20=20
> +        if (sn->extra_data_size >=3D endof(QCowSnapshotExtraData, icount=
)) {
> +            sn->icount =3D be64_to_cpu(extra.icount);
> +        } else {
> +            sn->icount =3D -1ULL;
> +        }
> +
>          if (sn->extra_data_size > sizeof(extra)) {
>              uint64_t extra_data_end;
>              size_t unknown_extra_data_size;
> @@ -333,6 +339,7 @@ int qcow2_write_snapshots(BlockDriverState *bs)
>          memset(&extra, 0, sizeof(extra));
>          extra.vm_state_size_large =3D cpu_to_be64(sn->vm_state_size);
>          extra.disk_size =3D cpu_to_be64(sn->disk_size);
> +        extra.icount =3D cpu_to_be64(sn->icount);
>=20=20
>          id_str_size =3D strlen(sn->id_str);
>          name_size =3D strlen(sn->name);
> diff --git a/block/qcow2.h b/block/qcow2.h
> index b71e444fca..125ea9679b 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -206,6 +206,7 @@ typedef struct QEMU_PACKED QCowSnapshotHeader {
>  typedef struct QEMU_PACKED QCowSnapshotExtraData {
>      uint64_t vm_state_size_large;
>      uint64_t disk_size;
> +    uint64_t icount;
>  } QCowSnapshotExtraData;
>=20=20
>=20=20
> @@ -219,6 +220,8 @@ typedef struct QCowSnapshot {
>      uint32_t date_sec;
>      uint32_t date_nsec;
>      uint64_t vm_clock_nsec;
> +    /* icount value for the moment when snapshot was taken */
> +    uint64_t icount;
>      /* Size of all extra data, including QCowSnapshotExtraData if availa=
ble */
>      uint32_t extra_data_size;
>      /* Data beyond QCowSnapshotExtraData, if any */
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 7da0d81df8..0463f761ef 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -707,6 +707,11 @@ Snapshot table entry:
>=20=20
>                      Byte 48 - 55:   Virtual disk size of the snapshot in=
 bytes
>=20=20
> +                    Byte 56 - 63:   icount value which corresponds to
> +                                    the record/replay instruction count
> +                                    when the snapshot was taken. Set to =
-1
> +                                    if icount was disabled
> +
>                      Version 3 images must include extra data at least up=
 to
>                      byte 55.
>=20=20

Hmm is this why I'm seeing some of the iotests fail on the CI:

261      fail       [11:34:17] [11:34:44]                    output mismatc=
h (see 261.out.bad)
--- /builds/stsquad/qemu/tests/qemu-iotests/261.out	2020-10-01 11:16:22.000=
000000 +0000
+++ /builds/stsquad/qemu/build/tests/qemu-iotests/261.out.bad	2020-10-01 11=
:34:44.000000000 +0000
@@ -29,9 +29,10 @@
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Unknown extra data: =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD
   [1]
     ID: 2
     Name: sn1
@@ -42,9 +43,10 @@
   [2]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Unknown extra data: =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD
=20
 =3D=3D=3D Repair botched v3 =3D=3D=3D
=20
@@ -61,9 +63,10 @@
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Unknown extra data: =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD
   [1]
     ID: 2
     Name: sn1
@@ -74,9 +77,10 @@
   [2]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Unknown extra data: =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD
=20
 =3D=3D=3D Add new snapshot =3D=3D=3D
=20
@@ -85,9 +89,10 @@
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Unknown extra data: =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD
   [1]
     ID: 2
     Name: sn1
@@ -98,15 +103,17 @@
   [2]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Unknown extra data: =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD
   [3]
     ID: 4
     Name: sn3
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Unknown extra data:=20
=20
 =3D=3D=3D Remove different snapshots =3D=3D=3D
=20
@@ -123,9 +130,10 @@
   [1]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Unknown extra data: =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD
=20
 --- sn1 ---
 No errors were found on the image.
@@ -133,15 +141,17 @@
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Unknown extra data: =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD
   [1]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Unknown extra data: =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD
=20
 --- sn2 ---
 No errors were found on the image.
@@ -149,9 +159,10 @@
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Unknown extra data: =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD
   [1]
     ID: 2
     Name: sn1
@@ -210,7 +221,7 @@
 No errors were found on the image.
=20
 507 snapshots should remain:
-  qemu-img info reports 507 snapshots
+  qemu-img info reports 0 snapshots
   Image header reports 507 snapshots
=20
 =3D=3D=3D Snapshot table too big with one entry with too much extra data =
=3D=3D=3D
@@ -341,6 +352,6 @@
 No errors were found on the image.
=20
 65536 snapshots should remain:
-  qemu-img info reports 65536 snapshots
+  qemu-img info reports 0 snapshots
   Image header reports 65536 snapshots
 *** done


--=20
Alex Benn=C3=A9e

