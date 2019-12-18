Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B89FC2D0C3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391F62146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMAcblrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391F62146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihY2B-0005Hr-94
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihY1E-0004mx-HQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihY19-0002Kk-0e
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:01:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44873
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihY18-0002B3-Rr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576670485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nnTOVHuW87Jr/QF5nTyCZsFNBa9WxSkLxkS3rc7V324=;
 b=CMAcblrSa9quoeC6sxcghhVePalAQnrshpCYZYmxDr/Dx9pL7045+57pj9qgfmE/YgLTGK
 4lbU2NOLl77eaWE8BeRLtJRU4HMYZK9DYPB75x6c9wtG0/fDWzAsLFLd2NXsy6cF+vzuKD
 6R9q23BIAFHut9PF1SMNVMhUCFbCDZs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-G62gFVv_NAqS0LjzT4_onw-1; Wed, 18 Dec 2019 07:01:23 -0500
Received: by mail-wm1-f70.google.com with SMTP id p5so434679wmc.4
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vtprSGYHU4j197Ob5MFH6FDAhj99Ty+47OcaF4TZslQ=;
 b=MedRIOAlLZhhwnfvhGOrJ0LloPDIhDBjxRWGDdjjyHBx+sbo4UD5NlZi3dKT4eC92j
 Ug22meH/UwkbuZC17CKy/8m/r37Oj4VcWfDHkG39lmAZqzU75chzP1UzJTncIAdVbFuQ
 ir3UTpdodPZbWM0cb2qVEFz0l80vY98u/Z2aaZxTPHZq2wIW+8ScVYwfjK9H1GhmQF9P
 X0JcPIKJB32JRvVFvJAk8uZXLkGppSOha54WW71VV6mNcX+IoMIeuJavjLhIqyBDWgGC
 t/nK1iUO5EpjRucrDjAr0y62nIxmVi4G5tTGgSTATu1HIvC5ffph4oJKJuNuLZLzDrOC
 CgDw==
X-Gm-Message-State: APjAAAV8Ol3QkrDC/qxydw77ZGESaD4qfEaM+5kF2fgS2F4AnTIW4tnx
 XTWz4YtrNkGzE9jUqKtN7e0q1FFjHR4mc9FS9NCcR+iX2GdPPFW/g72m1XoumQzzLWVZEXeHAvC
 BDx15kswmrKg2WRw=
X-Received: by 2002:a05:6000:50:: with SMTP id
 k16mr2402936wrx.145.1576670482376; 
 Wed, 18 Dec 2019 04:01:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqzP+Fh3tnwzAq8B8UcmM2mVBYjuJtoDSV8sbDFanUFk2f/c6bgGmh1sUtNsOgYBEFE0wS3EXA==
X-Received: by 2002:a05:6000:50:: with SMTP id
 k16mr2402888wrx.145.1576670482076; 
 Wed, 18 Dec 2019 04:01:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c?
 ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
 by smtp.gmail.com with ESMTPSA id s8sm2242512wrt.57.2019.12.18.04.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:01:21 -0800 (PST)
Subject: Re: [PATCH-for-5.0 v3 3/6] hw/pci-host/i440fx: Use size_t to iterate
 over ARRAY_SIZE()
To: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191209095002.32194-1-philmd@redhat.com>
 <20191209095002.32194-4-philmd@redhat.com>
 <a4745134-47dc-ab8a-6009-69fcc9dfbb02@redhat.com>
 <46339299-e45b-79a3-5b45-f62fb5c7b26f@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b629cd94-95e9-d351-6e80-23594c2b6245@redhat.com>
Date: Wed, 18 Dec 2019 13:01:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <46339299-e45b-79a3-5b45-f62fb5c7b26f@vivier.eu>
Content-Language: en-US
X-MC-Unique: G62gFVv_NAqS0LjzT4_onw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/19 12:57, Laurent Vivier wrote:
> Le 09/12/2019 =C3=A0 11:05, Thomas Huth a =C3=A9crit=C2=A0:
>> On 09/12/2019 10.49, Philippe Mathieu-Daud=C3=A9 wrote:
>>> We don't enforce the -Wsign-conversion CPPFLAG, but it doesn't hurt
>>> to avoid this warning:
>>>
>>>   warning: implicit conversion changes signedness: 'int' to 'size_t' (a=
ka 'unsigned long') [-Wsign-conversion]
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>  hw/pci-host/i440fx.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
>>> index fbdc563599..0cc80b276d 100644
>>> --- a/hw/pci-host/i440fx.c
>>> +++ b/hw/pci-host/i440fx.c
>>> @@ -419,12 +419,11 @@ out:
>>>  static void igd_pt_i440fx_realize(PCIDevice *pci_dev, Error **errp)
>>>  {
>>>      uint32_t val =3D 0;
>>> -    int i, num;
>>> +    size_t i;
>>>      int pos, len;
>>>      Error *local_err =3D NULL;
>>> =20
>>> -    num =3D ARRAY_SIZE(igd_host_bridge_infos);
>>> -    for (i =3D 0; i < num; i++) {
>>> +    for (i =3D 0; i < ARRAY_SIZE(igd_host_bridge_infos); i++) {
>>>          pos =3D igd_host_bridge_infos[i].offset;
>>>          len =3D igd_host_bridge_infos[i].len;
>>>          host_pci_config_read(pos, len, &val, &local_err);
>>>
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
>>
>=20
> Applied to my trivial-patches branch.

No need to, I've already queued the whole series.

Paolo


