Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74DAC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B714B20738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XF3Yc9B2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B714B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEA36-00040X-SB
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jEA1o-00020s-PX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jEA1m-0001wA-Ee
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:04:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:28325)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jEA1m-0001sy-Ah
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584443094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L01CjseCFDMhFsC0i9ME7v9DJmRxNRom6rPpOe+iNPA=;
 b=XF3Yc9B2baHLiRo+s68dDTQcvAMk1ISgFsTIhq7OhWBNUc2eVW1QySo0NIzy0WxyHMrzEf
 mtcluyf9jj+kzxC7lBw98da7r4K2h/LStg2guw/o+VlqLxEMjIJiStqez5swoGW0Gqsy8o
 fSi+NgdJAqGJ0rd3dhLKl16I8YwTSFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-clNt_uFrOQmBEVEPz0tb2w-1; Tue, 17 Mar 2020 07:04:52 -0400
X-MC-Unique: clNt_uFrOQmBEVEPz0tb2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BDAA1926DAA;
 Tue, 17 Mar 2020 11:04:51 +0000 (UTC)
Received: from [10.36.112.136] (ovpn-112-136.ams2.redhat.com [10.36.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30E427E31A;
 Tue, 17 Mar 2020 11:04:44 +0000 (UTC)
Subject: Re: [PATCH v2 3/8] qapi/misc: Restrict balloon-related commands to
 machine code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-4-philmd@redhat.com>
 <e69a3576-3b3b-2ee8-df15-ec9e699ff43b@redhat.com>
 <c32e5f6f-539c-5f09-d927-49dd9587844b@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <7f7f3e39-08b8-b120-9d25-1c72200b947f@redhat.com>
Date: Tue, 17 Mar 2020 12:04:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c32e5f6f-539c-5f09-d927-49dd9587844b@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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

On 17.03.20 12:03, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi David,
>=20
> On 3/16/20 10:05 AM, David Hildenbrand wrote:
>> On 16.03.20 01:03, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>   qapi/machine.json          | 83 +++++++++++++++++++++++++++++++++++++=
+
>>>   qapi/misc.json             | 83 -------------------------------------=
-
>>>   include/sysemu/balloon.h   |  2 +-
>>>   balloon.c                  |  2 +-
>>>   hw/virtio/virtio-balloon.c |  2 +-
>>>   monitor/hmp-cmds.c         |  1 +
>>>   6 files changed, 87 insertions(+), 86 deletions(-)
>>>
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index 07ffc07ba2..c096efbea3 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -915,3 +915,86 @@
>>>     'data': 'NumaOptions',
>>>     'allow-preconfig': true
>>>   }
>>> +
>>> +##
>>> +# @balloon:
>>> +#
>>> +# Request the balloon driver to change its balloon size.
>>> +#
>>> +# @value: the target size of the balloon in bytes
>>
>> Not related to your patch. The description of most of this stuff is wron=
g.
>>
>> It's not the target size of the balloon, it's the target logical size of
>> the VM (logical_vm_size =3D vm_ram_size - balloon_size)
>>
>> -> balloon_size =3D vm_ram_size - @value
>>
>> E.g., "balloon 1024" with a 3G guest means "please inflate the balloon
>> to 2048"
>>
>>> +#
>>> +# Returns: - Nothing on success
>>> +#          - If the balloon driver is enabled but not functional becau=
se the KVM
>>> +#            kernel module cannot support it, KvmMissingCap
>>> +#          - If no balloon device is present, DeviceNotActive
>>> +#
>>> +# Notes: This command just issues a request to the guest.  When it ret=
urns,
>>> +#        the balloon size may not have changed.  A guest can change th=
e balloon
>>> +#        size independent of this command.
>>> +#
>>> +# Since: 0.14.0
>>> +#
>>> +# Example:
>>> +#
>>> +# -> { "execute": "balloon", "arguments": { "value": 536870912 } }
>>> +# <- { "return": {} }
>>> +#
>>> +##
>>> +{ 'command': 'balloon', 'data': {'value': 'int'} }
>>> +
>>> +##
>>> +# @BalloonInfo:
>>> +#
>>> +# Information about the guest balloon device.
>>> +#
>>> +# @actual: the number of bytes the balloon currently contains
>>
>> Dito
>>
>> @actual is the logical size of the VM (logical_vm_size =3D vm_ram_size -
>> balloon_size)
>>
>>> +#
>>> +# Since: 0.14.0
>>> +#
>>> +##
>>> +{ 'struct': 'BalloonInfo', 'data': {'actual': 'int' } }
>>> +
>>> +##
>>> +# @query-balloon:
>>> +#
>>> +# Return information about the balloon device.
>>> +#
>>> +# Returns: - @BalloonInfo on success
>>> +#          - If the balloon driver is enabled but not functional becau=
se the KVM
>>> +#            kernel module cannot support it, KvmMissingCap
>>> +#          - If no balloon device is present, DeviceNotActive
>>> +#
>>> +# Since: 0.14.0
>>> +#
>>> +# Example:
>>> +#
>>> +# -> { "execute": "query-balloon" }
>>> +# <- { "return": {
>>> +#          "actual": 1073741824,
>>> +#       }
>>> +#    }
>>> +#
>>> +##
>>> +{ 'command': 'query-balloon', 'returns': 'BalloonInfo' }
>>> +
>>> +##
>>> +# @BALLOON_CHANGE:
>>> +#
>>> +# Emitted when the guest changes the actual BALLOON level. This value =
is
>>> +# equivalent to the @actual field return by the 'query-balloon' comman=
d
>>> +#
>>> +# @actual: actual level of the guest memory balloon in bytes
>>
>> Dito
>>
>> @actual is the logical size of the VM (vm_ram_size - balloon_size)
>>
>>
>> Most probably we want to pull this description fix out. #badinterface
>=20
> Since you understand how ballooning works, do you mind sending a patch=20
> with description fixed? :)

Will add it to my todo list, so your patch can go in first :)

Thanks

--=20
Thanks,

David / dhildenb


