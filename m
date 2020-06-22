Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA00C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CC520578
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihqlYifR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CC520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnI6m-0000c5-5d
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnI5z-0008MO-0h
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:46:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58795
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnI5w-0002mh-9Z
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592815582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=CDhzlPay7U35WYpNP4ypQOZeNoi2pWDmNc7kMRdNPr4=;
 b=ihqlYifRMOqytirmePv9GPYZ7ieM+9FPDizYkHmxf9cSesBr+n5bX+iC0SgVOmMJsGLeTP
 D8Us4x1cXSwtyX3cxlqZpXAs2X2v3tErNyt7i/ZHLRc9zIQlInh9p2ATVXlcyVmR4IFGKX
 JBWjltKfXexAso0pXbQ4afssbqhuDpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-lXpDEBvMM5CB8c0RnUW6jg-1; Mon, 22 Jun 2020 04:46:20 -0400
X-MC-Unique: lXpDEBvMM5CB8c0RnUW6jg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8688A1005513;
 Mon, 22 Jun 2020 08:46:18 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4FDC7C1FC;
 Mon, 22 Jun 2020 08:46:16 +0000 (UTC)
Subject: Re: [PATCH] ppc/pnv: Silence missing BMC warning with qtest
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <159280903824.485572.831378159272329707.stgit@bahia.lan>
 <47741f1f-0070-4325-9690-9549211f266c@kaod.org>
 <20200622095312.0919cfc4@bahia.lan>
 <e2b5e91c-fb8a-e007-ef1f-fbea886d6ae5@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <cc5c1f33-1924-f899-f0e8-d6dcc0edced9@redhat.com>
Date: Mon, 22 Jun 2020 10:46:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e2b5e91c-fb8a-e007-ef1f-fbea886d6ae5@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/06/2020 10.24, Philippe Mathieu-Daudé wrote:
> On 6/22/20 9:53 AM, Greg Kurz wrote:
>> On Mon, 22 Jun 2020 09:13:46 +0200
>> Cédric Le Goater <clg@kaod.org> wrote:
>>
>>> On 6/22/20 8:57 AM, Greg Kurz wrote:
>>>> The device introspect test in qtest emits some warnings with the
>>>> the pnv machine types during the "nodefaults" phase:
>>>>
>>>> TEST check-qtest-ppc64: tests/qtest/device-introspect-test
>>>> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
>>>> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
>>>> one
>>>> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
>>>> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
>>>> one
>>>> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
>>>> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
>>>> one
>>>>
>>>> This is expected since the pnv machine doesn't create the internal
>>>> BMC simulator fallback when "-nodefaults" is passed on the command
>>>> line, but these warnings appear in ci logs and confuse people.
>>>>
>>>> Not having a BMC isn't recommended but it is still a supported
>>>> configuration, so a straightforward fix is to just silent this
>>>> warning when qtest is enabled.
>>>>
>>>> Fixes: 25f3170b0654 ("ppc/pnv: Create BMC devices only when defaults are enabled")
>>>> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>>
>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>
>>> It looks good but could you reproduce ? 
>>>
>>
>> Yup, this test is only run in "slow" mode, eg:
>>
>>     make check-qtest-ppc64 SPEED=slow
> 
> Indeed:
> https://gitlab.com/qemu-project/qemu/-/jobs/603546723#L3337
> 
> See in .gitlab-ci.yml:
> 
>   build-disabled:
>    ...
>    - make -j"$JOBS"
>    - make -j"$JOBS" check-qtest SPEED=slow
> 
> Thomas, FYI this job is now timeouting most of the time.

Do you know why it got much slower? Have additional tests been added? Or
is there a performance regressions somewhere?

 Thomas


