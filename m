Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E96CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBA020650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ECteYd6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBA020650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNf7x-00017m-Qp
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iNe46-0008AA-TK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iNe45-0002eS-FD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:26:14 -0400
Received: from mout.web.de ([212.227.17.11]:43101)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>)
 id 1iNe40-0002RH-07; Thu, 24 Oct 2019 10:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571927139;
 bh=9FbTgtuzcaCTjHUA8BY5mKaFybBmxQpiWe1iZMpLbP8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ECteYd6W7+tp3RAxMUKZ2oADi66QCSQVMtP+Pw595ghY+Rz/s1Idpn3PXaxkT5iO5
 Ict4U5HrjWYjyMXkoOFSbRWjUKURK3hDInCIkz3AEcIr6VWeo1ezyPwvHtKSPkA0+d
 NT7hWX1IqqiSDVhnobU1upEvRUbVNu2+00JFOa6c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.150]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LbrZ2-1hgZWx132a-00jMnl; Thu, 24
 Oct 2019 16:25:39 +0200
Date: Thu, 24 Oct 2019 16:25:35 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 1/4] block/replication.c: Ignore requests after failover
Message-ID: <039d59f89205824273eef070cdfa7d5e94f95697.1571925699.git.lukasstraub2@web.de>
In-Reply-To: <cover.1571925699.git.lukasstraub2@web.de>
References: <cover.1571925699.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N+uedjqvs76OPbOtDsp0z41+9k3NWKoNkTJgPFrKREuJ21iR//o
 ewMsA3MGKGDnBKEt3mZbmHUiuvusrrzdw6Y0n2g5zVy+pmlKmMrkzg2jG0d4Wfm23cU2QSG
 1PcSZwCQ7XchdE9BZ4ki0HxdQNfRMFwHkCFYqs+yWvPBLMcBAdiYmYU2QRcb5FTzNYyexC6
 XyG5WFbow66C0VRrgpFWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6iDpevWf7ak=:en4MnMBtuJfdrRM62TmJ0B
 o9lFzlR8nJUrQgAsMGv13tz6cfXNsp1tLlAy+MAOQj3IxjES9VExNgi/pbgwPxMZhgzC3tzFc
 UKC9aLLupGenudyQ8DkKglJB2tKIcb/8vlKiOEhsa6/0Vi8VKCDK+9Sy5/u0pzNzcqx9Ia3yi
 kJNhs1DabApFvxmGE/E7TfyvleRTLduQ6oMuYLxfAwdob6jbk9ys46ocp0n5+kN4yZq38eicu
 gJIFHKR4rhifIooNlHfCnpHevwB6tL3LNE4d4PO4icU5/kIHXKe4uzOuGnuGcag079W+VEgDu
 y98CiFnbUYiRa1p0Mfo4A6nQzjhX1FCUIxUIAVMj9xid3b/PsQzRfnCyJqrEqvjG1zNkGcQW+
 IC1lKzpxZgmMleZEXDBYjZzsYCdcIAWFqB+4WuE3lCjYXFn7ZEk+VFsQmY1qMeaZQyw32lqUT
 wrJO2HKe+h6p/qW6DfAvgi4QrJgfghHxgCegcVqPWEJN2V2MU2AuHj9PCYXCUUOXNoT7k3UTc
 cpowuvCYtQHdPELz+SfZ3hxl7dCL030S+gWoJcWGtSBDQkYPwGsEWt95G+r06N5mNxdjx0AKv
 atRy4Ouqb9CakS+qSxcwFM84OnqI7Dikjo/te+1Iorv/t2nK7Tco0MTOYD5W7HtodyixHcgwu
 U1sn4ivjcre5EE/kJazkzeIzHpIRAaHAu1m/4nRj+7m2TsjZOA+sqatlHTlgh9G2rFsaOMhCV
 uB1F04GIjJo2PEBfXPKH8d7lTzIxBPBJd6DmJvq4rrLvLbArCxILiL6c+RVVd+lER6bjDtlqK
 hptyIBYmYmvfzKiz38E6qv/TvUWWtVMImfAmgcieHq3HAJXfxwDZo6+aOV65+yWmkbvTvFQRE
 NHgYylI5bTAVP4cAuy3Ur9lzNc8GlIxxsE+A9yAL47o5vSjaZ3pfIHNNeCe7F5S2ygZtjKsui
 BgaFLwnnkNfIg6IFjwMNIHDBQxgOZhYkI3iMBg12qY7bficlQDcfSSTEuyWPAKV/am5vl10By
 5kehvgvJGKGID55kqqhxqq5pHjZQ6pSZ9pXNflEdJ27kXE5Hwrtd5m7Okk5XRRpTF99QQZYno
 rP4ZsBe3c5pzxcGXCX2qNJ9bD4CBqdIZ9vboE8XJNbZ0ZFs+vdCCSqj2GsSzqBClFq0qHKVvD
 k720+tEqLBHpocoAfNYEoVVCNNJMrGEes2mVTh115zxAbfPaSfLSxw29gyPVYaCGJ3+1CeaFo
 UIQyuewuET2/+mlCBMQcp/A9WemIVPFLN1L115R5an2JfQhgGTWMhoVzCUSE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.11
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wency@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>,
 Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After failover the Secondary side of replication shouldn't change state, b=
