Received: from eggs.gnu.org ([2001:4830:134:3::10]:51021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1esgsO-0008R7-Ti
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:33:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1esgsL-00039K-Qb
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:33:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:58068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1esgsL-00038k-Hw
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:33:21 -0500
Message-ID: <5A9CBB2F.8010400@intel.com>
Date: Mon, 05 Mar 2018 11:36:15 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com>
	<1519980450-3404-3-git-send-email-wei.w.wang@intel.com>
	<20180302203557-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180302203557-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] virtio-balloon:
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
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 03/03/2018 02:37 AM, Michael S. Tsirkin wrote:
> On Fri, Mar 02, 2018 at 04:47:29PM +0800, Wei Wang wrote:
>> diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
>> index af49e19..16a2aae 100644
>> --- a/include/sysemu/balloon.h
>> +++ b/include/sysemu/balloon.h
> ...
>
>> +typedef void (QEMUBalloonFreePageStart)(void *opaque);
>> +typedef void (QEMUBalloonFreePageStop)(void *opaque);
> So I think the rule is that no bitmap sync must happen
> between these two, otherwise a hint might arrive and
> override the sync output.
>
> Should be documented I think.
>

Yes, agree. How about adding the following new balloon API explanation 
to this patch's commit:

     - balloon_free_page_start: Callers call this API to obtain guest free
       page hints, and clear the related bits from the migration dirty 
bitmap.
       The whole process is implemented in a new thread independent of the
       migration thread. Free page hints imply the part of guest memory is
       likely to be free without a guarantee. That is, the reported free 
pages
       may not be free any more when QEMU receives them, so callers are
       responsible for detecting those pages that are not free pages 
after the
       bits are cleared from the dirty bitmap. To ensure the above, this API
       should be used when the migration dirty logging mechanism (e.g.
       guest memory write-protection) has started.

     - balloon_free_page_stop: Callers call this API to stop the guest from
       reporting free page hints. Bits from the dirty bitmap are safe to
       be cleared on condition that the dirty logging mechanism is recording
       pages that the guest has written to. To avoid the case that clearing
       bits of free page hints overrides the dirty bits offered by the dirty
       logging mechanism, this API is suggested to be called before QEMU
       synchronizes the dirty logging bitmap.

     - balloon_free_page_support: This API is called to check whether the
       balloon device supports the guest free page reporting feature. The
       balloon_free_page_start and balloon_free_page_stop APIs should be 
used
       only when this API returns true.


Best,
Wei
