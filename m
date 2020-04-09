Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC851C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A6C206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5BrdMTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A6C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbIZ-00041k-MM
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMbHq-0003YN-Dn
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMbHp-0002bA-BI
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:48:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55630
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMbHp-0002af-83
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586454500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UF5iOW1gw/0ZTmMM8cvxO1bY6Vmj1yIOnrgG8K2pGfM=;
 b=P5BrdMTzoHzdi1Hj2QCGvBT0N4gQqnl3TE4Lo87QbdOOa0H7Q/TxO2s+MpmFFgnE+W7/kj
 Fih3qZcRVZ2LQgf5vkI1OH6iBUKVWN6vb0sW/2Iy+dy8wsu8zr3/ES5u70uMUAMSMsLJYT
 cfZ+dmFvc+OZSmVJqgA9wrhDGafwvG0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-s8uLxwgcPmSxHkz0U7GygA-1; Thu, 09 Apr 2020 13:48:17 -0400
X-MC-Unique: s8uLxwgcPmSxHkz0U7GygA-1
Received: by mail-ed1-f72.google.com with SMTP id g7so640336edm.20
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 10:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cZwEhRRgs9uWB6Km7R7GBSMFB78dEUiDzU10j7vY5xw=;
 b=EaRoVw3/KNBm851KfDNoH1b2lWlzr7eNE1L6c6m9lTqEOIxjQU6dhttBl5GU0kVem8
 SNzJvdLX56jHte1bTnZ+dWyPzU2HP6JfhCoLjh1AB2+4J83MFCjklNUlyng2T2XfLtz3
 4m8LqB80wOv8q2Myb9MJp2gDeFDxtyhHNA/wgjV7p+1/rRHCbKhJMlrdTOoMwKUwz/jD
 6vOJXgefQXyhJv8gfSB8HuLR5tX/p1UyBbRpyBjZjlbzHlPWRGeocG0/A1WBs/bfIkaP
 VASfmrRw/TKMAjUfBkCTQajBzNu3+s/G7CFHwekkyTPR4gFfJDR/C7G3nMoNhTQ4HP7C
 IoqA==
X-Gm-Message-State: AGi0PublVR50vs7sQr1EkRNB9r/SYe0zyx6yWtsCuhCQCm/1UUa/Hd/B
 WVy3gLcCdCCJ1NgbULXUhyTopAgQFq2E9ca8vLPJiqq36OhbZUREyo0M61YglGAMrzq0AlmBIhp
 tzZlUl0iBKqN2Im8=
X-Received: by 2002:a05:6402:2067:: with SMTP id
 bd7mr1263261edb.174.1586454496090; 
 Thu, 09 Apr 2020 10:48:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypJvNuLKBhWslHOk9zedLnRH8+60U9V7SkYPVtsPLGrdpDJELHIO1Pvrk4E3XTDfam2gh7oTVw==
X-Received: by 2002:a05:6402:2067:: with SMTP id
 bd7mr1263243edb.174.1586454495881; 
 Thu, 09 Apr 2020 10:48:15 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id m18sm3050684eda.14.2020.04.09.10.48.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2020 10:48:15 -0700 (PDT)
Subject: Re: [PATCH RESEND 0/3] travis-ci: Improve OSX coverage
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
References: <20200218142018.7224-1-philmd@redhat.com>
 <b97d2a79-bb0b-02b9-13a8-b45bc7475442@redhat.com>
Message-ID: <4fb06f80-265d-0af9-9da2-e8bd157b2127@redhat.com>
Date: Thu, 9 Apr 2020 19:48:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b97d2a79-bb0b-02b9-13a8-b45bc7475442@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 10:18 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/18/20 3:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Add more packages on the Mojave OSX job (Xcode 10),
>> and duplicate the job to build on Catalina (Xcode 11).
>=20
> ping?

Ping for patches 1 + 2 (extend OSX coverage)?

>=20
>>
>> Each job takes ~34min:
>> https://travis-ci.org/philmd/qemu/builds/651473221
>>
>> Philippe Mathieu-Daud=C3=A9 (3):
>> =C2=A0=C2=A0 .travis.yml: Expand OSX code coverage
>> =C2=A0=C2=A0 .travis.yml: Build with ncurses on OSX
>> =C2=A0=C2=A0 .travis.yml: Test building with Xcode 11.3
>>
>> =C2=A0 .travis.yml | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
>> =C2=A0 1 file changed, 46 insertions(+), 2 deletions(-)
>>


