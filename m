Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B255C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3279D20665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqWhbMZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3279D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kASRV-000771-Hg
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 02:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kASQi-0006Hc-5R
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 02:27:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52781
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kASQg-0003Hc-7w
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 02:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598336853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pUJTE73BR2+NpO28itr5zrwu4gGWIFEDom+TtL0Cm5o=;
 b=NqWhbMZbJphkdIHFVsIQ3dON1R2W7oCOh/5FYKZktpNhYvpV2IrwqCdhlmw7wwVDBbSBrP
 j3XkO8LM7VcNHgQado/0rPKOW186b7zmAGu6J14Lse9SF1xkPQvo9Q5xGXDoDnyeX5ugrJ
 DaS3lx2xBr2XcEoWqdjjcp5hfvjK6Xg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-vdVwh3oPNVGi1QShudidDg-1; Tue, 25 Aug 2020 02:27:31 -0400
X-MC-Unique: vdVwh3oPNVGi1QShudidDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E5548030C8;
 Tue, 25 Aug 2020 06:27:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C991A5D9D5;
 Tue, 25 Aug 2020 06:27:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 11A71112D737; Tue, 25 Aug 2020 08:27:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/1] spapr_vscsi: do not allow device hotplug
References: <20200820190635.379657-1-danielhb413@gmail.com>
 <7f6ab4e6-42b1-3de4-5893-2ef09fc9dd26@redhat.com>
Date: Tue, 25 Aug 2020 08:27:28 +0200
In-Reply-To: <7f6ab4e6-42b1-3de4-5893-2ef09fc9dd26@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 21 Aug 2020 13:08:24
 +0200")
Message-ID: <87k0xnjl4f.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:37:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Cc'ing Markus
>
> On 8/20/20 9:06 PM, Daniel Henrique Barboza wrote:
>> We do not implement hotplug in the vscsi bus, but we forgot to
>> tell qdev about it. The result is that users are able to hotplug
>> devices in the vscsi bus, the devices appear in qdev, but they
>> aren't usable by the guest OS unless the user reboots it first.
>>=20
>> Setting qbus hotplug_handler to NULL will tell qdev-monitor, via
>> qbus_is_hotpluggable(), that we do not support hotplug operations
>> in spapr_vscsi.
>>=20
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1862059
>>=20
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>  hw/scsi/spapr_vscsi.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
>> index d17dc03c73..57f0a1336f 100644
>> --- a/hw/scsi/spapr_vscsi.c
>> +++ b/hw/scsi/spapr_vscsi.c
>> @@ -1219,6 +1219,9 @@ static void spapr_vscsi_realize(SpaprVioDevice *de=
v, Error **errp)
>> =20
>>      scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(dev),
>>                   &vscsi_scsi_info, NULL);
>> +
>> +    /* ibmvscsi SCSI bus does not allow hotplug. */
>> +    qbus_set_hotplug_handler(BUS(&s->bus), NULL);
>
> Can't this be a problem later in DeviceClass::unrealize()?

Can't say offhand.  Cc'ing QOM maintainers for actual expertise.

A quick grep coughs up virtio_serial_device_realize() /
virtio_serial_device_unrealize(), which set and unset the hotplug
handler of a bus their device provides.  Not the same as the code above,
just a clue that messing with a bus's hotplug handler in a realize
method can work.

qbus_set_hotplug_handler() is entirely undocumented.  It sets a link.
Might be intended for use by the device that provides the bus.

> I was expecting something like, overwriting the parent bus type:
>
> -- >8 --
> @@ -1271,6 +1271,7 @@ static void spapr_vscsi_class_init(ObjectClass
> *klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      SpaprVioDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
>
> +    k->bus_type =3D NULL; /* ibmvscsi SCSI bus does not allow hotplug. *=
/
>      k->realize =3D spapr_vscsi_realize;
>      k->reset =3D spapr_vscsi_reset;
>      k->devnode =3D spapr_vscsi_devnode;

k->bus_type does not exist.  Do you mean dc->bus_type?

TYPE_VIO_SPAPR_VSCSI_DEVICE is a subtype of TYPE_VIO_SPAPR_DEVICE is a
subtype of TYPE_DEVICE.

TYPE_DEVICE is bus-less, i.e. (concrete) instances do not plug into a
bus.

TYPE_VIO_SPAPR_DEVICE has bus_type TYPE_SPAPR_VIO_BUS, i.e. (concrete)
instances plug into a TYPE_SPAPR_VIO_BUS.  Both hot and cold plug.

Zapping TYPE_VIO_SPAPR_VSCSI_DEVICE's bus_type makes it bus-less.  I
doubt that's okay.  Also, it's not just about hot plug.  What are you
trying to accomplish?


