Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD96C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 20:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD4A21775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 20:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cE5l5mIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD4A21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iznu3-0003xN-E0
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 15:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izntU-0003Lh-K1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 15:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izntT-0005zH-M9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 15:37:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43704
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izntT-0005yh-J3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 15:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581021418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i3/QIxY9a4hGMUCO6ojEHPC6gW4y7NH0vxDHvs1NOo8=;
 b=cE5l5mIX9jKnG3fbRkJjskb1ChBruhzDQIyG7tCqtRriwOQ+oguqQGFMgDh0XsS3dgLYlP
 dv1eqFMfCMKFZgU7uY/BAnaMDBWDjh70bpftLYlg5ijunreb1YfhsCRRHMCn1W1WnVED+U
 BZoRtuYvSsdqAf2M2xLJ/O56TKLgFQQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-c0GQufzIPuiz35SirUMNpw-1; Thu, 06 Feb 2020 15:36:55 -0500
Received: by mail-wm1-f71.google.com with SMTP id z7so609797wmi.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 12:36:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tDKxNiUakhkYL3yyLRKv4nW3ZKHDpH2FL/0Cbl5X/2c=;
 b=cOv013foeojCvD/F1ibRGRGDOMfy79QwrppcBS4rCe8TPKHIni3YFV8pCbHczrlGbq
 m7ea2H5xtoRhZOGIfoM1R5m9aUHG41xWah1CcsdJJfv35igETrXHNTJrsVpZdxPpnLa4
 3iJ2qpbnGyReDcJen11i066FaukRFiTWGgsc3E9MoQuvHKqHgnBugKNUdj/DmmCLkqgm
 lSF69YY+/5mmafAQHfoT9TssQlEkq4pvu/a7rAwtkLAOzSBWiHOBBvYO2Xal6yDX5Fb+
 DSR/c47k5SBTz7lGP5zblySDhtTUxYkVoXVml1SAyQJh9nxegWTwde2oNbpzrffp7a8f
 mLOg==
X-Gm-Message-State: APjAAAVvu4yxQjkZZ1P5DOohPVHBp6MTssljl3wFca4QghMXwDpvJ3cy
 EVqlor5uTP9/mHdW3SFPQ2KsQK0wCV1D5nVd73TAiskh9fOz3auSoY3tsvlHCJH41MwlF/OIBtF
 b1TjKcq8Dazo3D2Q=
X-Received: by 2002:a1c:bdc5:: with SMTP id n188mr6484216wmf.124.1581021413753; 
 Thu, 06 Feb 2020 12:36:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvrptNMOj6WMv/c38sGWTKZgvIPl7fEb3YY+AOdnvgjKdXYpD7bNLFnmusYP9Le6ec3FN7Wg==
X-Received: by 2002:a1c:bdc5:: with SMTP id n188mr6484188wmf.124.1581021413419; 
 Thu, 06 Feb 2020 12:36:53 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s16sm514636wrn.78.2020.02.06.12.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 12:36:52 -0800 (PST)
Subject: Re: [PATCH v2 17/29] tests/acceptance/virtio_check_params: Improve
 exception logging
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-18-philmd@redhat.com>
 <20200206195441.GA412524@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <41dbf2d1-0c38-f483-fdc6-815015f1649d@redhat.com>
Date: Thu, 6 Feb 2020 21:36:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206195441.GA412524@habkost.net>
Content-Language: en-US
X-MC-Unique: c0GQufzIPuiz35SirUMNpw-1
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
Cc: Cleber Rosa <crosa@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 8:54 PM, Eduardo Habkost wrote:
> On Wed, Jan 29, 2020 at 10:23:33PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   tests/acceptance/virtio_check_params.py | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/=
virtio_check_params.py
>> index 4a417b8ef5..51a2dd76e8 100755
>> --- a/tests/acceptance/virtio_check_params.py
>> +++ b/tests/acceptance/virtio_check_params.py
>> @@ -77,8 +77,12 @@ class VirtioMaxSegSettingsCheck(Test):
>>               vm.set_machine(mt["name"])
>>               for s in VM_DEV_PARAMS[dev_type_name]:
>>                   vm.add_args(s)
>> -            vm.launch()
>> -            query_ok, props, error =3D self.query_virtqueue(vm, dev_typ=
e_name)
>> +            try:
>> +                vm.launch()
>> +                query_ok, props, error =3D self.query_virtqueue(vm, dev=
_type_name)
>> +            except:
>> +                query_ok =3D False
>> +                error =3D sys.exc_info()[0]
>=20
> I would prefer to do this inside query_virtqueue(), but:

The problem is in vm.launch():

DEBUG| Output: "xencall: error: Could not obtain handle on privileged=20
command interface: No such file or directory\nxen be core: xen be core:=20
can't open xen interface\ncan't open xen interface\nqemu-system-x86_64:=20
failed to initialize xen: Operation not permitted\n"

>=20
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>=20

Thanks, I'll keep this patch queued.

Phil.


