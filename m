Received: from eggs.gnu.org ([2001:4830:134:3::10]:43121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cwPEU-0005au-Gn
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cwPER-0002PY-Pn
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:27:02 -0400
MIME-Version: 1.0
In-Reply-To: <CAOGPPbfpN5QVxzvAkRv4MY7nE0YBxU0-UeMuJpVCe-wBB_9p8A@mail.gmail.com>
References: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
	<20170406140255.GA31259@stefanha-x1.localdomain>
	<CAOGPPbfpN5QVxzvAkRv4MY7nE0YBxU0-UeMuJpVCe-wBB_9p8A@mail.gmail.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Fri, 7 Apr 2017 16:26:58 +0800
Message-ID: <CAOGPPbfaCT0_VLksv3aZzk0MhaVbosHHwTOy--JR_6YC=58pXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3] migration/block:limit the time used for
 block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, quintela@redhat.com, dgilbert@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

On Fri, Apr 7, 2017 at 9:30 AM, 858585 jemmy <jemmy858585@gmail.com> wrote:
> On Thu, Apr 6, 2017 at 10:02 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> On Wed, Apr 05, 2017 at 05:27:58PM +0800, jemmy858585@gmail.com wrote:
>>> From: Lidong Chen <lidongchen@tencent.com>
>>>
>>> when migration with high speed, mig_save_device_bulk invoke
>>> bdrv_is_allocated too frequently, and cause vnc reponse slowly.
>>> this patch limit the time used for bdrv_is_allocated.
>>
>> bdrv_is_allocated() is supposed to yield back to the event loop if it
>> needs to block.  If your VNC session is experiencing jitter then it's
>> probably because a system call in the bdrv_is_allocated() code path is
>> synchronous when it should be asynchronous.
>>
>> You could try to identify the system call using strace -f -T.  In the
>> output you'll see the duration of each system call.  I guess there is a
>> file I/O system call that is taking noticable amounts of time.
>
> yes, i find the reason where bdrv_is_allocated needs to block.
>
> the mainly reason is caused by qemu_co_mutex_lock invoked by
> qcow2_co_get_block_status.
>     qemu_co_mutex_lock(&s->lock);
>     ret = qcow2_get_cluster_offset(bs, sector_num << 9, &bytes,
>                                    &cluster_offset);
>     qemu_co_mutex_unlock(&s->lock);
>
> other reason is caused by l2_load invoked by
> qcow2_get_cluster_offset.
>
>     /* load the l2 table in memory */
>
>     ret = l2_load(bs, l2_offset, &l2_table);
>     if (ret < 0) {
>         return ret;
>     }
>
>>
>> A proper solution is to refactor the synchronous code to make it
>> asynchronous.  This might require invoking the system call from a
>> thread pool worker.
>>
>
> yes, i agree with you, but this is a big change.
> I will try to find how to optimize this code, maybe need a long time.
>
> this patch is not a perfect solution, but can alleviate the problem.

Hi everyone:
    Do you think should we use this patch currently? and optimize this
code later?
    Thanks.

>
>> Stefan
