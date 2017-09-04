Received: from eggs.gnu.org ([2001:4830:134:3::10]:45512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1doldU-0003nN-92
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1doldR-0001cr-0W
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:17:32 -0400
References: <1504030416-18618-1-git-send-email-thuth@redhat.com>
	<eb148e1c-6cfa-b871-c201-de3f3565e4c8@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b60993f4-a20e-fdca-283d-089f272bb4cd@redhat.com>
Date: Mon, 4 Sep 2017 09:17:20 +0200
MIME-Version: 1.0
In-Reply-To: <eb148e1c-6cfa-b871-c201-de3f3565e4c8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] tests: Fix broken
 ivshmem-server-msi/-irq tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 04.09.2017 08:53, Laurent Vivier wrote:
> On 29/08/2017 20:13, Thomas Huth wrote:
>> Broken with commit b4ba67d9a7025 ("libqos: Change PCI accessors to take
>> opaque BAR handle") a while ago, but nobody noticed since the tests are
>> only run in SPEED=slow mode: The msix_pba_bar is not correctly initialized
> 
> you mean "SPEED=quick"?

Ah, well, that sentence was ambiguous - I meant "nobody noticed since
the *ivshmem* tests are only run in SPEED=slow mode *and we are running
the tests in quick mode only by default*".
Maybe this could be fixed up when the patch is picked up...

>> anymore if bir_pba has the same value as bir_table. With this fix,
>> "make check SPEED=slow" should work fine again.
>>
>> Fixes: b4ba67d9a702507793c2724e56f98e9b0f7be02b
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/libqos/pci.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
>> index 2dcdead..28d576c 100644
>> --- a/tests/libqos/pci.c
>> +++ b/tests/libqos/pci.c
>> @@ -120,6 +120,8 @@ void qpci_msix_enable(QPCIDevice *dev)
>>      bir_pba = table & PCI_MSIX_FLAGS_BIRMASK;
>>      if (bir_pba != bir_table) {
>>          dev->msix_pba_bar = qpci_iomap(dev, bir_pba, NULL);
>> +    } else {
>> +        dev->msix_pba_bar = dev->msix_table_bar;
>>      }
>>      dev->msix_pba_off = table & ~PCI_MSIX_FLAGS_BIRMASK;
>>  
>> @@ -138,8 +140,11 @@ void qpci_msix_disable(QPCIDevice *dev)
>>      qpci_config_writew(dev, addr + PCI_MSIX_FLAGS,
>>                                                  val & ~PCI_MSIX_FLAGS_ENABLE);
>>  
>> +    if (dev->msix_pba_bar.addr != dev->msix_table_bar.addr) {
>> +        qpci_iounmap(dev, dev->msix_pba_bar);
>> +    }
>>      qpci_iounmap(dev, dev->msix_table_bar);
>> -    qpci_iounmap(dev, dev->msix_pba_bar);
>> +
>>      dev->msix_enabled = 0;
>>      dev->msix_table_off = 0;
>>      dev->msix_pba_off = 0;
>>
> 
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Thanks!
 Thomas
