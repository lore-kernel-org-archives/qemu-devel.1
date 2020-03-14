Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA18C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC852074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sf6jH8Xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC852074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD24b-0007hl-KP
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jD242-0007D6-Mk
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jD240-0000vy-SA
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:22:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49933
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jD240-0000vU-OD
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584174152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSwLyjqGRFfVGBwNBqMHhHcF3se/8yuvuLVM8Gro4x4=;
 b=Sf6jH8XiELG/s/xoy0JF46JGP/Gj3N10LKLF3dJuKUHgGmX46cVhcAyS+RzyyzBLnBqd8k
 jsl8El/hyZqWdV3JfrARsLToWiy8/ULJw4vD/IbTWrSSUwz4J1C/V7BJUVLjsRZJc5SGAP
 CGqYNEUrPYBeHhqEPnrs50U9Q7AFIsA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-QtyCqhhRNfamO4YbIA0XRQ-1; Sat, 14 Mar 2020 04:22:30 -0400
X-MC-Unique: QtyCqhhRNfamO4YbIA0XRQ-1
Received: by mail-wr1-f72.google.com with SMTP id b12so5652511wro.4
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zDcfN90vjDeq4Yhg5DGQheMYuLFQdx5p3FUDL1LuPRU=;
 b=fK0O3WIwcUJOGkMlrbrSftbGU20hOSwpHVDy2NDteBquiCdewmt3BEBBp9Hy4dMGeg
 Koh9k5nDRaS7Jgf/GFieodPBiUVW2uCQzTWqC6L9YBEeUNI0BTAupdrzFYQK3S/svq4h
 WX92/Vcdm1l0fN2IpF2zM2jb017HqyjRgwv3G9I9tR/3GhhgEa1ZFLtMPAhM+2+T+a4T
 h3hNknCCXe5LKz/Bxa03IaDjfRIaPHjmhwbJxqylq+r41wA+NPqJrc3iZFMibOqjNvwv
 MJX0VlH8Eiliw4vQytRGERgTK4q0khHbK9TTZjftoZXmreKpVcfXKwNjPPDUtY8pUakv
 wnFA==
X-Gm-Message-State: ANhLgQ3hDTbPo7+Yr2uMxfKDtx7YUAxCf5iEIsbhlZ4Iygfk28rxatSX
 fNEv0emBJbzNdsLVKXufeD3+p8cLXmT+amx5vs/XvfRwYuahPepBIolVw7MuHlXr7TXWzePQ1o6
 CzXd8/zGYFTQyZ8s=
X-Received: by 2002:a7b:cf33:: with SMTP id m19mr6843809wmg.168.1584174148766; 
 Sat, 14 Mar 2020 01:22:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt/iGn7sDfDnou23xyY6PEi1XucgXsY4SBpkvwDazvADhy7Xftl9HdI1gGjpj3rwkj6/dFY8Q==
X-Received: by 2002:a7b:cf33:: with SMTP id m19mr6843768wmg.168.1584174148481; 
 Sat, 14 Mar 2020 01:22:28 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id s2sm19571313wmj.15.2020.03.14.01.22.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:22:27 -0700 (PDT)
Subject: Re: [PATCH 2/9] qapi/misc: Move add_client command with chardev code
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20200313184153.11275-1-philmd@redhat.com>
 <20200313184153.11275-3-philmd@redhat.com>
 <CAMxuvaxRikWH9Y1cujGR02z=5Kmynnax5fYLqqBuQP4_0WxdSw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d677612e-b305-ebac-e326-4c628fb195c9@redhat.com>
Date: Sat, 14 Mar 2020 09:22:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMxuvaxRikWH9Y1cujGR02z=5Kmynnax5fYLqqBuQP4_0WxdSw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 Peter Lieven <pl@kamp.de>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/14/20 1:23 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Mar 13, 2020 at 7:42 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Without looking at the rest of the series, I fail to see the
> improvement, quite the opposite. A bit of context?


