Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C350AC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875DB20706
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnW/eHXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875DB20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEsJ-0000Uv-Ap
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igEqk-0007Jn-7x
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igEqg-0003By-DE
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:21:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39639
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igEqg-00039k-4M
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576358473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d2cgnUsyCFW2BiPycL0uarGIB4Ld7QKWjjmbSxUwEzA=;
 b=UnW/eHXQ4eVRMLeTaKXd31iWZmfM+3MJfUTluWA78gpJbhZaWLSIOw38PRKN7LLL2PlC/u
 JOkKDKB4O8TUMRej6HYv4hJimMN6lT6LVeCjO+r/WXhGmJLmwSNbQvQpDZBJqVRxOTQKLj
 C/MukYfqjGUJSDmhcQAocq4wHLiK5xQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-kkATIfZ-OHKQwgam24uxPw-1; Sat, 14 Dec 2019 08:19:36 -0500
Received: by mail-wr1-f69.google.com with SMTP id o6so977022wrp.8
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 05:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pbwj25+M4vo0DDMS+IXW0D/94V5mNsvVY7y8A6P2wk0=;
 b=GXgp0a7aGAKE7bPdVEU+k8HujtMFpeMIs4w7pPomYvPatwtQxKPJl48sLQj1JC9LvO
 bePYxMZVAqk8aQa2XgN6t8uV2UZLRxa/4AN2lVKl2Q5MhrKIUXqEB50Mw1pdHc4jgugu
 tICaAAMmLF7XXiIggcLhfrgS3m12IRHuTK3cfhLsOp1lp/x1c/v/D3Ba0xPwtRKB8CHm
 ebZo1CToTdnmI392Lu7L4FQZVsJqYVNLRUMfWls3OJbsGF3n6IGwohSe3U7RIHb6wZKp
 SPkETks4ebsrF3adYMFudyIJcXdHCEFu7Rk7q27t1AbvoAuA6SIlgl2OXUJrnoeaGpnq
 tbwA==
X-Gm-Message-State: APjAAAV3COYKnkB8I8wawAJyG8IY7h497yT8KNbwIXEPUzm7l8j73Kb+
 z0zuYP2QA/wfzY7LSyD1ilf6PLIm2uuGD72FemhYiEomKB7YN0XXj2J1vJkahrNSk9nuleG+Ehh
 PJpNO1x2ahBWfmTM=
X-Received: by 2002:adf:f70b:: with SMTP id r11mr20027578wrp.388.1576329575091; 
 Sat, 14 Dec 2019 05:19:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6RcXnogXj8b8Itp9T7IvRotAlxhlWFymOy/GoHa8Ch32tvYS53TROMBiv7fGomyorxd1D6A==
X-Received: by 2002:adf:f70b:: with SMTP id r11mr20027559wrp.388.1576329574923; 
 Sat, 14 Dec 2019 05:19:34 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id g23sm14093585wmk.14.2019.12.14.05.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 05:19:34 -0800 (PST)
Subject: Re: [PATCH] mos6522: remove anh register
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20191212194359.13508-1-laurent@vivier.eu>
 <20191213014419.GA207300@umbus.fritz.box>
 <68431265-fd33-89de-6a61-0c823beaa16e@vivier.eu>
 <9c731591-3180-d9f8-e5f9-d1b34356664b@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8de4d817-dacc-73d1-e20b-7b6c533c76d0@redhat.com>
Date: Sat, 14 Dec 2019 14:19:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <9c731591-3180-d9f8-e5f9-d1b34356664b@ilande.co.uk>
Content-Language: en-US
X-MC-Unique: kkATIfZ-OHKQwgam24uxPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/14/19 11:47 AM, Mark Cave-Ayland wrote:
> On 13/12/2019 08:45, Laurent Vivier wrote:
>> Le 13/12/2019 =C3=A0 02:44, David Gibson a =C3=A9crit=C2=A0:
>>> On Thu, Dec 12, 2019 at 08:43:59PM +0100, Laurent Vivier wrote:
>>>> Register addr 1 is defined as buffer A with handshake (vBufAH),
>>>> register addr 15 is also defined as buffer A without handshake (vBufA)=
.
>>>>
>>>> Linux kernel has a big "DON'T USE!" next to the register 1 addr
>>>> definition (vBufAH), and only uses register 15 (vBufA).
>>>>
>>>> So remove the definition of 'anh' and use only 'a' (with VIA_REG_ANH a=
nd
>>>> VIA_REG_A).
>>>
>>> I'm not actually following the rationale for removing the register.
>>> Linux doesn't use it, but if it's part of the real hardware model we
>>> should keep it, no?
>>
>> It's actually two methods to access the same register (with handshake,
>> without handshake).
>>
>> In the datashit Register 15 is described as "Same as register 1 except
>> no handshake".
>=20
> Indeed, certainly my reading of the specification was that it was the sam=
e register.
> I'd be inclined to add qemu_log() at unimp for the handshake registers so=
 at least we
> can easily spot if anything is using them.

Agreed, clever than my review suggestion.

      case VIA_REG_A:
+        qemu_log_mask(LOG_UNIMP, ...);
+        /* fall through */
+    case VIA_REG_ANH:
          val =3D s->a;
          break;


