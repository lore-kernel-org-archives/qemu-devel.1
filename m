Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38816C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7C621556
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hw6vI7FU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7C621556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8q9m-0005V3-VY
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8q8w-0004ye-4e
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:50:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8q8v-0001RF-4S
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:50:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60789
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8q8v-0001RA-12
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583175016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wv0Zh3X6MlzdzxJ8ZjfmlNNthA+g25ppMBxQfnNmSDE=;
 b=Hw6vI7FUnbdNcL/yE+LxbZKTUp/csdRW3nxujpIxeG3dkAfrKAn14Agv8Tze2bOk9VgywR
 ZXUrEdZC82Q9Bzzxw7llX6B6rPQreBPA2JOZp+npLOTyyW/+fbBPf470PqQniHcrUxwVRk
 fqGJ/0Rxc9L1ZZyPBo2q4WE+sZrObrU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-4BZ2sllrOvizl5rrylQSpg-1; Mon, 02 Mar 2020 13:50:12 -0500
X-MC-Unique: 4BZ2sllrOvizl5rrylQSpg-1
Received: by mail-wr1-f70.google.com with SMTP id d7so109493wrr.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a3+LvL2AOpAv3a3cHcuLvXbTMmyrF/QEvF9LigkcKCg=;
 b=GFsiDnPYNBt2n5Zu+MMmDiTicuGeIs4p8ZZFg++bhonq9cEIoYc07q2eHoAOAzJKCW
 VZB8e1/HByalQlcNSu3GNJJTdWkA8jSRfSvxQxSVSZikTi2XeJx0cfWHMMD03bo78WBq
 wf6AZIBp21TkawuZcPHg2nuY9wnyFWfpoIF4XQ2kGaTg/dluVWPZwHzbdmhmQNqUEwZR
 d6C5z0jGAfxYLUoNwpMT++oWnmkrM8cm5zIfx84kosMTJMnCp+QuBjtyG+j6idRKdPlN
 HLqpeSfAmKdAlBtB88UY4SCpcyN5kkwvJBDqSSbFHdAtqZc35/1hoE8Sp3DP3YIhQoMp
 6Xcw==
X-Gm-Message-State: ANhLgQ3MZfzyvSvPgWLFgWVrJ63PVtSh/ZCwiQL474HyhsiHVLMr35kV
 W2X2R3HOt4DcQR13xEundMHv28FcH63wyioc0KI2wp26hPVC1yG9Ea9+9eE3qTAdqRqnRq+IpiS
 qg8TqZWI8BXq87AY=
X-Received: by 2002:a5d:6503:: with SMTP id x3mr905854wru.241.1583175011568;
 Mon, 02 Mar 2020 10:50:11 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtgAFrLPtYxeaiH2R+GPxjJG0nahR2ppnUYwavjcy4a+I08fzCW12KYKzY4zEPkduREmx0Rsw==
X-Received: by 2002:a5d:6503:: with SMTP id x3mr905829wru.241.1583175011275;
 Mon, 02 Mar 2020 10:50:11 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id g25sm1086674wmh.3.2020.03.02.10.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 10:50:10 -0800 (PST)
Subject: Re: [PATCH v1 01/10] tests/vm: use $(PYTHON) consistently
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200302181907.32110-1-alex.bennee@linaro.org>
 <20200302181907.32110-2-alex.bennee@linaro.org>
 <2f430da1-6429-746c-92e0-58b1fed5ffcb@redhat.com> <877e028ur2.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6a629127-b5a9-6be0-384e-08085056d795@redhat.com>
Date: Mon, 2 Mar 2020 19:50:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <877e028ur2.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 qemu-devel@nongnu.org, Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 7:41 PM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> On 3/2/20 7:18 PM, Alex Benn=C3=A9e wrote:
>>> From: Robert Foley <robert.foley@linaro.org>
>>> Change Makefile.include to use $(PYTHON) so for vm-boot-ssh to be
>>> consistent with other cases like vm-build.
>>
>> So what you are trying to fix here is when you have two python3
>> installed (one from the distribution and one manually built), and you
>> want to use the manually built?
>=20
> No - just consistency with the rest of the build system.

This patch was first posted on 2/5/20 but it shouldn't be necessary since:

commit c88ee46cdb9888fbe9ea45c174743d6f7544b737
Date:   Thu Jan 30 17:32:24 2020 +0100

     tests: Explicit usage of Python 3

     Use the program search path to find the Python 3 interpreter.

Anyway consistency is good:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
>>
>>> Signed-off-by: Robert Foley <robert.foley@linaro.org>
>>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Message-Id: <20200219163537.22098-2-robert.foley@linaro.org>
>>> ---
>>>    tests/vm/Makefile.include | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
>>> index 9e7c46a4735..778e5067554 100644
>>> --- a/tests/vm/Makefile.include
>>> +++ b/tests/vm/Makefile.include
>>> @@ -80,7 +80,7 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
>>>      vm-boot-ssh-%: $(IMAGES_DIR)/%.img
>>>    =09$(call quiet-command, \
>>> -=09=09$(SRC_PATH)/tests/vm/$* \
>>> +=09=09$(PYTHON) $(SRC_PATH)/tests/vm/$* \
>>>    =09=09$(if $(J),--jobs $(J)) \
>>>    =09=09--image "$<" \
>>>    =09=09--interactive \
>>>
>=20
>=20


