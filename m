Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5998DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E822186D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bgj4ZBbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E822186D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX9K5-0003Fo-0B
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 14:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iX9Iu-0002jr-W4
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iX9Iu-0005ZN-2f
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:36:48 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iX9It-0005Ys-Sb
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:36:48 -0500
Received: by mail-wr1-x444.google.com with SMTP id i12so25331490wro.5
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2+H0YNDemKRjXJDUgif6n4MIbtXp2KAsqOQ5L73ind8=;
 b=Bgj4ZBbk2VDulvdNEGgBj+hsB0sY4D/kZZ6pK0FNKznBag62CAha+80Gvk+UF372Ij
 pxwVLvOO4Kj0+DVDW0m0MDG5a6RbqhyWsLMAK4+EefyV4X5t8DjHNrcydMBWzWWIh+zE
 Mcw4Oo3Lyf39GumAcK+hFDxpPKBXvQUppk9V9gT/amllpSKMveOI2FSCttGySXSozMg1
 7wFMqzRn0/4wDn4t8nDrm3r1QDOCZhpQ8/h2ySXvbkN1HpClX15zEDVFhOYJHo2F0A+t
 /xlvqrnvmWKKYgNf+b+YkSTBNygtyzUqk06Wj82r+SfuaEh2J3sjqqY/m7tjEU2Idy9U
 CZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2+H0YNDemKRjXJDUgif6n4MIbtXp2KAsqOQ5L73ind8=;
 b=hdka6qHG+Yo1OxOr4K6XmcQxxkuMPLHiwCsEjRi7UNIF9qyXKC6kifJ22fTPsPEjyI
 b0WYWzYQIKe9m5k9lZiOzBZHKbFJcY1CiiCWZ/JJAXJ/4NseHLO75FjoUSaYWlGNtz+P
 bhcYLT9sVsAN8wwwigFyDbyIHUIIxStxq91D+TP1hvMGOnL6tHUu72fVfsg51lTB1DTq
 QDUfGCvhxEn8sOatAiEK7geBuXeUQFaENhf+M7XBhuPmQqFD023tTVc+whlP5Zi93Eiw
 DazgRIblco/qgFiVHXh81qhKl5tZKj/SBXmlR86PFJb9v6pLEccgwwtOPF4QIfAyGTId
 XkiQ==
X-Gm-Message-State: APjAAAVlhv0G3W1khqLhPlKla5MTPrB202MBuA+LJCl/9uK075oXKiqv
 5+GbOynohWPRKO/JonBzfqT0Smd/UftIIA==
X-Google-Smtp-Source: APXvYqybsWNh4BVFGbuL0q/26/W01kJx45q0BZmktZ2Erwr2MvURv075RXEf8RUqDP6gMMXsleExaw==
X-Received: by 2002:a5d:4589:: with SMTP id p9mr27077217wrq.61.1574192206317; 
 Tue, 19 Nov 2019 11:36:46 -0800 (PST)
Received: from [192.168.8.102] (64.red-79-149-204.dynamicip.rima-tde.net.
 [79.149.204.64])
 by smtp.gmail.com with ESMTPSA id 205sm5291652wmb.3.2019.11.19.11.36.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 11:36:45 -0800 (PST)
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Taylor Simpson <tsimpson@quicinc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <82dfa44e-0a27-080e-2653-b004c27fc3d1@linaro.org>
Date: Tue, 19 Nov 2019 20:36:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 6:22 PM, Taylor Simpson wrote:
> - Laurent suggested I split the patch into two parts: linux-user and target/hexagon.  If I do that, which one should contain the changes to common files (e.g., configure)?  Also, note that we won't be able to build until both patches are merged.  Is that OK?

The configure parts should be a third, last, patch.

The series is bisectable, because before the configure patch,
none of the hexagon code is compiled at all.


r~

