Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A1FC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 05:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5732220989
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 05:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5732220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiXU7-0002zw-1c
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 01:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33547)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiXTE-0002Vn-RC
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiXT8-0004JO-6A
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:06:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiXT7-00049Y-2M
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:06:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B349781F0F;
 Wed,  3 Jul 2019 05:05:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8075B7E699;
 Wed,  3 Jul 2019 05:05:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CAE1C1132ABF; Wed,  3 Jul 2019 07:05:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 03 Jul 2019 07:05:56 +0200
Message-ID: <878stfzozv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 03 Jul 2019 05:05:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] What's IOMMUMemoryRegion's super?
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The usual QOM boilerplate for defining a sub-{type,class} looks like
this:

    static const TypeInfo sysbus_device_type_info = {
        .name = TYPE_SYS_BUS_DEVICE,
        .parent = TYPE_DEVICE,
        .instance_size = sizeof(SysBusDevice),
        .abstract = true,
        .class_size = sizeof(SysBusDeviceClass),
        .class_init = sysbus_device_class_init,
    };

    typedef struct SysBusDeviceClass {
        /*< private >*/
        DeviceClass parent_class;
        [...]
    } SysBusDeviceClass;

    struct SysBusDevice {
        /*< private >*/
        DeviceState parent_obj;
        [...]
    };

Note the TypeInfo states the parent type (member @parent), and
associated class and instance structs (used members @instance_size and
@class_size) have the parent type's class and member struct as first
member.

This makes type casts to parent types work.  The checked QOM casts add
safety by checking it's actually a parent type.

Now consider TYPE_IOMMU_MEMORY_REGION:

    static const TypeInfo iommu_memory_region_info = {
        .parent             = TYPE_MEMORY_REGION,
        .name               = TYPE_IOMMU_MEMORY_REGION,
        .class_size         = sizeof(IOMMUMemoryRegionClass),
        .instance_size      = sizeof(IOMMUMemoryRegion),
        .instance_init      = iommu_memory_region_initfn,
        .abstract           = true,
    };

    typedef struct IOMMUMemoryRegionClass {
        /* private */
--->    struct DeviceClass parent_class;
        [...]
    };

    struct IOMMUMemoryRegion {
        MemoryRegion parent_obj;
        [...]
    };

The parent is TYPE_MEMORY_REGION, and the instance struct's first member is
TYPE_MEMORY_REGION's instance struct as I expect, but the class struct's
first member is something else entirely.

What's going on here?  Am I confused?

The commit message is of no help whatsoever:

    commit 1221a4746769f70231beab4db8da1c937e60340c
    Author: Alexey Kardashevskiy <aik@ozlabs.ru>
    Date:   Tue Jul 11 13:56:20 2017 +1000

        memory/iommu: introduce IOMMUMemoryRegionClass

        This finishes QOM'fication of IOMMUMemoryRegion by introducing
        a IOMMUMemoryRegionClass. This also provides a fastpath analog for
        IOMMU_MEMORY_REGION_GET_CLASS().

        This makes IOMMUMemoryRegion an abstract class.

        Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
        Message-Id: <20170711035620.4232-3-aik@ozlabs.ru>
        Acked-by: Cornelia Huck <cohuck@redhat.com>
        Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

