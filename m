Received: from eggs.gnu.org ([2001:4830:134:3::10]:51107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fPkQR-000235-5G
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fPkQM-0000R3-2m
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:01:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:27903)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fPkQL-0000QX-OK
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:01:06 -0400
Message-ID: <5B14F2A3.9010805@intel.com>
Date: Mon, 04 Jun 2018 16:04:51 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
	<20180529181221-mutt-send-email-mst@kernel.org>
	<5B0E6AE9.2030505@intel.com>
	<20180530154325-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180530154325-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, zhang.zhanghailiang@huawei.com, Peter Xu <peterx@redhat.com>

On 05/30/2018 08:47 PM, Michael S. Tsirkin wrote:
> On Wed, May 30, 2018 at 05:12:09PM +0800, Wei Wang wrote:
>> On 05/29/2018 11:24 PM, Michael S. Tsirkin wrote:
>>> On Tue, Apr 24, 2018 at 02:13:47PM +0800, Wei Wang wrote:
>>>> +/*
>>>> + * Balloon will report pages which were free at the time of this call. As the
>>>> + * reporting happens asynchronously, dirty bit logging must be enabled before
>>>> + * this call is made.
>>>> + */
>>>> +void balloon_free_page_start(void)
>>>> +{
>>>> +    balloon_free_page_start_fn(balloon_opaque);
>>>> +}
>>> Please create notifier support, not a single global.
>> OK. The start is called at the end of bitmap_sync, and the stop is called at
>> the beginning of bitmap_sync. In this case, we will need to add two
>> migration states, MIGRATION_STATUS_BEFORE_BITMAP_SYNC and
>> MIGRATION_STATUS_AFTER_BITMAP_SYNC, right?

Peter, do you have any thought about this?

Currently, the usage of free page optimization isn't limited to the 
first stage. It is used in each stage. A global call to start the free 
page optimization is made after bitmap sync, and another global call to 
stop the optimization is made before bitmap sync. It is simple to just 
use global calls.

If we change the implementation to use notifiers, I think we will need 
to add two new MigrationStatus as above. Would you think that is 
worthwhile for some reason?

Best,
Wei
