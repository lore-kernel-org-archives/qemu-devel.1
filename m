Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EE8C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BF62075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtvA6IcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BF62075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7JT-0001ug-0s
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 10:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is7Ij-0001TJ-CV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:43:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is7Ih-00020D-PW
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:43:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44847
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is7Ih-0001zk-L7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579189395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xP1b3XRjCaR23Gl9n9t2xLL3XcccUWCoYMwhtnBuh3c=;
 b=LtvA6IcJXWim4VDo41rEbKgF4/elBKYOWWVREVfw65r0/85AEfb7aiwJ/239IHRmvnulBH
 1XOTQRoXSLQdtgEY+qqZ79Drv9vo6KDRvTAE6anx3Hx1zYDAuWv837/1/VnTPGNWaLXFbH
 VXU8J54Jk0A8rRK1rlO1YdVlS0pxcq4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-CW9q0RmtNLuCxyC7r1wQWQ-1; Thu, 16 Jan 2020 10:43:11 -0500
Received: by mail-wr1-f69.google.com with SMTP id z14so9490138wrs.4
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 07:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xP1b3XRjCaR23Gl9n9t2xLL3XcccUWCoYMwhtnBuh3c=;
 b=Jj8klDhsB8p/PkAEoCavAbWtR7VaRQ+nlM/ADDNNoIfAOv4yjDpRSw0dpuvQEbj66E
 tkscrm6U7ugAs8jzTsT7kfjrQEG+XEOHnB81nLalDC1hSvzQGGGL/y0fjDg62dWOlt0L
 qZiBpAyOYmLscnPNVb85/WNd5kbRe1iTxYjH71Srkyg9fS7I+JDRZ+QXJKUP9a6EGmHa
 aY6uSUH/vzPqsQd4xE0zopKwjjAf4L+8t/wOeZEk98snhAAisXqCd5g/3TupNDbXvQc5
 xnIk4leNcC+vTZiJGRxytTRTOGfabG780rv0R8FYyV6iezbhV8X+BUN0EJBMw+CiIgAW
 P9rg==
X-Gm-Message-State: APjAAAWb97pYzcG8O4xUNMJaJ+mzaxcdujvw2B4JdIVTrF7TJoBq26dg
 a86bJnSxYNhdwWSqK6D56wjhQaQEhBU+yoi4t/HhyMh3ghnmRebTMMvu3HXVfU8m4dGofId5Pys
 JGaZ3nwGxAIhjrso=
X-Received: by 2002:a05:600c:2298:: with SMTP id
 24mr6988416wmf.65.1579189390683; 
 Thu, 16 Jan 2020 07:43:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqxsQ22242W5u1MVJT6bH5QkJL4Hu7reSWAboapP47oMpZuRNhDY+ZKg6yDG5oX/k72JLrjYow==
X-Received: by 2002:a05:600c:2298:: with SMTP id
 24mr6988396wmf.65.1579189390444; 
 Thu, 16 Jan 2020 07:43:10 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id p15sm3076155wma.40.2020.01.16.07.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 07:43:09 -0800 (PST)
Subject: Re: [PATCH v2 00/86] refactor main RAM allocation to use hostmem
 backend
To: qemu-devel@nongnu.org, no-reply@patchew.org, imammedo@redhat.com,
 Markus Armbruster <armbru@redhat.com>
References: <157912207219.8290.12574147223674937177@37313f22b938>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b81ad35f-73d0-a333-d0fe-758e64242ca2@redhat.com>
Date: Thu, 16 Jan 2020 16:43:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157912207219.8290.12574147223674937177@37313f22b938>
Content-Language: en-US
X-MC-Unique: CW9q0RmtNLuCxyC7r1wQWQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On 1/15/20 10:01 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/1579100861-73692-1-git-send-email-imammedo@redhat.com/
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
>    TEST    iotest-qcow2: 217
> socket_accept failed: Resource temporarily unavailable
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/libqtest.c:272:qtest_init_without_qmp_handshake: assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)
> /tmp/qemu-test/src/tests/qtest/libqtest.c:140: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/libqtest.c:272:qtest_init_without_qmp_handshake: assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)
> make: *** [check-qtest-x86_64] Error 1

Is this something we should care about?

> make: *** Waiting for unfinished jobs....
>    TEST    check-qtest-aarch64: tests/qtest/test-hmp
>    TEST    iotest-qcow2: 220
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=755fcbfd171f40b1b16d6aac34e7c09b', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-qd5wtatm/src/docker-src.2020-01-15-15.50.14.28652:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=755fcbfd171f40b1b16d6aac34e7c09b
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-qd5wtatm/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    11m0.219s
> user    0m8.267s
> 
> 
> The full log is available at
> http://patchew.org/logs/1579100861-73692-1-git-send-email-imammedo@redhat.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


