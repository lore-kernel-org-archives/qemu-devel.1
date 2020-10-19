Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BE1C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C856321741
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kp5MxjrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C856321741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUYnS-0002XY-Ks
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 13:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUYlh-0000tX-Ja
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUYlb-0003Gx-1W
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603127772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8kfedeknWc3Gl9wEFSgf7H+jeWSR9nYp3f9Nu1nsOc=;
 b=Kp5MxjrXH9mcJAtZY9MJHNbkEljNR+UiPJN/nl2ODkP1tS6+BJ24f6frUQkUbmYwd/5KGw
 +AlGuhjXhOlWrp8kjJwaBG1gwrWOGNQNiRdtLHCHt+9JdkIB5V0fMaXbKM4qQQxn7bI7jK
 4/KMAHyJP52GQ+RD4wobPSh3SHM+how=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-WFCYhSpkNw63EUh0u1CXMg-1; Mon, 19 Oct 2020 13:14:04 -0400
X-MC-Unique: WFCYhSpkNw63EUh0u1CXMg-1
Received: by mail-wr1-f69.google.com with SMTP id x16so132336wrg.7
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 10:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w8kfedeknWc3Gl9wEFSgf7H+jeWSR9nYp3f9Nu1nsOc=;
 b=ab7FEl29lIjv2qNZqgzfplRcxfEU9f/cbWLd/qtcRBMvn3Q1Lu1xi9Vlfnry6O5Hp/
 yp8tnIz6AMxh2zaFdaFcnuIWEY1KMw7cG+itWkMoyji5YgnFoC9N4qJXWVvqJpSncysi
 IyZDozCMvzFYIkkpADPK9R+hRAlQmHI6H5G6wANSODDIibqZq9573rMI0zbVg/ucJh8w
 bO0uoKfK3ZA7qFEWLIENgHzi3leRkDUrnAY4snU/Vesail3xxGVdUWXNAgx51iykZyNX
 YhLbZx2elLvr37dR911ZxCCMmnbiHfwPQgwoPtaFrPj6mI99HzzcX0paOHVONRVtGe4Y
 hJ7w==
X-Gm-Message-State: AOAM531eXuC+SvOp5qE51hY7A19kYdDXEVbQLg+5jWZjHgqd2DoNCJkJ
 8GiXNCea3s9FxyJTCdaNtl+tx11LHctNDp8pQndIBADCO8yQi5zlxiDO94ZLFPCvnLDDMLWzU8c
 /NsIyV2c98nGF+Zg=
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr240702wrh.213.1603127643456; 
 Mon, 19 Oct 2020 10:14:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJaETvGmSSvK5d65w2S+BINQMegPr+7AW/V5IJurcyphxuvZ26od/9FlsjPeCFjTe2emV9tw==
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr240681wrh.213.1603127643212; 
 Mon, 19 Oct 2020 10:14:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id u202sm253366wmu.23.2020.10.19.10.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 10:14:02 -0700 (PDT)
To: Emmanuel Blot <eblot.ml@gmail.com>, QEMU <qemu-devel@nongnu.org>
References: <24B952F3-465C-4AB2-AF28-6CA4722D94B7@gmail.com>
 <3869557c-10a0-8f07-a59a-69120a522568@redhat.com>
 <AA504B32-5134-4CDD-8CDA-6F200C7376CF@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: ld: file not found: _PreallocMode_lookup on macOS Catalina
Message-ID: <1cdb3e50-0dfb-3ddd-fed7-142e893fa364@redhat.com>
Date: Mon, 19 Oct 2020 19:14:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <AA504B32-5134-4CDD-8CDA-6F200C7376CF@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/20 18:40, Emmanuel Blot wrote:
> On 19 Oct 2020, at 17:50, Philippe Mathieu-Daudé wrote:
> 
>> Cc'ing Markus/John/Paolo
> 
> I never used `git bisect` up to now, so I might be wronb but it seems
> the issue would have been introduced with the following commit:

Hi,

I think this could be the fix.  The problem would be that

	awk '$2=="U"{print "-Wl,-u," $1}'

used to filter away lines with only one token, while the
Python script does not.

diff --git a/scripts/undefsym.py b/scripts/undefsym.py
index 69a895cd26..4b6a72d95f 100644
--- a/scripts/undefsym.py
+++ b/scripts/undefsym.py
@@ -15,12 +15,11 @@ def filter_lines_set(stdout, from_staticlib):
     linesSet = set()
     for line in stdout.splitlines():
         tokens = line.split(b' ')
-        if len(tokens) >= 1:
-            if len(tokens) > 1:
-                if from_staticlib and tokens[1] == b'U':
-                    continue
-                if not from_staticlib and tokens[1] != b'U':
-                    continue
+        if len(tokens) >= 2:
+            if from_staticlib and tokens[1] == b'U':
+                continue
+            if not from_staticlib and tokens[1] != b'U':
+                continue
             new_line = b'-Wl,-u,' + tokens[0]
             if not new_line in linesSet:
                 linesSet.add(new_line)


If not, can you attach (or diff) the contents of block.syms and
qemu.syms before and after this commit?

Also please attach the output (on any commit) of "nm -P -g *.so".

Thanks,

Paolo

> 604f3e4e90c011a6b94fdc1d13700f3ec2375f2a is the first bad commit
> commit 604f3e4e90c011a6b94fdc1d13700f3ec2375f2a
> Author: Yonggang Luo <luoyonggang@gmail.com>
> Date:   Thu Sep 3 01:00:50 2020 +0800
> 
>     meson: Convert undefsym.sh to undefsym.py
> 
>     Shell scripts are not easily invoked from the build process
>     on MSYS, so convert undefsym.sh to a python script.
> 
>     Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>     Message-Id: <20200902170054.810-3-luoyonggang@gmail.com>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
>  meson.build         |  2 +-
>  scripts/undefsym.py | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  scripts/undefsym.sh | 20 --------------------
>  3 files changed, 50 insertions(+), 21 deletions(-)
>  create mode 100644 scripts/undefsym.py
>  delete mode 100755 scripts/undefsym.sh




