Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A8AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95652063A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/2jwJiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95652063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix9z6-0002ao-2X
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ix9yL-0001cJ-Ro
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ix9yK-0003oZ-RW
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:35:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54412
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ix9yK-0003oG-OI
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580391304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BSxw757oKVot5QAkhm88G4y6RNeUShSzy/ctriGDBVk=;
 b=i/2jwJiW7nvVHM0bYIAifNRCkDjeRC1XHGdPf+o9SuLlEPwqQSHW2AXvDOcrLKDM2+IYMy
 dtRraQ8h8OR1yItV6zUmkbOi6tuN9I45CK2w2rekNvO2EsCZ8sNiXBhbcDk5WhlRRipxWb
 2oSrl33hpiS5WOwYRiNCo8ywEN42GA4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-U1qLtuYJN2eT_4Vat5M-xw-1; Thu, 30 Jan 2020 08:34:59 -0500
Received: by mail-wr1-f70.google.com with SMTP id s13so1712337wru.7
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 05:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qgWZmuhOKMFfk4VlYLuSzsR74+izZ4gtbxwoXtULvz0=;
 b=aJnqb6i9CmSW8APVmNa4GPNPB6RFE/NTtaGDRX7wK/kfA/hlXG6mu52te80Ijo8Gsb
 +N0hMcbxM1IHcDoT0Q2pIp6VOLSreBAtriHBirgv1oNEMKc+JLRNB+9PElwRp1JjfVUP
 w9Zrn+mjgvRDYdaiI+Oaz7Pp3XLz3H38q412j0PtaxmpzrE967yO+T1eb1H2p4BabQuQ
 /v1X1YQy8P2uvI5unul6wpYpkZ+O1FkFytr7myT58jwzOdBji2rGC+w7H6+4ruERWDXd
 pwr63QxmsDAhbMU+Ozabuk3qPq28EwEkQzQYHXyjZZJbZV0FobsI53e366v/aqhvZ9lR
 wp+Q==
X-Gm-Message-State: APjAAAUuK5vpZslKu8so95scZ1bYjqcHHMBXxAhJ3HWmgWwC1T8x9j/l
 E7HygYM+jqdiJJqxvJh1JaRUNtbZ5+GTeZOKvP4nqfGDAEqSe2pBrQx/6cXxNFzvh++VMJBb9i3
 L3zktk+RXaeAZ260=
X-Received: by 2002:a7b:c216:: with SMTP id x22mr5990223wmi.51.1580391298568; 
 Thu, 30 Jan 2020 05:34:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzaK3e7+tI1ynJ6nZWf6xjV+JfROJgFKfNjftS9fcCTVFysf2JJkQdFIT9TmVxClGHNFy2SMw==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr5990189wmi.51.1580391298345; 
 Thu, 30 Jan 2020 05:34:58 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id r6sm4272192wrp.95.2020.01.30.05.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 05:34:57 -0800 (PST)
Subject: Re: [PATCH 10/10] tests/qemu-iotests/check: Update to match Python 3
 interpreter
To: Kevin Wolf <kwolf@redhat.com>
References: <20200129231402.23384-1-philmd@redhat.com>
 <20200129231402.23384-11-philmd@redhat.com>
 <20200130105839.GB6438@linux.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f20bd922-f5b7-7acd-fcc8-9326b282a36c@redhat.com>
Date: Thu, 30 Jan 2020 14:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130105839.GB6438@linux.fritz.box>
Content-Language: en-US
X-MC-Unique: U1qLtuYJN2eT_4Vat5M-xw-1
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 11:58 AM, Kevin Wolf wrote:
> Am 30.01.2020 um 00:14 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
>> All the iotests Python scripts have been converted to search for
>> the Python 3 interpreter. Update the ./check script accordingly.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index 2890785a10..2e7d29d570 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -825,7 +825,7 @@ do
>>  =20
>>           start=3D$(_wallclock)
>>  =20
>> -        if [ "$(head -n 1 "$source_iotests/$seq")" =3D=3D "#!/usr/bin/e=
nv python" ]; then
>> +        if [ "$(head -n 1 "$source_iotests/$seq")" =3D=3D "#!/usr/bin/e=
nv python3" ]; then
>>               if $python_usable; then
>>                   run_command=3D"$PYTHON $seq"
>>               else
>=20
> Changing some test cases in patch 2 and only updating ./check now breaks
> bisectability.
>=20
> I'm not sure why you separated patch 2 and 8. I think the easiest way
> would be to change all qemu-iotests cases in the same patch and also
> update ./check in that patch.

Tests in patch 2 use: if __name__ =3D=3D "__main__", while tests in patch 8=
=20
don't. If I add the check I have to re-indent the patches, some lines=20
don't fit the 80char limit and require manual fixup... This doesn't look=20
worthwhile.

>=20
> Otherwise, you'd have to change ./check in patch 2 to accept both
> versions and could possibly remove the "python" version again here.

OK.


