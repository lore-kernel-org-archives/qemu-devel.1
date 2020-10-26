Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786C9C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC33B20791
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4WGN9h9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC33B20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXBEF-0001s5-RX
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 18:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXBDP-0001SP-6I
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXBDM-0002oQ-KT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603752221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2U+UfvmnRHyw1OHw85R6WNy0gmWT8eY4rhWl2mHSiwM=;
 b=X4WGN9h9bBo4MTPK7kAo7K5T8gpjzFO4gXwiCaRv3WvN6MMdVRfj1C14VOm/uaBC9m1J3r
 dAdhW4CfDiVMxjD8MMtWHvNL/D6cDJ8ZMxF/XiG17XrdHBP9zVkOleG8ZxY7MLwtENRK0q
 bI++FSfd/lFZhugLoDEYfIBTGVBKm18=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-gMbNknlDN4Kh3U97rmfblg-1; Mon, 26 Oct 2020 18:43:40 -0400
X-MC-Unique: gMbNknlDN4Kh3U97rmfblg-1
Received: by mail-ej1-f69.google.com with SMTP id c10so6599165ejm.15
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 15:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2U+UfvmnRHyw1OHw85R6WNy0gmWT8eY4rhWl2mHSiwM=;
 b=mw52MfvToCK0MpkVicakU4HErJkvXrKVjumvQS3Upfr+eUDXTp6zwUKW9WwgxjVLl2
 PscVauzMABUXaLrqc0wQ9O/VUxRMUshVUGlwNNo2cQKRiFzzKJ0cgn0cxyhIo452m4Ce
 zAXYLbVKKlTM7ccFWrV3u9ya9IWuirODCNyRT3tclN5qn7NemSiBFYYpjgSnlRuEQYIp
 UKzh2MtTEKTVRt/E8ZAvvIILwl0C9egkjxEyFmZ9qlZCE2ChR2UwQq1DIIpT3r/JLxsx
 9O97eVo+Du7r6Fhp36YgIx4tUXZrRWRN66/PD8D1nh7g/P/5AiRr3Itu36E8urCfEq2E
 vStg==
X-Gm-Message-State: AOAM531u0Ce3K6gCf00MbiupBpnfuG4k20dLW+zHwgDPmbc3MJmd/Ckn
 wrhLtE2v7FYfmxMkRVsgfILqvKJxUYUBK3z0WyMOZSHVznSKmIGkPGTTwf23i3/2M0cBj4xkJpW
 o/JfcrpC3Q7Ia9bY=
X-Received: by 2002:a17:906:1bea:: with SMTP id
 t10mr17541857ejg.305.1603752218765; 
 Mon, 26 Oct 2020 15:43:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1IYl0487eDRvHnmGC2klH9qLW+4Ey0plIoyrvgEoT0tLe7DksOjtQqVkOoa24+trRx0vzjw==
X-Received: by 2002:a17:906:1bea:: with SMTP id
 t10mr17541838ejg.305.1603752218536; 
 Mon, 26 Oct 2020 15:43:38 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e2sm6565823ejd.81.2020.10.26.15.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 15:43:37 -0700 (PDT)
Subject: Re: runaway avocado
To: Peter Maydell <peter.maydell@linaro.org>,
 avocado-devel <avocado-devel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <CAFEAcA8z=vQ9E6hNKUuzk2EgH8Dpkxo=3YbnQ5iX0DYCQDr6bg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <caccebbf-e12d-ab91-d631-ae126d8cddf7@redhat.com>
Date: Mon, 26 Oct 2020 23:43:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8z=vQ9E6hNKUuzk2EgH8Dpkxo=3YbnQ5iX0DYCQDr6bg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing avocado-devel@

On 10/26/20 11:35 PM, Peter Maydell wrote:
> So, I somehow ended up with this process still running on my
> local machine after a (probably failed) 'make check-acceptance':
> 
> petmay01 13710 99.7  3.7 2313448 1235780 pts/16 Sl  16:10 378:00
> ./qemu-system-aarch64 -display none -vga none -chardev
> socket,id=mon,path=/var/tmp/tmp5szft2yi/qemu-13290-monitor.sock -mon
> chardev=mon,mode=control -machine virt -chardev
> socket,id=console,path=/var/tmp/tmp5szft2yi/qemu-13290-console.sock,server,nowait
> -serial chardev:console -icount
> shift=7,rr=record,rrfile=/var/tmp/avocado_iv8dehpo/avocado_job_w9efukj5/32-tests_acceptance_reverse_debugging.py_ReverseDebugging_AArch64.test_aarch64_virt/replay.bin,rrsnapshot=init
> -net none -drive
> file=/var/tmp/avocado_iv8dehpo/avocado_job_w9efukj5/32-tests_acceptance_reverse_debugging.py_ReverseDebugging_AArch64.test_aarch64_virt/disk.qcow2,if=none
> -kernel /home/petmay01/avocado/data/cache/by_location/a00ac4ae676ef0322126abd2f7d38f50cc9cbc95/vmlinuz
> -cpu cortex-a53
> 
> and it was continuing to log to a deleted file
> /var/tmp/avocado_iv8dehpo/avocado_job_w9efukj5/32-tests_acceptance_reverse_debugging.py_ReverseDebugging_AArch64.test_aarch64_virt/replay.bin
> 
> which was steadily eating my disk space and got up to nearly 100GB
> in used disk (invisible to du, of course, since it was an unlinked
> file) before I finally figured out what was going on and killed it
> about six hours later...
> 
> Any suggestions for how we might improve the robustness of the
> relevant test ?
> 
> thanks
> -- PMM
> 


