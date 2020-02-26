Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5757FC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22EC92084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XthpVrTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EC92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sem-0004T8-Aj
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sds-0003GJ-S8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sdo-0006lf-0T
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39635
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sdn-0006kP-Sr
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582707963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Sbkpo7K4fbQQabaezht/7HSdtDe1em0zHLb8IleaCg=;
 b=XthpVrTGcCRci7yavTpg32xCbHcPORxC9tuDLDqb+wSNw+mmcQTIaeh8LMOYrES8nazVbV
 caAPgIfcMYqgJApR+SCTYblDXecfU8VtOp07FbNMUh+XG0gc59N4x/ivTZgdmfYfcu/85X
 DYohfAOX/75dNcs7nc68PdIJWu6rWTo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-Z9riQ2-8NAe2PXDxiuCylA-1; Wed, 26 Feb 2020 04:06:01 -0500
X-MC-Unique: Z9riQ2-8NAe2PXDxiuCylA-1
Received: by mail-qv1-f71.google.com with SMTP id f17so3074966qvi.6
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HQCVFXmC4HNrtLa78+UIIIU3F1sBdIpmGro+wxgLStc=;
 b=IeJayRzSUBQ6cEtyTHZXqvW1YdB+3aXVMvnMlHqdne9SXA+zhbL3gxiEjgiCk2rSw9
 fW7tiUSeU8S8YRza2joZ/iuwBws3XUjKl8aqgutLLBk0CD9vUW6yROSnLPRQmoSWnXdC
 akOkYrwvqAEwgi0y2fe4oHO0hbJt5hOsyUmtvvcgxKulzIDz4XUiIirbCGG27Fb+Dr58
 wAE0DqICgMl7T0F1YZNJZFIdcTUd/GSv8LEDjW/CPvan10ISGuEVkFnXG84SRtHBgnof
 YwMRl21yVUyCcoG9PedV6g2sK1fnGN8ThO/xgyfydcoLbupOP2Xg6ieJ/TEqdJ/A75Uf
 PXyg==
X-Gm-Message-State: APjAAAWx2I1ccOD5gk3qh915El9hlfoF4gtgJnPPw5KejRDD5nPh03kI
 0bTxPUPK39tg5rmM4KIQec/me/lGF34klmte35+Lje9C3kB4ERki0kSepRJqB12fdPLSebIynbM
 YEXrhYUafCiYJbbQ=
X-Received: by 2002:ac8:42de:: with SMTP id g30mr4106860qtm.195.1582707960708; 
 Wed, 26 Feb 2020 01:06:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1QkWk7My2SwC62w1LQ6SDOyzhpUJKG+7jW51YBG5mGQALUAUK4aMdAZaU/qH85Z05CBwmLQ==
X-Received: by 2002:ac8:42de:: with SMTP id g30mr4106833qtm.195.1582707960500; 
 Wed, 26 Feb 2020 01:06:00 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 o3sm786655qkk.87.2020.02.26.01.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:05:59 -0800 (PST)
Date: Wed, 26 Feb 2020 04:01:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/30] virtio-pmem: do delete rq_vq in virtio_pmem_unrealize
Message-ID: <20200226090010.708934-8-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Similar to other virtio-devices, rq_vq forgot to delete in
virtio_pmem_unrealize, this patch fix it.  This device has already
maintained a vq pointer, thus we use the new virtio_delete_queue
function directly to do the cleanup.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200225075554.10835-4-pannengyuan@huawei.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 97287e923b..43399522f5 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -130,6 +130,7 @@ static void virtio_pmem_unrealize(DeviceState *dev, Err=
or **errp)
     VirtIOPMEM *pmem =3D VIRTIO_PMEM(dev);
=20
     host_memory_backend_set_mapped(pmem->memdev, false);
+    virtio_delete_queue(pmem->rq_vq);
     virtio_cleanup(vdev);
 }
=20
--=20
MST


