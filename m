Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E5EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF12D20708
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="vaPmsBmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF12D20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwAe-0005oA-27
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iuw81-0003VI-AZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iuw80-0003x0-46
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:23:52 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:42126)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iuw7z-0003ue-M8; Fri, 24 Jan 2020 05:23:52 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 19A0196EF0;
 Fri, 24 Jan 2020 10:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579861429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BySGxDsyN2GdcHiLz72LfERqzzxfEvMqN3wPn0ZWxX0=;
 b=vaPmsBmh3MYuIgxHO/LqRjO652uRuRuYJK2LO48ncqJXEoruVBDMIzV+w7rMsi0UL0Qx73
 JnsayMZLy7z4Hw/7CrmaydKDqfDCEeTLlK5K9iQXU9AGWMkdJ4VFz0QfrtTwjN5YZ2HPRV
 kpvn3TbfyJf453N/id+xaMfCkg31TG0=
Subject: Re: [PATCH v8 00/11] Multi-phase reset mechanism
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200123132823.1117486-1-damien.hedde@greensocs.com>
 <CAFEAcA8G7zGwRkbGRjyK4P7KZ9V+cboBHwnTH=jJs4NWu7rMMA@mail.gmail.com>
 <81bde2c9-76d3-f5a0-3e54-089028be9dfb@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <64bf5059-5ec0-bd0a-9375-17dd69229eca@greensocs.com>
Date: Fri, 24 Jan 2020 11:23:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <81bde2c9-76d3-f5a0-3e54-089028be9dfb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579861429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BySGxDsyN2GdcHiLz72LfERqzzxfEvMqN3wPn0ZWxX0=;
 b=Hp0O508VKtQKRxMfQCWnafRb7LzxUxkwNbxTYt+6Ff9381KJOx2vWraUeWeXkOCkx5PruG
 puZDuFgNsMRXUa79bYnJTLH8csaCZQgtIihpX5moY48oI02a0kMdK2T2IK0WXSNuLeI0hT
 s60hrN4YgXaeEZlyivZPrSDr1LTQm9A=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579861429; a=rsa-sha256; cv=none;
 b=x9YUZC4mFELVdyNvNvdR8SNYmQyUaQCsZEICkqnroDKmn4egmGOIwv5v+5nIHCgXOUs8WX
 BHRdUZfmO7POrWj480iRZYXMVZAW4NY+jgYg2QBCJRBl+BOPadvkzDITFkCpcTzKtiwAqV
 RavHTUCggNJwxQfdsUT6ajjlPXmy7Zg=
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



On 1/24/20 11:17 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/24/20 11:05 AM, Peter Maydell wrote:
>> On Thu, 23 Jan 2020 at 13:28, Damien Hedde
>> <damien.hedde@greensocs.com> wrote:
>>> v8:
>>> =C2=A0=C2=A0 + patch 3&5: ResettableState::count type from uint32_t t=
o unsigned
>>> =C2=A0=C2=A0=C2=A0=C2=A0 (Philippe)
>>
>> We'll have to change that back if we ever want to migrate
>> the count (migration insists on fixed-sized types), but
>> I guess we can do that when we get to it...
>=20
> Oh I forgot about migration :( (this was just a suggestion, not a
> requirement).

I forgot it too, and I probably put a uint32_t in the first place
because of migration in an earlier version of the patchset...

Damien

