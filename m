Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F1CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A7222522
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXjI6ZxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A7222522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuztK-0004OV-2T
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 09:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuzsk-0003oe-9W
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuzsi-0002id-8s
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:24:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24242
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuzsi-0002hd-6F
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579875860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Z8TRbuEZPXmFnhw14fKCrwKVE80mj53w3EltTduC0E=;
 b=AXjI6ZxY4ZZ8CkJVDh+gXZ+hW0MaiGZ8o31rWEq+SvRpMrL4eOzHpQP4QGMryFpgHULJKT
 fZ1113/b7VPmkr1Hwrgem1jBXFwY6UprnzyFf/DAypwPs3/Iwrt42/Ap07HyckngQ5ILMu
 MmV1UOxPtT1Bcif3oSgCMag0CvGfzG0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-_3i7FhhpM4a3Eoh4yFboQA-1; Fri, 24 Jan 2020 09:24:08 -0500
Received: by mail-wr1-f70.google.com with SMTP id 90so1336390wrq.6
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 06:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3RZVsFUHDq5W7W6pw7CJnk+brPdqj8/Ub+PRtD+cQZA=;
 b=IO/JbN9oIbvsPqytlC5movRVdoYBMb4dV0TvqoS68wjb5U9oI3+ACLeTgg+kvhBuzY
 T+Qn4u1Go8VfX2vNydU9JRXg0XvWpVwDJIf6dtP6yagWOKGkt8KTWPWXL8OuM7QkIXGN
 LhgoYYweWBP2NgR8e60djxIPjZGwVICwpg0dZ9WGvY+c7VvAw+JxqdtZ0d+6zCWtkKFo
 8NTqGKZ5mGgsAcqImjSQNeN2hCX+SmTtZx8IK9fIjXXaGuXDoP4fbcFpNgI/9uPn6LRS
 WupAFFiAJEW9ut/F34ld249W6APfwBaS/zW0oqlwP2VDHxJuCRI0NdoI6bwjuYjzD2AM
 kHCw==
X-Gm-Message-State: APjAAAX6TDpwxf2YZv/nb4rMkTdnPh0pq0E5L7bhnpKNdfhcCPmqYa9D
 2FrYgzAAoRqbwe1ytVnFSe662hMd6OPnhSvFp2gjXZpbiBrvKsHXNtqmSM0RQGJDPR0kmh1wKFK
 GGalytOVXFGcGO74=
X-Received: by 2002:a1c:44d:: with SMTP id 74mr3726884wme.53.1579875845901;
 Fri, 24 Jan 2020 06:24:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrvfeAlkQmyJ86X8OPW3F49cB3CrQnMo5UEnRtQ0MbNHCCvN+U68jxiTkLEFCZcgvLqJRBrw==
X-Received: by 2002:a1c:44d:: with SMTP id 74mr3726848wme.53.1579875845548;
 Fri, 24 Jan 2020 06:24:05 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id t25sm7001957wmj.19.2020.01.24.06.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 06:24:04 -0800 (PST)
Subject: Re: [PATCH] iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
To: Kevin Wolf <kwolf@redhat.com>
References: <B07CB62A-7860-4385-A6A4-4ECA211DBE42@nutanix.com>
 <9F93582E-139B-45B2-8630-FDD331F09DEF@kamp.de>
 <c00fc076-3a46-7a52-a539-66751fb2943a@redhat.com>
 <6C861A00-A30A-4CED-85F7-412A13760C4B@nutanix.com>
 <20200124133919.GD4732@dhcp-200-226.str.redhat.com>
 <d6a7238c-1da2-6447-5eb6-8e0b729f239c@redhat.com>
 <20200124135212.GF4732@dhcp-200-226.str.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8ab863c-df6a-0e1c-cb7b-b577bb058215@redhat.com>
Date: Fri, 24 Jan 2020 15:24:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200124135212.GF4732@dhcp-200-226.str.redhat.com>
Content-Language: en-US
X-MC-Unique: _3i7FhhpM4a3Eoh4yFboQA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Lieven <pl@kamp.de>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 2:52 PM, Kevin Wolf wrote:
> Am 24.01.2020 um 14:42 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
>> On 1/24/20 2:39 PM, Kevin Wolf wrote:
>>> Am 24.01.2020 um 11:48 hat Felipe Franciosi geschrieben:
>>>> On Jan 24, 2020, at 10:04 AM, Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com> wrote:
>>>>> Also shouldn't we report some warning in case of such invalid
>>>>> request? So the management side can look at the 'malicious iSCSI
>>>>> server'?
>>>>
>>>> I think having the option to do so is a good idea. There are two cases
>>>> I can think of that you run into a "malicious" storage server:
>>>> 1) Someone hacked your storage server
>>>> 2) Your control plane allows your compute to connect to a user
>>>> provided storage service
>>>>
>>>> Thinking as an admin, if I only allow storage servers I provide, then
>>>> I want to see such warnings. If I let people point the VMM to dodgy
>>>> servers, then I probably don't want the log spam.
>>>
>>> For this reason, we generally don't log things for failed I/O requests.
>>> If we wanted to introduce it, we'd better find a way to do so
>>> consistently everywhere and not just in a single place with a one-off
>>> option.
>>
>> I'm just suggesting to use error_report().
>=20
> If you do this unconditionally with an untrusted server, you allow it to
> DoS you by filling up your disk with error logs.

Good point :) error_report_once() then!


