Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6D1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8486A255A1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhrdTlnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8486A255A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpx8K-0007Ep-O9
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jpx7h-0006o9-Qw
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:59:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jpx7e-00020n-OU
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593449942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJy6iouKigApIWu6D46+NKM9SfoXQvXddGr8lsXdF+8=;
 b=FhrdTlnZZphec++mYZAMdMrOYHnBBAC+7gNXXyvjE3oL+QS74apgFhRd+WqMHcmd7vo+4k
 j18r0HqnLE14Dd3R9yehTjgXl4hQ9NOBJzidvmHssFR699Rtt7b88C3zPNJhlOmnxpiL61
 msgDfgbyOBY/lyt8i+pX4GDeooDs4/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-bWorfDkWNKG1p-g59i_Qng-1; Mon, 29 Jun 2020 12:58:59 -0400
X-MC-Unique: bWorfDkWNKG1p-g59i_Qng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED8548015F4;
 Mon, 29 Jun 2020 16:58:57 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F82A10013C1;
 Mon, 29 Jun 2020 16:58:53 +0000 (UTC)
Subject: Re: [PATCH v4 0/3] Avoid abort on QMP attempt to add an object with
 duplicate id
To: Paolo Bonzini <pbonzini@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, berrange@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com, patchew-devel@redhat.com
References: <20200629112329.27611-1-eric.auger@redhat.com>
 <8bd5b010-1c58-1a38-f234-d7669cd72d35@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <79214005-6b94-24d8-5bfa-c765863a0b35@redhat.com>
Date: Mon, 29 Jun 2020 18:58:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8bd5b010-1c58-1a38-f234-d7669cd72d35@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:37:37
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

As I reported earlier, I am no able to reproduce on my end with both

sudo time make docker-test-mingw@fedora SHOW_ENV=1 J=14 NETWORK=1
sudo time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1

It fails on the first memory-backend-ram object-add that should be valid.

resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1',
'props': {'size': 4294967296 } } }");

Could it be that the size is too large (4GB)?

Thanks

Eric



> 
> Paolo
> 
> 


