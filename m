Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3847C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719C720719
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KH2wvOGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719C720719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8mx-0002F9-GS
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE8mB-0001gK-Qb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE8m9-00070t-Kf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:44:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47659)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE8m9-0006zw-GV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584438281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ydlv3t/fgg0Oh+XrU4zmNRiOD5j5E+9BICK2YbaQOGI=;
 b=KH2wvOGSarcQzJlDiY0HZvVgw9Rsip0wY7h99Nu4+RjofPHAdRzSQ2/GKmcnq0CGgh7C+9
 QyfZzhC+MfKn3wGlpz/9Z/oGiW3RhNdSEuNOPa6DYBJo+vdEC1QdBnXZ9vTdCWjCVZs61W
 j6lzlzmle+vgk/MZovu0B2SiXIc+RDY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-_tqX4D1VN--gLPNQTIL7wA-1; Tue, 17 Mar 2020 05:44:39 -0400
X-MC-Unique: _tqX4D1VN--gLPNQTIL7wA-1
Received: by mail-wr1-f69.google.com with SMTP id l16so9700433wrr.6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 02:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GstcnBGFKIvGMhc/ADnzprQCVlvGfB5aLAAosRFLqgI=;
 b=hcgAY611eU04OIkXJehrfqMMww0uYRwzC6P29lvel8CLV9BNyXnL2H9nEM861LstOS
 Jb+RP9PjPCth5r7Ghmc4tJOgwpVgnlyzIhyxqleIqj9PIY2U6KFbZMNv6KOI5ze0x+j0
 u/TqJuLTcKe/VHg1QJPEqnj/Bx5n4g1OpzY/oYwltqkm1G/1KYMCYb+aIaPMVlFEs/KQ
 wt/kX8kMAVytmGYhL9vCehjDDvbR11zbWDPTBd5a2/xJ/zxBci1JtK++wRcIk2wVKSSN
 UBTqkASLvuhKQ2ydSx8tS/6CAzqumLhCjQ6KC13aj6HdRJPyi29iB3UHqcu58p0u2TNa
 fW+A==
X-Gm-Message-State: ANhLgQ0b032zILS69RtX4l07lsBzc+juQxlr8Ibp7RjtDEwr1jeIoRCi
 tsK1Y4Wsq7WXDRXJ3TMYa1Kyzm3h4BcKNxacdWu3U0A29NYQIlcApOu5XsO9JPffXbo0F9xe+G9
 nLHYxvcSEPMFHtJA=
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr4314998wmj.29.1584438275822;
 Tue, 17 Mar 2020 02:44:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvt0JTvSYfGJNlWC8RncMusB08brpJV51W59NAargO3o7lijaZ+5CdrPejRpPVkcrufJCCHkw==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr4314971wmj.29.1584438275596;
 Tue, 17 Mar 2020 02:44:35 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id z11sm3268730wmc.30.2020.03.17.02.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 02:44:35 -0700 (PDT)
Subject: Re: [PATCH v2 5/8] qapi/misc: Restrict query-vm-generation-id command
 to machine code
To: Igor Mammedov <imammedo@redhat.com>
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-6-philmd@redhat.com>
 <20200316134538.4209b297@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c8d31aa1-9e52-a45f-a23c-1e66305194a0@redhat.com>
Date: Tue, 17 Mar 2020 10:44:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316134538.4209b297@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 1:45 PM, Igor Mammedov wrote:
> On Mon, 16 Mar 2020 01:03:45 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Acked-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>>   qapi/machine.json | 20 ++++++++++++++++++++
>>   qapi/misc.json    | 21 ---------------------
>>   hw/acpi/vmgenid.c |  2 +-
>>   stubs/vmgenid.c   |  2 +-
>>   4 files changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index c096efbea3..1a2a4b0d48 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -415,6 +415,26 @@
>>   ##
>>   { 'command': 'query-target', 'returns': 'TargetInfo' }
>>  =20
>> +##
>> +# @GuidInfo:
>> +#
>> +# GUID information.
>> +#
>> +# @guid: the globally unique identifier
>> +#
>> +# Since: 2.9
>> +##
>> +{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
>> +
>> +##
>> +# @query-vm-generation-id:
>> +#
>> +# Show Virtual Machine Generation ID
>> +#
>> +# Since: 2.9
>> +##
>> +{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>> +
>>   ##
>>   # @LostTickPolicy:
>>   #
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index f70025f34c..8c02870227 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -1383,24 +1383,3 @@
>>   #
>>   ##
>>   { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
>> -
>> -##
>> -# @GuidInfo:
>> -#
>> -# GUID information.
>> -#
>> -# @guid: the globally unique identifier
>> -#
>> -# Since: 2.9
>> -##
>> -{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
>> -
>> -##
>> -# @query-vm-generation-id:
>> -#
>> -# Show Virtual Machine Generation ID
>> -#
>> -# Since: 2.9
>> -##
>> -{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }

Daniel explained on IRC the GUID structure is "standardized by microsoft=20
as a way to detect when a guest has certain operations applied" to a=20
saved snapshot.

https://docs.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-machine-ge=
neration-identifier=20


So this one goes to qapi/block-core.json, right?

>> -
>> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
>> index 2df7623d74..2b26bacaf8 100644
>> --- a/hw/acpi/vmgenid.c
>> +++ b/hw/acpi/vmgenid.c
>> @@ -12,7 +12,7 @@
>>  =20
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>> -#include "qapi/qapi-commands-misc.h"
>> +#include "qapi/qapi-commands-machine.h"
>>   #include "qemu/module.h"
>>   #include "hw/acpi/acpi.h"
>>   #include "hw/acpi/aml-build.h"
>> diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
>> index 568e42b064..bfad656c6c 100644
>> --- a/stubs/vmgenid.c
>> +++ b/stubs/vmgenid.c
>> @@ -1,6 +1,6 @@
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>> -#include "qapi/qapi-commands-misc.h"
>> +#include "qapi/qapi-commands-machine.h"
>>   #include "qapi/qmp/qerror.h"
>>  =20
>>   GuidInfo *qmp_query_vm_generation_id(Error **errp)
>=20


