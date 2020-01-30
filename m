Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD8EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA096206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2H2Xliv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA096206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix9oP-0006IQ-56
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ix9nk-0005rV-4B
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ix9nh-0001Ut-MR
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:24:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57497
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ix9nh-0001US-JC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580390644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erPkdlaAj6fcWGDdulB8eblIVh6S2jlOorb+TF2nnMA=;
 b=h2H2XlivACHWjRc334snr+fj21al7wMaywe2fre+fT5xR6p7zrOd7U/iPse5luEkmZ+MiY
 Jr6Y1HSjCjJJUYL8Hir0Luglk+X8Bzy/bCbOEeyvdtYmE/6I4rTwU3ttEf+YAbseUjUhQ+
 cOVWITpklp8driYOJFzRIh+TsGfwUZ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-WTSXtBmzPCKaLJjuXKEsHQ-1; Thu, 30 Jan 2020 08:24:02 -0500
Received: by mail-wr1-f69.google.com with SMTP id k18so1715365wrw.9
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 05:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DGHzVtcPwtF+mzP6/sebta0M9m1Iwvc7R+CyODx7uEk=;
 b=YQLsKNjcIASUPKYp2+wUwTT7EE1lv4ngPnZuMSfZhPwjaEKUjDOYcHmvS5Bai3RsGH
 uJ4U8s7AawZeNgqKsNberH3Sdn5XPq95BupopCVXwTVw9eO67gDX/VeQHBzufT+aALBA
 uK2q6lBOCNyRufVI4DuU/CFuhItbLKyiimSvBHtybQEESY4A1FlN39Fb0zlEqJ2law0k
 8yxPKear3wqE6iVkV5octZfG3ASMEBcNrm89vjCt7Hb85JbJXuI+w49XA1oGjNIFY7Yd
 kmvFOIcb0WIG3+GsLGrdkDndKNRM8bJEILZWYXbD026aqyiDBEcsFYTcJYSAiTqmVi2m
 CWBA==
X-Gm-Message-State: APjAAAWz4NuYKLesFc79evcrnNVqV5mCkGrjB7ciP0Y6A0Fw/ovtQuwM
 ZlXrNe8rjZgITsUAqcNwT6w32nO1QOjEQAwJF8+p+rsDxdOgHeIF4BCl6qxqp7zsuo9OxUnaNP4
 xy+7zqRq+T+wlG3o=
X-Received: by 2002:a1c:7406:: with SMTP id p6mr6014209wmc.82.1580390641466;
 Thu, 30 Jan 2020 05:24:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqztaRkz1iqd91XHODjYPGo6CwSRiVaah4LfMHFkCfIfpgIerny6CxdFfUxv2zbDSB6k4ooeRw==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr6014182wmc.82.1580390641226;
 Thu, 30 Jan 2020 05:24:01 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n1sm7148072wrw.52.2020.01.30.05.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 05:24:00 -0800 (PST)
Subject: Re: [PATCH v2 01/29] hw/core: Allow setting 'virtio-blk-device.scsi'
 property on OSX host
To: Cornelia Huck <cohuck@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-2-philmd@redhat.com>
 <20200130132003.50057b0d.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <161e2df7-c0b1-7d0c-2c33-e2439475d367@redhat.com>
Date: Thu, 30 Jan 2020 14:23:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130132003.50057b0d.cohuck@redhat.com>
Content-Language: en-US
X-MC-Unique: WTSXtBmzPCKaLJjuXKEsHQ-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 1:20 PM, Cornelia Huck wrote:
> On Wed, 29 Jan 2020 22:23:17 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> Commit ed65fd1a27 restricted the 'scsi' property to Linux hosts:
>=20
> It was restricted to Linux hosts before that commit; that only became
> problematic because we set it unconditionally in the compat code.
>=20
>>
>>    1261 static Property virtio_blk_properties[] =3D {
>>    1262     DEFINE_BLOCK_PROPERTIES(VirtIOBlock, conf.conf),
>>    ...
>>    1268 #ifdef __linux__
>>    1269     DEFINE_PROP_BIT64("scsi", VirtIOBlock, host_features,
>>    1270                       VIRTIO_BLK_F_SCSI, false),
>>    1271 #endif
>=20
> What about:
>=20
> Commit ed65fd1a2750 ("virtio-blk: switch off scsi-passthrough by
> default") changed the default value of the 'scsi' property of
> virtio-blk, which is only available on Linux hosts. It also added an
> unconditional compat entry for 2.4 or earlier machines.

OK!

>>
>> When we try to set this property on a pre-2.4 machine on OSX,
>=20
> Pre-2.5, I think?

Yes :S

>> we get:
>>
>>     Unexpected error in object_property_find() at qom/object.c:1201:
>>     qemu-system-x86_64: -device virtio-blk-pci,id=3Dscsi0,drive=3Ddrive0=
: can't apply global virtio-blk-device.scsi=3Dtrue: Property '.scsi' not fo=
und
>>
>> Fix this error by marking the property optional.
>>
>> Fixes: ed65fd1a27
>=20
> Fixes: ed65fd1a2750 ("virtio-blk: switch off scsi-passthrough by default"=
)

OK.

>=20
>> Suggested-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   hw/core/machine.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 3e288bfceb..d8e30e4895 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -148,7 +148,8 @@ GlobalProperty hw_compat_2_5[] =3D {
>>   const size_t hw_compat_2_5_len =3D G_N_ELEMENTS(hw_compat_2_5);
>>  =20
>>   GlobalProperty hw_compat_2_4[] =3D {
>> -    { "virtio-blk-device", "scsi", "true" },
>> +    /* Optional because the 'scsi' property is Linux-only */
>> +    { "virtio-blk-device", "scsi", "true", .optional =3D true },
>>       { "e1000", "extra_mac_registers", "off" },
>>       { "virtio-pci", "x-disable-pcie", "on" },
>>       { "virtio-pci", "migrate-extra", "off" },
>=20
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks!


