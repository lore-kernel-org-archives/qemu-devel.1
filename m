Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0E9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365B523431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQqEDW4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365B523431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59X1-00005g-DR
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 10:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i59OK-0001MA-Ef
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 10:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i59OJ-0008B8-1D
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 10:02:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i59OI-0008AQ-OQ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 10:02:38 -0400
Received: by mail-wr1-x435.google.com with SMTP id z11so17636806wrt.4
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Y/64MQ4aZG+Iy1hvG08sd+9VcypVY5uKq+szPuHt2qc=;
 b=uQqEDW4v1MqKHuODY0ZAJZqYE7Zbcas7NFMgd774SmnC21IdloE4KL53PBq7rYJTOq
 5a73ReRzOXN0pZzCw/CwuIiYu+IKpfQd87EqvntqDLn2zc8ASPbBWQE5duzlRF8bUhog
 x7C8FyiCR7U1MpddK6y4nLA7mu61yy/9KYarXjULWvPF0I5ZKPeMeOlydvPoz8NFujFe
 U/xhOAXBb5sZgAYqZHNXe76/zUDmR9vJlnucGvk1SXrJV29Z+OzpdMuhSblG9Fw83Qq1
 yL5xBHLwFusd+QwfvvrkH34hxmJ8Ovdmm1wnEREskXAY0YC8HxaCV+9NgOQvXvA70EtX
 cFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Y/64MQ4aZG+Iy1hvG08sd+9VcypVY5uKq+szPuHt2qc=;
 b=fer/yyeN1tRXc7oQ/zXoodzMIXQ76x/XPGPreU4iDjnHXoajcrduxTp5mJoo7sgSUc
 RgihJ32aePlYUk/K8h69ikOaduhxofxrQ8tF6iLgHmC+4IyCSBjc09RnV8E9zbwW4d65
 G+cbZIaVW2uhCcRRrZ6RI8bUYtfw2LpU20qemPRD6ILyhoeKlHldAQbJTiEB2nVHg0z7
 w+uS8alJlJRLZt5mjNMaKFq6znlGbVK/5+W4tbXgwa/646s/gDR7gPngVrfT4JjlI1eL
 KYl7zy55M1rmpd9cNiA3w8kbvvmoiVjRhNf78K7cW2GPBfjLanViyeS+9tgUaiBhQxJv
 qyVg==
X-Gm-Message-State: APjAAAVjEa4CYKpt/Ol2c+lSPgXnmodQKl4xckfAkaJBiTcA8BHYBHsu
 9l+bEeqaSkT1t8qEEXMO8B0N5A==
X-Google-Smtp-Source: APXvYqzRuufGU8EHDM7jKoYkKsnHTfml2krXA5Fl4p4k0Anx+N4Og+YTDBWHNm+yaOQlHv/ZVEUy3w==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr37079525wrw.18.1567519357117; 
 Tue, 03 Sep 2019 07:02:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t13sm18020993wra.70.2019.09.03.07.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 07:02:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 991F71FF87;
 Tue,  3 Sep 2019 15:02:35 +0100 (BST)
References: <20190822134725.32479-1-marcandre.lureau@redhat.com>
 <20190822134725.32479-3-marcandre.lureau@redhat.com>
 <06c4e9a3-9c40-89a5-ce64-4f8dc8c3adc0@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <06c4e9a3-9c40-89a5-ce64-4f8dc8c3adc0@redhat.com>
Date: Tue, 03 Sep 2019 15:02:35 +0100
Message-ID: <87ef0x7a10.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: Re: [Qemu-devel] [PULL 2/6] docker.py: add podman support
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
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P?= =?utf-8?Q?=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/22/19 3:47 PM, Marc-Andr=C3=A9 Lureau wrote:
>> Add a --engine option to select either docker, podman or auto.
>>
>> Among other advantages, podman allows to run rootless & daemonless
>> containers, fortunately sharing compatible CLI with docker.
>>
>> With current podman, we have to use a uidmap trick in order to be able
>> to rw-share the ccache directory with the container user.
>>
>> With a user 1000, the default mapping is:                               =
                                                                           =
                                                               1000 (host) =
-> 0 (container).
>> So write access to /var/tmp/ccache ends will end with permission
>> denied error.
>>
>> With "--uidmap 1000:0:1 --uidmap 0:1:1000", the mapping is:
>> 1000 (host) -> 0 (container, 1st namespace) -> 1000 (container, 2nd name=
space).
>> (the rest is mumbo jumbo to avoid holes in the range of UIDs)
>>
>> A future podman version may have an option such as --userns-keep-uid.
>> Thanks to Debarshi Ray <rishi@redhat.com> for the help!
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>  tests/docker/docker.py | 48 +++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 43 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index f15545aeea..ac5baab4ca 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -20,6 +20,7 @@ import hashlib
>>  import atexit
>>  import uuid
>>  import argparse
>> +import enum
>
> This broke Shippable:
> https://app.shippable.com/github/qemu/qemu/runs/1897/summary/console

The patch to fix it is in my PR although there are more fixes for the
fall-out coming in a new series.

--
Alex Benn=C3=A9e

