Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1C4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680A021D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3lL6cHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680A021D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSlCk-0005je-AG
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 14:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSl8A-0000bV-TS
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSl86-0008O7-Eb
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602698641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYbezzmOgJSSdMY7a2ySbLpVNVK2KXCoCTs5dE4OZkM=;
 b=N3lL6cHci3QeKv1n1gP+I9aMM0wEdGbibTAB3P2y9USdYISXoVkQH2/gxuUwK252nud0/u
 pFJNRwwaj1OHjZfUNTX0VYWz4mIn83IstO0VQ/o5YNK9H8gHwSnKsUSmee58q0stJl9vEs
 Ggm+MpIpwgl+oF++QZI5zCFDjBXILnw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-476ww3_yO2ajDZP_DPncEg-1; Wed, 14 Oct 2020 14:03:59 -0400
X-MC-Unique: 476ww3_yO2ajDZP_DPncEg-1
Received: by mail-wm1-f71.google.com with SMTP id u5so187895wme.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 11:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kYbezzmOgJSSdMY7a2ySbLpVNVK2KXCoCTs5dE4OZkM=;
 b=NoAG96nTN30unIy5vBr8Z4GH9QXtVbmjvfEUkQpVyNkgdRdrQoSUx8ySeP6cJDQ2Vb
 bXxqoOFfOHrnyx0xiZuXsjbUusKLB3PTobX9lRsOGUE0Yy1CvJZZcBc+6XY5L5SbWqjA
 AEqFNBOD6NXjX8eS5O/XBKDaT3ITqKPoIhFoCjpc4r9RgVzczHRrdM4K7cjgFzoh/+8G
 NZrK9hGeTLWKpxdyHW8TQmTh/LyGJubFIDIVj/MjueG0EZTaRxmJ5pdiPitodPslmw9Z
 SVs1Y7w/K79WW0kxT0JQEuwWHOn9ikKYc0aSAbMUQm3ihpibMdqyICu/5hVi1sDE64SV
 Y3tA==
X-Gm-Message-State: AOAM531x8KEweGW8VoFTOS45krsopH6BNsmFT3MZHQapuROUcljHCzCD
 cL3KZvx8I5KX6e3tcsO9t7j80rM4l3sYrLt1NTbNupUCwoSyTR5l8szECsnQu5kESJWVvnl3sHI
 lvQJmeEPfHcK5Z+4=
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr94521wmh.156.1602698638564;
 Wed, 14 Oct 2020 11:03:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfa6Cj9yXZA/smaQ4NZTDYJ8SBbDJSp6ZunAkGLIrqzqdO6yTBX7x/J97LpWFMpwjZ9VH6zw==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr94481wmh.156.1602698638200;
 Wed, 14 Oct 2020 11:03:58 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x64sm290093wmg.33.2020.10.14.11.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 11:03:57 -0700 (PDT)
Subject: Re: [PATCH v2 01/15] python: create qemu.core package
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201014142957.763624-1-jsnow@redhat.com>
 <20201014142957.763624-2-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8e0c4840-43ad-5246-e507-3224398d674c@redhat.com>
Date: Wed, 14 Oct 2020 20:03:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014142957.763624-2-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben@bwidawsk.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Rohit Shinde <rohit.shinde12194@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 4:29 PM, John Snow wrote:
> move python/qemu/*.py to python/qemu/core/*.py and update import
> directives across the tree.
> 
> This is done to create a PEP420 namespace package, in which we may
> create subpackages. To do this, the namespace directory ("qemu") should
> not have any modules in it. Those files will go in a new 'core'
> subpackage instead.
> 
> Bolster the core/__init__.py module, making the top-level classes and
> functions from this package available directly inside the `qemu.core`
> namespace.
> 
> This facilitates the convenient shorthand:
> 
>> from qemu.core import QEMUQtestMachine, QEMUMonitorProtocol
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/{qemu => }/.isort.cfg              |  0
>   python/qemu/__init__.py                   | 11 ------
>   python/qemu/{ => core}/.flake8            |  0
>   python/qemu/core/__init__.py              | 44 +++++++++++++++++++++++
>   python/qemu/{ => core}/accel.py           |  0
>   python/qemu/{ => core}/console_socket.py  |  0
>   python/qemu/{ => core}/machine.py         |  0
>   python/qemu/{ => core}/pylintrc           |  0
>   python/qemu/{ => core}/qmp.py             |  0
>   python/qemu/{ => core}/qtest.py           |  0
>   scripts/device-crash-test                 |  2 +-
>   scripts/qmp/qemu-ga-client                |  2 +-
>   scripts/qmp/qmp                           |  2 +-
>   scripts/qmp/qmp-shell                     |  2 +-
>   scripts/qmp/qom-fuse                      |  2 +-
>   scripts/qmp/qom-get                       |  2 +-
>   scripts/qmp/qom-list                      |  2 +-
>   scripts/qmp/qom-set                       |  2 +-
>   scripts/qmp/qom-tree                      |  2 +-
>   scripts/render_block_graph.py             |  6 ++--
>   scripts/simplebench/bench_block_job.py    |  4 +--
>   tests/acceptance/avocado_qemu/__init__.py |  2 +-
>   tests/acceptance/boot_linux.py            |  3 +-
>   tests/acceptance/virtio_check_params.py   |  2 +-
>   tests/acceptance/virtio_version.py        |  2 +-
>   tests/migration/guestperf/engine.py       |  2 +-
>   tests/qemu-iotests/235                    |  2 +-
>   tests/qemu-iotests/297                    |  2 +-
>   tests/qemu-iotests/300                    |  4 +--
>   tests/qemu-iotests/iotests.py             |  4 +--
>   tests/vm/basevm.py                        |  6 ++--
>   31 files changed, 71 insertions(+), 41 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


