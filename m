Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7003C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AC5206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzrxO6he"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AC5206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix9tw-0000Ph-Mq
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ix9tI-0008Ov-N8
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ix9tB-0005lC-NA
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:29:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53148
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ix9tA-0005fm-Jl
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580390975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KREE3Nucfhn3kYs7Ms6ptr1Zw7I8lizr9weCX4sIh+4=;
 b=AzrxO6hegaB0/N+Ot5YKwEqSc9I2932Bct58BUG0SRUejAR8K+AdW5iU2vC9J82/Rbg0qe
 i7leCdwYkni5tE4sRyLcLLazerGSouLBRJipFVId3n70/Ak8H5xfjO0KrGF9vkYMUapY5Q
 SDu9xhqLtzc01G2zJJ9qVFzwIqf0N1g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-t5CM4W5HP6GAFFkHfAOq5A-1; Thu, 30 Jan 2020 08:29:33 -0500
Received: by mail-wr1-f69.google.com with SMTP id h30so1713430wrh.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 05:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Daa+3ygvMZCBO7CUtkrbOylFq1LMYnRkrNrg8w96ULI=;
 b=PSNOk5rPUv5ku3uKMn0jeYJqWY+92av26nZYGjWBl5yowoMphdlFB5IG6xkExRL2sf
 S60+0KL2CiA4uatOeVvHdecme76bfZEnDR9SIrZpaueC+SuhGpDACzRsgAkaoi9zsvf5
 NEx8wuChSOy1sQS3wURJL/m6xlzyUL/zEBCuQ5rQ3Zx8K+nlk3zi+b7+zjY/1/mGOjyp
 PX9BO40/Mepg0gwtJvrBDi30eFHxpyFX76kWqfbYoFG6ph3Sj2396YcWwFJn8X5h8HE5
 9ssTHCkF6xZ+ryrTjreFqur/kTET5XeamST1S7qMazUYTGc5BQswwCdIctFO05oO2swX
 M44g==
X-Gm-Message-State: APjAAAUfSDbE6JjTIvpUeTj+KcABf3aJGeEebhIsujWpkIP16dTyxv69
 IUzKCAt8z0QbsbYqtag3Fdv2+x1WVreAGn02/aaudSqbMQKgUO9IZ1f+aPwfog9HqP6IxWh9h4n
 Un94/uoMYORvg9Rg=
X-Received: by 2002:a7b:c444:: with SMTP id l4mr5624127wmi.178.1580390972479; 
 Thu, 30 Jan 2020 05:29:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZl2kj4MujTdIj0lZODiF+hNSxCLXJ3Ew0I0ufiagC5RNtQx8wh88HJsL6hfErCMBSDoiprg==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr5624107wmi.178.1580390972246; 
 Thu, 30 Jan 2020 05:29:32 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d10sm7342363wrw.64.2020.01.30.05.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 05:29:31 -0800 (PST)
Subject: Re: [PATCH v2 19/29] tests/acceptance/virtio_check_params: Only test
 Xen as superuser
To: Cornelia Huck <cohuck@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-20-philmd@redhat.com>
 <20200130133751.4e954bb1.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <29514738-d5e0-a649-67c1-69bd200eafd1@redhat.com>
Date: Thu, 30 Jan 2020 14:29:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130133751.4e954bb1.cohuck@redhat.com>
Content-Language: en-US
X-MC-Unique: t5CM4W5HP6GAFFkHfAOq5A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 1:37 PM, Cornelia Huck wrote:
> On Wed, 29 Jan 2020 22:23:35 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> When running the test unprivileged, we get:
>>
>>    $ avocado --show=3Dapp,machine run tests/acceptance/virtio_check_para=
ms.py
>>    JOB ID     : b631d5d692e49b791b211d33b80730315d561d45
>>    JOB LOG    : job-results/job-2020-01-22T17.56-b631d5d/job.log
>>     (1/1) tests/acceptance/virtio_check_params.py:VirtioMaxSegSettingsCh=
eck.test_machine_types:
>>    machine: {'name': 'pc-i440fx-2.12', 'seg_max_adjust': 'false', 'devic=
e': 'virtio-scsi-pci'}
>>    machine: {'name': 'pc-i440fx-2.0', 'seg_max_adjust': 'false', 'device=
': 'virtio-scsi-pci'}
>>    machine: {'name': 'xenpv', 'seg_max_adjust': 'false', 'device': 'virt=
io-scsi-pci'}
>>    FAIL: machine type xenpv: <class 'qemu.qmp.QMPConnectError'> (0.40 s)
>>
>> Looking at the job.log file we find:
>>
>>    xencall: error: Could not obtain handle on privileged command interfa=
ce: No such file or directory
>>    xen be core: xen be core: can't open xen interface
>>
>> Do not run this test on Xen machines if not superuser.
>>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   tests/acceptance/virtio_check_params.py | 2 ++
>>   1 file changed, 2 insertions(+)
>=20
> I still think changing the title to "Test Xen only as superuser" would
> be an improvement.

If it fits the 72chars in patch subject, I'm happy to change :)


