Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885C3C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E94E24679
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKeXFWHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E94E24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ishYt-0002VM-HQ
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 01:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ishXf-0001ib-5g
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ishXd-0003nR-IL
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:25:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55238
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ishXd-0003mr-Es
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579328704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Z1/qEkZsvqSAp8PFWltEZbz1bYLXdIWTuZZIzaQj4g=;
 b=jKeXFWHTp0Dh3CSIsxvgeZco1enMoY1mseR1MrViHnNgCpwBSlNAKhkXeI0YbZa3xcvwQ3
 SuAKADvX13vW2FjMRtTVIcX7kLVqEJsmClNdAfCSRnx2FNMqQ54PPPF4oF4KRmivjo9++5
 RKc3tLZDUsWrdKfS+PsTfgIpEWWb5oE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-wKCb5NCAP9CizIY1BfD_Cw-1; Sat, 18 Jan 2020 01:25:01 -0500
Received: by mail-wr1-f70.google.com with SMTP id u18so11381913wrn.11
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 22:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UjMU5xyxheR+enjE2UALUKM8EJmOAmwuDV+5pYbtNC4=;
 b=Znw2kYt/Pm18tbYpoP8/nhdRh11FKoqQoCjz+HAv1YZgN8VzVX+eVT5TjWn4JKancK
 5ZtzrvcqsIwcCqCQnPwOED7yG8DVmvCf6NnFq1eCUEsdoGTtGrpJIoxpRUmmtENWRJ5s
 muXKN4WQvHuaAKTl9J78sKO5OvA5AiB3JeM/DqJDaKxS75xCZAQivcjMxUA94S92YY54
 tlO2iNkMWl0e34gN32eyAK0X6U9HaipKXCKnBabDEqe5wHGetZUT6OspvnURpW1M9Q/0
 7V6Fh3cH1MegD+GXdayedt8LT93VF/+f3Ixw+cMiCGlZE9QObNjb4m8mcpPRPiDoMDp3
 hFhQ==
X-Gm-Message-State: APjAAAXXVGZxJ4IItsIE6x/aOkDiu/8LDACwPN6XX8Ii4Cybj6LG+G3C
 js7rfdvTn/+LbSqwkQYkFqOi0Np1j3MV2RZTdae3i8ArjOPidbtVuJ33zkVHCYFzJAjwNrXKNup
 qS3OGyXDeyUY2BeE=
X-Received: by 2002:adf:fa43:: with SMTP id y3mr6862411wrr.65.1579328700188;
 Fri, 17 Jan 2020 22:25:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqyoVMoRNcQ7UT0+4XsT4HbwqHsDaxneiuhvIDgy6mwuPTswaklmHFpgCLEwXFvQ60ogPzDvJA==
X-Received: by 2002:adf:fa43:: with SMTP id y3mr6862397wrr.65.1579328699974;
 Fri, 17 Jan 2020 22:24:59 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id u8sm12972924wmm.15.2020.01.17.22.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 22:24:59 -0800 (PST)
Subject: Re: [PATCH v1] vnc: fix VNC artifacts
To: Cameron Esfahani <dirty@apple.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200117074530.mt2upbm7y5knyj7j@sirius.home.kraxel.org>
 <C23889A4-CD29-4B95-9D43-DA6FB7C179C0@apple.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2ab27da6-3ea7-d775-61d0-377c4efc8a59@redhat.com>
Date: Sat, 18 Jan 2020 07:24:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <C23889A4-CD29-4B95-9D43-DA6FB7C179C0@apple.com>
Content-Language: en-US
X-MC-Unique: wKCb5NCAP9CizIY1BfD_Cw-1
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 10:43 PM, Cameron Esfahani via wrote:
> I=E2=80=99m new to this process, what are the next steps?

Assuming your patch is in a branch named vncfix_v1:

1/ Start new branch based on the commit previous to your patch:

   - git checkout -b vncfix_v2 vncfix_v1~

2/ Revert the offending patch, explain in commit description why:

   - git revert de3f7de7f4e257

3/ Apply the rest of your patch on top, git-cherry-pick is smart to=20
directly use the diff context. Verify the patch is correct and rewrite=20
the commit description:

   - git cherry-pick vncfix_v1

4/ Send the 2 patches as a series to the mailing list

>=20
> Cameron Esfahani
> dirty@apple.com
>=20
>> On Jan 16, 2020, at 11:47 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>> =EF=BB=BFOn Thu, Jan 16, 2020 at 07:50:58PM -0800, Cameron Esfahani wrot=
e:
>>> Remove VNC optimization to reencode framebuffer update as raw if it's
>>> smaller than the default encoding.  QEMU's implementation was naive and
>>> didn't account for the ZLIB z_stream mutating with each compression.  J=
ust
>>> saving and restoring the output buffer offset wasn't sufficient to "rew=
ind"
>>> the previous encoding.  Considering that ZRLE is never larger than raw =
and
>>> even though ZLIB can occasionally be fractionally larger than raw, the
>>> overhead of implementing this optimization correctly isn't worth it.
>>
>> So just revert de3f7de7f4e257 then ...
>>
>>> In my investigation, ZRLE always compresses better than ZLIB so
>>> prioritize ZRLE over ZLIB, even if the client hints that ZLIB is
>>> preferred.
>>
>> ... and make this a separate patch?
>>
>> cheers,
>>   Gerd
>>
>>
>=20


