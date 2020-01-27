Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9F0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB00A214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ha7e2IMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB00A214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw6EL-0000Q1-Vl
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 10:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iw6Bn-0007yV-Ra
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iw6Bm-0006WM-QB
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:20:35 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:42616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iw6Bm-0006Tz-CY; Mon, 27 Jan 2020 10:20:34 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 6212C96EF0;
 Mon, 27 Jan 2020 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1580138431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IvXqHt5G4SpArh/mzyHqRTRYaY8FMay9iJB/36VGW8g=;
 b=ha7e2IMA/N0epIghek5/xwcQGWHfSEP7dhjXA+ITfsFWUFevyl0RE5OtsTTgfphuCdsTXF
 C+7sDkfdNe+lL3juw+l9U2RZVzGYHEzp0ypIb9KQJE82co60wghtRhk1f0Xy1DqfvNGDFv
 wd4FZ8ok6gOEfy39gOnzmimwfs98sYA=
Subject: Re: [PATCH v8 00/11] Multi-phase reset mechanism
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200123132823.1117486-1-damien.hedde@greensocs.com>
 <CAFEAcA8G7zGwRkbGRjyK4P7KZ9V+cboBHwnTH=jJs4NWu7rMMA@mail.gmail.com>
 <81bde2c9-76d3-f5a0-3e54-089028be9dfb@redhat.com>
 <CAFEAcA_927erQTvG3LS9ffqwY2WochmF4cKNSs12aPqiReTfRg@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <84645773-394d-e3bf-6719-9a6153208e00@greensocs.com>
Date: Mon, 27 Jan 2020 16:20:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_927erQTvG3LS9ffqwY2WochmF4cKNSs12aPqiReTfRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1580138431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IvXqHt5G4SpArh/mzyHqRTRYaY8FMay9iJB/36VGW8g=;
 b=xL8Q7KJLpprpTZVV1pKs0y459ZM0TW0knzlD8ZlUv4PGOw1DX1nDSCMcdLV/sM7nyY6m+G
 ol17Lz+fNMhEKHUzeA9waRleCFQIPU7xTK9pmpuiLgXPat5zpxI/woEStMg73GoBvI7la9
 oiYOw8yPqPG12DSGg03ySq5R2H/fJ+k=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1580138431; a=rsa-sha256; cv=none;
 b=b+ni6Yy7Jy5y2+1IY2anZAaEJGQPrk5m8bFyvIwGSrh36WPJrKunu6udB4IO6+QxV95fwq
 GhIaUZ8B5bJ0+noYyIhtUxXi1rFtDhLjfOViG7MWkQkXqyqS8q3p6zA4hY0zwHNCyIaT7O
 6P+uQLgGjh7f4scZzZCFzi8eOKP1amo=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/24/20 11:18 AM, Peter Maydell wrote:
> On Fri, 24 Jan 2020 at 10:17, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>>
>> On 1/24/20 11:05 AM, Peter Maydell wrote:
>>> On Thu, 23 Jan 2020 at 13:28, Damien Hedde <damien.hedde@greensocs.co=
m> wrote:
>>>> v8:
>>>>    + patch 3&5: ResettableState::count type from uint32_t to unsigne=
d
>>>>      (Philippe)
>>>
>>> We'll have to change that back if we ever want to migrate
>>> the count (migration insists on fixed-sized types), but
>>> I guess we can do that when we get to it...
>>
>> Oh I forgot about migration :( (this was just a suggestion, not a
>> requirement).
>=20
> Migration handling is going to require changes anyway, flipping
> the type of the field will just be a minor part of that patch
> if/when it arrives. It seems easier to take v8 if it's otherwise OK.
>=20

Hi Peter,

For me v8 is ok. In which pull queue should it be taken ?

Thanks,
Damien

