Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0910C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3C2206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPWfU7Dv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3C2206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJMM-0005dd-Sf
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 06:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jnJLP-0004oL-Ea
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:06:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28103
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jnJLN-0007tc-UV
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592820384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8d3d9DMhvDqSvEBwhmgi9M5139uy5/tOB3pZzlOoPL0=;
 b=OPWfU7DvPPi/m1ZnkgnXPQRxVAEXC7Vblk2ihDGaMAwulYPyndOsZe3RfjgS2qZCDn7zY3
 ERoMSg5ymJpOGTHvE/O7se4CHmfWWgVOeqDSWCZYquiQkSzYoCqWqLeZUPlY04wkNRYVNj
 hy0luWJFVtzblhpGrvDsqTqP9O550So=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-rcaBPA6GPHe_wfvEbq1DuQ-1; Mon, 22 Jun 2020 06:06:21 -0400
X-MC-Unique: rcaBPA6GPHe_wfvEbq1DuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2719C1005512;
 Mon, 22 Jun 2020 10:06:20 +0000 (UTC)
Received: from [10.40.194.228] (unknown [10.40.194.228])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4376C7C204;
 Mon, 22 Jun 2020 10:06:19 +0000 (UTC)
Subject: Re: [PATCH] qga: Use gethostname() instead of g_get_host_name()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <8e73f685e10c684eb5e2c88c2185504d26f024fc.1592296355.git.mprivozn@redhat.com>
 <dae9555b-f9f1-37d1-5c42-f64bf448d73e@linaro.org>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <7662a926-8cfa-216e-bb50-9302b222d9b1@redhat.com>
Date: Mon, 22 Jun 2020 12:06:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <dae9555b-f9f1-37d1-5c42-f64bf448d73e@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: vfeenstr@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 11:54 PM, Richard Henderson wrote:
> On 6/16/20 1:34 AM, Michal Privoznik wrote:
>> +#ifndef G_OS_WIN32
> 
> Nit: positive tests are easier to reason with and extend than negative tests.
> I would reverse these two blocks and use a positive test for windows.
> 
> Also, CONFIG_WIN32 is what we use elsewhere for this test.
> 
> 
> r~
> 

Fair enough. Do you want me to send v2 or is it something that committer 
can fix before merging?

Michal