ecause
it now functions as our primary disk.

In replication_start, replication_do_checkpoint, replication_stop, ignore
the request if current state is BLOCK_REPLICATION_DONE (sucessful failover=
) or
BLOCK_REPLICATION_FAILOVER (failover in progres i.e. currently merging act=
ive
and hidden images into the base image).

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
=2D--
 block/replication.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/block/replication.c b/block/replication.c
index 3d4dedddfc..78234d1a04 100644
=2D-- a/block/replication.c
+++ b/block/replication.c
@@ -454,6 +454,17 @@ static void replication_start(ReplicationState *rs, R=
eplicationMode mode,
     aio_context_acquire(aio_context);
     s =3D bs->opaque;

+    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
+        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
+        /*
+         * This case happens when a secondary is promoted to primary.
+         * Ignore the request because the secondary side of replication
+         * doesn't have to do anything anymore.
+         */
+        aio_context_release(aio_context);
+        return;
+    }
+
     if (s->stage !=3D BLOCK_REPLICATION_NONE) {
         error_setg(errp, "Block replication is running or done");
         aio_context_release(aio_context);
@@ -577,6 +588,17 @@ static void replication_do_checkpoint(ReplicationStat=
e *rs, Error **errp)
     aio_context_acquire(aio_context);
     s =3D bs->opaque;

+    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
+        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
+        /*
+         * This case happens when a secondary was promoted to primary.
+         * Ignore the request because the secondary side of replication
+         * doesn't have to do anything anymore.
+         */
+        aio_context_release(aio_context);
+        return;
+    }
+
     if (s->mode =3D=3D REPLICATION_MODE_SECONDARY) {
         secondary_do_checkpoint(s, errp);
     }
@@ -593,7 +615,7 @@ static void replication_get_error(ReplicationState *rs=
, Error **errp)
     aio_context_acquire(aio_context);
     s =3D bs->opaque;

-    if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
+    if (s->stage =3D=3D BLOCK_REPLICATION_NONE) {
         error_setg(errp, "Block replication is not running");
         aio_context_release(aio_context);
         return;
@@ -635,6 +657,17 @@ static void replication_stop(ReplicationState *rs, bo=
ol failover, Error **errp)
     aio_context_acquire(aio_context);
     s =3D bs->opaque;

+    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
+        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
+        /*
+         * This case happens when a secondary was promoted to primary.
+         * Ignore the request because the secondary side of replication
+         * doesn't have to do anything anymore.
+         */
+        aio_context_release(aio_context);
+        return;
+    }
+
     if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
         error_setg(errp, "Block replication is not running");
         aio_context_release(aio_context);
=2D-
2.20.1