You are right this not needed. I guess remember I had a linker failure=20
at some point while working on this series but I then take some patches=20
out while rebasing, so it might be the result of an earlier incorrect patch=
.

>=20
>> ---
>>   qapi/char.json     | 32 ++++++++++++++++++++++++++++++++
>>   qapi/misc.json     | 32 --------------------------------
>>   monitor/qmp-cmds.c |  1 +
>>   3 files changed, 33 insertions(+), 32 deletions(-)
>>
>> diff --git a/qapi/char.json b/qapi/char.json
>> index 6907b2bfdb..8b7baf11eb 100644
>> --- a/qapi/char.json
>> +++ b/qapi/char.json
>> @@ -572,3 +572,35 @@
>>   { 'event': 'VSERPORT_CHANGE',
>>     'data': { 'id': 'str',
>>               'open': 'bool' } }
>> +
>> +##
>> +# @add_client:
>> +#
>> +# Allow client connections for VNC, Spice and socket based
>> +# character devices to be passed in to QEMU via SCM_RIGHTS.
>> +#
>> +# @protocol: protocol name. Valid names are "vnc", "spice" or the
>> +#            name of a character device (eg. from -chardev id=3DXXXX)
>> +#
>> +# @fdname: file descriptor name previously passed via 'getfd' command
>> +#
>> +# @skipauth: whether to skip authentication. Only applies
>> +#            to "vnc" and "spice" protocols
>> +#
>> +# @tls: whether to perform TLS. Only applies to the "spice"
>> +#       protocol
>> +#
>> +# Returns: nothing on success.
>> +#
>> +# Since: 0.14.0
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "add_client", "arguments": { "protocol": "vnc",
>> +#                                              "fdname": "myclient" } }
>> +# <- { "return": {} }
>> +#
>> +##
>> +{ 'command': 'add_client',
>> +  'data': { 'protocol': 'str', 'fdname': 'str', '*skipauth': 'bool',
>> +            '*tls': 'bool' } }
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index c18fe681fb..e84e6823e9 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -39,38 +39,6 @@
>>   { 'enum': 'LostTickPolicy',
>>     'data': ['discard', 'delay', 'slew' ] }
>>
>> -##
>> -# @add_client:
>> -#
>> -# Allow client connections for VNC, Spice and socket based
>> -# character devices to be passed in to QEMU via SCM_RIGHTS.
>> -#
>> -# @protocol: protocol name. Valid names are "vnc", "spice" or the
>> -#            name of a character device (eg. from -chardev id=3DXXXX)
>> -#
>> -# @fdname: file descriptor name previously passed via 'getfd' command
>> -#
>> -# @skipauth: whether to skip authentication. Only applies
>> -#            to "vnc" and "spice" protocols
>> -#
>> -# @tls: whether to perform TLS. Only applies to the "spice"
>> -#       protocol
>> -#
>> -# Returns: nothing on success.
>> -#
>> -# Since: 0.14.0
>> -#
>> -# Example:
>> -#
>> -# -> { "execute": "add_client", "arguments": { "protocol": "vnc",
>> -#                                              "fdname": "myclient" } }
>> -# <- { "return": {} }
>> -#
>> -##
>> -{ 'command': 'add_client',
>> -  'data': { 'protocol': 'str', 'fdname': 'str', '*skipauth': 'bool',
>> -            '*tls': 'bool' } }
>> -
>>   ##
>>   # @NameInfo:
>>   #
>> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
>> index 864cbfa32e..67d95b4af7 100644
>> --- a/monitor/qmp-cmds.c
>> +++ b/monitor/qmp-cmds.c
>> @@ -31,6 +31,7 @@
>>   #include "sysemu/block-backend.h"
>>   #include "qapi/error.h"
>>   #include "qapi/qapi-commands-block.h"
>> +#include "qapi/qapi-commands-char.h"
>>   #include "qapi/qapi-commands-control.h"
>>   #include "qapi/qapi-commands-machine.h"
>>   #include "qapi/qapi-commands-misc.h"
>> --
>> 2.21.1
>>
>=20


