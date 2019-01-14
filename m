Received: from eggs.gnu.org ([209.51.188.92]:36569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1giwGe-0004kE-D7
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1giwGY-0006v3-KG
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:02:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1giwGX-0006sl-9x
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:02:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190113143641.38936-1-lifei1214@126.com>
	<20190114033130.GE24343@xz-x1>
Date: Mon, 14 Jan 2019 08:02:23 +0100
In-Reply-To: <20190114033130.GE24343@xz-x1> (Peter Xu's message of "Mon, 14
	Jan 2019 11:31:30 +0800")
Message-ID: <87va2rwwlc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hw/misc/edu: add msi_uninit() for
 pci_edu_uninit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Fei Li <lifei1214@126.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com

Peter Xu <peterx@redhat.com> writes:

> On Sun, Jan 13, 2019 at 10:36:41PM +0800, Fei Li wrote:
>> From: Fei Li <shirley17fei@gmail.com>
>> 
>> Let's supplement the msi_uninit() when failing to realize
>> the pci edu device.
>> 
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Signed-off-by: Fei Li <shirley17fei@gmail.com>
>> ---
>>  hw/misc/edu.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
>> index cdcf550dd7..4feb7503de 100644
>> --- a/hw/misc/edu.c
>> +++ b/hw/misc/edu.c
>> @@ -367,6 +367,7 @@ static void pci_edu_uninit(PCIDevice *pdev)
>>  {
>>      EduState *edu = EDU(pdev);
>>  
>> +    msi_uninit(pdev);
>
> It would be cleaner to me to call this after the join() since
> edu_fact_thread() could potentially use msi_*() helpers then the
> destructions follow the reverse order of init.

Destruction in reverse creation order is good practice.

This being the "QEMU educational PCI device", good practice is even more
desirable.

> Reviewed-by: Peter Xu <peterx@redhat.com>
>
>>      qemu_mutex_lock(&edu->thr_mutex);
>>      edu->stopping = true;
>>      qemu_mutex_unlock(&edu->thr_mutex);
>> -- 
>> 2.17.2 (Apple Git-113)
>> 
>
> Regards,
