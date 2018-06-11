Received: from eggs.gnu.org ([2001:4830:134:3::10]:46121)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1fSNMV-0007ER-JA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1fSNMR-00072R-Kc
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:59:59 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:39812 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1fSNMR-0006zt-AO
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:59:55 -0400
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:59:43 +0200
References: <1528375581-29538-1-git-send-email-pl@kamp.de>
	<db7a78de-7962-63ee-e550-f954f12a3586@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <6a1e0e02-0c43-7ca5-322a-565232802f75@kamp.de>
Date: Mon, 11 Jun 2018 15:59:45 +0200
MIME-Version: 1.0
In-Reply-To: <db7a78de-7962-63ee-e550-f954f12a3586@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] qemu-img: align is_allocated_sectors to 4k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com

Am 11.06.2018 um 15:30 schrieb Max Reitz:
> On 2018-06-07 14:46, Peter Lieven wrote:
>> We currently don't enforce that the sparse segments we detect during convert are
>> aligned. This leads to unnecessary and costly read-modify-write cycles either
>> internally in Qemu or in the background on the storage device as nearly all
>> modern filesystems or hardware has a 4k alignment internally.
>>
>> As we per default set the min_sparse size to 4k it makes perfectly sense to ensure
>> that these sparse holes in the file are placed at 4k boundaries.
>>
>> The number of RMW cycles when converting an example image [1] to a raw device that
>> has 4k sector size is about 4600 4k read requests to perform a total of about 15000
>> write requests. With this path the 4600 additional read requests are eliminated.
>>
>> [1] https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-amd64-disk1.vmdk
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>   qemu-img.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
> I like the idea, but it doesn't seem guaranteed that
> is_allocated_sectors() is called on aligned offsets, so this alignment
> work may still leave things unaligned.

I can't image why this should happen. As long as the alignment devides the buffer size we either
write or skip aligned bytes. Maybe get_block_status returns an unaligned number of sectors?

>
> Furthermore, we should probably not blindly assume 4k but instead use
> some block limit of the target, like pwrite_zeroes_alignment, or
> pdiscard_alignment, depending on the case.  (Or probably still
> min_sparse, if that's less.)
>
> Since is_allocated_sectors_min() (the only caller of
> is_allocated_sectors()) is called from just a single place, taking those
> factors into account should be possible.

I also thought of this, but for instance for raw-posix I always get a request_alignment of 1.
But maybe the alignments you proposed produce a better result. I will check that.

Thanks,
Peter
