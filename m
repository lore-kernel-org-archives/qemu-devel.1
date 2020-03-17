Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C69C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1726920719
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJF5yWIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1726920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEA2l-0003BL-8M
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEA0p-0000t6-Ac
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEA0n-0005az-SK
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:03:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26666)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEA0n-0005ZA-O6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584443033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9S6m29ACT1LTfZ9iW2T6I2ORE6jTBM8gOfOLAsULhzA=;
 b=BJF5yWIew5RfuBbSYM9gKkR76Ep8fLjnBSqs2unulGDmE7fTEGH5EHsoKwoCBqeBELxWFS
 5p5LociAZZEs/ieomxx1EKioRSoZNQmGpxE9aCOcNnf/v4ZklLV2sYeJ1lxbrs3b/qdJD8
 Sc3k+6sOiipbBXQVd3kZkBDoi7Uk0qI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-1igg5nPnOOaJ19UrhCQtOw-1; Tue, 17 Mar 2020 07:03:49 -0400
X-MC-Unique: 1igg5nPnOOaJ19UrhCQtOw-1
Received: by mail-wm1-f69.google.com with SMTP id z26so5795953wmk.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z5gCHxwhzTQWhmhcGJ6v4pPsTwBuxG5PrrnczaJcp8w=;
 b=AS0690VH/aErcRtqFS9CXt1fMLaGg8q72ZhSEMAhk2mDH+YkoQP+r+ySmIFxgHEOLP
 Qi0fmvnGshfpEF2PMPeplmMjmE0CSZLao57cQodcblLZZxdlTtqqWCwvi4rup6LIt7pu
 GpwpnBNPzovLv4dhTqdIUSNPvPl08wEK9rWDjNkHDQ3+2hGs94X9yLrLbKOKR5UqluV4
 wM02+uyGQpiUgqwaHi5VyeUZ5Ppzu671Q1ZSNKWjmJ63uvOX3B8Gket4UKJBrbsCDKEF
 rrRBuSd+auOo7e3qb78NvoozZnfPPjxpUnrqoEazi2b4LQGZoRTzcdKqB95KCwdP1Yyh
 9Rtg==
X-Gm-Message-State: ANhLgQ1Lx1tm19n+XYitfZPdQw8cqlyyfE6AThsAFE6UMEX5s9qrlr+P
 ERNMo6kIShBbgWsBXhE1knFGMTlMPsru8uFYQa/L7vKL46Bx58ejAE56y07TPqsxORTJ10niKit
 /fBGR7V8qiqc/fiM=
X-Received: by 2002:a05:6000:1147:: with SMTP id
 d7mr5733996wrx.73.1584443028340; 
 Tue, 17 Mar 2020 04:03:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsb4ykRTyPN6T1O5wHA0r7jOCK1FN0dD9ewVqHMDDPG3dSXNW0YDun3E45sF4WMxcDMm1xgFw==
X-Received: by 2002:a05:6000:1147:: with SMTP id
 d7mr5733957wrx.73.1584443028009; 
 Tue, 17 Mar 2020 04:03:48 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id t9sm670232wrx.31.2020.03.17.04.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 04:03:47 -0700 (PDT)
Subject: Re: [PATCH v2 3/8] qapi/misc: Restrict balloon-related commands to
 machine code
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-4-philmd@redhat.com>
 <e69a3576-3b3b-2ee8-df15-ec9e699ff43b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c32e5f6f-539c-5f09-d927-49dd9587844b@redhat.com>
Date: Tue, 17 Mar 2020 12:03:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e69a3576-3b3b-2ee8-df15-ec9e699ff43b@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

On 3/16/20 10:05 AM, David Hildenbrand wrote:
> On 16.03.20 01:03, Philippe Mathieu-Daud=C3=A9 wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   qapi/machine.json          | 83 ++++++++++++++++++++++++++++++++++++++
>>   qapi/misc.json             | 83 --------------------------------------
>>   include/sysemu/balloon.h   |  2 +-
>>   balloon.c                  |  2 +-
>>   hw/virtio/virtio-balloon.c |  2 +-
>>   monitor/hmp-cmds.c         |  1 +
>>   6 files changed, 87 insertions(+), 86 deletions(-)
>>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 07ffc07ba2..c096efbea3 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -915,3 +915,86 @@
>>     'data': 'NumaOptions',
>>     'allow-preconfig': true
>>   }
>> +
>> +##
>> +# @balloon:
>> +#
>> +# Request the balloon driver to change its balloon size.
>> +#
>> +# @value: the target size of the balloon in bytes
>=20
> Not related to your patch. The description of most of this stuff is wrong=
.
>=20
> It's not the target size of the balloon, it's the target logical size of
> the VM (logical_vm_size =3D vm_ram_size - balloon_size)
>=20
> -> balloon_size =3D vm_ram_size - @value
>=20
> E.g., "balloon 1024" with a 3G guest means "please inflate the balloon
> to 2048"
>=20
>> +#
>> +# Returns: - Nothing on success
>> +#          - If the balloon driver is enabled but not functional becaus=
e the KVM
>> +#            kernel module cannot support it, KvmMissingCap
>> +#          - If no balloon device is present, DeviceNotActive
>> +#
>> +# Notes: This command just issues a request to the guest.  When it retu=
rns,
>> +#        the balloon size may not have changed.  A guest can change the=
 balloon
>> +#        size independent of this command.
>> +#
>> +# Since: 0.14.0
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "balloon", "arguments": { "value": 536870912 } }
>> +# <- { "return": {} }
>> +#
>> +##
>> +{ 'command': 'balloon', 'data': {'value': 'int'} }
>> +
>> +##
>> +# @BalloonInfo:
>> +#
>> +# Information about the guest balloon device.
>> +#
>> +# @actual: the number of bytes the balloon currently contains
>=20
> Dito
>=20
> @actual is the logical size of the VM (logical_vm_size =3D vm_ram_size -
> balloon_size)
>=20
>> +#
>> +# Since: 0.14.0
>> +#
>> +##
>> +{ 'struct': 'BalloonInfo', 'data': {'actual': 'int' } }
>> +
>> +##
>> +# @query-balloon:
>> +#
>> +# Return information about the balloon device.
>> +#
>> +# Returns: - @BalloonInfo on success
>> +#          - If the balloon driver is enabled but not functional becaus=
e the KVM
>> +#            kernel module cannot support it, KvmMissingCap
>> +#          - If no balloon device is present, DeviceNotActive
>> +#
>> +# Since: 0.14.0
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "query-balloon" }
>> +# <- { "return": {
>> +#          "actual": 1073741824,
>> +#       }
>> +#    }
>> +#
>> +##
>> +{ 'command': 'query-balloon', 'returns': 'BalloonInfo' }
>> +
>> +##
>> +# @BALLOON_CHANGE:
>> +#
>> +# Emitted when the guest changes the actual BALLOON level. This value i=
s
>> +# equivalent to the @actual field return by the 'query-balloon' command
>> +#
>> +# @actual: actual level of the guest memory balloon in bytes
>=20
> Dito
>=20
> @actual is the logical size of the VM (vm_ram_size - balloon_size)
>=20
>=20
> Most probably we want to pull this description fix out. #badinterface

Since you understand how ballooning works, do you mind sending a patch=20
with description fixed? :)

Thanks,

Phil.


