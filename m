Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E55C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 04:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11EE20776
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 04:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxxlTnPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11EE20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdnrO-0004wD-Vl
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 00:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdnqs-0004VZ-J3
 for qemu-devel@nongnu.org; Wed, 27 May 2020 00:39:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38129
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdnqr-0003j4-62
 for qemu-devel@nongnu.org; Wed, 27 May 2020 00:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590554375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W881pdo0kifoIbLJj9MyAVG1CLInIE7LgsllUtsWh/g=;
 b=CxxlTnPZjwqTT6qe21t1mC+TZ6s/NDG5loW1ZG6UhfQgryDKhWxNjypuOsPX7RgAPiw+8W
 zLpcdaqo0mkiLitwOayTAa5sDneSTJGdb9RJvHW3DJ3M+OaKD2tKrEuRQHdw8HdQijh2TB
 AtFXlcMEtoZmBxEFUzO6IzRvYEdHjF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-zcCq40YJMcK1-XBdtcbizQ-1; Wed, 27 May 2020 00:39:33 -0400
X-MC-Unique: zcCq40YJMcK1-XBdtcbizQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C90F18017EB
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 04:39:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AC516FB84;
 Wed, 27 May 2020 04:39:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9BA43113864A; Wed, 27 May 2020 06:39:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 30/55] auxbus: New aux_realize_bus(),
 pairing with aux_init_bus()
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-31-armbru@redhat.com>
 <bed7f417-fc23-8170-28ad-9e49a92ecc1c@redhat.com>
Date: Wed, 27 May 2020 06:39:30 +0200
In-Reply-To: <bed7f417-fc23-8170-28ad-9e49a92ecc1c@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 26 May 2020 13:54:59
 +0200")
Message-ID: <87v9ki0z5p.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 22:58:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com,
 Markus Armbruster <armbru@redhat.com>, ehabkost@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/19/20 4:55 PM, Markus Armbruster wrote:
>> aux_init_bus() encapsulates the creation of an aux-bus and its
>> aux-to-i2c-bridge device.
>>=20
>> Create aux_realize_bus() to similarly encapsulate their realization.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/hw/misc/auxbus.h | 7 +++++++
>>  hw/display/xlnx_dp.c     | 2 +-
>>  hw/misc/auxbus.c         | 5 +++++
>>  3 files changed, 13 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
>> index a539a98c4b..6ab6cf5bb6 100644
>> --- a/include/hw/misc/auxbus.h
>> +++ b/include/hw/misc/auxbus.h
>> @@ -93,6 +93,13 @@ struct AUXSlave {
>>   */
>>  AUXBus *aux_init_bus(DeviceState *parent, const char *name);
>
> Previous to your patch, but aux_init_bus() is misnamed.
>
> I'd rather rename this one aux_bus_init() ...
>
>> =20
>> +/**
>> + * aux_realize_bus: Realize an AUX bus.
>> + *
>> + * @bus: The AUX bus.
>> + */
>> +void aux_realize_bus(AUXBus *bus);
>
> ... and this one aux_bus_realize().
>
> If you mind :)

Makes sense.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!


