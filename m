Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32226C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC1F20781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SM/5yWjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC1F20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo66a-00005A-7y
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jo61m-0005j1-Ik
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37385
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jo61j-0003fS-RC
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593007522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQEm1+lgRaMLBc8Q04MiO+xc7SMu3DjN9BceYTh8oek=;
 b=SM/5yWjK/KMRMp7BhNxaL7TcIQYO+rmPlsBWUNWnEfz58xgCL6AfaEMXfLvOIRTtC6SBUe
 YAL64gBlTUhBs7lHHqokgr8BmW5YrzpGVfRNpCDScvQ2qnD6HrkPp6RJRhNNpSM53xx3QB
 SEDjNBY9n5Ia/51ODL0OSdYZAmGcRVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-UVvLxqW0M_a91pU5R3Ieiw-1; Wed, 24 Jun 2020 10:05:09 -0400
X-MC-Unique: UVvLxqW0M_a91pU5R3Ieiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5D47EC1A6;
 Wed, 24 Jun 2020 14:05:08 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0254679326;
 Wed, 24 Jun 2020 14:05:03 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] Avoid abort on QMP attempt to add an object with
 duplicate id
To: qemu-devel@nongnu.org, no-reply@patchew.org
References: <159300571296.6613.13304084890286151375@d1fd068a5071>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <34990a8f-8334-ea11-59b7-28808e9e69e4@redhat.com>
Date: Wed, 24 Jun 2020 16:05:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <159300571296.6613.13304084890286151375@d1fd068a5071>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, eric.auger.pro@gmail.com, berrange@redhat.com,
 ehabkost@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 6/24/20 3:35 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200624124301.7112-1-eric.auger@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>   TEST    iotest-qcow2: 114
>   TEST    iotest-qcow2: 117
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/qmp-cmd-test.c:225:test_object_add_with_duplicate_id: assertion failed: (qdict_haskey(resp, "return"))
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/qmp-cmd-test.c:225:test_object_add_with_duplicate_id: assertion failed: (qdict_haskey(resp, "return"))
> make: *** [check-qtest-aarch64] Error 1
> make: *** Waiting for unfinished jobs....
>   TEST    iotest-qcow2: 120
>   TEST    iotest-qcow2: 126
> ---
>   TEST    check-qtest-x86_64: tests/qtest/qmp-test
>   TEST    check-qtest-x86_64: tests/qtest/qmp-cmd-test
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/qmp-cmd-test.c:225:test_object_add_with_duplicate_id: assertion failed: (qdict_haskey(resp, "return"))
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/qmp-cmd-test.c:225:test_object_add_with_duplicate_id: assertion failed: (qdict_haskey(resp, "return"))
> make: *** [check-qtest-x86_64] Error 1
>   TEST    iotest-qcow2: 220
>   TEST    iotest-qcow2: 226
>   TEST    iotest-qcow2: 229
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=d6cb3d069c7a44ecbf5b02c17a39e884', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-litaiimt/src/docker-src.2020-06-24-09.18.47.9149:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=d6cb3d069c7a44ecbf5b02c17a39e884
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-litaiimt/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    16m25.200s
> user    0m5.519s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200624124301.7112-1-eric.auger@redhat.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 
Hum, time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1

passes for me, run on top of 2/2.

I don't get what's wrong here?

Eric



