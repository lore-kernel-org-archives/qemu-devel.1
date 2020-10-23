Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68648C55178
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7612192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrWIU1OL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7612192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVqgz-0005CZ-G8
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 02:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVqec-0004GA-Dg
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 02:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVqea-0007mx-8e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 02:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603434858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RwHWmzPlHXd/gAXauMq/bM3qqyEBRrdjTZrK5uNq4HM=;
 b=KrWIU1OLuEgZfmJwPNOXrG/xElyPVXU+lEzYDax7y9qrZGOrdDzIIGzcwE3rywzn846nhu
 J7ZmseWyAO8798X/j69zdv6EuzZ04B+pk+iwygcrafmYCfRYKt+fF8+Sftxd39GZhOy/2H
 zc3XS9VIEZ6dY7NofqIxRjt6a2/YX1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-9cUK6EmjOD2DdIzaG30Qwg-1; Fri, 23 Oct 2020 02:34:16 -0400
X-MC-Unique: 9cUK6EmjOD2DdIzaG30Qwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0933C8030A8;
 Fri, 23 Oct 2020 06:34:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-123.ams2.redhat.com [10.36.112.123])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 333F110027AB;
 Fri, 23 Oct 2020 06:34:11 +0000 (UTC)
Subject: Re: [PATCH RESEND v2 1/7] tests/migration: fix memleak in
 wait_command/wait_command_fd
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201023061218.2080844-1-kuhn.chenqun@huawei.com>
 <20201023061218.2080844-2-kuhn.chenqun@huawei.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cf2dd7ff-48fc-dfd7-73d3-425d033d8fa2@redhat.com>
Date: Fri, 23 Oct 2020 08:34:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201023061218.2080844-2-kuhn.chenqun@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: lvivier@redhat.com, zhang.zhanghailiang@huawei.com, pannengyuan@huawei.com,
 Maxim Levitsky <mlevitsk@redhat.com>, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/2020 08.12, Chen Qun wrote:
> Properly free each command resp to avoid memory leak.
> ASAN shows memory leak stack:
> 
> Indirect leak of 2352520 byte(s) in 571 object(s) allocated from:
>     #0 0x7f6ca3308d4e in __interceptor_calloc (/lib64/libasan.so.5+0x112d4e)
>     #1 0x7f6ca3127a50 in g_malloc0 (/lib64/libglib-2.0.so.0+0x55a50)
>     #2 0x557bf3c71d2b in qdict_new ../qobject/qdict.c:29
>     #3 0x557bf3c9caba in parse_object ../qobject/json-parser.c:318
>     #4 0x557bf3c9ce75 in json_parser_parse ../qobject/json-parser.c:580
>     #5 0x557bf3c8c8cf in json_message_process_token ../qobject/json-streamer.c:92
>     #6 0x557bf3c9ea59 in json_lexer_feed_char ../qobject/json-lexer.c:313
>     #7 0x557bf3c9eeb5 in json_lexer_feed ../qobject/json-lexer.c:350
>     #8 0x557bf3c4793a in qmp_fd_receive ../tests/qtest/libqtest.c:608
>     #9 0x557bf3c47b58 in qtest_qmp_receive ../tests/qtest/libqtest.c:618
>     #10 0x557bf3c44245 in wait_command ../tests/qtest/migration-helpers.c:59
>     #11 0x557bf3c445cb in migrate_query_status ../tests/qtest/migration-helpers.c:108
>     #12 0x557bf3c44642 in check_migration_status ../tests/qtest/migration-helpers.c:124
>     #13 0x557bf3c447e7 in wait_for_migration_status ../tests/qtest/migration-helpers.c:148
>     #14 0x557bf3c43b8f in test_migrate_auto_converge ../tests/qtest/migration-test.c:1243
>     ......
> 
> Fix: 5e34005571af5
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---

Thanks, I've queued it now to my qtest-next branch:

https://gitlab.com/huth/qemu/-/commits/qtest-next/

 Thomas


