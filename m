Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3774CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F1A22515
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OP7JOCbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F1A22515
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvM1H-0002t5-7n
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvM0S-0002EM-9M
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:34:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvM0P-0000Q2-90
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594737240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UB8M4CZu44kJhtEc5ZmxxCl71WvAqj2QdKusJMHGvv8=;
 b=OP7JOCbmxh3A9WXPvz9hT8efaoGW4JYbnv44Uf8gbGfzX0u4FYvDRWvnGX1SZRzXFuumiz
 hc7/t0aISHosl/4UG2iEN47X20D6/6H4r2Cg1/ZUTQ4K79MHz6YvPamdpw4tuoSJ0nnntj
 yVTkNNHGaGS8yNmKGIhOYlMmZvTZrew=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77--TJ1uoljPVCbxCTxIt5hhw-1; Tue, 14 Jul 2020 10:33:58 -0400
X-MC-Unique: -TJ1uoljPVCbxCTxIt5hhw-1
Received: by mail-wr1-f71.google.com with SMTP id 89so21943733wrr.15
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 07:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=UB8M4CZu44kJhtEc5ZmxxCl71WvAqj2QdKusJMHGvv8=;
 b=bhGxocvKiS4KkjdRhBY6F2UVZ+PmWxnaM2BZ9Z3V/Pks8TU5DZ2EGRkNay8tnPkv4C
 8tKitxc1rQboe+rHz9d5Zdy6HAOwB8xAq0kq1Icw8AaD78WRZ0+I8ywds0Tfw+qnKTIf
 dUtOh1Os0Ik2D0Hx5sTp3MuHVC+Vx0jatvoNB2jXJWJel90L7hYmGTNUU4iXkEll8vVg
 f2G4DgbQOBvjAsgobrcbbat1pR1mqMzrz9EUJ0uUqxEzpXoUgS1qeTahr0bogzoKEpli
 GuU/pFBstXNDW3raHTHmiin8gKdwjw1KnEqAshqh8cJNYl3fP/o3KLvyJ0YyM+Vk63re
 oxmQ==
X-Gm-Message-State: AOAM530ViOY6RMzKUqVZnUAZ6u9Wr/Ttpon6OrFV0Ijn3ML4iaW1z73N
 ++DevdbgyqlpNDYfh5zYHw1d7zdk3NeEJx9TcdjAU+oi9PH54DBxX9VJZuFItrbykZ7e7Q8hrRe
 GnlbveH1tsKWyA6U=
X-Received: by 2002:adf:d842:: with SMTP id k2mr6171001wrl.239.1594737236950; 
 Tue, 14 Jul 2020 07:33:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMdDdxqMQQdUh3G7nUReNyxf//0PDBsKImjrY27/nt5ciaL6FHYIntdPwaN5xwzUgunUnv1A==
X-Received: by 2002:adf:d842:: with SMTP id k2mr6170940wrl.239.1594737236595; 
 Tue, 14 Jul 2020 07:33:56 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j75sm19644190wrj.22.2020.07.14.07.33.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 07:33:55 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] colo: Introduce resource agent and test suite/CI
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <cover.1591456338.git.lukasstraub2@web.de>
 <20200705113750.45175374@luklap>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <71686e50-1dda-5aca-c1c4-2906cac38da4@redhat.com>
Date: Tue, 14 Jul 2020 16:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200705113750.45175374@luklap>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:44:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/20 11:37 AM, Lukas Straub wrote:
> On Sat, 6 Jun 2020 21:17:32 +0200
> Lukas Straub <lukasstraub2@web.de> wrote:
> 
>> Hello Everyone,
>> So here is v2. Patch 1 can already be merged independently of the others.
>>
>> Regards,
>> Lukas Straub
>>
>> Changes:
>> v2:
>>  -use new yank api
>>  -drop disk_size parameter
>>  -introduce pick_qemu_util function and use it
>>
>> Overview:
>>
>> Hello Everyone,
>> These patches introduce a resource agent for fully automatic management of colo
>> and a test suite building upon the resource agent to extensively test colo.
>>
>> Test suite features:
>> -Tests failover with peer crashing and hanging and failover during checkpoint
>> -Tests network using ssh and iperf3
>> -Quick test requires no special configuration
>> -Network test for testing colo-compare
>> -Stress test: failover all the time with network load
>>
>> Resource agent features:
>> -Fully automatic management of colo
>> -Handles many failures: hanging/crashing qemu, replication error, disk error, ...
>> -Recovers from hanging qemu by using the "yank" oob command
>> -Tracks which node has up-to-date data
>> -Works well in clusters with more than 2 nodes
>>
>> Run times on my laptop:
>> Quick test: 200s
>> Network test: 800s (tagged as slow)
>> Stress test: 1300s (tagged as slow)
>>
>> The test suite needs access to a network bridge to properly test the network,
>> so some parameters need to be given to the test run. See
>> tests/acceptance/colo.py for more information.
>>
>> I wonder how this integrates in existing CI infrastructure. Is there a common
>> CI for qemu where this can run or does every subsystem have to run their own
>> CI?
>>
>> Regards,
>> Lukas Straub
>>
>>
>> Lukas Straub (7):
>>   block/quorum.c: stable children names
>>   avocado_qemu: Introduce pick_qemu_util to pick qemu utility binaries
>>   boot_linux.py: Use pick_qemu_util
>>   colo: Introduce resource agent
>>   colo: Introduce high-level test suite
>>   configure,Makefile: Install colo resource-agent
>>   MAINTAINERS: Add myself as maintainer for COLO resource agent
>>
>>  MAINTAINERS                               |    6 +
>>  Makefile                                  |    5 +
>>  block/quorum.c                            |   20 +-
>>  configure                                 |   10 +
>>  scripts/colo-resource-agent/colo          | 1466 +++++++++++++++++++++
>>  scripts/colo-resource-agent/crm_master    |   44 +
>>  scripts/colo-resource-agent/crm_resource  |   12 +
>>  tests/acceptance/avocado_qemu/__init__.py |   15 +
>>  tests/acceptance/boot_linux.py            |   11 +-
>>  tests/acceptance/colo.py                  |  677 ++++++++++
>>  10 files changed, 2251 insertions(+), 15 deletions(-)
>>  create mode 100755 scripts/colo-resource-agent/colo
>>  create mode 100755 scripts/colo-resource-agent/crm_master
>>  create mode 100755 scripts/colo-resource-agent/crm_resource
>>  create mode 100644 tests/acceptance/colo.py
>>
>> --
>> 2.20.1
> 
> Ping...

Ping^2?


