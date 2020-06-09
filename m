Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5981EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E895D2078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N27qK2Qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E895D2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jib9D-0006a7-Uf
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jib8X-00065U-MS
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:05:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56658
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jib8V-0007Ni-Ux
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591697138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IhX5EVhqHsHtXJijPROwqCfjsiE8Dw9uu73eK0g66jU=;
 b=N27qK2QtlNGgAfk1+L4bZEmY5zjjWZ0LSKU60t7WZXBlT9h7NLWK7yTQVoyrlk/PdSPcNc
 Fz8OCdJUfJH2Ne2uI2cnBppF3Giag2ZhKTO8xmAwVfpqeLmnbJRg15MBAtMLZ4TGOwbOql
 ViRdLZJlb/PDQMNzWjJe4xuubt35sFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-BQYXrUMePZ-4doJRJXqBaQ-1; Tue, 09 Jun 2020 06:05:36 -0400
X-MC-Unique: BQYXrUMePZ-4doJRJXqBaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC3F98015CB
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 10:05:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ED757A8CD;
 Tue,  9 Jun 2020 10:05:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0486F11386A6; Tue,  9 Jun 2020 12:05:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 46/58] qdev: Drop qdev_realize() support for null bus
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-47-armbru@redhat.com>
 <ac4cb234-0c4b-d783-8641-a0b0867370d4@redhat.com>
Date: Tue, 09 Jun 2020 12:05:33 +0200
In-Reply-To: <ac4cb234-0c4b-d783-8641-a0b0867370d4@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 9 Jun 2020 10:45:26
 +0200")
Message-ID: <87h7vkpn9u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/29/20 3:45 PM, Markus Armbruster wrote:
>> The "null @bus means main system bus" convenience feature is no longer
>> used.  Drop it.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/core/qdev.c | 16 ++--------------
>>  1 file changed, 2 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index a1fdebb3aa..78a06db76e 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -408,8 +408,7 @@ void qdev_init_nofail(DeviceState *dev)
>>  /*
>>   * Realize @dev.
>>   * @dev must not be plugged into a bus.
>> - * Plug @dev into @bus if non-null, else into the main system bus.
>> - * This takes a reference to @dev.
>> + * Plug @dev into @bus.  This takes a reference to @dev.
>>   * If @dev has no QOM parent, make one up, taking another reference.
>>   * On success, return true.
>>   * On failure, store an error through @errp and return false.
>> @@ -419,18 +418,7 @@ bool qdev_realize(DeviceState *dev, BusState *bus, =
Error **errp)
>>      Error *err =3D NULL;
>> =20
>>      assert(!dev->realized && !dev->parent_bus);
>> -
>> -    if (!bus) {
>> -        /*
>> -         * Assert that the device really is a SysBusDevice before we
>> -         * put it onto the sysbus.  Non-sysbus devices which aren't
>> -         * being put onto a bus should be realized with
>> -         * object_property_set_bool(OBJECT(dev), true, "realized",
>> -         * errp);
>> -         */
>> -        g_assert(object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE))=
;
>> -        bus =3D sysbus_get_default();
>> -    }
>> +    assert(bus);
>
> Hmm what about renaming that to sysbus_init_nofail() and keep
> qdev_init_nofail() (without the bus part)?

I'm dense.  What are you proposing?

>> =20
>>      qdev_set_parent_bus(dev, bus);
>> =20
>>=20


