Received: from eggs.gnu.org ([2001:4830:134:3::10]:54913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1crRHm-00042Q-9F
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1crRHl-0006E1-C8
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:37:54 -0400
MIME-Version: 1.0
In-Reply-To: <CAJSP0QX_FVWE2Y=TwCDLNqpX8i+erSr=2OY4iw9jPVUmD5ieqA@mail.gmail.com>
References: <1489233245-27057-1-git-send-email-ashijeetacharya@gmail.com>
	<CAJSP0QXYdcBt1zOLEz1fdVBg6eo2Yg+uCA=u2nPQHBe01Bo9ow@mail.gmail.com>
	<CAC2QTZbOK76fi3fX_msqc_UJu_J1RMkA7dXnSn+Zs5Cxyon6jA@mail.gmail.com>
	<20170323150955.GD12560@stefanha-x1.localdomain>
	<CAC2QTZZSPKXW6_Aaw4pTOqixpijT7XuiO3TjXwWz6BNkR-H+9g@mail.gmail.com>
	<CAJSP0QX_FVWE2Y=TwCDLNqpX8i+erSr=2OY4iw9jPVUmD5ieqA@mail.gmail.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Fri, 24 Mar 2017 21:07:49 +0530
Message-ID: <CAC2QTZZfCbT0BQ0CzwHBxjSn1-9_xbfD88Jax82HMdt6pDpbQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/2] Allocate mutiple clusters for VMDK I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On Fri, Mar 24, 2017 at 8:54 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Thu, Mar 23, 2017 at 4:22 PM, Ashijeet Acharya
> <ashijeetacharya@gmail.com> wrote:
>> On Thu, Mar 23, 2017 at 8:39 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>> On Tue, Mar 21, 2017 at 09:14:08AM +0000, Ashijeet Acharya wrote:
>>>> On Tue, 21 Mar 2017 at 13:21, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>>
>>>> > On Sat, Mar 11, 2017 at 11:54 AM, Ashijeet Acharya
>>>> > <ashijeetacharya@gmail.com> wrote:
>>>> > > This series optimizes the I/O performance of VMDK driver.
>>>> > >
>>>> > > Patch 1 makes the VMDK driver to allocate multiple clusters at once.
>>>> > Earlier
>>>> > > it used to allocate cluster by cluster which slowed down its performance
>>>> > to a
>>>> > > great extent.
>>>> > >
>>>> > > Patch 2 changes the metadata update code to update the L2 tables for
>>>> > multiple
>>>> > > clusters at once.
>>
>> These are the commands I ran to test the write requests:
>>
>> My test file "test1.vmdk" is a 1G empty vmdk image created by using
>> 'qemu-img' tool.
>>
>> Before optimization:
>> $ ./bin/qemu-io -f vmdk --cache writeback
>> qemu-io> open -n -o driver=vmdk test1.vmdk
>> qemu-io> aio_write 0 128M
>> qemu-io> wrote 134217728/134217728 bytes at offset 0
>> 128 MiB, 1 ops; 0:00:16.46 (7.772 MiB/sec and 0.0607 ops/sec)
>>
>> After optimization:
>> $ ./bin/qemu-io -f vmdk --cache writeback
>> qemu-io> open -n -o driver=vmdk test1.vmdk
>> qemu-io> aio_write 0 128M
>> qemu-io> wrote 134217728/134217728 bytes at offset 0
>> 128 MiB, 1 ops; 0:00:08.19 (15.627 MiB/sec and 0.1221 ops/sec)
>>
>> Will these work?
>
> It is best to avoid --cache writeback in performance tests because
> using the host page cache puts the performance at the mercy of the
> kernel's page cache.

Okay, understood.

>
> I have run the following benchmark using "qemu-img bench":
>
> This patch series improves 128 KB sequential write performance to an
> empty VMDK file by 29%.
>
> Benchmark command: ./qemu-img bench -w -c 1024 -s 128K -d 1 -t none -f
> vmdk test.vmdk
>
> (Please include the 2 lines above in the next revision of the patch.)
>
Yes, I will do that. Also, this really helped me understand how to
actually test I/O optimizations.

Thanks for your help, this really solved my issue.

Ashijeet
