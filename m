Received: from eggs.gnu.org ([2001:4830:134:3::10]:55149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dBJEc-0001eW-HL
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dBJEY-0000IB-J0
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:04:46 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:34838 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dBJEY-0000Hh-6p
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:04:42 -0400
References: <20170518100925.28682-1-vsementsov@virtuozzo.com>
	<20170518102523.GD4646@noname.redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4f9deae2-c489-9681-83d3-e878adb33946@virtuozzo.com>
Date: Thu, 18 May 2017 14:04:34 +0300
MIME-Version: 1.0
In-Reply-To: <20170518102523.GD4646@noname.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] qcow2: add allocated-size to image
 specific info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org

18.05.2017 13:25, Kevin Wolf wrote:
> Am 18.05.2017 um 12:09 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Shows, how much data qcow2 allocates in underlying file. This should
>> be helpful on non-sparse file systems, when qemu-img info "disk size"
>> doesn't provide this information.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> Hi all.
>>
>> Here is an allocated-size feature for qemu-img info.
> I'm not a fan of loading all L2 tables (can take some time) for
> 'qemu-img info' (which should be very quick). Why isn't the qemu-img
> check output good enough?
>
> Kevin
>
> $ ./qemu-img check /tmp/test.qcow2
> No errors were found on the image.
> 16164/491520 = 3.29% allocated, 11.98% fragmented, 0.00% compressed clusters
> Image end offset: 1060044800
> $ ./qemu-img check --output=json /tmp/test.qcow2
> {
>      "image-end-offset": 1060044800,
>      "total-clusters": 491520,
>      "check-errors": 0,
>      "allocated-clusters": 16164,
>      "filename": "/tmp/test.qcow2",
>      "format": "qcow2",
>      "fragmented-clusters": 1937
> }


It is not the same, it shows guest clusters, but we need host clusters - 
including all metadata, dirty bitmaps, snapshots, etc..



-- 
Best regards,
Vladimir
