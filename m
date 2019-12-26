Return-Path: <SRS0=LSdK=2Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C174BC2D0DA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 18:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9257120740
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 18:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pj/qRwEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9257120740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikXWE-0001Gt-Jt
	for qemu-devel@archiver.kernel.org; Thu, 26 Dec 2019 13:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ikXVb-0000nz-O8
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 13:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ikXVY-0006Or-Uj
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 13:05:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36372
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ikXVY-0006Oa-Pp
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 13:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577383511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C8xcEt4HJzv2LOkIezdcLMmJJZ2npeJIHV/Yvs+/wJo=;
 b=Pj/qRwEbX8n3kee5pQGlqxIfudCh00GnWNB9HmbY0xGYVsercqXzgyKNR2ENMzfGKTXiZK
 w0vuPgBIoBb5vFFMcqiAO36Q5Clpxb511tEVfkG59Y0IGA4Sw995r/hiEfoFj756+RsPsC
 dzxqrljyEr4UUeX+so+eGqS2yXXSM/8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-mI8g9rvbORCGhP3XIKbI9w-1; Thu, 26 Dec 2019 13:05:07 -0500
Received: by mail-wr1-f70.google.com with SMTP id k18so11667551wrw.9
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2019 10:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=C8xcEt4HJzv2LOkIezdcLMmJJZ2npeJIHV/Yvs+/wJo=;
 b=C9QFcEV30x9/F7sT4nrNZwLbvYspqwftEtpsr/DHPKrR5U3uWHKj7HsjbFROIH49Ku
 KXVv1k+wfQo9w4PAk2J67hEiMOeMB6AHOmmBCRsH/RVWnX5Ez+AUV6DIbr8wRarls3KQ
 nqAdK+pVAYyE6REBIHPXvAVat+HFqlpjwa7ZmBFn8SVmf6kGrQ7Jo0j4FzMPugIHlqvG
 cp63n1WvquJlJboYsyJwSUoFGn08mQLCeBpGFH1Jcm+j2heOn58yS7Onu2r1sSznq+2L
 BHbG4pr2xAGr2ik600+ZXeWEwV5iaxi3ZsR1LWle9UMrnsC4WcF5TOq874oYrFYizHas
 xKBw==
X-Gm-Message-State: APjAAAX9prImu+H6ZyXQwUROSQvqfM/Yv7tkxOz87cVnEr+ca6WOFsou
 AsTsgA+Mz/W5jcnTFa9s8G4ElGc9ap972W2v+zyqHP+8a8IgW0W8YWVRvGfvaZkPyW07+wTaRdy
 Ap1H8AC9kZ5J2YwU=
X-Received: by 2002:a5d:4983:: with SMTP id r3mr46976503wrq.134.1577383506547; 
 Thu, 26 Dec 2019 10:05:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxs3BKqOBbJwRp3mav7JbG/zJ9pfC46H61WitaE1aXzoyFLYSRzj2J6z4BZ9pf/HGlKWPaXMQ==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr46976485wrq.134.1577383506388; 
 Thu, 26 Dec 2019 10:05:06 -0800 (PST)
Received: from [192.168.1.25] (abayonne-654-1-186-92.w92-134.abo.wanadoo.fr.
 [92.134.161.92])
 by smtp.gmail.com with ESMTPSA id t5sm31288318wrr.35.2019.12.26.10.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2019 10:05:05 -0800 (PST)
To: qemu-devel <qemu-devel@nongnu.org>, Jeff Cody <codyprime@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: GraphViz extension on QEMU Wiki
Message-ID: <b4291830-5edd-5f7e-6170-63e43b6e629d@redhat.com>
Date: Thu, 26 Dec 2019 19:05:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Language: en-US
X-MC-Unique: mI8g9rvbORCGhP3XIKbI9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Hello,

Is it possible to have the GraphViz extension installed on the QEMU wiki?

This:
https://www.mediawiki.org/wiki/Extension:GraphViz

I'm not sure who is responsible of this...

Thanks!

Phil.


