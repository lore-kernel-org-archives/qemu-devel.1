Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42E7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B95620767
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnBrOHf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B95620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTWy-0001lU-T6
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joTVa-00007U-HB
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:09:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joTVY-0002pN-Ft
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593097783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n5n0YEjiwNl+7xXegi6g3Fgm//jQ3clv5v8ePC6IBGw=;
 b=YnBrOHf8xsnCCmYxgmnkTID6U6MPDtMgdMNzsKFbfqy3mYPJ7CcMrb5bW9VSu+dKfmYHC7
 oEyGICIFH4mfpy4dY5EKfj3LMFTYQFmpaWvO26HioheoyVm66V/N4co4OFN5nieyrZDsC6
 MI7auKmqMnoA6izO/bsmD8Osxj7K4/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-nm502fGTOUqrZj83FiuyWA-1; Thu, 25 Jun 2020 11:09:40 -0400
X-MC-Unique: nm502fGTOUqrZj83FiuyWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50194BFC4;
 Thu, 25 Jun 2020 15:09:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CA817C1EC;
 Thu, 25 Jun 2020 15:09:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C65511384D4; Thu, 25 Jun 2020 17:09:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 34/46] qom: Don't handle impossible
 object_property_get_link() failure
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-35-armbru@redhat.com>
 <4c1644b4-4d30-9831-9484-dc32081f41db@redhat.com>
Date: Thu, 25 Jun 2020 17:09:36 +0200
In-Reply-To: <4c1644b4-4d30-9831-9484-dc32081f41db@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 25 Jun 2020 08:36:39
 +0200")
Message-ID: <87d05nxjv3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 6/24/20 6:43 PM, Markus Armbruster wrote:
>> Don't handle object_property_get_link() failure that can't happen
>> unless the programmer screwed up, pass &error_abort.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/arm/bcm2835_peripherals.c |  7 +------
>>  hw/arm/bcm2836.c             |  7 +------
>>  hw/display/bcm2835_fb.c      |  8 +-------
>>  hw/dma/bcm2835_dma.c         |  9 +--------
>>  hw/gpio/bcm2835_gpio.c       | 15 ++-------------
>>  hw/intc/nios2_iic.c          |  8 +-------
>>  hw/misc/bcm2835_mbox.c       |  9 +--------
>>  hw/misc/bcm2835_property.c   | 17 ++---------------
>>  hw/usb/hcd-dwc2.c            |  9 +--------
>>  9 files changed, 11 insertions(+), 78 deletions(-)
>>=20
>> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
>> index 8313410ffe..3c40bda91e 100644
>> --- a/hw/arm/bcm2835_peripherals.c
>> +++ b/hw/arm/bcm2835_peripherals.c
>> @@ -134,12 +134,7 @@ static void bcm2835_peripherals_realize(DeviceState=
 *dev, Error **errp)
>>      uint64_t ram_size, vcram_size;
>>      int n;
>> =20
>> -    obj =3D object_property_get_link(OBJECT(dev), "ram", &err);
>> -    if (obj =3D=3D NULL) {
>> -        error_setg(errp, "%s: required ram link not found: %s",
>> -                   __func__, error_get_pretty(err));
>> -        return;
>> -    }
>> +    obj =3D object_property_get_link(OBJECT(dev), "ram", &error_abort);
> [...]
>
> Should we now add an assert(errp) in object_property_get_link()?
> Basically this would force forks to adapt their code when
> rebasing.

Functions should not place additional restrictions @errp arguments
without a compelling reason.  What if you want genuinely don't need the
error details when object_property_get_link() fails?  Passing null is
better than passing &err only to error_free(err).

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!


