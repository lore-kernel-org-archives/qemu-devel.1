Received: from eggs.gnu.org ([2001:4830:134:3::10]:60120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cTD6L-0007gV-6k
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cTD6K-0004Km-1L
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:37:57 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:32977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cTD6J-0004I7-Rz
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:37:55 -0500
Received: by mail-qt0-x244.google.com with SMTP id n13so16232416qtc.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:37:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170116131500.GA14681@stefanha-x1.localdomain>
References: <CA+scX6=rRiGHsOj8oxjTe4KqEF7S_GUao3k=TUQeE7FpyT_K8w@mail.gmail.com>
	<20170103155047.GE14707@stefanha-x1.localdomain>
	<CA+scX6mCDjnZdEMemuDerPxR2L4w12PyyvH==tW_PdW6Kqe7+A@mail.gmail.com>
	<20170116131500.GA14681@stefanha-x1.localdomain>
From: Weiwei Jia <harrynjit@gmail.com>
Date: Mon, 16 Jan 2017 14:37:53 -0500
Message-ID: <CA+scX6ka+8sgt5DaKqmJbcyQ1LS=Me=wR7T41VNat=Wc-nTbvA@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, libvir-list <libvir-list@redhat.com>, krister@redhat.com

On Mon, Jan 16, 2017 at 8:15 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Jan 03, 2017 at 12:02:14PM -0500, Weiwei Jia wrote:
>> > The expensive part is the virtqueue kick.  Recently we tried polling the
>> > virtqueue instead of waiting for the ioeventfd file descriptor and got
>> > double-digit performance improvements:
>> > https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00148.html
>> >
>> > If you want to understand the performance of your benchmark you'll have
>> > compare host/guest disk stats (e.g. request lifetime, disk utilization,
>> > queue depth, average request size) to check that the bare metal and
>> > guest workloads are really sending comparable I/O patterns to the
>> > physical disk.
>> >
>> > Then you using Linux and/or QEMU tracing to analyze the request latency
>> > by looking at interesting points in the request lifecycle like virtqueue
>> > kick, host Linux AIO io_submit(2), etc.
>> >
>>
>> Thank you. I will look into "polling the virtqueue" as you said above.
>> Currently, I just use blktrace to see disk stats and add logs in the
>> I/O workload to see the time latency for each request. What kind of
>> tools are you using to analyze request lifecycle like virtqueue kick,
>> host Linux AIO iosubmit, etc.
>>
>> Do you trace the lifecycle like this
>> (http://www.linux-kvm.org/page/Virtio/Block/Latency#Performance_data)
>> but it seems to be out of date. Does it
>> (http://repo.or.cz/qemu-kvm/stefanha.git/shortlog/refs/heads/tracing-dev-0.12.4)
>> still work on QEMU 2.4.1?
>
> The details are out of date but the general approach to tracing the I/O
> request lifecycle still apply.
>
> There are multiple tracing tools that can do what you need.  I've CCed
> Karl Rister who did the latest virtio-blk dataplane tracing.
>
> "perf record -a -e kvm:\*" is a good start.  You can use "perf probe" to
> trace QEMU's trace events (recent versions have sdt support, which means
> SystemTap tracepoints work) and also trace any function in QEMU:
> http://blog.vmsplice.net/2011/03/how-to-use-perf-probe.html

Thank you. I will try it.


Best,
Weiwei Jia
