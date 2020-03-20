Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5CCC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C9B20739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vot33jSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C9B20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFEev-0006bd-B8
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFEeI-00068o-KX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFEeH-00065o-B7
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:13:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFEeH-00062j-7a
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584699184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Ox8NyD7+S5jv3R8kB1mKYRrCj5Ao3ik/YHO+wX9Yi0=;
 b=Vot33jSotmJkwrsfGhn/kL3sUFAIafw3nP08tCY1xYVzkuHk6j5dQL1L1t/C87XcGdFExl
 0/SE5mgKd/1ZIlnveYpu5xCscBgCI02XxqfcUbF2pIfQBmT72Byz6FFiXh1y9Dz1BXl73O
 aeQBhw71qejj410pz53/Uz1fUPzC4ms=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-NSVw9WjfMGOHXYko6_MZdw-1; Fri, 20 Mar 2020 06:13:00 -0400
X-MC-Unique: NSVw9WjfMGOHXYko6_MZdw-1
Received: by mail-ed1-f71.google.com with SMTP id a32so4605206edf.17
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 03:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wU0X9XHMwx6I/yWM497g+uA26l5Ld3talr+tKqoIVPE=;
 b=eB45THFBdri7OFr/PwVLNm+enIrGQk/6UqVCvL/+iZFoDexOUws5ZIaJF86V+6JV3G
 R5BFKAledmwK54eIlSv57sTh6EY9jjTyf2mTXJjcnV4ylECMSAf5QdWbXZzcDACLTjXE
 UG+2uzlhcXI8fbzcemBeJlK+iHr3hmv67T+28UxyQnAjdjmvKkdMPXFhXveMqLm0u+3N
 pLRB1hpN1sQza7IbUFfGhqK3AyAuqctr2ZjAeuS5uZ2EmrvdWgXP429acyRjJDtaLX5J
 CLOHkcu6wM4ZdyW221SROAgBdOteFqVJEndmYkbC/BzYn2tI7EmcQNKI3rCfA1TYc9UZ
 dLBQ==
X-Gm-Message-State: ANhLgQ0cTbL6hhPV0EMwlN9BRJM8+jXrawi+C+jlhxGvBYjzBb3zUwZW
 JSadPgsxuY2v6Uoo0q6LLgimowZ9wva4y3wIU2VPVbKw2g23L/1pPdE3cwbY219fvAa1iGYFTH/
 4PND6xEWh7wwMSsw=
X-Received: by 2002:aa7:d3d7:: with SMTP id o23mr7112523edr.330.1584699179569; 
 Fri, 20 Mar 2020 03:12:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv3PQ2nfAlYyh7chd+sd+bFkTBLU5AECodHRKY8M45xr17GlV8eUs1ve+SeEf4EgFIZG52LcA==
X-Received: by 2002:aa7:d3d7:: with SMTP id o23mr7112503edr.330.1584699179297; 
 Fri, 20 Mar 2020 03:12:59 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id s2sm62541edx.18.2020.03.20.03.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 03:12:58 -0700 (PDT)
Subject: Re: [PATCH 0/3] iotests: Fix intermittent 030 hang
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200313083617.8326-1-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9cc2f46f-9398-c244-b8e5-e7c2509adc26@redhat.com>
Date: Fri, 20 Mar 2020 11:12:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313083617.8326-1-kwolf@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 9:36 AM, Kevin Wolf wrote:
> Peter ran into a 030 hang while testing a pull request. This turned out
> to be two bugs in the test suite at once: First was the test failing
> because a timeout was apparently too short, second was that the timeout
> would actually cause the test to hang instead of failing. This series
> should fix both.
>=20
> Kevin Wolf (3):
>    iotests.py: Enable faulthandler
>    python/qemu: Kill QEMU process if 'quit' doesn't work
>    iotests: Increase pause_wait() timeout
>=20
>   python/qemu/machine.py        | 1 +
>   tests/qemu-iotests/iotests.py | 5 ++++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


