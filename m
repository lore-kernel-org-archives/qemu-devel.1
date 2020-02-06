Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9F4C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34ADE2253D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOaTG4ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34ADE2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iziY5-0000m2-Dt
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iziWn-00081H-Ch
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iziWi-0001L1-Ui
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:53:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41279
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iziWi-0001GP-BC
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581000786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dHrQx5j+jQNUevff1y6DuVQn2BWHhWp5qvTGO9me2D4=;
 b=VOaTG4gaqeHtrCSU6w/qbRPZl9rZus6RtDEOaQM3JubnC9pb4j/mqo5ulyrJ4NXTNzs/rQ
 QQsba5Jw3bsxVUx4D6SSIaHLTq5MsuXSAEblFFwFiOkOqV0TN8bTM+NV9bTVMH9iQOU332
 wfrulZUPWbM+0R4edTwhqS0KHamWnHk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-BiRMcfA1NcqVc36NzVOJag-1; Thu, 06 Feb 2020 09:52:51 -0500
Received: by mail-wm1-f71.google.com with SMTP id d4so92216wmd.7
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 06:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dHrQx5j+jQNUevff1y6DuVQn2BWHhWp5qvTGO9me2D4=;
 b=OB8Xv5qGbqc8t2cLz7WAFlnxSzTJOejAwvuRPdYpwiNSEqH8wllQ2eQo2wIWg3Ixwe
 rhkT+yvMxygUAFQUAhqatyQdIUoa+hB2GmnoiN95FtUGppvFEHbzJkiuL5FJItUtvtfI
 TFxfzX6UgJ34qXSnjwOUI4t+dObbly8qW2AGH13CisntAeQztYErgcvtAf526NhrxlE6
 krwZjUw+h2uDP+8OhHgmdldLeoIPVM6mU5oDzn88A99z6zjlhvZsKE5LFpsCLn9ToScw
 HlNHgP4oscVeS3EcweqFxv+rzXur6dr0DP96ggRglcbTAbFbWWacedCkJWE4aexyTtrg
 LyeA==
X-Gm-Message-State: APjAAAVvVsz5giaJHGxex5JVHI9gRoi9eTw/q/yjcFW/L77heuy+o2Db
 FSNEx42wMBaFlXvL9fO6yO/ZcqeIFaXaIA3Kyv3kIWqqOFkTGRIFuaatxG15rpdKtBmt4YWJEmx
 KGqZfaz98zo2my+8=
X-Received: by 2002:a7b:c088:: with SMTP id r8mr5061020wmh.18.1581000769815;
 Thu, 06 Feb 2020 06:52:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzKyw+ovUzRNxsGfh7PWfPIiSoph7gZ+KSYo7HtP8E0QCHrc8nPdW7mF7e9xJ2M8d7xtvG1kw==
X-Received: by 2002:a7b:c088:: with SMTP id r8mr5061000wmh.18.1581000769581;
 Thu, 06 Feb 2020 06:52:49 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id d204sm3981588wmd.30.2020.02.06.06.52.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 06:52:49 -0800 (PST)
Subject: Re: [PATCH v2 0/5] python/qemu: qmp: Fix, delint and improvements
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200204141111.3207-1-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a8238c8a-92d6-3870-ff8c-1d499fe8e295@redhat.com>
Date: Thu, 6 Feb 2020 15:52:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204141111.3207-1-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: BiRMcfA1NcqVc36NzVOJag-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: jsnow@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 3:11 PM, Wainer dos Santos Moschetta wrote:
> I started fixing an issue on exception handling which in some places
> currently use the deprecated (in Python 3.3) `socket.error`. Then I
> ended up delinting the module code and making some improvements.
> 
> Changes in v2:
> - Rebased to master. No conflicts.
> - Added docstring describing the allowed value of the new `timeout`
>    option in accept() (patch 03) [jsnow]
> - Set the new `timeout` option to 15.0 by default [philmd]
> 
> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg667479.html
> 
> Git:
> - Tree: https://github.com/wainersm/qemu
> - Branch: python_qmp_sockets_error-v2
> 
> CI:
> - Travis (FAIL): https://travis-ci.org/wainersm/qemu/builds/645583812
>    Jobs failures aren't related with these changes
> 
> 
> Wainer dos Santos Moschetta (5):
>    python/qemu: qmp: Replace socket.error with OSError
>    python/qemu: Delint the qmp module
>    python/qemu: qmp: Make accept()'s timeout configurable
>    python/qemu: qmp: Make QEMUMonitorProtocol a context manager
>    python/qemu: qmp: Remove unnused attributes
> 
>   python/qemu/qmp.py | 97 +++++++++++++++++++++++++++++++++-------------
>   1 file changed, 71 insertions(+), 26 deletions(-)
> 

Patches 3 and 4 applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


