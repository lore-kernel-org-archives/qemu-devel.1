Received: from eggs.gnu.org ([209.51.188.92]:54266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gveoR-0003DM-5l
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gveZg-0006zc-5U
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 03:46:54 -0500
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-6-david@redhat.com>
	<c0200012-4bbd-d4ed-86ac-941f0f43bff1@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2c68f04e-61f5-43f0-c9eb-138cb965f2d4@redhat.com>
Date: Mon, 18 Feb 2019 09:46:25 +0100
MIME-Version: 1.0
In-Reply-To: <c0200012-4bbd-d4ed-86ac-941f0f43bff1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/6] tests/device-plug: Add CPU core
 unplug request test for spapr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 15.02.19 16:35, Thomas Huth wrote:
> On 15/02/2019 14.30, David Hildenbrand wrote:
>> We can easily test this, just like PCI.
> 
> ... maybe add a sentence why this is only done for spapr, and not for
> s390x and x86 ?

Yes, will do!

> 
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  tests/device-plug-test.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/tests/device-plug-test.c b/tests/device-plug-test.c
>> index 6f7255552a..ec6cb5de7b 100644
>> --- a/tests/device-plug-test.c
>> +++ b/tests/device-plug-test.c
>> @@ -101,6 +101,21 @@ static void test_ccw_unplug(void)
>>      qtest_quit(qtest);
>>  }
>>  
>> +static void test_spapr_cpu_unplug_request(void)
>> +{
>> +    QTestState *qtest;
>> +
>> +    qtest = qtest_initf("-cpu power9_v2.0 -smp 1,maxcpus=2 "
>> +                        "-device power9_v2.0-spapr-cpu-core,core-id=1,id=dev0");
>> +
>> +    /* similar to test_pci_unplug_request */
>> +    device_del_request(qtest, "dev0");
>> +    system_reset(qtest);
>> +    wait_device_deleted_event(qtest, "dev0");
>> +
>> +    qtest_quit(qtest);
>> +}
> 
> My initial thought was: This should go into tests/cpu-plug-test.c
> instead ... but since you need the functions that you defined here,
> looks like this is the better place here...

Yes, I consider the tests in here to test basic unplug (+later plug)
functionality for all kinds of devices. Very specific tests (e.g.
testing different cpu plug combinations) should be handled in different
files.

Thanks!

-- 

Thanks,

David / dhildenb
