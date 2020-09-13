Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E44C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 11:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA562151B
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 11:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fw4+4kW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA562151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHQFT-0006f1-Qy
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 07:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHQEb-00064X-Sz
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 07:31:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27452
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHQEY-0002qs-73
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 07:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599996708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GIAySS27Eot4EqlPC5aKlcLDvkJo1dEo9RZF9UXhruo=;
 b=Fw4+4kW+YQkpkroIUJUDk5LBStqzDkLZ+v7Zfo+uWvjGqZTRFPR+11sPhXQ8NKENQ2JlZD
 mKsuhtqVag77iA6VTXiAVvleO4hGn9I0I0lQY/g1viC0AOL12GbReu7orIfT1pylIvomJV
 ZcI3yU2v3DinRXnCXIRJYuo04/hNFqU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-ikdAoo0tOW2YOmJUeF_s6w-1; Sun, 13 Sep 2020 07:31:44 -0400
X-MC-Unique: ikdAoo0tOW2YOmJUeF_s6w-1
Received: by mail-wr1-f71.google.com with SMTP id i10so5450611wrq.5
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 04:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GIAySS27Eot4EqlPC5aKlcLDvkJo1dEo9RZF9UXhruo=;
 b=ZBT/gxwpBErUWOZhM4aUAXImbzjA/X+3bvRRH7Q+plK4OI2KS5QcpTYozxixPmNU6w
 YKPbmXFoEJBUFuymkc4pwm6wijxfVMgn+sNOW9tRjU+IXdAz87K1kaurV2WWC2ASAsXl
 6vkLVVFWHXVNNvvS5R+vgkgF1zc+H6aMyMO+w8VJ6SF34gPMZ9FQplwirQrsZpKICdHT
 Z05BSGHa0q3oS7RJjgduQBMgloG4WdGmqL8mpyfcTZc6XoIm0k7a/bTZJeje+s8el4MR
 +ABC5IkIdT5n/H8ne+PbASKJmCY9DYmkHNZdtrx4mnfD1j2i9rwrvgq6ek6c2R4VWcbX
 i0kg==
X-Gm-Message-State: AOAM531t3uXOAoAyVCM3LBNtNU/jIti+FxD5iudz74Fu56BMyqe+SZ65
 xukS23xIZqExGf5whO58YjtdjS0S5DZ+AgfDKQIlt/wSXSF9izNvxfxndfQkaNJszz2kaGoICwO
 KGCg1e4StyX9B9Kc=
X-Received: by 2002:adf:f44d:: with SMTP id f13mr10707114wrp.224.1599996703602; 
 Sun, 13 Sep 2020 04:31:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxn625O9ZbhinOdfKpGc03+gkIdIsafgEQCcjV4kGlXYvbf7KsRWsvbC0Yx3d8ShVsjyFRSvQ==
X-Received: by 2002:adf:f44d:: with SMTP id f13mr10707078wrp.224.1599996703292; 
 Sun, 13 Sep 2020 04:31:43 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v9sm17385273wrv.35.2020.09.13.04.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 04:31:42 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] user-mode: Prune build dependencies (part 2)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20200910152225.524322-1-philmd@redhat.com>
 <f8c9c94c-9b27-6c16-bde1-1a0a91287563@redhat.com>
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
Message-ID: <fb687ccc-919c-6c61-4dbc-9e76625c3743@redhat.com>
Date: Sun, 13 Sep 2020 13:31:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f8c9c94c-9b27-6c16-bde1-1a0a91287563@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 07:31:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/20 11:16 AM, Paolo Bonzini wrote:
> On 10/09/20 17:22, Philippe Mathieu-Daudé wrote:
>> This is the second part of a series reducing user-mode
>> dependencies. By stripping out unused code, the build
>> and testing time is reduced (as is space used by objects).
>>
>> Part 2:
>> - Extract code not related to user-mode from qapi/misc.json
>>
>> Since v3:
>> - Rebased (Meson)
>> - Addressed Markus comments:
>>   - Use g_assert_not_reached() in stub
>>   - Add commit descriptions
>>   - Extract ACPI / PCI
>>   - MEMORY not extracted as no feedback from Igor/MST
>>
>> Since v2:
>> - Addressed Igor review comments (move query-uuid to machine)
>> - Addressed David review comments (fix balloon documentation)
>>
>> Since v1:
>> - Do not extract the 'add_client' command (elmarco)
>>
>> CI:
>> https://gitlab.com/philmd/qemu/-/pipelines/188367944
>>
>> Philippe Mathieu-Daudé (9):
>>   target/i386: Restrict X86CPUFeatureWord to X86 targets
>>   qapi: Restrict LostTickPolicy enum to machine code
>>   qapi: Correct balloon documentation
>>   qapi: Restrict balloon-related commands to machine code
>>   qapi: Restrict query-vm-generation-id command to machine code
>>   qapi: Restrict query-uuid command to machine code
>>   qapi: Restrict device memory commands to machine code
>>   qapi: Extract ACPI commands to 'acpi.json'
>>   qapi: Extract PCI commands to 'pci.json'
>>
>>  qapi/acpi.json                       | 141 +++++
>>  qapi/machine-target.json             |  45 ++
>>  qapi/machine.json                    | 430 ++++++++++++--
>>  qapi/misc.json                       | 820 ---------------------------
>>  qapi/pci.json                        | 316 +++++++++++
>>  qapi/qapi-schema.json                |   2 +
>>  include/hw/acpi/acpi_dev_interface.h |   2 +-
>>  include/hw/mem/memory-device.h       |   2 +-
>>  include/hw/rtc/mc146818rtc.h         |   2 +-
>>  include/hw/virtio/virtio-pmem.h      |   2 +-
>>  include/sysemu/balloon.h             |   2 +-
>>  block/iscsi.c                        |   2 +-
>>  hw/acpi/core.c                       |   2 +-
>>  hw/acpi/cpu.c                        |   2 +-
>>  hw/acpi/memory_hotplug.c             |   3 +-
>>  hw/acpi/vmgenid.c                    |   2 +-
>>  hw/core/qdev-properties.c            |   1 +
>>  hw/i386/kvm/i8254.c                  |   2 +-
>>  hw/pci/pci-stub.c                    |   2 +-
>>  hw/pci/pci.c                         |   2 +-
>>  hw/virtio/virtio-balloon.c           |   2 +-
>>  hw/virtio/virtio-mem-pci.c           |   1 +
>>  monitor/hmp-cmds.c                   |   2 +
>>  monitor/qmp-cmds.c                   |   1 +
>>  softmmu/balloon.c                    |   2 +-
>>  stubs/uuid.c                         |   2 +-
>>  stubs/vmgenid.c                      |   2 +-
>>  target/i386/cpu.c                    |   2 +-
>>  target/i386/machine-stub.c           |  23 +
>>  MAINTAINERS                          |   2 +
>>  qapi/meson.build                     |   2 +
>>  target/i386/meson.build              |   1 +
>>  32 files changed, 944 insertions(+), 880 deletions(-)
>>  create mode 100644 qapi/acpi.json
>>  create mode 100644 qapi/pci.json
>>  create mode 100644 target/i386/machine-stub.c
>>
> 
> I'm not sure about the first.  It's a bit ugly to have a property whose
> getter aborts.

This is (IIUC) the change Markus requested in v3 (see [*]).

Commit description: "add a stub to satisfy the linker."

This stub should be never used on user-mode => abort.

[*] https://www.mail-archive.com/qemu-block@nongnu.org/msg67560.html

> 
> For patches 2-9 though:
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks!

> 
> Paolo
> 


