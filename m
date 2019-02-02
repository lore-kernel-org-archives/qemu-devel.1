Received: from eggs.gnu.org ([209.51.188.92]:47184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpnAl-00080T-B5
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 23:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpnAj-0000F5-4V
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 23:44:55 -0500
Received: from m50-111.126.com ([123.125.50.111]:57962)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpnAh-0000By-Vu
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 23:44:53 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: fei <lifei1214@126.com>
In-Reply-To: <87k1ij7jie.fsf@dusky.pond.sub.org>
Date: Sat, 2 Feb 2019 12:44:22 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <447BFB43-A3B1-4236-8DA5-D8E9C2B467D4@126.com>
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-5-lifei1214@126.com>
	<87k1ij7jie.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 04/11] qemu_thread: supplement
 error handling for pci_edu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Jiri Slaby <jslaby@suse.cz>



> =E5=9C=A8 2019=E5=B9=B42=E6=9C=881=E6=97=A5=EF=BC=8C20:58=EF=BC=8CMarkus A=
rmbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Fei Li <lifei1214@126.com> writes:
>=20
>> From: Fei Li <fli@suse.com>
>>=20
>> Utilize the existed errp to propagate the error and do the
>> corresponding cleanup to replace the temporary &error_abort.
>>=20
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Jiri Slaby <jslaby@suse.cz>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>> hw/misc/edu.c | 11 ++++++++---
>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
>> index 21adbfddce..8fe232b6d6 100644
>> --- a/hw/misc/edu.c
>> +++ b/hw/misc/edu.c
>> @@ -356,9 +356,14 @@ static void pci_edu_realize(PCIDevice *pdev, Error *=
*errp)
>>=20
>>     qemu_mutex_init(&edu->thr_mutex);
>>     qemu_cond_init(&edu->thr_cond);
>> -    /* TODO: let the further caller handle the error instead of abort() h=
ere */
>> -    qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
>> -                       edu, QEMU_THREAD_JOINABLE, &error_abort);
>> +    if (qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
>> +                           edu, QEMU_THREAD_JOINABLE, errp) < 0) {
>> +        qemu_cond_destroy(&edu->thr_cond);
>> +        qemu_mutex_destroy(&edu->thr_mutex);
>> +        timer_del(&edu->dma_timer);
>> +        msi_uninit(pdev);
>> +        return;
>> +    }
>>=20
>>     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
>>                     "edu-mmio", 1 * MiB);
>=20
> In review of v9, I pointed out that pci_edu_uninit() neglects to call
> msix_uninit(), and you offered to fix it.  Not in this series.  Do you
> still intend to fix it?
Yes, I have already sent that patch separately as I consider it is little re=
levant. And that patch has been merged. :)
>=20
> That's a separate patch, though, so
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
Thanks for the review!

Have a nice day
Fei=
