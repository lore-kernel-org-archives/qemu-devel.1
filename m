Received: from eggs.gnu.org ([2001:4830:134:3::10]:59877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1crKfz-0003Av-FJ
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 04:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1crKfw-0003CX-Di
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 04:34:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1crKfw-0003CM-7R
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 04:34:24 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <5023e01f-ee47-d066-eb7b-0ac4b8837283@huawei.com> (Yang
	Hongyang's message of "Fri, 24 Mar 2017 09:57:31 +0800")
References: <20170323210124.12300-1-quintela@redhat.com>
	<5023e01f-ee47-d066-eb7b-0ac4b8837283@huawei.com>
Reply-To: quintela@redhat.com
Date: Fri, 24 Mar 2017 09:34:21 +0100
Message-ID: <87d1d7844y.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC] Split migration bitmaps by ramblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Hongyang <yanghongyang@huawei.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Yang Hongyang <yanghongyang@huawei.com> wrote:
> Hi Juan,
>
>   First of all, I like the refactor patchset about RAMState, it makes
> things clean, great!

Thanks.

The whole idea of the series was to make testing changes easier.

> On 2017/3/24 5:01, Juan Quintela wrote:
>> Hi
>> 
>> This series split the migration and unsent bitmaps by ramblock.  This
>> makes it easier to synchronize in small bits.  This is on top of the
>> RAMState and not-hotplug series.
>> 
>> Why?
>> 
>> reason 1:
>> 
>> People have complained that by the time that we detect that a page is
>> sent, it has already been marked dirty "again" inside kvm, so we are
>> going to send it again.  On top of this patch, my idea is, for words
>> of the bitmap that have any bit set, just synchonize the bitmap before
>> sending the pages.  I have not looking into performance numbers yet,
>> jsut asking for comments about how it is done.
>
> Here you said 'synchonize the bitmap before sending the pages', do you
> mean synchronize the bitmap from kvm? If so, I doubt the performance...
> because every synchronization will require a ioctl(). If not, the
> synchronization of per block is useless.
>
> Currently, migration thread will synchronize the bitmap from kvm every
> iter(migration_bitmap_sync()). The RAMBlock already has kind of per block
> bitmap for this kind of sync. And the migration bitmap is used to put all
> those per block bitmap together for data sending use.

Hi
For huge memory machines, we are doing it always in one go.


bitmap_sync(1TB RAM)
walk bitmap for 512MB of RAM, at that point, it is very probable that
this page is again dirty in the KVM bitmap, so, we send it, but as it is
dirty again, we would have to send it in the next pass.  This sent is
completely useless.

So my idea is to split things in smaller chunks.  As we have to do an
ioctl, we wouldn't want to synchronize page by page, but perhaps 16MB at
a time, 64MB, anything less than the whole amount of memory.

Later, Juan.
