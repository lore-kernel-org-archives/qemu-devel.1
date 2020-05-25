Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C96BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B8A208A7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBmAGH4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B8A208A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdDr8-0003pe-0p
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 10:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdDq5-0002aW-CC
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:12:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38709
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdDq3-0005ND-CC
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590415941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cw0QuUNnEmFDBI+9RBVfIrh3pClI25Yb2YK7C5VjR7Q=;
 b=BBmAGH4/TV3ud0wTobvjyPWcfvGyEmKO407QeeIPECXt6Y1pq14NHxWa/g+hikY+mlVEuF
 oZ34V24IHu9sEavF/iq+Nq/k3N714JL6i0zmsrzjjh63+ZapxccLHSlL0+PxZie9jVTaYT
 rHldQBx7Z66fhBPH5LOzFhZ7jdYgkUc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-iXG6WiliNBGCec5zO0R3ag-1; Mon, 25 May 2020 10:12:20 -0400
X-MC-Unique: iXG6WiliNBGCec5zO0R3ag-1
Received: by mail-ej1-f70.google.com with SMTP id h17so13675ejo.21
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 07:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Cw0QuUNnEmFDBI+9RBVfIrh3pClI25Yb2YK7C5VjR7Q=;
 b=IFsraFeSMckRSKC025qa0LhfECE0gmvFTavXYUMpU+VhaG8ouy1Sfkk4JXXfWWNiVU
 ftgmeZAgkIeM9BU1LE97K2Pu+vLSEes9cnVAmOaaB6StKZOK6Vy4PuTBrIVEw8lVKsdZ
 Uxl1Zv3Ea9O+Xu8fKSx/I3+cykrFJ0wt2N9y5mCtP3ZiYj2H2NsFdcttyF4UIZn2ctvQ
 i/+WbL78tA9pzTHmfztzEvmVamA4pyYclgq2X4hHnytdB9MdwY6xVx9j68nisgCQ3Aej
 CG9U3r7WSDUXfn7ZRHyrUQUUHiufqVUY78gdijXO0YECKx283q+Ctd6a6DAAg6enWE5X
 /M1A==
X-Gm-Message-State: AOAM530+bPZtKDq4zbJh3Q0e0AlMzQE16ZYJN0gb75TsqNGFDd5eDSLY
 xo+4NjMELL8LzKzi2j7Flg4DHwnItg4fdbGslLO0TLwuB0OQbmSJD4MrKNUto5jku+qBxOkX596
 Dqe9D2KaQ86Nz9Ho=
X-Received: by 2002:a17:906:33c1:: with SMTP id
 w1mr20252179eja.313.1590415939102; 
 Mon, 25 May 2020 07:12:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyg+f+ByiNpmDZXRTtwVjzbRQKbp7mzgkR7IqrcP7P0uW4z97/+t0/8yA8DBYm5gconbSL0rA==
X-Received: by 2002:a17:906:33c1:: with SMTP id
 w1mr20252053eja.313.1590415937570; 
 Mon, 25 May 2020 07:12:17 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id w10sm15270459eju.106.2020.05.25.07.12.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 07:12:16 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] qapi/misc: Restrict PCI commands to machine code
