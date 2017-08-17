Received: from eggs.gnu.org ([2001:4830:134:3::10]:40732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diIUg-0003bs-Rx
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diIUd-0004AI-Oo
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:57:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diIUd-0004A4-GN
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:57:39 -0400
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-5-git-send-email-thuth@redhat.com>
	<6454a1a2-e9eb-272f-1380-f514a07c5a20@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9d10d055-0256-cf39-f68e-175b56da5bb2@redhat.com>
Date: Thu, 17 Aug 2017 12:57:27 +0200
MIME-Version: 1.0
In-Reply-To: <6454a1a2-e9eb-272f-1380-f514a07c5a20@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] tests: Introduce generic device
 hot-plug/hot-unplug functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

On 17.08.2017 11:53, David Hildenbrand wrote:
> On 17.08.2017 08:25, Thomas Huth wrote:
>> A lot of tests provide code for adding and removing a device via the
>> device_add and device_del QMP commands. Maintaining this code in so
>> many places is cumbersome and error-prone (some of the code parts
>> check the responses in an incorrect way, for example), so let's
>> provide some proper generic qtest functions for adding and removing a
>> device instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
[...]
>> diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
>> index 2dcdead..aada753 100644
>> --- a/tests/libqos/pci.c
>> +++ b/tests/libqos/pci.c
>> @@ -394,21 +394,6 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
>>  void qpci_plug_device_test(const char *driver, const char *id,
>>                             uint8_t slot, const char *opts)
>>  {
>> -    QDict *response;
>> -    char *cmd;
>> -
>> -    cmd = g_strdup_printf("{'execute': 'device_add',"
>> -                          " 'arguments': {"
>> -                          "   'driver': '%s',"
>> -                          "   'addr': '%d',"
>> -                          "   %s%s"
>> -                          "   'id': '%s'"
>> -                          "}}", driver, slot,
>> -                          opts ? opts : "", opts ? "," : "",
>> -                          id);
>> -    response = qmp(cmd);
>> -    g_free(cmd);
>> -    g_assert(response);
>> -    g_assert(!qdict_haskey(response, "error"));
>> -    QDECREF(response);
>> +    qtest_hot_plug_device(driver, id, "'addr': '%d'%s%s", slot,
>> +                          opts ? ", " : "", opts ? opts : "");

While PCI uses 'addr' as additional parameter here...

[...]
>> +    qtest_hot_plug_device("usb-tablet", id, "'port': '%d', 'bus': '%s.0'",
>> +                          port, hcd_id);

... USB uses 'port' and 'bus' ...

[...]
>
> Not sure if it would be better to avoid the fmt and provide more
> parameters instead. Specifying a parameter as NULL will ifgnore it.
> 
> void qtest_hot_plug_device(const char *driver, const char *id,
>                            const char *drive, const char *port,
>                            const char *bus)
> 
> that should cover all cases and callers don't have to build strings in a
> special format.

... so I'm afraid, but no, this does not work. The additional parameters
are specific to the device type, so there is no way to get around the
format string if we want to stay flexible here.

 Thomas
