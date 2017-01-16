Received: from eggs.gnu.org ([2001:4830:134:3::10]:60263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cTD72-00088G-TJ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cTD71-0004VY-PJ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:38:40 -0500
Received: from mail-yb0-x242.google.com ([2607:f8b0:4002:c09::242]:36126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cTD71-0004VT-Kp
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:38:39 -0500
Received: by mail-yb0-x242.google.com with SMTP id l23so4716911ybj.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:38:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0de557f6-8912-6a94-d8f5-009637e921fe@redhat.com>
References: <CA+scX6=rRiGHsOj8oxjTe4KqEF7S_GUao3k=TUQeE7FpyT_K8w@mail.gmail.com>
	<20170103155047.GE14707@stefanha-x1.localdomain>
	<CA+scX6mCDjnZdEMemuDerPxR2L4w12PyyvH==tW_PdW6Kqe7+A@mail.gmail.com>
	<20170116131500.GA14681@stefanha-x1.localdomain>
	<0de557f6-8912-6a94-d8f5-009637e921fe@redhat.com>
From: Weiwei Jia <harrynjit@gmail.com>
Date: Mon, 16 Jan 2017 14:38:38 -0500
Message-ID: <CA+scX6=hdF2pc22ct9vwb2HELBXc2dFbMDuu6HVEexDpXQaWww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Performance about x-data-plane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: krister@redhat.com
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, eblake@redhat.com, libvir-list <libvir-list@redhat.com>

On Mon, Jan 16, 2017 at 10:00 AM, Karl Rister <krister@redhat.com> wrote:
> On 01/16/2017 07:15 AM, Stefan Hajnoczi wrote:
>> On Tue, Jan 03, 2017 at 12:02:14PM -0500, Weiwei Jia wrote:
>>>> The expensive part is the virtqueue kick.  Recently we tried polling the
>>>> virtqueue instead of waiting for the ioeventfd file descriptor and got
>>>> double-digit performance improvements:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00148.html
>>>>
>>>> If you want to understand the performance of your benchmark you'll have
>>>> compare host/guest disk stats (e.g. request lifetime, disk utilization,
>>>> queue depth, average request size) to check that the bare metal and
>>>> guest workloads are really sending comparable I/O patterns to the
>>>> physical disk.
>>>>
>>>> Then you using Linux and/or QEMU tracing to analyze the request latency
>>>> by looking at interesting points in the request lifecycle like virtqueue
>>>> kick, host Linux AIO io_submit(2), etc.
>>>>
>>>
>>> Thank you. I will look into "polling the virtqueue" as you said above.
>>> Currently, I just use blktrace to see disk stats and add logs in the
>>> I/O workload to see the time latency for each request. What kind of
>>> tools are you using to analyze request lifecycle like virtqueue kick,
>>> host Linux AIO iosubmit, etc.
>>>
>>> Do you trace the lifecycle like this
>>> (http://www.linux-kvm.org/page/Virtio/Block/Latency#Performance_data)
>>> but it seems to be out of date. Does it
>>> (http://repo.or.cz/qemu-kvm/stefanha.git/shortlog/refs/heads/tracing-dev-0.12.4)
>>> still work on QEMU 2.4.1?
>>
>> The details are out of date but the general approach to tracing the I/O
>> request lifecycle still apply.
>>
>> There are multiple tracing tools that can do what you need.  I've CCed
>> Karl Rister who did the latest virtio-blk dataplane tracing.
>
> I roughly followed this guide by Luiz Capitulino:
>
> https://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg00887.html
>
> I tweaked his trace-host-and-guest script to avoid doing IO while
> tracing is enabled, my version is available here:
>
> http://people.redhat.com/~krister/tracing/trace-host-and-guest
>
> I built QEMU with --enable-trace-backends=ftrace and then turned on the
> QEMU trace events I was interested in with this bit of bash:
>
> for event in $(/usr/libexec/qemu-kvm -trace help 2>&1|grep virtio|grep
> -v "gpu\|console\|serial\|rng\|balloon\|ccw"); do virsh
> qemu-monitor-command master --hmp trace-event ${event} on; done
>
> At this point, the QEMU trace events are automatically inserted into the
> ftrace buffers and the methodology outlined by Luiz gets the guest
> kernel, host kernel, and QEMU events properly interleaved.


Thank you. I will try it.


Best,
Weiwei Jia
