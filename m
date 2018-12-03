Received: from eggs.gnu.org ([2001:4830:134:3::10]:37086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gTjBA-0002VZ-Q6
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gTjB7-000085-A2
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:02:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:56907)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gTjB6-00006q-TS
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:02:05 -0500
Message-ID: <5C04E427.8030402@intel.com>
Date: Mon, 03 Dec 2018 16:07:03 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com>
	<1543803511-34793-5-git-send-email-wei.w.wang@intel.com>
	<20181203051025.GB27620@xz-x1>
In-Reply-To: <20181203051025.GB27620@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 4/7] migration: API to clear bits of
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

On 12/03/2018 01:10 PM, Peter Xu wrote:
> On Mon, Dec 03, 2018 at 10:18:28AM +0800, Wei Wang wrote:
>> This patch adds an API to clear bits corresponding to guest free pages
>> from the dirty bitmap. Spilt the free page block if it crosses the QEMU
>> RAMBlock boundary.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Peter Xu <peterx@redhat.com>
>> ---
> [...]
>
>> +void qemu_guest_free_page_hint(void *addr, size_t len)
>> +{
>> +    RAMBlock *block;
>> +    ram_addr_t offset;
>> +    size_t used_len, start, npages;
>> +    MigrationState *s = migrate_get_current();
>> +
>> +    /* This function is currently expected to be used during live migration */
>> +    if (!migration_is_setup_or_active(s->state)) {
>> +        return;
>> +    }
>> +
>> +    for (; len > 0; len -= used_len, addr += used_len) {
>> +        block = qemu_ram_block_from_host(addr, false, &offset);
>> +        if (unlikely(!block || offset > block->used_length)) {
> Maybe >=?  My fault if it is...

It would not cause problems (npages will be 0 below),
but I agree it sounds better to have ">=" earlier here. Thanks!
No problem, I can post another new version.


Best,
Wei
