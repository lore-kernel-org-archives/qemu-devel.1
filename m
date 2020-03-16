Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC9AC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01F720409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITFcRtyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01F720409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDso0-0003PL-4V
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDqFq-0005A0-7g
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDqFo-0003kt-0Q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:58:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59201
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDqFn-0003hi-RS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584367083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7/d8+MuJKar+88rBazaw6wz7CaJpDOFtJRxT1cE/Wx4=;
 b=ITFcRtyjYL5V9REx+dxglw1lgAv4EwuYfqyG0o3TR4Lyj+OUMgHJyuXefrB8WDofvaLJnC
 3AWswunpPeHa1sWwQEUAlrCbdspGKI4SVpLNk8N1TfmgXeDTMZTkvLycgyI6bhJsi2M/6g
 Cymt+qAjwdxLtRMt/am42ETRwHQS8hg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-ga847J6LN7O0u0njFDRTnA-1; Mon, 16 Mar 2020 09:58:01 -0400
X-MC-Unique: ga847J6LN7O0u0njFDRTnA-1
Received: by mail-ed1-f70.google.com with SMTP id x93so6252129ede.19
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 06:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XR4EhODMFHBMam95GhaFU+5NIlJsFFVhcpKtZPC62dk=;
 b=RqsB8aJzVrMcbGKj22DtJBRFeXBcpcQ1kWpUIwECwsJWZssdOsV5nQhJNgBbFaZ1ln
 9m0XhqGe5K6sRhi57h3i43+BO/+o2Yg1u8GHdgh9ayzH8cWCNGs+xQ35hWHyXPsn0n6s
 K9vEWaGI3KH3nwZ+K2Kzg1DKsEQUONZHciiuDNnRA//j5yTBsZdnF8ZAj+mttfNLKoNY
 1swuGpatf3xpP3FGeQ3+R7X63bThNh5tGdLc6dNlExUBqp1pRJKB/rLt0PG3P0dgBR0x
 wHYIi4SArULiIu486C0l686EuX6HFJgo56qye+O/TN+j5DXt1BFTneYkGqY3KE8w47+W
 7gWA==
X-Gm-Message-State: ANhLgQ2rYkdZdBX3bpU8rA89Bj9LLMshvOJm/WFozn1Pn5eKZeYzGwUp
 rmG1z64nxN8lCk/NO9fNLHMM4mMMmSclAR14V2loeixdM7qQd5ks86fm1eCOM+/+hbQpS5uHfnk
 Tz//1c/G6rPVXYLc=
X-Received: by 2002:a17:906:1396:: with SMTP id
 f22mr23955945ejc.147.1584367080440; 
 Mon, 16 Mar 2020 06:58:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvh0DjC7FiEaK1fzS6oR3bSj7+gQ/okaTovVdxneihGa7oN1YWQDt+rAWiu31H1kWHPd90W+Q==
X-Received: by 2002:a17:906:1396:: with SMTP id
 f22mr23955926ejc.147.1584367080090; 
 Mon, 16 Mar 2020 06:58:00 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id e15sm2625169eds.2.2020.03.16.06.57.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 06:57:59 -0700 (PDT)
Subject: Re: [PATCH v2 4/8] qapi/misc: Move query-uuid command with block code
To: Igor Mammedov <imammedo@redhat.com>
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-5-philmd@redhat.com>
 <20200316134317.4d40d16b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d51b48dd-4c4b-8bd0-558f-5b88a75f51f4@redhat.com>
Date: Mon, 16 Mar 2020 14:57:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316134317.4d40d16b@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 3/16/20 2:09 PM, Igor Mammedov wrote:
> On Mon, 16 Mar 2020 01:03:44 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
> here should be why

Indeed.

Daniel explained on IRC the GUID structure is "standardized by microsoft=20
as a way to detect when a guest has certain operations applied" to a=20
saved snapshot.
https://docs.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-machine-ge=
neration-identifier

>=20
> PS:
>   I don't see a reason to move it to block code at all
> if this command is moved then it should be machine code
I guess I mixed GUID with UUID (classic identifier shown in SMBIOS)...

