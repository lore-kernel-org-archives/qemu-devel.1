Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02658C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AFD204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POhYbBIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AFD204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7yfu-0006hI-1b
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 06:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7yfF-0006IK-Jw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:16:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50070
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7yfD-00080c-Bi
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597745778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Sr3wQN0b5Uwb07jdxUU0siNpgfiwiqFEfanP2UGTYiY=;
 b=POhYbBIAxJqSkxeYuFFSDx6DDLa/RQxahWIhdaY4jIUn1KtJiDSBK1mYZJbHJJmGKemdd7
 2HnOwa6vUM34USgX7G23qt1X3cio1Xd2VU1P43a/i9gorriL7CkcgSS3CdUSycYgEjhCAW
 FFKeKcM3GFKIwbc3/VpzQee2B6+gO90=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-ZLdIgHjfPYGwjLuTTpPgxA-1; Tue, 18 Aug 2020 06:16:14 -0400
X-MC-Unique: ZLdIgHjfPYGwjLuTTpPgxA-1
Received: by mail-wr1-f72.google.com with SMTP id f14so8015493wrm.22
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 03:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Sr3wQN0b5Uwb07jdxUU0siNpgfiwiqFEfanP2UGTYiY=;
 b=Z5oF1kMvBvwp1sNXLhRgf7mzYsYsDdNGgh7NvjrAd5JGcroYVATZnpwWpYQRgl+A/o
 +KeMmWclCGIi75CcpZGpuOF0FBnGBtZsUgm5aSy0HC+ICTarsm76ksMdNVam//rXNV2l
 UdGrqhyPz0u5XeDcRM+bM7EH1ptvt8/bPS70UaGZV5JKkayy7GAkxK0oc3EkhBZSFHPp
 taZ7etKMFc/44EOsHCsL1eiLNhgqmiURcKjV1Vf+D9aCn6w4H0PTeeyKXky7UlAz1MbC
 kvTtaX15u2JXm+2CcUtVGBq+TJrHSaZ2l0pvRdrMFAd/IP5XEawRLNIqkTQBqaSCmvYV
 2TNg==
X-Gm-Message-State: AOAM5320DeCgPw2E1lF+HAjjCGtJez8vxGiW8DNiI+qUDPnU8/lKsb7B
 doYgkpIDfs3MwercxZIXNsDb6QCPXgKTpNyjrz2wpT5cOlDQo07ZmBeTn5pAXJGfbksFKdo3rA7
 ZfNIm9MnNYDa3YZs=
X-Received: by 2002:a1c:5a41:: with SMTP id o62mr18967440wmb.16.1597745773226; 
 Tue, 18 Aug 2020 03:16:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyilBgE7TR6mTwi6568kLw8F8IcbAcUm7s6eWNhEI4qkBwfHhSP6CiDtQRWjSaBnwO8V3vZnA==
X-Received: by 2002:a1c:5a41:: with SMTP id o62mr18967404wmb.16.1597745772901; 
 Tue, 18 Aug 2020 03:16:12 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id n11sm26394383wmi.15.2020.08.18.03.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 03:16:11 -0700 (PDT)
Subject: Re: [PATCH V2] Introduce a new flag for piix to disable root bus PCI
 hotplug
