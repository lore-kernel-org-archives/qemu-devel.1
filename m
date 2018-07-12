Received: from eggs.gnu.org ([2001:4830:134:3::10]:48862)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1fdXp7-0005gG-Ni
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1fdXp2-0000Kx-JZ
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:23:41 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:44838 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1fdXp2-0000F6-8m
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:23:36 -0400
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:23:29 +0200
References: <1531235146-6048-1-git-send-email-pl@kamp.de>
	<20180710153155.GM5852@localhost.localdomain>
	<73DCB217-9027-4248-8C81-A83AD4512927@kamp.de>
	<20180711082526.GA4266@localhost.localdomain>
From: Peter Lieven <pl@kamp.de>
Message-ID: <30a8b1e5-d95b-0ca3-2c19-35337349afb6@kamp.de>
Date: Thu, 12 Jul 2018 11:23:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180711082526.GA4266@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V5] qemu-img: align result of
 is_allocated_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 11.07.2018 um 10:25 schrieb Kevin Wolf:
> Am 10.07.2018 um 22:16 hat Peter Lieven geschrieben:
>>
>>> Am 10.07.2018 um 17:31 schrieb Kevin Wolf <kwolf@redhat.com>:
>>>
>>> Am 10.07.2018 um 17:05 hat Peter Lieven geschrieben:
>>>> We currently don't enforce that the sparse segments we detect during convert are
>>>> aligned. This leads to unnecessary and costly read-modify-write cycles either
>>>> internally in Qemu or in the background on the storage device as nearly all
>>>> modern filesystems or hardware have a 4k alignment internally.
>>>>
>>>> This patch modifies is_allocated_sectors so that its *pnum result will always
>>>> end at an alignment boundary. This way all requests will end at an alignment
>>>> boundary. The start of all requests will also be aligned as long as the results
>>>> of get_block_status do not lead to an unaligned offset.
>>>>
>>>> The number of RMW cycles when converting an example image [1] to a raw device that
>>>> has 4k sector size is about 4600 4k read requests to perform a total of about 15000
>>>> write requests. With this path the additional 4600 read requests are eliminated while
>>>> the number of total write requests stays constant.
>>>>
>>>> [1] https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-amd64-disk1.vmdk
>>>>
>>>> Signed-off-by: Peter Lieven <pl@kamp.de>
>>> It looked convincing, but I'm afraid this is still not correct.
>>> qemu-iotests 122 fails for me with this patch.
>> I will have a look, where and why exactly it fails, but the allocation
>> pattern might be slightly different due to the alignment. What counts
>> is that the output is byte identical or not?
> Right, I noticed only after sending this email that it's qemu-img map
> output that changes and this might actually be okay. I didn't check,
> however, if the exact changes are what is expected and whether we need
> to add more test cases to cover what the test originally wanted to
> cover.
>
> So after all, there's a good chance that all that's missing is just an
> update to the test case.

I checked the output of test 122 and what happens is exactly what is expected.
The zero areas align to 4k or 8k respectively. If they don't align they are reported
as allocated. I would just go ahead and include the test update and send V6 if there
are no objections.

If someone feels that the behaviour is undesired we can also just go ahead
with a light version of the patch and use only bs->request_alignment as target
alignment and ignore the value of min_sparse.

In this case we could even think about as treating this as a bug fix as it
avoids these ugly RMW cycles that we were seeing and this is why we created this
patch.

Best,
Peter
