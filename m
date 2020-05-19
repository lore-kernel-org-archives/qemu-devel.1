Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C24C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C93E2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCBRQoSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C93E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1javka-0003eI-Jx
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 02:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1javk0-0002wK-Ne
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:28:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32666
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1javjz-0004xh-4g
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589869717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OD1dv4ObTTj2m8HH0mlORHDz3oLGL81jKstqN19r1wY=;
 b=SCBRQoStaC+B7vlVm7M75oCCqFummjqfS06DNgBuDrXyFS02Egb+oxhboxMQz+xgiPZ+1b
 Pr9DGvxIUt//q02otfjX34nngzM8y0y8HsSXz38w/HkGKqPzB0mWM0u5irZJonsANI/0z1
 ggmFQ54pAFCt0zc+n7VOh03rTV6qGIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-mCDOWrkcPSC9vQOV8YtpmQ-1; Tue, 19 May 2020 02:28:35 -0400
X-MC-Unique: mCDOWrkcPSC9vQOV8YtpmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 380A5835B4A;
 Tue, 19 May 2020 06:28:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5FEC60C05;
 Tue, 19 May 2020 06:28:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2143911358BC; Tue, 19 May 2020 08:28:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 16/24] ppc/pnv: Put "*-pnv-chip" and "pnv-xive" on the
 main system bus
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-17-armbru@redhat.com>
 <5abeb1b9-16d4-2984-720f-2f0d776ec19e@kaod.org>
Date: Tue, 19 May 2020 08:28:32 +0200
In-Reply-To: <5abeb1b9-16d4-2984-720f-2f0d776ec19e@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Mon, 18 May 2020 18:34:59 +0200")
Message-ID: <877dx85tgv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 5/18/20 7:04 AM, Markus Armbruster wrote:
>> pnv_init() creates "power10_v1.0-pnv-chip", "power8_v2.0-pnv-chip",
>> "power8e_v2.1-pnv-chip", "power8nvl_v1.0-pnv-chip", or
>> "power9_v2.0-pnv-chip" sysbus devices in a way that leaves them
>> unplugged.
>>=20
>> pnv_chip_power9_instance_init() creates a "pnv-xive" sysbus device in
>> a way that leaves it unplugged.
>>=20
>> Create them the common way that puts them into the main system bus.
>> Affects machines powernv8, powernv9, and powernv10.  Visible in "info
>> qtree".  Here's the change for powernv9:
>>=20
>>      bus: main-system-bus
>>        type System
>>     +  dev: power9_v2.0-pnv-chip, id ""
>>     +    chip-id =3D 0 (0x0)
>>     +    ram-start =3D 0 (0x0)
>>     +    ram-size =3D 1879048192 (0x70000000)
>>     +    nr-cores =3D 1 (0x1)
>>     +    cores-mask =3D 72057594037927935 (0xffffffffffffff)
>>     +    nr-threads =3D 1 (0x1)
>>     +    num-phbs =3D 6 (0x6)
>>     +    mmio 000603fc00000000/0000000400000000
>>     [...]
>>     +  dev: pnv-xive, id ""
>>     +    ic-bar =3D 1692157036462080 (0x6030203100000)
>>     +    vc-bar =3D 1689949371891712 (0x6010000000000)
>>     +    pc-bar =3D 1690499127705600 (0x6018000000000)
>>     +    tm-bar =3D 1692157036986368 (0x6030203180000)
>>=20
>> Cc: "C=C3=A9dric Le Goater" <clg@kaod.org>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: qemu-ppc@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/ppc/pnv.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index da637822f9..8d4fc8109a 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -818,7 +818,7 @@ static void pnv_init(MachineState *machine)
>>      pnv->chips =3D g_new0(PnvChip *, pnv->num_chips);
>>      for (i =3D 0; i < pnv->num_chips; i++) {
>>          char chip_name[32];
>> -        Object *chip =3D object_new(chip_typename);
>> +        Object *chip =3D OBJECT(qdev_create(NULL, chip_typename));
>> =20
>>          pnv->chips[i] =3D PNV_CHIP(chip);
>> =20
>> @@ -1317,8 +1317,8 @@ static void pnv_chip_power9_instance_init(Object *=
obj)
>>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(obj);
>>      int i;
>> =20
>> -    object_initialize_child(obj, "xive", &chip9->xive, sizeof(chip9->xi=
ve),
>> -                            TYPE_PNV_XIVE, &error_abort, NULL);
>> +    sysbus_init_child_obj(obj, "xive", &chip9->xive, sizeof(chip9->xive=
),
>> +                          TYPE_PNV_XIVE);
>>      object_property_add_alias(obj, "xive-fabric", OBJECT(&chip9->xive),
>>                                "xive-fabric");
>
> OK. But why only XIVE and not all sub-devices of the PnvChip device ?=20
>
> Shouldn't they be initialized in the same way, calling sysbus_init_child_=
obj ?=20
No, your code is just fine there.

sysbus_init_child_obj() is a convenience wrapper around
object_initialize_child() and qdev_set_parent_bus().  Only sysbus
devices may use it.  The other sub-devices are not susbus devices:

* TYPE_PNV8_PSI, TYPE_PNV9_PSI, TYPE_PNV10_PSI

  Subtypes of TYPE_PNV_PSI, which is a subtype of TYPE_DEVICE.

* TYPE_PNV8_LPC, TYPE_PNV9_LPC, TYPE_PNV10_LPC

  Subtypes of TYPE_PNV_LPC, which is a subtype of TYPE_DEVICE.

* TYPE_PNV8_OCC, TYPE_PNV9_OCC

  Subtypes of TYPE_PNV_OCC, which is a subtype of TYPE_DEVICE.

* TYPE_PNV8_HOMER, TYPE_PNV9_HOMER

  Subtypes of TYPE_PNV_HOMER, which is a subtype of TYPE_DEVICE.

* TYPE_PNV_PHB4_PEC

  Subtype of TYPE_DEVICE.

* TYPE_PNV_QUAD

  Subtype of TYPE_DEVICE.

Except for:

* TYPE_PNV_PHB3

  Subtype of TYPE_PCIE_HOST_BRIDGE, which is a subtype of
  TYPE_PCI_HOST_BRIDGE, which is a subtype of TYPE_SYS_BUS_DEVICE.

where you use object_initialize_child() and qdev_set_parent_bus()
directly.  Works.  We could perhaps change it to use
sysbus_init_child_obj(), but it would be a waste; my next series will
kill that helper :)