To: qemu-devel@nongnu.org
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-8-philmd@redhat.com>
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
Message-ID: <2b9b397c-024e-45b5-f8b6-d78064a96f26@redhat.com>
Date: Mon, 25 May 2020 16:12:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316000348.29692-8-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 3/16/20 1:03 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  qapi/machine.json | 304 ++++++++++++++++++++++++++++++++++++++++++++++
>  qapi/misc.json    | 304 ----------------------------------------------
>  hw/pci/pci-stub.c |   2 +-
>  hw/pci/pci.c      |   2 +-
>  4 files changed, 306 insertions(+), 306 deletions(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index f77ee63730..33b259dbd0 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1172,3 +1172,307 @@
>  ##
>  { 'event': 'ACPI_DEVICE_OST',
>       'data': { 'info': 'ACPIOSTInfo' } }
> +
> +##
> +# @PciMemoryRange:
> +#
> +# A PCI device memory region
> +#
> +# @base: the starting address (guest physical)
> +#
> +# @limit: the ending address (guest physical)
> +#
> +# Since: 0.14.0
> +##
> +{ 'struct': 'PciMemoryRange', 'data': {'base': 'int', 'limit': 'int'} }
> +
> +##
> +# @PciMemoryRegion:
> +#
> +# Information about a PCI device I/O region.
> +#
> +# @bar: the index of the Base Address Register for this region
> +#
> +# @type: - 'io' if the region is a PIO region
> +#        - 'memory' if the region is a MMIO region
> +#
> +# @size: memory size
> +#
> +# @prefetch: if @type is 'memory', true if the memory is prefetchable
> +#
> +# @mem_type_64: if @type is 'memory', true if the BAR is 64-bit
> +#
> +# Since: 0.14.0
> +##
> +{ 'struct': 'PciMemoryRegion',
> +  'data': {'bar': 'int', 'type': 'str', 'address': 'int', 'size': 'int',
> +           '*prefetch': 'bool', '*mem_type_64': 'bool' } }
> +
> +##
> +# @PciBusInfo:
> +#
> +# Information about a bus of a PCI Bridge device
> +#
> +# @number: primary bus interface number.  This should be the number of the
> +#          bus the device resides on.
> +#
> +# @secondary: secondary bus interface number.  This is the number of the
> +#             main bus for the bridge
> +#
> +# @subordinate: This is the highest number bus that resides below the
> +#               bridge.
> +#
> +# @io_range: The PIO range for all devices on this bridge
> +#
> +# @memory_range: The MMIO range for all devices on this bridge
> +#
> +# @prefetchable_range: The range of prefetchable MMIO for all devices on
> +#                      this bridge
> +#
> +# Since: 2.4
> +##
> +{ 'struct': 'PciBusInfo',
> +  'data': {'number': 'int', 'secondary': 'int', 'subordinate': 'int',
> +           'io_range': 'PciMemoryRange',
> +           'memory_range': 'PciMemoryRange',
> +           'prefetchable_range': 'PciMemoryRange' } }
> +
> +##
> +# @PciBridgeInfo:
> +#
> +# Information about a PCI Bridge device
> +#
> +# @bus: information about the bus the device resides on
> +#
> +# @devices: a list of @PciDeviceInfo for each device on this bridge
> +#
> +# Since: 0.14.0
> +##
> +{ 'struct': 'PciBridgeInfo',
> +  'data': {'bus': 'PciBusInfo', '*devices': ['PciDeviceInfo']} }
> +
> +##
> +# @PciDeviceClass:
> +#
> +# Information about the Class of a PCI device
> +#
> +# @desc: a string description of the device's class
> +#
> +# @class: the class code of the device
> +#
> +# Since: 2.4
> +##
> +{ 'struct': 'PciDeviceClass',
> +  'data': {'*desc': 'str', 'class': 'int'} }
> +
> +##
> +# @PciDeviceId:
> +#
> +# Information about the Id of a PCI device
> +#
> +# @device: the PCI device id
> +#
> +# @vendor: the PCI vendor id
> +#
> +# @subsystem: the PCI subsystem id (since 3.1)
> +#
> +# @subsystem-vendor: the PCI subsystem vendor id (since 3.1)
> +#
> +# Since: 2.4
> +##
> +{ 'struct': 'PciDeviceId',
> +  'data': {'device': 'int', 'vendor': 'int', '*subsystem': 'int',
> +            '*subsystem-vendor': 'int'} }
> +
> +##
> +# @PciDeviceInfo:
> +#
> +# Information about a PCI device
> +#
> +# @bus: the bus number of the device
> +#
> +# @slot: the slot the device is located in
> +#
> +# @function: the function of the slot used by the device
> +#
> +# @class_info: the class of the device
> +#
> +# @id: the PCI device id
> +#
> +# @irq: if an IRQ is assigned to the device, the IRQ number
> +#
> +# @qdev_id: the device name of the PCI device
> +#
> +# @pci_bridge: if the device is a PCI bridge, the bridge information
> +#
> +# @regions: a list of the PCI I/O regions associated with the device
> +#
> +# Notes: the contents of @class_info.desc are not stable and should only be
> +#        treated as informational.
> +#
> +# Since: 0.14.0
> +##
> +{ 'struct': 'PciDeviceInfo',
> +  'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
> +           'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
> +           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo',
> +           'regions': ['PciMemoryRegion']} }
> +
> +##
> +# @PciInfo:
> +#
> +# Information about a PCI bus
> +#
> +# @bus: the bus index
> +#
> +# @devices: a list of devices on this bus
> +#
> +# Since: 0.14.0
> +##
> +{ 'struct': 'PciInfo', 'data': {'bus': 'int', 'devices': ['PciDeviceInfo']} }
> +
> +##
> +# @query-pci:
> +#
> +# Return information about the PCI bus topology of the guest.
> +#
> +# Returns: a list of @PciInfo for each PCI bus. Each bus is
> +#          represented by a json-object, which has a key with a json-array of
> +#          all PCI devices attached to it. Each device is represented by a
> +#          json-object.
> +#
> +# Since: 0.14.0
> +#
> +# Example:
> +#
> +# -> { "execute": "query-pci" }
> +# <- { "return": [
> +#          {
> +#             "bus": 0,
> +#             "devices": [
> +#                {
> +#                   "bus": 0,
> +#                   "qdev_id": "",
> +#                   "slot": 0,
> +#                   "class_info": {
> +#                      "class": 1536,
> +#                      "desc": "Host bridge"
> +#                   },
> +#                   "id": {
> +#                      "device": 32902,
> +#                      "vendor": 4663
> +#                   },
> +#                   "function": 0,
> +#                   "regions": [
> +#                   ]
> +#                },
> +#                {
> +#                   "bus": 0,
> +#                   "qdev_id": "",
> +#                   "slot": 1,
> +#                   "class_info": {
> +#                      "class": 1537,
> +#                      "desc": "ISA bridge"
> +#                   },
> +#                   "id": {
> +#                      "device": 32902,
> +#                      "vendor": 28672
> +#                   },
> +#                   "function": 0,
> +#                   "regions": [
> +#                   ]
> +#                },
> +#                {
> +#                   "bus": 0,
> +#                   "qdev_id": "",
> +#                   "slot": 1,
> +#                   "class_info": {
> +#                      "class": 257,
> +#                      "desc": "IDE controller"
> +#                   },
> +#                   "id": {
> +#                      "device": 32902,
> +#                      "vendor": 28688
> +#                   },
> +#                   "function": 1,
> +#                   "regions": [
> +#                      {
> +#                         "bar": 4,
> +#                         "size": 16,
> +#                         "address": 49152,
> +#                         "type": "io"
> +#                      }
> +#                   ]
> +#                },
> +#                {
> +#                   "bus": 0,
> +#                   "qdev_id": "",
> +#                   "slot": 2,
> +#                   "class_info": {
> +#                      "class": 768,
> +#                      "desc": "VGA controller"
> +#                   },
> +#                   "id": {
> +#                      "device": 4115,
> +#                      "vendor": 184
> +#                   },
> +#                   "function": 0,
> +#                   "regions": [
> +#                      {
> +#                         "prefetch": true,
> +#                         "mem_type_64": false,
> +#                         "bar": 0,
> +#                         "size": 33554432,
> +#                         "address": 4026531840,
> +#                         "type": "memory"
> +#                      },
> +#                      {
> +#                         "prefetch": false,
> +#                         "mem_type_64": false,
> +#                         "bar": 1,
> +#                         "size": 4096,
> +#                         "address": 4060086272,
> +#                         "type": "memory"
> +#                      },
> +#                      {
> +#                         "prefetch": false,
> +#                         "mem_type_64": false,
> +#                         "bar": 6,
> +#                         "size": 65536,
> +#                         "address": -1,
> +#                         "type": "memory"
> +#                      }
> +#                   ]
> +#                },
> +#                {
> +#                   "bus": 0,
> +#                   "qdev_id": "",
> +#                   "irq": 11,
> +#                   "slot": 4,
> +#                   "class_info": {
> +#                      "class": 1280,
> +#                      "desc": "RAM controller"
> +#                   },
> +#                   "id": {
> +#                      "device": 6900,
> +#                      "vendor": 4098
> +#                   },
> +#                   "function": 0,
> +#                   "regions": [
> +#                      {
> +#                         "bar": 0,
> +#                         "size": 32,
> +#                         "address": 49280,
> +#                         "type": "io"
> +#                      }
> +#                   ]
> +#                }
> +#             ]
> +#          }
> +#       ]
> +#    }
> +#
> +# Note: This example has been shortened as the real response is too long.
> +#
> +##
> +{ 'command': 'query-pci', 'returns': ['PciInfo'] }
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 3d9d7327fe..92b3926c6b 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -156,310 +156,6 @@
>  { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
>    'allow-preconfig': true }
>  
> -##
> -# @PciMemoryRange:
> -#
> -# A PCI device memory region
> -#
> -# @base: the starting address (guest physical)
> -#
> -# @limit: the ending address (guest physical)
> -#
> -# Since: 0.14.0
> -##
> -{ 'struct': 'PciMemoryRange', 'data': {'base': 'int', 'limit': 'int'} }
> -
> -##
> -# @PciMemoryRegion:
> -#
> -# Information about a PCI device I/O region.
> -#
> -# @bar: the index of the Base Address Register for this region
> -#
> -# @type: - 'io' if the region is a PIO region
> -#        - 'memory' if the region is a MMIO region
> -#
> -# @size: memory size
> -#
> -# @prefetch: if @type is 'memory', true if the memory is prefetchable
> -#
> -# @mem_type_64: if @type is 'memory', true if the BAR is 64-bit
> -#
> -# Since: 0.14.0
> -##
> -{ 'struct': 'PciMemoryRegion',
> -  'data': {'bar': 'int', 'type': 'str', 'address': 'int', 'size': 'int',
> -           '*prefetch': 'bool', '*mem_type_64': 'bool' } }
> -
> -##
> -# @PciBusInfo:
> -#
> -# Information about a bus of a PCI Bridge device
> -#
> -# @number: primary bus interface number.  This should be the number of the
> -#          bus the device resides on.
> -#
> -# @secondary: secondary bus interface number.  This is the number of the
> -#             main bus for the bridge
> -#
> -# @subordinate: This is the highest number bus that resides below the
> -#               bridge.
> -#
> -# @io_range: The PIO range for all devices on this bridge
> -#
> -# @memory_range: The MMIO range for all devices on this bridge
> -#
> -# @prefetchable_range: The range of prefetchable MMIO for all devices on
> -#                      this bridge
> -#
> -# Since: 2.4
> -##
> -{ 'struct': 'PciBusInfo',
> -  'data': {'number': 'int', 'secondary': 'int', 'subordinate': 'int',
> -           'io_range': 'PciMemoryRange',
> -           'memory_range': 'PciMemoryRange',
> -           'prefetchable_range': 'PciMemoryRange' } }
> -
> -##
> -# @PciBridgeInfo:
> -#
> -# Information about a PCI Bridge device
> -#
> -# @bus: information about the bus the device resides on
> -#
> -# @devices: a list of @PciDeviceInfo for each device on this bridge
> -#
> -# Since: 0.14.0
> -##
> -{ 'struct': 'PciBridgeInfo',
> -  'data': {'bus': 'PciBusInfo', '*devices': ['PciDeviceInfo']} }
> -
> -##
> -# @PciDeviceClass:
> -#
> -# Information about the Class of a PCI device
> -#
> -# @desc: a string description of the device's class
> -#
> -# @class: the class code of the device
> -#
> -# Since: 2.4
> -##
> -{ 'struct': 'PciDeviceClass',
> -  'data': {'*desc': 'str', 'class': 'int'} }
> -
> -##
> -# @PciDeviceId:
> -#
> -# Information about the Id of a PCI device
> -#
> -# @device: the PCI device id
> -#
> -# @vendor: the PCI vendor id
> -#
> -# @subsystem: the PCI subsystem id (since 3.1)
> -#
> -# @subsystem-vendor: the PCI subsystem vendor id (since 3.1)
> -#
> -# Since: 2.4
> -##
> -{ 'struct': 'PciDeviceId',
> -  'data': {'device': 'int', 'vendor': 'int', '*subsystem': 'int',
> -            '*subsystem-vendor': 'int'} }
> -
> -##
> -# @PciDeviceInfo:
> -#
> -# Information about a PCI device
> -#
> -# @bus: the bus number of the device
> -#
> -# @slot: the slot the device is located in
> -#
> -# @function: the function of the slot used by the device
> -#
> -# @class_info: the class of the device
> -#
> -# @id: the PCI device id
> -#
> -# @irq: if an IRQ is assigned to the device, the IRQ number
> -#
> -# @qdev_id: the device name of the PCI device
> -#
> -# @pci_bridge: if the device is a PCI bridge, the bridge information
> -#
> -# @regions: a list of the PCI I/O regions associated with the device
> -#
> -# Notes: the contents of @class_info.desc are not stable and should only be
> -#        treated as informational.
> -#
> -# Since: 0.14.0
> -##
> -{ 'struct': 'PciDeviceInfo',
> -  'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
> -           'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
> -           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo',
> -           'regions': ['PciMemoryRegion']} }
> -
> -##
> -# @PciInfo:
> -#
> -# Information about a PCI bus
> -#
> -# @bus: the bus index
> -#
> -# @devices: a list of devices on this bus
> -#
> -# Since: 0.14.0
> -##
> -{ 'struct': 'PciInfo', 'data': {'bus': 'int', 'devices': ['PciDeviceInfo']} }
> -
> -##
> -# @query-pci:
> -#
> -# Return information about the PCI bus topology of the guest.
> -#
> -# Returns: a list of @PciInfo for each PCI bus. Each bus is
> -#          represented by a json-object, which has a key with a json-array of
> -#          all PCI devices attached to it. Each device is represented by a
> -#          json-object.
> -#
> -# Since: 0.14.0
> -#
> -# Example:
> -#
> -# -> { "execute": "query-pci" }
> -# <- { "return": [
> -#          {
> -#             "bus": 0,
> -#             "devices": [
> -#                {
> -#                   "bus": 0,
> -#                   "qdev_id": "",
> -#                   "slot": 0,
> -#                   "class_info": {
> -#                      "class": 1536,
> -#                      "desc": "Host bridge"
> -#                   },
> -#                   "id": {
> -#                      "device": 32902,
> -#                      "vendor": 4663
> -#                   },
> -#                   "function": 0,
> -#                   "regions": [
> -#                   ]
> -#                },
> -#                {
> -#                   "bus": 0,
> -#                   "qdev_id": "",
> -#                   "slot": 1,
> -#                   "class_info": {
> -#                      "class": 1537,
> -#                      "desc": "ISA bridge"
> -#                   },
> -#                   "id": {
> -#                      "device": 32902,
> -#                      "vendor": 28672
> -#                   },
> -#                   "function": 0,
> -#                   "regions": [
> -#                   ]
> -#                },
> -#                {
> -#                   "bus": 0,
> -#                   "qdev_id": "",
> -#                   "slot": 1,
> -#                   "class_info": {
> -#                      "class": 257,
> -#                      "desc": "IDE controller"
> -#                   },
> -#                   "id": {
> -#                      "device": 32902,
> -#                      "vendor": 28688
> -#                   },
> -#                   "function": 1,
> -#                   "regions": [
> -#                      {
> -#                         "bar": 4,
> -#                         "size": 16,
> -#                         "address": 49152,
> -#                         "type": "io"
> -#                      }
> -#                   ]
> -#                },
> -#                {
> -#                   "bus": 0,
> -#                   "qdev_id": "",
> -#                   "slot": 2,
> -#                   "class_info": {
> -#                      "class": 768,
> -#                      "desc": "VGA controller"
> -#                   },
> -#                   "id": {
> -#                      "device": 4115,
> -#                      "vendor": 184
> -#                   },
> -#                   "function": 0,
> -#                   "regions": [
> -#                      {
> -#                         "prefetch": true,
> -#                         "mem_type_64": false,
> -#                         "bar": 0,
> -#                         "size": 33554432,
> -#                         "address": 4026531840,
> -#                         "type": "memory"
> -#                      },
> -#                      {
> -#                         "prefetch": false,
> -#                         "mem_type_64": false,
> -#                         "bar": 1,
> -#                         "size": 4096,
> -#                         "address": 4060086272,
> -#                         "type": "memory"
> -#                      },
> -#                      {
> -#                         "prefetch": false,
> -#                         "mem_type_64": false,
> -#                         "bar": 6,
> -#                         "size": 65536,
> -#                         "address": -1,
> -#                         "type": "memory"
> -#                      }
> -#                   ]
> -#                },
> -#                {
> -#                   "bus": 0,
> -#                   "qdev_id": "",
> -#                   "irq": 11,
> -#                   "slot": 4,
> -#                   "class_info": {
> -#                      "class": 1280,
> -#                      "desc": "RAM controller"
> -#                   },
> -#                   "id": {
> -#                      "device": 6900,
> -#                      "vendor": 4098
> -#                   },
> -#                   "function": 0,
> -#                   "regions": [
> -#                      {
> -#                         "bar": 0,
> -#                         "size": 32,
> -#                         "address": 49280,
> -#                         "type": "io"
> -#                      }
> -#                   ]
> -#                }
> -#             ]
> -#          }
> -#       ]
> -#    }
> -#
> -# Note: This example has been shortened as the real response is too long.
> -#
> -##
> -{ 'command': 'query-pci', 'returns': ['PciInfo'] }
> -
>  ##
>  # @stop:
>  #
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index cc2a2e1f73..b50c7ca590 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -22,7 +22,7 @@
>  #include "sysemu/sysemu.h"
>  #include "monitor/monitor.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-commands-misc.h"
> +#include "qapi/qapi-commands-machine.h"
>  #include "qapi/qmp/qerror.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/msi.h"
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e1ed6677e1..5ebc783d57 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -46,7 +46,7 @@
>  #include "hw/hotplug.h"
>  #include "hw/boards.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-commands-misc.h"
> +#include "qapi/qapi-commands-machine.h"
>  #include "qemu/cutils.h"
>  
>  //#define DEBUG_PCI
> 


