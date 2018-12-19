Received: from eggs.gnu.org ([2001:4830:134:3::10]:42412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gZaWY-0008Tf-5f
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gZaWU-0003vy-40
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:00:26 -0500
References: <1545149484-4929-1-git-send-email-thuth@redhat.com>
	<878t0mbs79.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a1001443-d2ef-732c-fa26-cfa7b88b8e1a@redhat.com>
Date: Wed, 19 Dec 2018 13:00:09 +0100
MIME-Version: 1.0
In-Reply-To: <878t0mbs79.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU PATCH] block: Remove blk_attach_dev_legacy()
 / legacy_dev code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

On 2018-12-18 19:33, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> The last user of blk_attach_dev_legacy() is the code in xen_disk.c.
>> It passes a pointer to a XenBlkDev as second parameter. XenBlkDev
>> is derived from XenDevice which in turn is derived from DeviceState
>> since commit 3a6c9172ac5951e ("xen: create qdev for each backend device").
>> Thus the code can also simply use blk_attach_dev() with a pointer
>> to the DeviceState instead.
>> So we can finally remove all code related to the "legacy_dev" flag, too,
>> and turn the related "void *" in block-backend.c into "DeviceState *"
>> to fix some of the remaining TODOs there.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  Note: I haven't tested the Xen code since I don't have a working Xen
>>  installation at hand. I'd appreciate if someone could check it...
[...]
>> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
>> index 36eff94..9605caf 100644
>> --- a/hw/block/xen_disk.c
>> +++ b/hw/block/xen_disk.c
>> @@ -801,7 +801,9 @@ static int blk_connect(struct XenDevice *xendev)
>>           * so we can blk_unref() unconditionally */
>>          blk_ref(blkdev->blk);
>>      }
>> -    blk_attach_dev_legacy(blkdev->blk, blkdev);
>> +    if (blk_attach_dev(blkdev->blk, DEVICE(blkdev)) < 0) {
>> +        return -1;
>> +    }
> 
> Other error returns in this function call xen_pv_printf() first.  Should
> this one, too?

Only some of them do a xen_pv_printf() first, there are also many that
don't. blk_attach_dev() currently only returns an error if a device has
already been attach - which should simply never happen here, so a printf
currently does not seem to be justified to me. Alternatively, we could
also abort() here instead, I think. I'll leave that decision up to the
Xen maintainers...

 Thomas
