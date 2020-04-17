Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643F7C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226562087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDxjaTbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226562087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPQvu-0001sD-9O
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 09:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jPQvB-0001Cx-Hh
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jPQv9-0007qh-Q6
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:20:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24805
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jPQv9-0007qI-Kl
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587129638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2nEir+o8iyy9EHwpgUh7G3CFZXYAStAdKNN5t/5k5Os=;
 b=dDxjaTbRyAxoLhgNA+WwYIa0dz1AiFmamhdtbs+HQSm4jzH8co6Ltk81HJ3rMtOn+8vMpd
 Evo0bokkENnnK3ckU4C7F7OnzgjYTCRjx5yZhRa4yNAF2F2on/eq1kwM8bQhYwB64NrQdq
 PJb/uh7co/XKkUCtlLbODpoUz+daWFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-DVX8VpBdPZaNsuCu3tLRZA-1; Fri, 17 Apr 2020 09:20:24 -0400
X-MC-Unique: DVX8VpBdPZaNsuCu3tLRZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 819DA149C0;
 Fri, 17 Apr 2020 13:20:23 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6F1C118F4A;
 Fri, 17 Apr 2020 13:20:22 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Expose bitmaps' size during measure
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <158707735381.15335.6543965736162160984@39012742ff91>
 <a995b3cc-e17a-58ef-f778-9edeb21b4623@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d2ba25e8-3586-b966-3715-1cb6757029d8@redhat.com>
Date: Fri, 17 Apr 2020 08:20:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a995b3cc-e17a-58ef-f778-9edeb21b4623@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com, nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/16/20 7:17 PM, Eric Blake wrote:

>> The full log is available at
>> http://patchew.org/logs/20200416212349.731404-1-eblake@redhat.com/testin=
g.docker-quick@centos7/?type=3Dmessage.=20
>>
>=20
> I see:
>=20
> --- /tmp/qemu-test/src/tests/qemu-iotests/190.out=C2=A0=C2=A0=C2=A0 2020-=
04-16=20
> 21:15:51.000000000 +0000
> +++ /tmp/qemu-test/build/tests/qemu-iotests/190.out.bad=C2=A0=C2=A0=C2=A0=
 2020-04-16=20
> 22:45:47.504493172 +0000
> @@ -4,6 +4,7 @@
>  =C2=A0Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2199023255552
>  =C2=A0required size: 2199023255552
>  =C2=A0fully allocated size: 2199023255552
> +bitmaps size: 4846791580151137091
>  =C2=A0required size: 335806464
>=20
> which looks suspiciously like an uninitialized variable leaking through=
=20
> when there are no bitmaps to be measured.=C2=A0 I'll fix it in v2.

Here's what I'm squashing in:

diff --git i/block/crypto.c w/block/crypto.c
index d577f89659fa..4e0f3ec97f0e 100644
--- i/block/crypto.c
+++ w/block/crypto.c
@@ -535,7 +535,7 @@ static BlockMeasureInfo=20
*block_crypto_measure(QemuOpts *opts,
       * Unallocated blocks are still encrypted so allocation status=20
makes no
       * difference to the file size.
       */
-    info =3D g_new(BlockMeasureInfo, 1);
+    info =3D g_new0(BlockMeasureInfo, 1);
      info->fully_allocated =3D luks_payload_size + size;
      info->required =3D luks_payload_size + size;
      return info;
diff --git i/block/qcow2.c w/block/qcow2.c
index eba6c2511e60..8d7a9e87fba0 100644
--- i/block/qcow2.c
+++ w/block/qcow2.c
@@ -4808,7 +4808,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts=20
*opts, BlockDriverState *in_bs,
          required =3D virtual_size;
      }

-    info =3D g_new(BlockMeasureInfo, 1);
+    info =3D g_new0(BlockMeasureInfo, 1);
      info->fully_allocated =3D
          qcow2_calc_prealloc_size(virtual_size, cluster_size,
                                   ctz32(refcount_bits)) +=20
luks_payload_size;
diff --git i/block/raw-format.c w/block/raw-format.c
index 93b25e1b6b0b..4bb54f4ac6c5 100644
--- i/block/raw-format.c
+++ w/block/raw-format.c
@@ -346,7 +346,7 @@ static BlockMeasureInfo *raw_measure(QemuOpts *opts,=20
BlockDriverState *in_bs,
                              BDRV_SECTOR_SIZE);
      }

-    info =3D g_new(BlockMeasureInfo, 1);
+    info =3D g_new0(BlockMeasureInfo, 1);
      info->required =3D required;

      /* Unallocated sectors count towards the file size in raw images */


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


