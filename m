Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E147C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E08720674
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmhVy9h6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E08720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjd7-0000dM-0O
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPjcG-00089U-No
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPjcE-0003I1-C1
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601977837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3xbZ5STlDS1tMXzrf8QHaQPYHIPDA/1251SKOUfbLR0=;
 b=HmhVy9h6aAIw4muKITQ6/Otqi4OV/+s/aqmI96UzLPSsXjcFBdGE6q2AXI6Ozz5j5FC4bx
 0pl327h9OOsp56R/itXp2Qy8SPIBA5O166ubprntizT7VIyxkFFnGpYKWUk3aQXTliBGBC
 xB1Ffo8R/O+RuwlPHOc+Cjh3ai1hJx8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-dkc5JK5IMaiyjkhLAr3MHQ-1; Tue, 06 Oct 2020 05:50:36 -0400
X-MC-Unique: dkc5JK5IMaiyjkhLAr3MHQ-1
Received: by mail-wm1-f71.google.com with SMTP id r19so902673wmh.9
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 02:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3xbZ5STlDS1tMXzrf8QHaQPYHIPDA/1251SKOUfbLR0=;
 b=QAj7jO492j36CsFtzqGVZcBe3MVqzkjI++1aXDzrYjxfXQaSJ9YGuYS0BNkIZ1ucvn
 MtidA03+cHqi1l1Z+3nHWBDUBEVkSqMmVHGYCxY1Yvp82UDgCpQPeTcjYdJR6jonE6hF
 cb7GPE2btsXHNrXt4tpLyq9kWBgQBIi4FAY8JYx4VKxKgQ1OVZgPBPUJ8dePdHTOyERc
 CrolaYyLMktOFjYOjsqsz9gW2ov6+3q2gv+HzfoPfSqNi6CObxqnBy+Veker3ik8VJvD
 RK53hN4RqkQtcQz7SY5PlX9I9WinMQUamUD3wr57bv61DxFdngBaIxv/hsxJIHHzLHO+
 bYyA==
X-Gm-Message-State: AOAM532yH6RVDmHLZ92ISBirb2EIVSR8Y8O4Qc0/kg4FAgTA4qFxWBNk
 kaZ+8uf/g13HFMOCJ9cAVMnYvr8ov3Zn3lIFWLCcTonkW0Yr+2oU8b1U9iE0vVGc/bw8xcMCU9w
 rsHUqUCtZSWc32T4=
X-Received: by 2002:a5d:4709:: with SMTP id y9mr3965252wrq.59.1601977834774;
 Tue, 06 Oct 2020 02:50:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+Ru4lCoN3ooyUg9CKni1dbkCT3xfvu6jlqkQmctFTmWEMMvdHM12CT8hx5pB10oAJcDCb0Q==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr3965229wrq.59.1601977834558;
 Tue, 06 Oct 2020 02:50:34 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id g4sm3939543wrm.18.2020.10.06.02.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 02:50:33 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] qom: Always register
 FW_CFG_DATA_GENERATOR_INTERFACE
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201005105442.2093105-1-philmd@redhat.com>
 <20201005105442.2093105-2-philmd@redhat.com>
 <20201005132225.GN2385272@redhat.com>
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
Message-ID: <75862413-b6ac-ae7a-6f6e-a39e103f7e31@redhat.com>
Date: Tue, 6 Oct 2020 11:50:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005132225.GN2385272@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 3:22 PM, Daniel P. Berrangé wrote:
> On Mon, Oct 05, 2020 at 12:54:40PM +0200, Philippe Mathieu-Daudé wrote:
>> While the FW_CFG_DATA_GENERATOR_INTERFACE is only consumed
>> by a device only available using system-mode (fw_cfg), it is
>> implemented by a crypto component (tls-cipher-suites) which
>> is always available when crypto is used.
>>
>> Commit 69699f3055 introduced the following error in the
>> qemu-storage-daemon binary:
>>
>>   $ echo -e \
>>     '{"execute": "qmp_capabilities"}\r\n{"execute": "qom-list-types"}\r\n{"execute": "quit"}\r\n' \
>>     | storage-daemon/qemu-storage-daemon --chardev stdio,id=qmp0  --monitor qmp0
>>   {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 5}, "package": ""}, "capabilities": ["oob"]}}
>>   {"return": {}}
>>   missing interface 'fw_cfg-data-generator' for object 'tls-creds'
>>   Aborted (core dumped)
>>
>> Since QOM dependencies are resolved at runtime, this issue
>> could not be triggered at linktime, and we don't have test
>> running the qemu-storage-daemon binary.
>>
>> Fix by always registering the QOM interface.
>>
>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>> Fixes: 69699f3055 ("crypto/tls-cipher-suites: Produce fw_cfg consumable blob")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> I first used:
>>
>> +if config_host.has_key('CONFIG_GNUTLS') or have_system
>> +  qom_ss.add(files('fw_cfg_interface.c'))
>> +endif
>>
>> but then realized anything could implement a QOM interface,
>> so better keep this generic.
>> ---
>>  hw/nvram/fw_cfg.c      |  7 -------
>>  qom/fw_cfg_interface.c | 15 +++++++++++++++
> 
> I feel this should be left in hw/nvram, but still added to qom_ss.
> 
> The code location should reflect the functional area and maintainership,
> so we shouldn't move code just to satisfy linkage problems.

I thought Meson would conditionally include subdir() meson.build
like the Makefile based previous buildsys, but I was wrong, all
subdir are processed.
I'll respin with your suggestion, thanks.

Phil.


