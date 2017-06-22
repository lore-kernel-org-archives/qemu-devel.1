Received: from eggs.gnu.org ([2001:4830:134:3::10]:60925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dNqfw-0000Dl-MP
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 21:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dNqfv-00066E-Rt
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 21:12:48 -0400
References: <7ec58051-d835-a485-7578-2022351c9712@gmail.com>
	<20170619072727.GA6113@noname.redhat.com>
	<6324ce25-8fa8-9204-d15b-32f20fb71e4b@gmail.com>
	<20170619104915.GC6113@noname.redhat.com>
From: Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <1295c586-859f-23d5-67c5-e1d730ef63b5@gmail.com>
Date: Thu, 22 Jun 2017 09:12:03 +0800
MIME-Version: 1.0
In-Reply-To: <20170619104915.GC6113@noname.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Question] How can we confirm hot-plug disk
 succesfully?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, armbru@redhat.com

在 6/19/2017 6:49 PM, Kevin Wolf 写道:
>> 'info block' shows nothing, but we can't add drive who's id
>> is'drive-virtio-disk1' too.
> Yes, the old BlockBackend is only fully freed when the guest actually
> unplugs the device. Specifically, we would have to free the QemuOpts
> in DriveInfo that keeps the ID reserved. Currently, it is only freed
> when the BlockBackend is destroyed:
> 
>      blockdev_auto_del()
>          blk_unref()
>              blk_delete()
>                  drive_info_del()
> 
> We can't free the DriveInfo earlier because it's still needed while the
> guest device is still alive.
> 
> I'm not sure, but it may be possible to free just the QemuOpts in
> monitor_remove_blk(), so that the ID can immediately be reused.
> 
> Markus, would you know?
> 

Hi, all. Any ideas?

>> There is a more serious situation, we
>> could*never*  destory device memory with 'device_del', it's memory
>> leak to me if the guest os never support hot-plug and the user don't
>> know this information.
> The user sees that they never get a DEVICE_REMOVED event, so in some way
> the do know about it.

But the useless memory is always there and no way to free it, although 
we known that.
BTW, is it possible to force destroy the BlockBackend in this situation?

-- 
Thanks
     -Xie
