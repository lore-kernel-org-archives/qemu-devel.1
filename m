Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AFBC4727D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBDB20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dx7wlxwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBDB20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmmZ-0005Iy-Sc
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 09:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmd1-00037K-9H
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 09:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmct-0002hW-ED
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 09:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601989409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eYiffUvGIC3Z/S5dLTTEitmiRe7g4l10VFE8WFTisTw=;
 b=Dx7wlxwoJmRf4bQ+CpmNhh4P9bVehfRapGw0fkdj7KmODwQC2RkruwDwGIVsFpP/EfAnsK
 Ba0VZffHoaGaQXV2CSihiRXNfbUjVX53QEqhZbuNlWgKKycKmvvKLTVPWV7mI3XFSKQNOA
 j4Ptvno4N0y/O7NxUVIfE7fZE03FZLA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-CZ_bZWH3NouwhhUJgF7FmQ-1; Tue, 06 Oct 2020 09:03:28 -0400
X-MC-Unique: CZ_bZWH3NouwhhUJgF7FmQ-1
Received: by mail-wr1-f71.google.com with SMTP id o6so5312978wrp.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 06:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=eYiffUvGIC3Z/S5dLTTEitmiRe7g4l10VFE8WFTisTw=;
 b=oDfKrffGk/0mxwnavKbfkhZGe1ij0f19deXbYrKrUwMjemhzREEyUYaWanS4yNmkGb
 Ac5rXYlJcqKpWG7jx7DpAfH+zbZMDJTUK2YFdylHCjbblvTgonbCCQXkSPr8wgHeU28U
 XqB8h5wRypwYp1yQ5HyEDfky5VaZn3v9jaVHdXQdvdf6xkzDlzm9rzQZhvQjRrpaJWdL
 pI9fKA1CYBsTySqKmjR67GwBtUQCe+o4FoyzaQvVcYj5KlLmUSMcUmtM4sZ4cY/LiFVb
 ZEKWFWG3rNQeYmxDPWTWwIYSoVcsJZQlAH87bzholKR9dPIjVLbIzHI2Jw6hXcGVL8lS
 sGig==
X-Gm-Message-State: AOAM5333lz/xSb4sqwYh2QdqgRJydIbM7cxs/D5+FTzIeVmcGA2kecbm
 W85FEd+nuiJa46PJL08FhpDT4x4OR38Bp0i9msXQUR9RUEiwA6AIW3W8PNzDhCFgcBMTPUSfMmO
 hMgT4TgBvpSwSPTc=
X-Received: by 2002:a5d:504a:: with SMTP id h10mr4637468wrt.85.1601989406935; 
 Tue, 06 Oct 2020 06:03:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+ydZAFlBIWIx1bWLVK8LHkwixAEuNQcSrhjFzJxZjgOIaBYaGRZ9mGUnm0peLOh6xRVvcAg==
X-Received: by 2002:a5d:504a:: with SMTP id h10mr4637412wrt.85.1601989406523; 
 Tue, 06 Oct 2020 06:03:26 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id k8sm4368553wrl.42.2020.10.06.06.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 06:03:25 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] hw/nvram: Always register
 FW_CFG_DATA_GENERATOR_INTERFACE
To: Laszlo Ersek <lersek@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
References: <20201006111909.2302081-1-philmd@redhat.com>
 <20201006111909.2302081-2-philmd@redhat.com>
 <218dedba-ccec-8d7f-5697-a9634c362ea4@redhat.com>
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
Message-ID: <227b833f-eec6-64ab-3062-a552a82b9e7f@redhat.com>
Date: Tue, 6 Oct 2020 15:03:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <218dedba-ccec-8d7f-5697-a9634c362ea4@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 2:55 PM, Laszlo Ersek wrote:
> On 10/06/20 13:19, Philippe Mathieu-Daudé wrote:
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
>>  hw/nvram/fw_cfg-interface.c | 15 +++++++++++++++
>>  hw/nvram/fw_cfg.c           |  7 -------
>>  MAINTAINERS                 |  2 +-
>>  hw/nvram/meson.build        |  3 +++
>>  4 files changed, 19 insertions(+), 8 deletions(-)
>>  create mode 100644 hw/nvram/fw_cfg-interface.c
>>
>> diff --git a/hw/nvram/fw_cfg-interface.c b/hw/nvram/fw_cfg-interface.c
>> new file mode 100644
>> index 0000000000..2b19502ffe
>> --- /dev/null
>> +++ b/hw/nvram/fw_cfg-interface.c
>> @@ -0,0 +1,15 @@
>> +#include "qemu/osdep.h"
>> +#include "hw/nvram/fw_cfg.h"
>> +
>> +static const TypeInfo fw_cfg_data_generator_interface_info = {
>> +    .parent = TYPE_INTERFACE,
>> +    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
>> +    .class_size = sizeof(FWCfgDataGeneratorClass),
>> +};
>> +
>> +static void fw_cfg_register_types(void)
>> +{
>> +    type_register_static(&fw_cfg_data_generator_interface_info);
>> +}
>> +
>> +type_init(fw_cfg_register_types)
> 
> Can you rename *this* instance of "fw_cfg_register_types" to
> "fw_cfg_register_interfaces"?
> 
> While the code is correct from the C lang perspective, duplicate
> function names are not convenient when debugging with gdb, or when
> jumping to tags in an editor.

Sure.

> 
> With the rename:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!

> 
> (If you strongly disagree, I'm OK to R-b v2 as well.)
> 
> Thanks,
> Laszlo
> 
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 0e95d057fd..08539a1aab 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -1360,18 +1360,11 @@ static const TypeInfo fw_cfg_mem_info = {
>>      .class_init    = fw_cfg_mem_class_init,
>>  };
>>  
>> -static const TypeInfo fw_cfg_data_generator_interface_info = {
>> -    .parent = TYPE_INTERFACE,
>> -    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
>> -    .class_size = sizeof(FWCfgDataGeneratorClass),
>> -};
>> -
>>  static void fw_cfg_register_types(void)
>>  {
>>      type_register_static(&fw_cfg_info);
>>      type_register_static(&fw_cfg_io_info);
>>      type_register_static(&fw_cfg_mem_info);
>> -    type_register_static(&fw_cfg_data_generator_interface_info);
>>  }
>>  
>>  type_init(fw_cfg_register_types)
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b76fb31861..a45d908ebd 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2054,7 +2054,7 @@ R: Laszlo Ersek <lersek@redhat.com>
>>  R: Gerd Hoffmann <kraxel@redhat.com>
>>  S: Supported
>>  F: docs/specs/fw_cfg.txt
>> -F: hw/nvram/fw_cfg.c
>> +F: hw/nvram/fw_cfg*.c
>>  F: stubs/fw_cfg.c
>>  F: include/hw/nvram/fw_cfg.h
>>  F: include/standard-headers/linux/qemu_fw_cfg.h
>> diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
>> index 1f2ed013b2..fd2951a860 100644
>> --- a/hw/nvram/meson.build
>> +++ b/hw/nvram/meson.build
>> @@ -1,3 +1,6 @@
>> +# QOM interfaces must be available anytime QOM is used.
>> +qom_ss.add(files('fw_cfg-interface.c'))
>> +
>>  softmmu_ss.add(files('fw_cfg.c'))
>>  softmmu_ss.add(when: 'CONFIG_CHRP_NVRAM', if_true: files('chrp_nvram.c'))
>>  softmmu_ss.add(when: 'CONFIG_DS1225Y', if_true: files('ds1225y.c'))
>>
> 


