Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D918DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C4821582
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhQP95y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C4821582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihFS6-0000HO-Sx
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihFRL-0008HE-4y
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihFRH-0003cH-GT
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:11:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25278
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihFRH-0003VR-2x
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576599070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2h83AL8aS2w2Rnp2P4AIH18JYDJUV85rQtELdieBzDw=;
 b=hhQP95y3jIc40iXaCBjpK6rPKTmK09QD6rjrpBdegO7O/fpuMQoBIwRZ74re2X1DYTWg76
 K7Tr+OX8lQCyBTi2mvLIAAmQ682jVCQFreV+Wb6FOGLXJVDVqALX4GQa2cBP6gC2ll1/Au
 y7Rt+0bf4OuvBroMPidqzX2DgjOaknQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-Qvz6TwYONJybL6RYlcEqOA-1; Tue, 17 Dec 2019 11:11:08 -0500
Received: by mail-wr1-f72.google.com with SMTP id v17so5515068wrm.17
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 08:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yn+84cH9XOOvHfsX9iXhmgM1ZPfhhA7dJdWcLpX+LnQ=;
 b=UMQN/86sFodpdFHa7e1Wzkc+dVdByJFwPoq1cfamn8GI6M8aDFlovVGL6IZ31/BMpx
 CgUe+DYi2ecauRYgyJWtoDdRyiB9b7Ec3SruNET+D4fVCifgwNS7UOPWtGeB+URG6pvh
 2Y8oXqAafR2OhqXBWFyEy+F6SAX/pT0hgLE4NidovLa7l5DabLHZqmA2TVY5EqmOxU0+
 3qeII2Y1ZwBvg20W3cpSI6qgV/shr1XkOIRz9LKNAgsG9x5lmyCkRniz9pwrOnK//glI
 VYJd0w47x7zjOZnn5PPGY2Xq4KM3JyTf5qQrsQwgbLlZE0uab0FGrKULkgo34RvSda9J
 gJjw==
X-Gm-Message-State: APjAAAUtJM9qIN3rD8o8g38UFoAB0WG/Oy9gKqMol9p9uKjQqS3azRd9
 noVgd/rgyjKHisYXMLJuHHAsc/RjaalFxQ70reNRO29VaTUBbust4TEf2lv4rERNV6uUUwNiUnC
 ePIWxzj4iieBZV68=
X-Received: by 2002:adf:e58d:: with SMTP id l13mr36464942wrm.135.1576599067387; 
 Tue, 17 Dec 2019 08:11:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEr6MebCPVQYgmeqNnXuFr69J0IHlVTply6shSwblgeoSETJS/MCN9oT6owRynq7mhdfF65w==
X-Received: by 2002:adf:e58d:: with SMTP id l13mr36464861wrm.135.1576599066777; 
 Tue, 17 Dec 2019 08:11:06 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id t81sm3521182wmg.6.2019.12.17.08.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 08:11:06 -0800 (PST)
Subject: Re: [PATCH] target/arm: Display helpful message when hflags mismatch
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20191209134552.27733-1-philmd@redhat.com>
 <CAFXwXrmi=AqO9djosRt7vEGm5XDmnBt7KhHn9AQAWbVPLp+QkA@mail.gmail.com>
 <CAFEAcA9cOr03j9H1Z7YPyFKDViG5hS2mv4ATnWWWoWoKa9fb5Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <34ff9b70-8779-e0fa-abb3-89f99df93975@redhat.com>
Date: Tue, 17 Dec 2019 17:11:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9cOr03j9H1Z7YPyFKDViG5hS2mv4ATnWWWoWoKa9fb5Q@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: Qvz6TwYONJybL6RYlcEqOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 5:08 PM, Peter Maydell wrote:
> On Tue, 17 Dec 2019 at 16:02, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On Mon, 9 Dec 2019 at 03:46, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>>
>>> Instead of crashing in a confuse way, give some hint to the user
>>> about why we aborted. He might report the issue without having
>>> to use a debugger.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>   target/arm/helper.c | 18 +++++++++++++++---
>>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
>=20
>=20
> Applied to target-arm.next, thanks.

Thanks, you can also add (from a different thread):
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>


