Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0716DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 07:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C169120829
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 07:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcMLC8X7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C169120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6UTe-0006L2-3B
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 03:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6USz-0005vU-FF
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 03:49:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58651
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6USx-0008NB-AW
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 03:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597391370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E1LvzE/UkXoMZu+EUee66U/Bhb40IX0fe13AsPKM+xk=;
 b=YcMLC8X7EdLc3qJ2UnhXaf28CwbQVG2RiElXGbjbxbAyMuG13qT9KDKceHpI+R4GcrkXOm
 WNQefZwpi5991vJKfxgHntgK9+fzvbizVjrSx5rdNCLBmIxkwZZ9BxhJyMZTVyFCqyU4Ps
 2G2bddb7jf0oAGzthpEpjSgNQPUak0Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-1iiqihWpMbutn3CMryhBHg-1; Fri, 14 Aug 2020 03:49:26 -0400
X-MC-Unique: 1iiqihWpMbutn3CMryhBHg-1
Received: by mail-wm1-f70.google.com with SMTP id t26so2989715wmn.4
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 00:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=E1LvzE/UkXoMZu+EUee66U/Bhb40IX0fe13AsPKM+xk=;
 b=bzOdTjcPRiy7pbXft4h3hBdlovc4ShR3vsfokazr0XE3F42SnlF34GY33sxB+mjMSI
 KVFyJgX/Hb6Ea++ejanlPrk/74Zvz3kWnEbKKkqng1huybacCjmrLgzSwpVtNkjdueMc
 Mcq9PqoNgNlon5v22MwxCqPzhgvC9rEcMD+k26Nc5cEjBxOn521ZJK8hYiFPLsjhe9KR
 Up6Im4X+NCW31c4qxG/nvx5ETSgM/9SKQ6PY2j+HVgqfw2OQgIco7k+GBHo3UO4PwRWY
 hxQv1INN/bwVOSCBZrYVctPLlGB8QoqRdc8ojtX6u1W6JBDcXA0kLtZLGbBXfFGgAK5L
 rOcA==
X-Gm-Message-State: AOAM531Zn/o/KSHF1tWc+9zW8142XDjRkiqTu7k61FM2dQwYtUfwvzuu
 oWOy3fYUnAM+lKPftHVm1j7cLkCkDaQelx1SMCECk8b6sYqtTaBixfaEdcl1ASIzslXOE5Gxp0i
 mm5rkmjOjhpAvW6E=
X-Received: by 2002:a1c:7e44:: with SMTP id z65mr1470678wmc.13.1597391365428; 
 Fri, 14 Aug 2020 00:49:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyM0yv6LuUznprFWvRQQuTvv6iFIrXSUZTqE7dRxI8OLI0rYXOSlwM+dkIygIwgPZyrAWK2Aw==
X-Received: by 2002:a1c:7e44:: with SMTP id z65mr1470651wmc.13.1597391365182; 
 Fri, 14 Aug 2020 00:49:25 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j24sm15252993wrb.49.2020.08.14.00.49.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 00:49:24 -0700 (PDT)
Subject: Re: [PATCH v5 00/14] QEMU cpus.c refactoring part2
To: Claudio Fontana <cfontana@suse.de>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <159732818874.15736.6159613223332985218@66eaa9a8a123>
 <543b7917-1949-9548-6648-c798efaf70ba@suse.de>
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
Message-ID: <227a3142-36b8-9f61-b4b5-a45eed68acc4@redhat.com>
Date: Fri, 14 Aug 2020 09:49:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <543b7917-1949-9548-6648-c798efaf70ba@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 03:37:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 ehabkost@redhat.com, haxm-team@intel.com, mtosatti@redhat.com,
 armbru@redhat.com, r.bolshakov@yadro.com, dovgaluk@ispras.ru,
 wenchao.wang@intel.com, pbonzini@redhat.com, sunilmut@microsoft.com,
 rth@twiddle.net, alex.bennee@linaro.org, colin.xu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 6:06 PM, Claudio Fontana wrote:
> Any current infra work that could cause this failure?
> 
> I do not have problems when testing this set of commands locally,
> for me it's all green.

Marc-André tried to debug this, but is having hard time reproducing.

> 
> Thanks,
> 
> Claudio
> 
> On 8/13/20 4:16 PM, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20200812183250.9221-1-cfontana@suse.de/
>>
>>
>>
>> Hi,
>>
>> This series failed the docker-quick@centos7 build test. Please find the testing commands and
>> their output below. If you have Docker installed, you can probably reproduce it
>> locally.
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>> make docker-image-centos7 V=1 NETWORK=1
>> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
>> === TEST SCRIPT END ===
>>
>>   TEST    check-unit: tests/test-char
>> Unexpected error in object_property_try_add() at /tmp/qemu-test/src/qom/object.c:1181:
>> attempt to add duplicate property 'serial-id' to object (type 'container')
>> ERROR test-char - too few tests run (expected 38, got 9)
>> make: *** [check-unit] Error 1
>> make: *** Waiting for unfinished jobs....
>>   TEST    check-qtest-x86_64: tests/qtest/hd-geo-test
>> qemu-system-aarch64: -accel kvm: invalid accelerator kvm
>> ---
>>     raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=e2cd2d5f1f1d4eb6bc6bcd79e3d16404', '-u', '1001', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-2np4x1wq/src/docker-src.2020-08-13-10.00.40.11908:/var/tmp/qemu:z,ro', 'qemu/centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
>> filter=--filter=label=com.qemu.instance.uuid=e2cd2d5f1f1d4eb6bc6bcd79e3d16404
>> make[1]: *** [docker-run] Error 1
>> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-2np4x1wq/src'
>> make: *** [docker-run-test-quick@centos7] Error 2
>>
>> real    15m49.276s
>> user    0m8.608s
>>
>>
>> The full log is available at
>> http://patchew.org/logs/20200812183250.9221-1-cfontana@suse.de/testing.docker-quick@centos7/?type=message.
>> ---
>> Email generated automatically by Patchew [https://patchew.org/].
>> Please send your feedback to patchew-devel@redhat.com
>>
> 


