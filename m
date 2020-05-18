Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46973C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11286207ED
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="KH5VT0Zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11286207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajPi-0000gB-5D
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1jajOe-000051-HI
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:17:48 -0400
Received: from mout01.posteo.de ([185.67.36.65]:33832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1jajOc-0008FJ-7H
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:17:48 -0400
Received: from submission (posteo.de [89.146.220.130]) 
 by mout01.posteo.de (Postfix) with ESMTPS id E1D7216005C
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:17:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1589822262; bh=otfDcwqFnFevf1TAoWaHaFPIvzzNTYYM/H40jlJfhkA=;
 h=Subject:To:Cc:From:Date:From;
 b=KH5VT0ZuOrEPQMa8Jnq0Vrx2WNmjAmjxN62Kk4dnHqUZA/FwFrJcMqH3vAGRwQOLX
 s601nqK5QY2nXtm/ozTicFIZnour/XAmq01ZsAgyJU3MONWXl1lrtlzBkKi7Rv5sLC
 iqA5z+rsHKVoiZ42coa10W8TFihasQ3Sh1awVjHNmlTtdj7v/C1LWNZTzBjXadMpCk
 j3guvyj8bGnaZ87kfmCeVzn6XKpokDJUhaaVCy+TX12bf8vw2LZw2p+dhroDBV8ySj
 SRqses/r22j4vXqDaMo1FtN0bx7ZXcZNKI3vFFtXDsq33r6PnUjmxvZT46yVxWDHBX
 dTVK50fRfg7xQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 49Qm116Kmqz6tmk;
 Mon, 18 May 2020 19:17:41 +0200 (CEST)
Subject: Re: [PATCH] hw/m68k/mcf52xx: Replace hw_error() by qemu_log_mask()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200518094904.24226-1-f4bug@amsat.org>
 <6a1d8e73-9417-2e52-a2a9-e5d1c00a0a2a@redhat.com>
 <6dc504aa-1fea-e5dd-1ba9-d1d59fbcb198@amsat.org>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <8092949e-43fc-f45f-a5e4-f16981657967@posteo.de>
Date: Mon, 18 May 2020 19:17:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6dc504aa-1fea-e5dd-1ba9-d1d59fbcb198@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.de;
 helo=mout01.posteo.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 12:01:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <huth@tuxfamily.org>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/05/2020 19.08, Philippe Mathieu-Daudé wrote:
> On 5/18/20 6:32 PM, Thomas Huth wrote:
>> On 18/05/2020 11.49, Philippe Mathieu-Daudé wrote:
>>> hw_error() calls exit(). This a bit overkill when we can log
>>> the accesses as unimplemented or guest error.
>>
>> Good idea. hw_error() is also mainly for CPU errors, it really should
>> not be used for non-CPU devices.
> 
> Are you sure?
> 
> $ git grep hw_error target | wc -l
> 5
> $ git grep hw_error hw | wc -l
> 137

Well, the function is defined in cpus.c and it's dumping the state of
each CPU ... I think it's used in a lot of places during development of
new code to quickly get some information on where things went wrong in
the guest, but technically, it really sounds wrong to me that a non-CPU
device creates CPU dumps in mature code.

 Thomas

