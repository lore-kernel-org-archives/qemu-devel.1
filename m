Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609D3C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C17F206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsuT8CLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C17F206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcTs-0006i3-2e
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcNj-0003b1-Kd
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:47:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60342
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcNh-0001Al-SD
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588603660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+vJp68OTHJYENo+LA7XgYbb4SQC7afepcet0t4udFaM=;
 b=NsuT8CLr6P0pUx/o6qNSO0kRdNpOGTWVe4NELiBIb8DITLJ75uBn9cmsmPOKIvAEzr32Pb
 /+RtYWCVmHxcWGqjKviNVk1GbH/HuY/Etf3LEjcYTl5jsbcHEIqfkjEYmKdte2/jVhy9c+
 J658ASWupa/kInr+KaIby+TxfruYicc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-LbihXrm3OkimvyDfdsK7nw-1; Mon, 04 May 2020 10:47:39 -0400
X-MC-Unique: LbihXrm3OkimvyDfdsK7nw-1
Received: by mail-wr1-f70.google.com with SMTP id o6so3499605wrn.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w3abu0QvtozAed0eJAORquhLm7dsvsmXXpioGTywpaQ=;
 b=dto6NXx1Jj/1Kea/6dn3DlQ0AKFeJOCwr5Qe3huIL2epSqKbsUpH7Csu8ChfMMjxia
 J4mb3hQmdG9jJjtaDGiMdH3hALDERINDI0O5P/tsGKvpSqAEb44VoZtp/5sMG09Zc2qW
 JOkMbjhHGCt3OC4mMVI321RGjVPa7gcmAqRHaODR0E740/jsJaucoIQC0V8PQ7RPu7mj
 mt4+liQqp9dCwJym67UqOmXHhwdeB6V+iJmoQOOv7vqaxPeeP2sa8+9DLcb6vOy3Rhlo
 5i7V1zA1GPdRoCDjGUqbltlYv+h03HApj3QnaaQhdy7gTplCJHGQGI++mkawocNIb3ES
 a2Cw==
X-Gm-Message-State: AGi0PubQdCe2mBNDsGCN0xniIaObk9GEnDx0YuB09IzyGq6ZNYkvMjQb
 NgtT3YtbUT5V3Zguolw0AuUqv3DtwPWFUJWAGFHUt+5YOLbgULmVyfIcevRqhAKgBUgNMPFcdsI
 urxeklEQKuluZKGA=
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr19677173wro.361.1588603657488; 
 Mon, 04 May 2020 07:47:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypJv3K4I4BSvd+NAQvGiDaDp4zQD4omq7EDxr9b4+cZUe6tQ/7yKQ9y1wXzYhjuUJGqQzXNfWg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr19677137wro.361.1588603657234; 
 Mon, 04 May 2020 07:47:37 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id z18sm18659005wrw.41.2020.05.04.07.47.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 07:47:36 -0700 (PDT)
Subject: Re: [PATCH v3 08/15] acpi: serial: don't use _STA method
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-9-kraxel@redhat.com>
 <f79d7f70-7377-3740-69c9-687641565fce@redhat.com>
 <20200504131955.356mjjafk4aq43ko@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8f2d9f28-ed9c-f6ee-f900-d02f27bebd10@redhat.com>
Date: Mon, 4 May 2020 16:47:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200504131955.356mjjafk4aq43ko@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 3:19 PM, Gerd Hoffmann wrote:
>>> -static Aml *build_com_device_aml(uint8_t uid)
>>> +static void build_com_device_aml(Aml *scope, uint8_t uid)
>>>    {
>>>        Aml *dev;
>>>        Aml *crs;
>>> -    Aml *method;
>>> -    Aml *if_ctx;
>>> -    Aml *else_ctx;
>>> -    Aml *zero =3D aml_int(0);
>>> -    Aml *is_present =3D aml_local(0);
>>> -    const char *enabled_field =3D "CAEN";
>>>        uint8_t irq =3D 4;
>>>        uint16_t io_port =3D 0x03F8;
>>>        assert(uid =3D=3D 1 || uid =3D=3D 2);
>>>        if (uid =3D=3D 2) {
>>> -        enabled_field =3D "CBEN";
>>>            irq =3D 3;
>>>            io_port =3D 0x02F8;
>>>        }
>>> +    if (!memory_region_present(get_system_io(), io_port)) {
>>> +        return;
>>> +    }
>>
>> The patch looks OK, but an you split this check into a separate (previou=
s?)
>> patch please?
>=20
> I don't think this belongs to a separate patch.  It is basically the
> same check the lpc bridge is doing when filling the pci config space
> (see hw/isa/lpc_ich9.c).  So this effectively maintains the existing
> logic, only that we now check directly instead of letting the guest
> check the pci config space bit via _STA method.
>=20
> Also note this is only temporary for bisecting, the next patch in the
> series moves the code to a device callback so this kind of "device
> exists" check is not needed any more.

Oh correct.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> take care,
>    Gerd
>=20


