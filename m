Received: from eggs.gnu.org ([209.51.188.92]:33716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggmz4-0005il-95
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 03:43:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggmz2-0003YF-9W
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 03:43:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ggmz1-0003Bi-Vz
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 03:43:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-10-fli@suse.com>
	<87a7kcml5i.fsf@dusky.pond.sub.org>
	<36097839-654b-6d1f-b79e-f9bc174ec126@suse.cz>
	<20190108065159.GA20511@xz-x1>
Date: Tue, 08 Jan 2019 09:43:11 +0100
In-Reply-To: <20190108065159.GA20511@xz-x1> (Peter Xu's message of "Tue, 8 Jan
	2019 14:51:59 +0800")
Message-ID: <87o98ree00.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 09/16] qemu_thread: supplement
 error handling for pci_edu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Fei Li <fli@suse.com>, lifei1214@126.com, shirley17fei@gmail.com, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Peter Xu <peterx@redhat.com> writes:

> On Tue, Jan 08, 2019 at 07:14:11AM +0100, Jiri Slaby wrote:
>> On 07. 01. 19, 18:29, Markus Armbruster wrote:
>> >    static void pci_edu_uninit(PCIDevice *pdev)
>> >    {
>> >        EduState *edu = EDU(pdev);
>> > 
>> >        qemu_mutex_lock(&edu->thr_mutex);
>> >        edu->stopping = true;
>> >        qemu_mutex_unlock(&edu->thr_mutex);
>> >        qemu_cond_signal(&edu->thr_cond);
>> >        qemu_thread_join(&edu->thread);
>> > 
>> >        qemu_cond_destroy(&edu->thr_cond);
>> >        qemu_mutex_destroy(&edu->thr_mutex);
>> > 
>> >        timer_del(&edu->dma_timer);
>> >    }
>> > 
>> > Preexisting: pci_edu_uninit() neglects to call msi_uninit().  Jiri?\
>> 
>> I don't know, the MSI support was added in:
>> commit eabb5782f70b4a10975b24ccd7129929a05ac932
>> Author: Peter Xu <peterx@redhat.com>
>> Date:   Wed Sep 28 21:03:39 2016 +0800
>> 
>>     hw/misc/edu: support MSI interrupt
>> 
>> Hence CCing Peter.
>
> Hi, Jiri, Markus, Fei,
>
> IMHO msi_uninit() is optional since it only operates on the config
> space of the device to remove the capability or fix up the flags
> without really doing any real destruction of objects so nothing will
> be leaked (unlike msix_uninit, which should be required).

Michael, Marcel, is neglecting to call msi_uninit() okay, a harmless
bug, or a harmful bug?

>                                                            But I do
> agree that calling msi_uninit() could be even nicer here.
>
> Anyone would like to post a patch? Or should I?

Please coordinate fixing this with Fei Li.
