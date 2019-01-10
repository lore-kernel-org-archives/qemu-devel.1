Received: from eggs.gnu.org ([209.51.188.92]:48482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghaP2-0007Si-UZ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghaP1-0006DQ-VO
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:29:44 -0500
Received: from m50-112.126.com ([123.125.50.112]:34900)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghaP0-0006CP-Vt
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:29:43 -0500
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-10-fli@suse.com>
	<87a7kcml5i.fsf@dusky.pond.sub.org>
	<36097839-654b-6d1f-b79e-f9bc174ec126@suse.cz>
	<20190108065159.GA20511@xz-x1> <87o98ree00.fsf@dusky.pond.sub.org>
From: Fei Li <lifei1214@126.com>
Message-ID: <8e592b32-7984-7a02-10e9-45fb9eb248ef@126.com>
Date: Thu, 10 Jan 2019 21:29:38 +0800
MIME-Version: 1.0
In-Reply-To: <87o98ree00.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Jiri Slaby <jslaby@suse.cz>, shirley17fei@gmail.com, qemu-devel@nongnu.org


ÔÚ 2019/1/8 ÏÂÎç4:43, Markus Armbruster Ð´µÀ:
> Peter Xu <peterx@redhat.com> writes:
>
>> On Tue, Jan 08, 2019 at 07:14:11AM +0100, Jiri Slaby wrote:
>>> On 07. 01. 19, 18:29, Markus Armbruster wrote:
>>>>     static void pci_edu_uninit(PCIDevice *pdev)
>>>>     {
>>>>         EduState *edu = EDU(pdev);
>>>>
>>>>         qemu_mutex_lock(&edu->thr_mutex);
>>>>         edu->stopping = true;
>>>>         qemu_mutex_unlock(&edu->thr_mutex);
>>>>         qemu_cond_signal(&edu->thr_cond);
>>>>         qemu_thread_join(&edu->thread);
>>>>
>>>>         qemu_cond_destroy(&edu->thr_cond);
>>>>         qemu_mutex_destroy(&edu->thr_mutex);
>>>>
>>>>         timer_del(&edu->dma_timer);
>>>>     }
>>>>
>>>> Preexisting: pci_edu_uninit() neglects to call msi_uninit().  Jiri?\
>>> I don't know, the MSI support was added in:
>>> commit eabb5782f70b4a10975b24ccd7129929a05ac932
>>> Author: Peter Xu <peterx@redhat.com>
>>> Date:   Wed Sep 28 21:03:39 2016 +0800
>>>
>>>      hw/misc/edu: support MSI interrupt
>>>
>>> Hence CCing Peter.
>> Hi, Jiri, Markus, Fei,
>>
>> IMHO msi_uninit() is optional since it only operates on the config
>> space of the device to remove the capability or fix up the flags
>> without really doing any real destruction of objects so nothing will
>> be leaked (unlike msix_uninit, which should be required).
> Michael, Marcel, is neglecting to call msi_uninit() okay, a harmless
> bug, or a harmful bug?

Kindly ping. :)

If corresponding change is needed, I'd like to do the update in the next 
version.

>>                                                             But I do
>> agree that calling msi_uninit() could be even nicer here.
>>
>> Anyone would like to post a patch? Or should I?
> Please coordinate fixing this with Fei Li.
Have a nice day, thanks all
Fei
