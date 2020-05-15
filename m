Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA28C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA282206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DP7p6yD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA282206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZVg8-0005bA-Ta
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZVfK-00050z-1I
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:25:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55898
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZVfI-0008BV-Kk
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589531155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oua+fjKyvtJ3bBX3LusnOPYXY1okTZXd7Hv5lXh1nMM=;
 b=DP7p6yD6YIAN5jw/PfTzCYW38LFAJ+Gd2f0gyEiOcCvVF1MEBKNhNwFY6Xcfj3pc6BDqpM
 RbaATtupnmbHKcWh/gukgFIvQDFopZfTXmKDe5TWHJ+RWl7xg5m+zpHN+WspWMsLMfISAU
 y6fBDLx2TWIQmZhzAEG2eJ/XYlOyYNU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-wVf-mb-zMnmz15qsgqPSKw-1; Fri, 15 May 2020 04:25:49 -0400
X-MC-Unique: wVf-mb-zMnmz15qsgqPSKw-1
Received: by mail-wr1-f72.google.com with SMTP id r7so805808wrc.13
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 01:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oua+fjKyvtJ3bBX3LusnOPYXY1okTZXd7Hv5lXh1nMM=;
 b=l0pFGotOetvz40jNO12/P1O/3ZFcV0rLNQe1e7v4HQu19NIUwoQ4z2NGT5yy1wo59g
 Fzu/w3rtmigy1JLf6ogKwWid9wCeRNOE0LI62lU3BG7CUM/tlBNVYESvz0Hee0e53zQK
 MgVea4SHesR0C5Rk4Bq9Y3nU47Hx7hCDdLJHKU80DsWtqgL480Uu2W8cKUgHlVlPUB1t
 ur9tJgiMFiTygeDZXh4NCMgDO8fz80mGlMXi/he1/EBaP174nYO/7o2gO6M9FaxmHJ5t
 o+1Zk45d4GMAUhEKxBhm9YZAnbWltp+sv6DYvKN4WzFn0Xnq+V+o4efsV9RnSXoxxAAx
 kNBA==
X-Gm-Message-State: AOAM532+Gl1roE/WRKfRMua1HCo29JPjdcYIjycT7rOJAYyPfxoQoz3d
 madqNyGu6s5byXjrzUYSm0AhLlwMLp9+9Dy+6P3EgP7+csDkXpL8idFmu4HxmfOsGnRgueXnaRC
 IAzT91tpOkACg2/w=
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr2701827wmb.123.1589531148558; 
 Fri, 15 May 2020 01:25:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmBBrCgc6+vox4aQYJBh1iibgOxI7vnnHUHHSk6z8u6B4AzSr/epSbVffkUm9DgONmUmLn/A==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr2701807wmb.123.1589531148336; 
 Fri, 15 May 2020 01:25:48 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q14sm2596285wrc.66.2020.05.15.01.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 01:25:47 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] Makefile: libfdt: build only the strict necessary
To: Claudio Fontana <cfontana@suse.de>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200514193811.6798-1-cfontana@suse.de>
 <be9d37e8-ea14-c42d-b8e6-405840e75b45@redhat.com>
 <37d6358a-2a3c-22d3-c998-fc7ff5255231@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <12b0bcd8-1a61-205c-fe5d-8ec92cb97724@redhat.com>
Date: Fri, 15 May 2020 10:25:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <37d6358a-2a3c-22d3-c998-fc7ff5255231@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 9:56 AM, Claudio Fontana wrote:
> On 5/15/20 9:50 AM, Philippe Mathieu-Daudé wrote:
>> Hi Claudio,
>>
>> On 5/14/20 9:38 PM, Claudio Fontana wrote:
>>> v3 -> v4: NB! only useful when updating to latest dtc (not in QEMU yet)
>>>
>>> * changed the approach to leverage new upstream dtc Makefile,
>>>     needs dtc submodule update to include upstream dtc commit
>>>     85e5d839847af54efab170f2b1331b2a6421e647.
>>
>> I don't have this commit locally:
>>
>> fatal: bad object 85e5d839847af54efab170f2b1331b2a6421e647
>>
>> My remote is https://git.qemu.org/git/dtc.git, might it be de-synchronized?
> 
> Hi Philippe, maybe that commit is not in the qemu dtc.git yet, only in David's tree at:
> 
> https://github.com/dgibson/dtc.git
> 
>>
>>>
>>> * LIBFDT_srcdir does not exist anymore in upstream dtc: it is also
>>>     not used anymore.
>>
>> Why not include the submodule update in the first patch?
> 
> Right, I am not sure how git.qemu.org/git/dtc.git is updated?
> 
> I guess once it is, I should include the submodule update.

OK. Maybe David want to make a libdtc release first, before to update 
QEMU submodule.

Meanwhile using David's remote, and the submodule update:

-- >8 --
diff --git a/dtc b/dtc
index 88f18909db..85e5d83984 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit 88f18909db731a627456f26d779445f84e449536
+Subproject commit 85e5d839847af54efab170f2b1331b2a6421e647
---

for the series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Thanks!
> 
> Claudio
> 
>>
>>>
>>> * LIBFDT_lib: need to avoid building libfdt.so at least for now, so pass as
>>>     empty to avoid building the .so. This is to avoid breaking existing
>>>     trees with objects already compiled without -fPIC.
>>>
>>> * clean: no need to make dtc clean target, every artifact is captured by
>>>     global clean rule
>>>
>>> v2 -> v3:
>>>
>>> * changed into a 2 patch series; in the second patch we remove the old
>>>     compatibility gunks that were meant for removal some time after 4.1.
>>>
>>> * renamed the libfdt PHONY rule to dtc/all, with the intent to make
>>>     existing working trees forward and backward compatible across the change.
>>>
>>> v1 -> v2:
>>>
>>> * fix error generated when running UNCHECKED_GOALS without prior configure,
>>>     for example during make docker-image-fedora. Without configure, DSOSUF is
>>>     empty, and the module pattern rule in rules.mak that uses this variable
>>>     can match too much; provide a default in the Makefile to avoid it.
>>>
>>> * only attempt to build the archive when there is a non-empty list of objects.
>>>     This could be done in general for the %.a: pattern in rules.mak, but maybe
>>>     there are valid reasons to build an empty .a?
>>>
>>> * removed some intermediate variables that did not add much value
>>>     (LIBFDT_srcdir, LIBFDT_archive)
>>>
>>> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src subdir),
>>> and with docker-image-fedora, docker-test-debug@fedora that failed before.
>>>
>>> Claudio Fontana (2):
>>>     Makefile: libfdt: build only the strict necessary
>>>     Makefile: remove old compatibility gunks
>>>
>>>    Makefile  | 32 ++++++++++++++++----------------
>>>    configure |  6 +-----
>>>    rules.mak |  2 ++
>>>    3 files changed, 19 insertions(+), 21 deletions(-)
>>>
>>
> 


