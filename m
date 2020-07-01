Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2A6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 06:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B406E20722
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 06:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SncSvNEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B406E20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqWbj-0003L3-Ue
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 02:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jqWb2-0002uM-0U
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 02:51:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45848
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jqWb0-0005VK-9o
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 02:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593586308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9qXbTpdV7Nx+DyRH1s7f/RdvqpcGJXdWPMWTtRJsffE=;
 b=SncSvNEb37iF0yEqsZfRte0saCk6Rr4aF7N4adwHUdITboUAVUeR3q5IlG5Ts3BrdVRSxb
 DSuIz2YQGbkd0cdA3W99ip5TqlN7MQLHDEiSKcvq1UHKeX3LLXUcqvM2wNnfJ4gY/fSgAi
 HYPFKidl9QBoxWeCbMufcNbVr2QAlfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-GA-Khh58Mk-w4-Ard05gUg-1; Wed, 01 Jul 2020 02:51:45 -0400
X-MC-Unique: GA-Khh58Mk-w4-Ard05gUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56C18107ACF3;
 Wed,  1 Jul 2020 06:51:44 +0000 (UTC)
Received: from [10.36.112.70] (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF83D7554F;
 Wed,  1 Jul 2020 06:51:42 +0000 (UTC)
Subject: Re: [PATCH v4 0/3] Avoid abort on QMP attempt to add an object with
 duplicate id
To: Paolo Bonzini <pbonzini@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, berrange@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com
References: <20200629112329.27611-1-eric.auger@redhat.com>
 <8bd5b010-1c58-1a38-f234-d7669cd72d35@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ef7a4ced-d39e-8d78-e289-9d5f5c440a25@redhat.com>
Date: Wed, 1 Jul 2020 08:51:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8bd5b010-1c58-1a38-f234-d7669cd72d35@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 6/29/20 5:30 PM, Paolo Bonzini wrote:
> On 29/06/20 13:23, Eric Auger wrote:
>> Attempting to add an object through QMP with an id that is
>> already used leads to a qemu abort. This is a regression since
>> d2623129a7de ("qom: Drop parameter @errp of object_property_add()
>> & friends").
>>
>> The first patch fixes the issue and the second patch adds a test
>> to check the error is gracefully returned to the QMP client.
>>
>> The last patch can be considered independently. It merges all the
>> object-add tests into a single test function and cover new failure
>> cases.
>>
>> Best Regards
>>
>> Eric
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/qom-graceful-v4
>>
>> History:
>> - v3 -> v4:
>>   - addressed style comment from Markus
>>   - added patch 3
>>
>> - v2 -> v3:
>>   - don't take the object reference on failure in
>>     object_property_try_add_child
>>   - add g_assert_nonnull(resp) in 2/2 while keeping
>>     Thomas A-b
>>
>> - v1 -> v2:
>>   - use the try terminology.
>>   - turn object_property_try_add() into a non-static function
>>   - add the test
>>
>>
>> Eric Auger (3):
>>   qom: Introduce object_property_try_add_child()
>>   tests/qmp-cmd-test: Add qmp/object-add-duplicate-id
>>   tests/qmp-cmd-test: Add qmp/object-add-failure-modes
>>
>>  include/qom/object.h       | 26 +++++++++-
>>  qom/object.c               | 21 ++++++--
>>  qom/object_interfaces.c    |  7 ++-
>>  tests/qtest/qmp-cmd-test.c | 99 ++++++++++++++++++++++++++++++++++++--
>>  4 files changed, 140 insertions(+), 13 deletions(-)
>>
> 
> Very nice.  I see a failure reported by Patchew, I'll look into it as
> well if you don't have time.

So "[PATCH v5 0/3] Avoid abort on QMP attempt to add an object with
duplicate id" seems to have fixed the Patchew error (I decreased the
size of the memory object downto 1MB).

Thanks

Eric
> 
> Paolo
> 


