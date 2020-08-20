Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31723C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BBF20674
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GE88iW/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BBF20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8sYQ-0000cx-9L
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 17:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8sXG-0007ie-Qe
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 17:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8sXF-0001Iy-Am
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 17:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597960548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Mua+x27GNP9PoMRmh9desET01GYPNoFzw4YIF8qk/S4=;
 b=GE88iW/wnGMmG1DAJgp4VYMlkhyGVr6vvieSg+GbjHGdOMUePz4ECU2dN1PvG22foGZ9ig
 WvdSS8AxtRbxqpcTXybbCt8H/75DBGRWiY5Y3oQg1Zn0DNm5PvGCy7NjMJp0gTGDw+4+Go
 wwyHVolwZVuqGLjFI84GpFQrawRKONE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-2pXW9Ak5Nv2rUFhHShv1Ig-1; Thu, 20 Aug 2020 17:55:45 -0400
X-MC-Unique: 2pXW9Ak5Nv2rUFhHShv1Ig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95DEC100CFC0;
 Thu, 20 Aug 2020 21:55:41 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E30371780;
 Thu, 20 Aug 2020 21:55:30 +0000 (UTC)
Date: Thu, 20 Aug 2020 17:55:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Suspicious QOM types without instance/class size
Message-ID: <20200820215529.GH642093@habkost.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 17:32:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Cameron Esfahani <dirty@apple.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While trying to convert TypeInfo declarations to the new
OBJECT_DECLARE* macros, I've stumbled on a few suspicious cases
where instance_size or class_size is not set, despite having type
checker macros that use a specific type.

The ones with "WARNING" are abstract types (maybe not serious if
subclasses set the appropriate sizes).  The ones with "ERROR"
don't seem to be abstract types.

WARNING: hw/arm/armsse.c:1159:1: class_size should be set to sizeof(ARMSSEClass)?
WARNING: hw/audio/hda-codec.c:900:1: instance_size should be set to sizeof(HDAAudioState)?
ERROR: hw/core/register.c:328:1: instance_size should be set to sizeof(RegisterInfo)?
WARNING: hw/input/adb.c:310:1: class_size should be set to sizeof(ADBDeviceClass)?
WARNING: hw/isa/isa-superio.c:181:1: instance_size should be set to sizeof(ISASuperIODevice)?
WARNING: hw/ppc/pnv_lpc.c:771:1: instance_size should be set to sizeof(PnvLpcController)?
ERROR: hw/ppc/spapr_drc.c:771:1: instance_size should be set to sizeof(SpaprDrc)?
WARNING: hw/rtc/m48t59-isa.c:156:1: class_size should be set to sizeof(M48txxISADeviceClass)?
WARNING: hw/rtc/m48t59.c:691:1: class_size should be set to sizeof(M48txxSysBusDeviceClass)?
ERROR: hw/s390x/virtio-ccw.c:1237:1: class_size should be set to sizeof(VirtioCcwBusClass)?
WARNING: hw/ssi/ssi.c:88:1: instance_size should be set to sizeof(SSISlave)?
ERROR: hw/virtio/virtio-pci.c:2101:1: class_size should be set to sizeof(VirtioPCIBusClass)?
WARNING: scsi/pr-manager.c:76:1: instance_size should be set to sizeof(PRManager)?
ERROR: target/i386/hvf/hvf.c:908:1: instance_size should be set to sizeof(HVFState)?

-- 
Eduardo


