Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F69DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF62020707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="if0qELc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF62020707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAx7q-0000nz-4e
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAx6a-0007fw-F1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAx6X-0003yM-PB
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598454767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BJE2WZTE4xvmgFxvyG1UsbLTRSXbl3G8EhoIcDGXKE=;
 b=if0qELc2mRNNgyPdhEdJiFZPHMxvcrgpms2eYDUNGrA/wrU6WH63FH4wT2Co/EuYJhp2Aj
 gAL2Vp6tHivGG9imyUl4R3bHrBUqE9JihZWtnyaGTWWjgpFyNx38h6omcJ9jBVOwAimXgj
 bZH1nRsWGS1FXLg6EZSg/XUWHMTNunI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-u3_J25EdN3e_Ul_RCCVFPQ-1; Wed, 26 Aug 2020 11:12:42 -0400
X-MC-Unique: u3_J25EdN3e_Ul_RCCVFPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9315189E606;
 Wed, 26 Aug 2020 15:12:41 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-182.ams2.redhat.com
 [10.36.114.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C48ED747C6;
 Wed, 26 Aug 2020 15:12:40 +0000 (UTC)
Subject: Re: [PATCH v2 6/7] x68: acpi: trigger SMI before sending hotplug
 Notify event to OSPM
To: Igor Mammedov <imammedo@redhat.com>
References: <20200818122208.1243901-1-imammedo@redhat.com>
 <20200818122208.1243901-7-imammedo@redhat.com>
 <382e54cc-1ac0-61e5-bf5d-0653480222a0@redhat.com>
 <cfd4dd52-4827-2288-4b4e-b396d48494f0@redhat.com>
 <20200826135501.5449641b@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <93968819-1988-1e6c-9ec7-3d1fb067c147@redhat.com>
Date: Wed, 26 Aug 2020 17:12:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200826135501.5449641b@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: boris.ostrovsky@oracle.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/26/20 13:55, Igor Mammedov wrote:
> On Wed, 26 Aug 2020 11:24:14 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:

>>   (2a) Change the firmware so that it sends a directed SMI as well to
>>        each CPU, just before sending an INIT-SIPI-SIPI. This should be
>>        idempotent -- if the broadcast SMI *has* covered the the CPU,
>>        then sending a directed SMI should make no difference.
> may be still racy, as new cpus can arrive diring/after direct broadcast.

(I think you meant "direct SMI")

That's not a problem -- the point is that we must never send
INIT-SIPI-SIPI to a hot-added CPU without making an SMI pending for it.

The above condition can be satisfied by not sending INIT-SIPI-SIPI to a
VCPU at all.

The firmware collects pending CPUs into an array, and then does the
directed SMI + INIT-SIPI-SIPI dance for each, in a separate loop.

So if a new VCPU is hot-added while we are sending the interrupts to the
already collected ones, that's fine -- we're not going to send *either*
SMI *or* INIT-SIPI-SIPI to that VCPU, until the next time we collect VCPUS.

It's basically the same idea as in your ACPI patch for QEMU.

I'll send the OVMF patches soon.

Thanks!
Laszlo


