Received: from eggs.gnu.org ([2001:4830:134:3::10]:38089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gRX9o-0008Mv-W9
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gRX9l-0008J9-SS
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:47:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:3079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gRX9l-0008Ik-J2
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:47:37 -0500
Message-ID: <5BFCE9B3.4020605@intel.com>
Date: Tue, 27 Nov 2018 14:52:35 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
	<1542276484-25508-5-git-send-email-wei.w.wang@intel.com>
	<20181127060638.GB3205@xz-x1>
In-Reply-To: <20181127060638.GB3205@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 4/8] migration: API to clear bits of
 guest free pages from the dirty bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On 11/27/2018 02:06 PM, Peter Xu wrote:
> On Thu, Nov 15, 2018 at 06:08:00PM +0800, Wei Wang wrote:
> Again, is it possible to resize during migration?
>
> So I think the check is fine, but uncertain about the comment.

Yes, resize would not happen with the current implementation.
But heard it could just be a temporal implementation. Probably
we could improve the comment like this:

"
Though the implementation might not support ram resize currently,
this could happen in theory with future updates. So the check here
handles the case that RAMBLOCK is resized after the free page hint is
reported.
"

>
> And shall we print something if that happened?  We can use
> error_report_once(), and squashing the above assert:
>
>    if (!block || offset > block->used_length) {
>      /* should never happen, but if it happens we ignore the hints and warn */
>      error_report_once("...");
>      return;
>    }
>
> What do you think?

Sounds good.

>
>> +
>> +        if (len <= block->used_length - offset) {
>> +            used_len = len;
>> +        } else {
>> +            used_len = block->used_length - offset;
>> +            addr += used_len;
> Maybe moving this line into the for() could be a bit better?
>
>    for (; len > 0; len -= used_len, addr += used_len) {
>

Yes, I think it looks better, thanks.

Best,
Wei
