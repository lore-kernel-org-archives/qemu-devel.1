Received: from eggs.gnu.org ([2001:4830:134:3::10]:35589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fdLy4-0003mI-JU
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fdLxz-0007O4-L4
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:44:08 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:44916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fdLxz-0007Nd-Dd
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:44:03 -0400
Received: by mail-ed1-x541.google.com with SMTP id d17-v6so8079957eds.11
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 13:44:03 -0700 (PDT)
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-4-e.emanuelegiuseppe@gmail.com>
	<b87b908a-9b47-abce-1e4e-a58a7f0dbad9@amsat.org>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <e9572e89-a8c0-abb1-99bb-f55b92e39e3d@gmail.com>
Date: Wed, 11 Jul 2018 22:44:00 +0200
MIME-Version: 1.0
In-Reply-To: <b87b908a-9b47-abce-1e4e-a58a7f0dbad9@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/7] tests/qgraph: sdhci driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org

Hi Philippe,

On 07/11/2018 10:13 PM, Philippe Mathieu-Daudé wrote:
> Hi Emanuele,
>
> On 07/09/2018 06:11 AM, Emanuele Giuseppe Esposito wrote:
>> Add qgraph nodes for sdhci-pci and generic-sdhci (memory mapped) drivers.
>> Both drivers implement (produce) the same interface sdhci, that provides the
>> readw - readq - writeq functions.
>>
>> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
>> ---
>>   tests/Makefile.include |   1 +
>>   tests/libqos/sdhci.c   | 142 +++++++++++++++++++++++++++++++++++++++++
>>   tests/libqos/sdhci.h   |  68 ++++++++++++++++++++
>>   3 files changed, 211 insertions(+)
>>   create mode 100644 tests/libqos/sdhci.c
>>   create mode 100644 tests/libqos/sdhci.h
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index b16bbd55df..acbf704a8a 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -770,6 +770,7 @@ libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
>>   libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o tests/libqos/malloc-generic.o
>>   
>>   libqgraph-obj-y = tests/libqos/qgraph.o
>> +libqgraph-pc-obj-y = $(libqos-pc-obj-y) tests/libqos/sdhci.o
> Shouldn't this be:
>
>     libqgraph-obj-y = tests/libqos/qgraph.o tests/libqos/sdhci.o
>
> (not PC related)
I need to add $(libqos-pc-obj-y) because it will include pc-pci.c and 
all the pci targerts, loading their libqos_init() functions and building 
the graph.

Doing as you suggested won't work for these reasons:
- pci-bus-pc and pci-bus nodes won't be created, so graph would be 
incomplete
- sdhci needs libqos to use global_qtest,  qpci_device_init, etc. that 
won't be provided by check-unit-y even by adding $(libqos-pc-obj-y).

So since test-qgraph do not need libqos, I (suggested by Paolo) added 
the test to the check-unit-y target, adding to it just libqgraph-obj.

For other devices like sdhci that need libqos, I created 
libqgraph-pc-obj-y (to be renamed to libqgraph-pci-obj-y, since it will 
also contain libqos-spapr ?) that will be added to target 
check-qtest-pci-y (that provides libqos).
>> +    QSDHCIProperties props;
>> +};
>> +
>> +/* Memory Mapped implementation of QSDHCI */
>> +struct QSDHCI_MemoryMapped {
>> +    QOSGraphObject obj;
>> +    QSDHCI sdhci;
>> +    uint64_t addr;
>> +};
>> +
>> +/* PCI implementation of QSDHCI */
>> +struct QSDHCI_PCI {
>> +    QOSGraphObject obj;
>> +    QPCIDevice dev;
>> +    QSDHCI sdhci;
>> +    QPCIBar mem_bar;
>> +};
>> +
>> +/**
>> + * qos_create_sdhci_mm(): external constructor used by all drivers/machines
>> + * that "contain" a #QSDHCI_MemoryMapped driver
>> + */
>> +void qos_create_sdhci_mm(QSDHCI_MemoryMapped *sdhci, uint32_t addr,
>> +                            QSDHCIProperties *common);
> Your IDE uses a weird indentation.
I actually did by hand, not sure how the indentation to split >80 lines 
should be.
Maybe I should remove a tab? Like this:

+void qos_create_sdhci_mm(QSDHCI_MemoryMapped *sdhci, uint32_t addr,
+                                            QSDHCIProperties *common);
