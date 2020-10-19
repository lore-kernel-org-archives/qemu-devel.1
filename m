Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF24C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3FF2224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EF6+z+WL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3FF2224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQXI-0000QU-BI
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUQVg-0007Kr-PD
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:27:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUQVe-0003al-5z
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603096032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ScxXAshqlvEYi/wEPnaZO/bO/liIH/WsWVPuh/wO+UU=;
 b=EF6+z+WLBMvVqkJw6FyZwiZg+zeWJZX17N8vpkOVMVnLYgcZpL/VxL8HJTa70xcLuiv83U
 EI9IyqVmNUp1psH+7ewJY7W9P+8LMTVQZetc81N4kVM/8P0ETSYs3YvV11Uwqv4j6Ra5CI
 AudWp0OkjO+iqJuvhwan8OKLwqg7hxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-I6Hcjpq3Pxej61Pu_cvX2g-1; Mon, 19 Oct 2020 04:27:10 -0400
X-MC-Unique: I6Hcjpq3Pxej61Pu_cvX2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D57B802B67;
 Mon, 19 Oct 2020 08:27:09 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-6.ams2.redhat.com [10.36.114.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35DB55B4B0;
 Mon, 19 Oct 2020 08:27:07 +0000 (UTC)
Subject: Re: [PATCH v2 9/9] block: check availablity for preadv/pwritev on mac
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-10-j@getutm.app>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <54ea1dc9-f4e5-7827-6d05-c574b8c411d1@redhat.com>
Date: Mon, 19 Oct 2020 10:27:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201019013928.72770-10-j@getutm.app>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:raw" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/2020 03.39, Joelle van Dyne wrote:
> From: osy <osy86@users.noreply.github.com>

That "From:" line looks wrong ... could you please fix the "Author" of your
patches / your git config?

> macOS 11/iOS 14 added preadv/pwritev APIs. Due to weak linking, configure
> will succeed with CONFIG_PREADV even when targeting a lower OS version. We
> therefore need to check at run time if we can actually use these APIs.

That sounds like the wrong approach to me ... could you please try to fix
the check in "configure" instead? E.g. by running compile_prog with
"-Werror", so that the test fails if there is no valid prototype available?

 Thomas


