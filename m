Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C8EC388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 18:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB99820757
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 18:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqpDjrsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB99820757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka0mj-00051f-QF
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 13:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1ka0lG-0003fX-M7
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 13:10:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1ka0lE-0004ae-OG
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 13:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604427023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AKwOFgGcymvVNOKEIioVZmLaWhOtgze5Ao/ktMiXOlM=;
 b=DqpDjrslkiZUcy88VFnWAiG895cAI7mlLiHxVX4QfdN0fgzLGDaI59EFKTccLW1K637uRx
 p1yL7rW1n+dEGdB0SAx0lpo0Qi7yJjvY6iWWAB4PKbTEs0v2uy48n3mKGHoiQdjsXWwDjC
 re2WifyDWxL28GRGDTYIOkYwd4dNcog=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-yj11hu8HMQamgWw6TfEdhQ-1; Tue, 03 Nov 2020 13:10:22 -0500
X-MC-Unique: yj11hu8HMQamgWw6TfEdhQ-1
Received: by mail-wm1-f70.google.com with SMTP id u9so64800wmb.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 10:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xzfCQh99cGndCB9rfFEpKH/Vq1xIq+5YH799EdIheUE=;
 b=ImBSuddmLHPy9CJXPj1lsztvVrM3y1DKcONhkATQyz8pq1q52ldkZ2hhG3jDEL1KrV
 E7fc+wsX/dflpnVCT3/TgjEEa43pKkXfZ+a3MU/d/DSCh8W5JpIPA3XUX1uUw6AjE6Kr
 QKtApkHLG9O6KQ8T3hzyfjoK2+2wP5ssHOU9P9Xg8RxIS45gyslMRS4ixAg0tBA2Gio1
 tSHxAO31OInzNbq4UKbNf/Ej366jqM+Z0CvnjbdyfZkXksK77B9Q0xL2V83fAHiEvqZ/
 ij9akKTiNJhRF+4ES2FYy6fg7BXw7Vh1HG1QYB3qCAa4H67Pe+/nBnZBRREtqfY+GvOr
 qmqw==
X-Gm-Message-State: AOAM533lXA41oeH096NvMHsZZYAect0g/rkOIhbyyOTS8/TfWsARQ8fo
 C1FhX3heIkSRXLVmbgifxV5ISE8q+WTPurBCww/RbvaJb/mvHtOcdOkVMHGRrjp8rlYmUCl+yui
 NqxKNCSVubJTM1Is=
X-Received: by 2002:adf:f4c9:: with SMTP id h9mr26409328wrp.332.1604427019744; 
 Tue, 03 Nov 2020 10:10:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzO/7jXpDrrtDzcoSbZUF21MKR9bWW8Jwjv3cVgyGyUKdmFh8CtylP6MPGV0oe8s/2fv6Kiuw==
X-Received: by 2002:adf:f4c9:: with SMTP id h9mr26409291wrp.332.1604427019418; 
 Tue, 03 Nov 2020 10:10:19 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t5sm30098233wrb.21.2020.11.03.10.10.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 10:10:18 -0800 (PST)
Subject: Re: [PULL 5/7] tests.acceptance: adds simple migration test
To: Cleber Rosa <crosa@redhat.com>
References: <20190222194146.13102-1-crosa@redhat.com>
 <20190222194146.13102-6-crosa@redhat.com>
 <CAP+75-UtiMFdp=ReaH0Vn7OD60hS+ZNsSvJyvVp1948Syn=ZGQ@mail.gmail.com>
 <20201103152636.GA3140758@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <00d0ee82-6704-6b59-8ae1-fb7b57be7226@redhat.com>
