Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A9CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC97D20758
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNyiXNOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC97D20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbNbt-0000xm-Sm
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 08:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbNbH-0000X3-Aj
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:13:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39263
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbNbG-0003rE-1X
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589976808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rPzBdNoG9LIhErbR3sEy5VBmmesGhnsx6mNlqF/mK/M=;
 b=KNyiXNOcW247ERJ8CgMUQZagHs+X7h0nYWRlXyp60KfNFBBOdVJJXjajN3nefeyJanwtrr
 Fd/GSXXY0PInSJw4pA2zWhMrKPWIvIxzt0TS0QcXmcorXJeSQfcRvffr9N11k7x+mDQ5qr
 h5slsnIsXU5/CSeEQXHKyk2D/mo+suo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-yjd9nDKVNTaUxBTeggrWHQ-1; Wed, 20 May 2020 08:13:26 -0400
X-MC-Unique: yjd9nDKVNTaUxBTeggrWHQ-1
Received: by mail-wr1-f69.google.com with SMTP id h12so1315155wrr.19
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 05:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rPzBdNoG9LIhErbR3sEy5VBmmesGhnsx6mNlqF/mK/M=;
 b=moHa94vT/DMvCWryXnyWqkEXjLOGkoP4/+9Fn5P5UZWXFbAwih4wRmvDx8ENxcCksh
 HLLiYHRBUgMnuupQNt4993JIzMBJNukg+8K7mKIU9CPd4iZ1ZBsQMHU87sI2YMWoHrVP
 jl55cV5G9mKeNHjC+DcA1c5F11tFa+GidjoGyKMzufIBInr93MRq1oh6I01kITbUwBsQ
 00zHm18iMQyhLwuL8YzFYYL9R4e5uR5g/Q6/WHsNOQY6GEuNuCjXc8UDiUXDNnHjjXjC
 oYvewKepG8LxorSHkCxbuf0tH7xaLa5qt76MjvJ0XpgNGEF4HADrFOzg1Kxogpr/swPV
 trlQ==
X-Gm-Message-State: AOAM531cOWLiDeL/Ojd4zkQXT4rgK8iH3hj++XPQr79tD7nBV7XN3NKg
 /0m9NVWOWQG0vOUDYuLNjx0ae4ImUIcBKp0Miz+uUCmM++hU2XGpvJ/fTmox5T907e2I5rpn3tl
 pqA4q6EQfAhkQS+k=
X-Received: by 2002:adf:a1c8:: with SMTP id v8mr3864102wrv.79.1589976805584;
 Wed, 20 May 2020 05:13:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnYoXvWuOI/07reazqsNJVQKiCVFsjdfI2ZkFPKAEVSTuT4CkJvKeBPDrzPYgS5ljpbmHeTQ==
X-Received: by 2002:adf:a1c8:: with SMTP id v8mr3864087wrv.79.1589976805383;
 Wed, 20 May 2020 05:13:25 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 94sm2752483wrf.74.2020.05.20.05.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 05:13:24 -0700 (PDT)
Subject: Re: [PATCH not-for-merge 0/5] Instrumentation for "Fixes around
 device realization"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200518051945.8621-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <60a1b3d3-354f-ab11-31f4-dbbbbf8a9270@redhat.com>
Date: Wed, 20 May 2020 14:13:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518051945.8621-1-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 7:19 AM, Markus Armbruster wrote:
> This is the instrumentation mentioned in "[PATCH 00/24] Fixes around
> device realization".
> 
> PATCH 2/5 might have value on its own.  You tell me.

I'd like to have 2/3 merged normally because as you described, having 
reproducible output makes testing simpler. Can you repost them with 
proper syntax/style?

I have similar hacks than 1/4/5.
What about having the warnings always displayed with warn_report() while 
running QTests? Simply checking qtest_enabled().

> 
> Shell script to smoke-test all machines:
> 
> #!/bin/sh
> success=0
> fail=0
> ulimit -c 0
> git-describe --dirty --match v\*
> git-log --oneline -1
> for i in bld/*-softmmu
> do
>      t=${i%-softmmu}
>      t=${t##*/}
>      q=$i/qemu-system-$t
>      echo "= $t ="
> 
>      for m in `$q -M help | sed -n '/(alias of/d;2,$s/ .*//p'`
>      do
> 	echo "== $m =="
> 	echo -e 'info qom-tree\ninfo qtree\nq' | $q -S -accel qtest -display none -L smoke-mon-roms -M $m -monitor stdio
> 	if [ $? -eq 0 ]
> 	then echo "*** Success: $m ***"; let success++
> 	else echo "*** Fail: $m"; let fail++
> 	fi
>      done
> done
> echo $success succeeded, $fail failed
> 
> 
> Markus Armbruster (5):
>    qom: Instrument to detect missed realize
>    qom: Make "info qom-tree" show children sorted
>    qdev: Make "info qtree" show child devices sorted by QOM path
>    qdev: Instrument to detect missed QOM parenting
>    qdev: Instrument to detect bus mismatch
> 
>   hw/core/qdev.c     | 17 ++++++++++++++++
>   qdev-monitor.c     | 32 ++++++++++++++++++++++++++++-
>   qom/qom-hmp-cmds.c | 51 +++++++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 98 insertions(+), 2 deletions(-)
> 