The one I wanted to move to qapi/block-core.json is:

##
# @GuidInfo:
#
# GUID information.
#
# @guid: the globally unique identifier
#
# Since: 2.9
##
{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }

##
# @query-vm-generation-id:
#
# Show Virtual Machine Generation ID
#
# Since: 2.9
##
{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }

So this one goes to qapi/machine.json... Thanks Igor!

>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   qapi/block-core.json | 30 ++++++++++++++++++++++++++++++
>>   qapi/misc.json       | 30 ------------------------------
>>   block/iscsi.c        |  2 +-
>>   stubs/uuid.c         |  2 +-
>>   4 files changed, 32 insertions(+), 32 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 91586fb1fb..5c3fa6c5d0 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -5415,3 +5415,33 @@
>>   { 'command': 'blockdev-snapshot-delete-internal-sync',
>>     'data': { 'device': 'str', '*id': 'str', '*name': 'str'},
>>     'returns': 'SnapshotInfo' }
>> +
>> +##
>> +# @UuidInfo:
>> +#
>> +# Guest UUID information (Universally Unique Identifier).
>> +#
>> +# @UUID: the UUID of the guest
>> +#
>> +# Since: 0.14.0
>> +#
>> +# Notes: If no UUID was specified for the guest, a null UUID is returne=
d.
>> +##
>> +{ 'struct': 'UuidInfo', 'data': {'UUID': 'str'} }
>> +
>> +##
>> +# @query-uuid:
>> +#
>> +# Query the guest UUID information.
>> +#
>> +# Returns: The @UuidInfo for the guest
>> +#
>> +# Since: 0.14.0
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "query-uuid" }
>> +# <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
>> +#
>> +##
>> +{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': tr=
ue }
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index ed28e41229..f70025f34c 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -97,36 +97,6 @@
>>   ##
>>   { 'command': 'query-kvm', 'returns': 'KvmInfo' }
>>  =20
>> -##
>> -# @UuidInfo:
>> -#
>> -# Guest UUID information (Universally Unique Identifier).
>> -#
>> -# @UUID: the UUID of the guest
>> -#
>> -# Since: 0.14.0
>> -#
>> -# Notes: If no UUID was specified for the guest, a null UUID is returne=
d.
>> -##
>> -{ 'struct': 'UuidInfo', 'data': {'UUID': 'str'} }
>> -
>> -##
>> -# @query-uuid:
>> -#
>> -# Query the guest UUID information.
>> -#
>> -# Returns: The @UuidInfo for the guest
>> -#
>> -# Since: 0.14.0
>> -#
>> -# Example:
>> -#
>> -# -> { "execute": "query-uuid" }
>> -# <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
>> -#
>> -##
>> -{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': tr=
ue }
>> -
>>   ##
>>   # @IOThreadInfo:
>>   #
>> diff --git a/block/iscsi.c b/block/iscsi.c
>> index 682abd8e09..68ed5cf3f8 100644
>> --- a/block/iscsi.c
>> +++ b/block/iscsi.c
>> @@ -42,7 +42,7 @@
>>   #include "qemu/uuid.h"
>>   #include "sysemu/replay.h"
>>   #include "qapi/error.h"
>> -#include "qapi/qapi-commands-misc.h"
>> +#include "qapi/qapi-commands-block-core.h"
>>   #include "qapi/qmp/qdict.h"
>>   #include "qapi/qmp/qstring.h"
>>   #include "crypto/secret.h"
>> diff --git a/stubs/uuid.c b/stubs/uuid.c
>> index 67f182fa3a..9ef75fdae4 100644
>> --- a/stubs/uuid.c
>> +++ b/stubs/uuid.c
>> @@ -1,5 +1,5 @@
>>   #include "qemu/osdep.h"
>> -#include "qapi/qapi-commands-misc.h"
>> +#include "qapi/qapi-commands-block-core.h"
>>   #include "qemu/uuid.h"
>>  =20
>>   UuidInfo *qmp_query_uuid(Error **errp)
>=20