Date: Tue, 3 Nov 2020 19:10:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103152636.GA3140758@localhost.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Wainer Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 4:27 PM, Cleber Rosa wrote:
> On Tue, Nov 03, 2020 at 11:40:30AM +0100, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On Fri, Feb 22, 2019 at 8:42 PM Cleber Rosa <crosa@redhat.com> wrote:
>>>
>>> From: Caio Carrara <ccarrara@redhat.com>
>>>
>>> This change adds the simplest possible migration test. Beyond the test
>>> purpose itself it's also useful to exercise the multi virtual machines
>>> capabilities from base avocado qemu test class.
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> Signed-off-by: Caio Carrara <ccarrara@redhat.com>
>>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>>> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>> Message-Id: <20190212193855.13223-3-ccarrara@redhat.com>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>  tests/acceptance/migration.py | 53 +++++++++++++++++++++++++++++++++++
>>>  1 file changed, 53 insertions(+)
>>>  create mode 100644 tests/acceptance/migration.py
>>>
>>> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
>>> new file mode 100644
>>> index 0000000000..6115cf6c24
>>> --- /dev/null
>>> +++ b/tests/acceptance/migration.py
>>> @@ -0,0 +1,53 @@
>>> +# Migration test
>>> +#
>>> +# Copyright (c) 2019 Red Hat, Inc.
>>> +#
>>> +# Authors:
>>> +#  Cleber Rosa <crosa@redhat.com>
>>> +#  Caio Carrara <ccarrara@redhat.com>
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>>> +# later.  See the COPYING file in the top-level directory.
>>> +
>>> +
>>> +from avocado_qemu import Test
>>> +
>>> +from avocado.utils import network
>>> +from avocado.utils import wait
>>> +
>>> +
>>> +class Migration(Test):
>>> +    """
>>> +    :avocado: enable
>>> +    """
>>> +
>>> +    timeout = 10
>>> +
>>> +    @staticmethod
>>> +    def migration_finished(vm):
>>> +        return vm.command('query-migrate')['status'] in ('completed', 'failed')
>>> +
>>> +    def _get_free_port(self):
>>> +        port = network.find_free_port()
>>> +        if port is None:
>>> +            self.cancel('Failed to find a free port')
>>> +        return port
>>
>> This method doesn't seem to work when running with -j2: 2 tests started
>> with different arch configurations get the same port... Is this a known issue?
>>
> 
> It's not bullet proof, but it seems to be quite safe... This is what I've tried:
> 
>  $ ./tests/venv/bin/avocado run --test-runner=nrunner --nrunner-max-parallel-tasks=10 tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost{,,,,,,,,,,,,,,,,,,,} 
> JOB ID     : 377957f4a16fbc2c6a6f6d9ae225c61af86bd570
> JOB LOG    : /home/cleber/avocado/job-results/job-2020-11-03T10.24-377957f/job.log
>  (02/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: STARTED
>  (06/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: STARTED
>  (01/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: STARTED
>  (05/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: STARTED
>  (03/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: STARTED
>  (10/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: STARTED
>  (07/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: STARTED
>  (09/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: STARTED
>  (04/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: STARTED
>  (08/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: STARTED
>  (02/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: PASS (0.46 s)
>  (06/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: PASS (0.60 s)
>  (01/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: PASS (0.51 s)
>  (03/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: PASS (0.49 s)
>  (05/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: PASS (0.52 s)
>  (10/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: PASS (0.51 s)
>  (07/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: PASS (0.52 s)
>  (09/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: PASS (0.53 s)
>  (04/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: PASS (0.49 s)
>  (08/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_localhost: PASS (0.56 s)
> ...
> RESULTS    : PASS 20 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
> JOB HTML   : /home/cleber/avocado/job-results/job-2020-11-03T10.24-377957f/results.html
> JOB TIME   : 3.82 s

Thanks for the testing.

> If this is about the issue you posted on IRC, it's about s390x and migration instead:
> 
> 2020-11-03 10:06:33,124 qmp              L0255 DEBUG| >>> {'execute': 'query-migrate'}
> 2020-11-03 10:06:33,124 qmp              L0148 DEBUG| <<< {'timestamp': {'seconds': 1604415993, 'microseconds': 124382}, 'event': 'GUEST_PANICKED', 'data': {'action': 'pause', 'info': {'core': 0, 'psw-addr': 0, 'reason': 'disabled-wait', 'psw-mask':
> 
> I ran across this on Friday, and will properly report it.

Ah I missed that *sigh* thanks.

> 
> Let me know if that helps,
> - Cleber.
> 


