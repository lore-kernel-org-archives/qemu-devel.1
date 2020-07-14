Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250F4C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C3022596
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8tQ1AWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C3022596
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvOhz-0007Gq-6H
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 13:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvOhM-0006o5-0s
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:26:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvOhJ-0006Kx-Ac
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594747588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bfFQJxSxZKjEGCmK98BfEbQb6fK5X90j6wuKMi2PYiM=;
 b=M8tQ1AWQz0k9rhtDDa7BOR3X9lKAarsMjnAjESRCooBi0T9QC89vmjKYaq1SksZzy454eB
 bCSPo6XLC0gfeSEqyvrcsjtwRnQllX40ktIIFARdCg/dyv9Wd0RoLXeW1LsL6zbwUhg2a9
 PGp035C2/N0YPjN1M4fjO+1DyyHc0mI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-qlLmHetiNJW30SG4Ci1oHg-1; Tue, 14 Jul 2020 13:26:16 -0400
X-MC-Unique: qlLmHetiNJW30SG4Ci1oHg-1
Received: by mail-wm1-f69.google.com with SMTP id v6so4949446wmg.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 10:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bfFQJxSxZKjEGCmK98BfEbQb6fK5X90j6wuKMi2PYiM=;
 b=DLkTCIXqpm4ta6RkDi5xnNaMoqbxx+OQnz8vV8IAezRqLMr7JvhFdjpHUWW7hrmql+
 gWe/IsnQNsU9Nfuku3FGin/w+kJZIltk/5YvWPYF3WGQ/CeofWHY/lpXnewcHsGKWtrE
 kP9V9Ue+CT3EH352apM1DLhtdBAN7IGpw9jxNdYEICk1AxI6RktBKyBCv1KAipsI8byD
 S1zc8biIS2DbLIaKig7AANwnTrZDbY9PlUZtZpnyix6EhJRV1+yfPqeM1PTpflk4yHws
 7mV2YbgP9T1JIvSvEYkWWqz+12gOi35lpiWJSzgPC3fduJWkpW0tx7fyv8PARZgm6lkb
 VZBA==
X-Gm-Message-State: AOAM533OcBnaiJWikRBeSShE70FUPYobDo4Q592DLBZaHm97cpyFsvjN
 xTPQumZRuePA77k5/FshOx29C0AOHb+DH5VVBxFN60ly/A2Xmgv+az2NZjPJsImi/nj9jSro/6B
 GhqsMZxbadt8ViSk=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr7169406wrs.306.1594747574938; 
 Tue, 14 Jul 2020 10:26:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnNZZ5suWiPlwBicYmjRFMaMd6fwRhr4Xt/7n4bMiANCBwQo/18Mv57RQOqMS6yPc93jteFw==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr7169377wrs.306.1594747574715; 
 Tue, 14 Jul 2020 10:26:14 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f9sm29990749wru.47.2020.07.14.10.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 10:26:13 -0700 (PDT)
Subject: Re: [PATCH v3 for-5.1 0/2] Fix crash due to NBD export leak
To: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, vsementsov@virtuozzo.com
References: <159474538053.11884.16567641221376136360@07a7f0d89f7d>
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
Message-ID: <8474b170-afbf-3e2f-022f-dbf018f7da07@redhat.com>
Date: Tue, 14 Jul 2020 19:26:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159474538053.11884.16567641221376136360@07a7f0d89f7d>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
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
Cc: kwolf@redhat.com, den@openvz.org, stefanha@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Marc-André

On 7/14/20 6:49 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200714162234.13113-1-vsementsov@virtuozzo.com/
...
> 
>   TEST    iotest-qcow2: 022
>   TEST    check-unit: tests/test-char
> **
> ERROR:/tmp/qemu-test/src/tests/test-char.c:1204:char_serial_test: 'chr' should not be NULL
> ERROR test-char - Bail out! ERROR:/tmp/qemu-test/src/tests/test-char.c:1204:char_serial_test: 'chr' should not be NULL

Seems related to latest chardev-pull-request.

> make: *** [check-unit] Error 1
> make: *** Waiting for unfinished jobs....
>   TEST    iotest-qcow2: 024
>   TEST    iotest-qcow2: 025
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=9dc2c7a6e3eb458c88fdd6be6a03c6eb', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-fzvixkio/src/docker-src.2020-07-14-12.32.53.19697:/var/tmp/qemu:z,ro', 'qemu/centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=9dc2c7a6e3eb458c88fdd6be6a03c6eb
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-fzvixkio/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    16m48.396s
> user    0m8.741s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200714162234.13113-1-vsementsov@virtuozzo.com/testing.docker-quick@centos7/?type=message.


