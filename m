Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D7CC11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0038120722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="be5RHki5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0038120722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4sIW-0002ON-7V
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 15:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dme@dme.org>) id 1j4sHZ-0001rd-V4
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dme@dme.org>) id 1j4sHY-00017p-NH
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:18:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dme@dme.org>) id 1j4sHY-00016M-Ag
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:18:48 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so3452155wma.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 12:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=clJiy4f+PN1aRd+JCRXqGiKzTDP7FtRd87H2U3PgZ0U=;
 b=be5RHki5mhkco46zRZI5LpOdWkUBYxrI3wG4Qnmcs6kjnYeVOsu2v8OwrYcnG6mTmN
 oTKcAZPf30RMYBfIpxNhfk+Bta3xb5Q+b2L5PrhR2TiHRbVbLbIS6D1LKFIS5UwqlJLC
 QIGwfCnK2jKMbrI7s9OYONjMTaZvD9Gt1uQ3A8uJXDXcy7/n12i0/9vDPSekClceoefz
 Lovnfd0hMakMe5zWRe8T9zxRHNbKe8qqcCo1ld0j285aZNsZWW30CAs1c7mJG0qqIzMz
 BP5pmE/kA9lPUxHNhsoibRFFAEZKyowfJWRpJ3QkPb3aXxBy7RRf47FzpQg4MkmclfkS
 nWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=clJiy4f+PN1aRd+JCRXqGiKzTDP7FtRd87H2U3PgZ0U=;
 b=rRYBTVuEcz82qIOZNOVB0uqVIpoysfID+1gHA0mQtyfjkfwjQDOxCxEwKa1JLOjZzm
 dzxIB5mBl0RzYoxwcuQDctv7u/wHPtAyCjAjICHB1Qu3MI8WHXuGmut4QM+dgyPeo8Nj
 rpEBS4/jBt3vn5unRpZth3Dbil7jZ8f7+q0blfZKgtEKNfrpUIizjiH5SBzbt5jnRFkz
 JLnZN63f+2zVga88oEIpHKA/ObtPk9PsTOyVLIgowCTjsUtBA7x12E0ZSFbhrYE7sTE5
 UvVOicKdECJjR8+1Ff8rHKqj6Oqj/JrOWtdft7A7uIe4fYJR9XrVXAtS7iML/TZkWjBA
 WQFA==
X-Gm-Message-State: APjAAAXo/xfH5bFGs+FpPHIyyXa8+50SeEDqlbknOLVotROw7eqmbRE3
 Qmh56V07YR5QvDRFq3Uz1J3X9w==
X-Google-Smtp-Source: APXvYqyOBF/iwwb+wW0ONl4LrEbo0Y2McAzAWx7CGmC05Z1x8SGv+mZPsC+TswoKqPwl0eV8ulBuJQ==
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr6364935wme.56.1582229926730; 
 Thu, 20 Feb 2020 12:18:46 -0800 (PST)
Received: from disaster-area.hh.sledj.net
 (1.0.0.0.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::1])
 by smtp.gmail.com with ESMTPSA id m9sm850766wrx.55.2020.02.20.12.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 12:18:45 -0800 (PST)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 0fdb7f71;
 Thu, 20 Feb 2020 20:18:44 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PULL 06/18] qemu-img: Add --target-is-zero to convert
In-Reply-To: <2c912ba1-998c-9ddb-55a4-c2ea1bb57edd@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
 <20200220160710.533297-7-mreitz@redhat.com>
 <2c912ba1-998c-9ddb-55a4-c2ea1bb57edd@redhat.com>
X-HGTTG: disaster-area
From: David Edmondson <dme@dme.org>
Date: Thu, 20 Feb 2020 20:18:44 +0000
Message-ID: <cunh7zlm2qj.fsf@disaster-area.hh.sledj.net>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, 2020-02-20 at 10:36:04 -06, Eric Blake wrote:

> On 2/20/20 10:06 AM, Max Reitz wrote:
>> From: David Edmondson <david.edmondson@oracle.com>
>> 
>> In many cases the target of a convert operation is a newly provisioned
>> target that the user knows is blank (reads as zero). In this situation
>> there is no requirement for qemu-img to wastefully zero out the entire
>> device.
>> 
>> Add a new option, --target-is-zero, allowing the user to indicate that
>> an existing target device will return zeros for all reads.
>> 
>> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
>> Message-Id: <20200205110248.2009589-2-david.edmondson@oracle.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   docs/interop/qemu-img.rst |  9 ++++++++-
>>   qemu-img-cmds.hx          |  4 ++--
>>   qemu-img.c                | 26 +++++++++++++++++++++++---
>>   3 files changed, 33 insertions(+), 6 deletions(-)
>> 
>> diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
>> index 42e4451db4..5f40137c10 100644
>> --- a/docs/interop/qemu-img.rst
>> +++ b/docs/interop/qemu-img.rst
>> @@ -214,6 +214,13 @@ Parameters to convert subcommand:
>>     will still be printed.  Areas that cannot be read from the source will be
>>     treated as containing only zeroes.
>>   
>> +.. option:: --target-is-zero
>> +
>> +  Assume that reading the destination image will always return
>> +  zeros. This parameter is mutually exclusive with a destination image
>
> Late tweak now that this is in a pull request, so we may want a followup 
> patch, but:
>
> The image doesn't always return zeros after we write to it, maybe we 
> should tweak this sentence:
>
> Assume that reading the destination image will initially return all zeros.

I will send a patch for this.

> Also, my earlier comment about 'zeroes' one line before 'zeros' still 
> applies - although both spellings are valid, we look inconsistent when 
> we can't make up our mind within two adjacent paragraphs.

If we can agree on one of "zeros" or "zeroes" then I'm happy to send a
patch making it consistent everywhere.

I think that given there are existing functions with "zeroes" in the
name, I'd be inclined to go that way.

dme.
-- 
Why stay in college? Why go to night school?

