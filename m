Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B01C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6D62067D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1CL/QJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6D62067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0xl-0001a6-97
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jz0x2-0000iU-R1
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:53:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48401
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jz0x1-0004DV-EG
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595609618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iGJWmcv015sRKtjObcdhr897PCM5Ydawc58sjuZIxY=;
 b=A1CL/QJ4H1p1zNY94r/vAMCeckzZfJHl7o/hmUMnYHs/b2NThXyUPY4zOCzi/PBhnIrY0X
 zqJeq6hRbhOZ5Ka7edPpNFVsim0oC4bVN8EFxP7zyYSSbuyzBizXP6gjap+nwGvcOTN9CW
 /ahgV+eO6AnplMgVJRCYTrJseDz16Bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-LjR-EhV9MWC3AVURBaMqxg-1; Fri, 24 Jul 2020 12:53:36 -0400
X-MC-Unique: LjR-EhV9MWC3AVURBaMqxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FB6B1009440
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 16:53:35 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8967E74F64;
 Fri, 24 Jul 2020 16:53:34 +0000 (UTC)
Subject: Re: [PATCH 0/3] scripts/qmp/qom-fuse: Scrape off the bitrot
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <20200723142738.1868568-1-armbru@redhat.com>
 <36a450fb-8072-1223-9253-0446ed23dcd1@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ba3b3e75-8f4d-2913-fb9d-efb125f1ceb4@redhat.com>
Date: Fri, 24 Jul 2020 12:53:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <36a450fb-8072-1223-9253-0446ed23dcd1@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 11:21 AM, Thomas Huth wrote:
> On 23/07/2020 16.27, Markus Armbruster wrote:
>> Markus Armbruster (3):
>>    scripts/qmp/qom-fuse: Unbreak import of QEMUMonitorProtocol
>>    scripts/qmp/qom-fuse: Port to current Python module fuse
>>    scripts/qmp/qom-fuse: Fix getattr(), read() for files in /
> 
> Could it be added to a CI pipeline, so that it does not bitrot again?
> 
>   Thomas
> 

Honestly, I'm working on it, but I could use some help getting the 
python directory into shape so I can do it.

I am trying to add pylint/mypy/flake8 tests to python/qemu to prevent 
that code from bitrot, but the review/discussion there didn't go anywhere.

Once there is a solid regime in place for python/qemu/ that is part of 
CI, I can work on moving more scripts and tooling there to start 
including those as part of the CI regime to prevent rot.

--js