To: Ani Sinha <ani@anisinha.ca>, qemu-devel@nongnu.org
References: <1597151528-75766-1-git-send-email-ani@anisinha.ca>
 <CAARzgwxZNpiTLn8aome=tVxHe-ut=Pkbte=McUbr=B2xx6kRfQ@mail.gmail.com>
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
Message-ID: <ffc51bbc-3aa1-ced3-60f2-033291fd1cdc@redhat.com>
Date: Tue, 18 Aug 2020 12:16:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAARzgwxZNpiTLn8aome=tVxHe-ut=Pkbte=McUbr=B2xx6kRfQ@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 8/18/20 11:54 AM, Ani Sinha wrote:
> Igor etc, I just tested this patch using a Windows 2012 R2 image and
> it seems to be working. Any feedbacks on this patch?
> 
> On Tue, Aug 11, 2020 at 6:42 PM Ani Sinha <ani@anisinha.ca> wrote:
>>
>> We introduce a new global flag for PIIX with which we can turn on or off PCI
>> device hotplug on the root bus. This flag can be used to prevent all PCI
>> devices from getting hotplugged or unplugged from the root PCI bus.
>>
>> Signed-off-by: Ani Sinha <ani@anisinha.ca>
>> ---
>>  hw/acpi/piix4.c      |  3 +++
>>  hw/i386/acpi-build.c | 20 ++++++++++++++++----
>>  2 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>> index 26bac4f..94ec35a 100644
>> --- a/hw/acpi/piix4.c
>> +++ b/hw/acpi/piix4.c
>> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>>
>>      AcpiPciHpState acpi_pci_hotplug;
>>      bool use_acpi_hotplug_bridge;
>> +    bool use_acpi_root_pci_hotplug;
>>
>>      uint8_t disable_s3;
>>      uint8_t disable_s4;
>> @@ -635,6 +636,8 @@ static Property piix4_pm_properties[] = {
>>      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>>      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
>>                       use_acpi_hotplug_bridge, true),
>> +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
>> +                     use_acpi_root_pci_hotplug, true),

From what I understood here, this file is already pretty twisted
and Igor doesn't want more workarounds:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg690564.html

¯\_(ツ)_/¯

>>      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>>                       acpi_memory_hotplug.is_enabled, true),
>>      DEFINE_PROP_END_OF_LIST(),
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index b7bcbbb..a82e5c1 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
>>      bool s3_disabled;
>>      bool s4_disabled;
>>      bool pcihp_bridge_en;
>> +    bool pcihp_root_en;
>>      uint8_t s4_val;
>>      AcpiFadtData fadt;
>>      uint16_t cpu_hp_io_base;
>> @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
>>      pm->pcihp_bridge_en =
>>          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
>>                                   NULL);
>> +    pm->pcihp_root_en =
>> +        object_property_get_bool(obj, "acpi-root-pci-hotplug", NULL);
>> +
>>  }
>>
>>  static void acpi_get_misc_info(AcpiMiscInfo *info)
>> @@ -337,12 +341,15 @@ static void build_append_pcihp_notify_entry(Aml *method, int slot)
>>  }
>>
>>  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>> -                                         bool pcihp_bridge_en)
>> +                                         bool pcihp_bridge_en,
>> +                                         bool pcihp_root_en)
>>  {
>>      Aml *dev, *notify_method = NULL, *method;
>>      QObject *bsel;
>>      PCIBus *sec;
>>      int i;
>> +    bool root_bus = pci_bus_is_root(bus);
>> +    bool root_pcihp_disabled = (root_bus && !pcihp_root_en);
>>
>>      bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
>>      if (bsel) {
>> @@ -361,6 +368,9 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>>          bool bridge_in_acpi;
>>
>>          if (!pdev) {
>> +            /* skip if pci hotplug for the root bus is disabled */
>> +            if (root_pcihp_disabled)
>> +                continue;
>>              if (bsel) { /* add hotplug slots for non present devices */
>>                  dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
>>                  aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
>> @@ -419,7 +429,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>>              method = aml_method("_S3D", 0, AML_NOTSERIALIZED);
>>              aml_append(method, aml_return(aml_int(s3d)));
>>              aml_append(dev, method);
>> -        } else if (hotplug_enabled_dev) {
>> +        } else if (hotplug_enabled_dev && !root_pcihp_disabled) {
>>              /* add _SUN/_EJ0 to make slot hotpluggable  */
>>              aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
>>
>> @@ -439,7 +449,8 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>>               */
>>              PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
>>
>> -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
>> +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
>> +                                         pcihp_root_en);
>>          }
>>          /* slot descriptor has been composed, add it into parent context */
>>          aml_append(parent_scope, dev);
>> @@ -1818,7 +1829,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>          if (bus) {
>>              Aml *scope = aml_scope("PCI0");
>>              /* Scan all PCI buses. Generate tables to support hotplug. */
>> -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
>> +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en,
>> +                                         pm->pcihp_root_en);
>>
>>              if (TPM_IS_TIS_ISA(tpm)) {
>>                  if (misc->tpm_version == TPM_VERSION_2_0) {
>> --
>> 2.7.4
>>
> 


