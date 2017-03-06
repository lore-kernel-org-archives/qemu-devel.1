Received: from eggs.gnu.org ([2001:4830:134:3::10]:42382)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1ckwEF-0000Qm-D4
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:15:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1ckwEC-00021f-7Y
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:15:23 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:36495 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1ckwEB-00020t-Uv
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:15:20 -0500
References: <1488288927-4607-1-git-send-email-pl@kamp.de>
	<aa13b45a-8d8a-5bb8-e17a-608159270733@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <8290a34f-939b-970b-de5e-e2e6a38e6f5d@kamp.de>
Date: Mon, 6 Mar 2017 18:15:16 +0100
MIME-Version: 1.0
In-Reply-To: <aa13b45a-8d8a-5bb8-e17a-608159270733@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: simplify img_convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@gmail.com, ct@flyingcircus.io, mreitz@redhat.com, famz@redhat.com

Am 06.03.2017 um 17:46 schrieb Eric Blake:
> On 02/28/2017 07:35 AM, Peter Lieven wrote:
>> img_convert has been around before there was an ImgConvertState or
>> a block backend, but it has never been modified to directly use
>> these structs. Change this by parsing parameters directly into
>> the ImgConvertState and directly use BlockBackend where possible.
>> Futhermore variable initalization has been reworked and sorted.
> s/Futhermore/Furthermore/
> s/initalization/initialization/
>
> I almost wonder if this should be split into multiple patches for ease
> of review.  But since you've already submitted it, I'll review it as-is.
>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>   qemu-img.c | 197 +++++++++++++++++++++++++------------------------------------
>>   1 file changed, 81 insertions(+), 116 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index caa76a7..f271167 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1488,7 +1488,7 @@ typedef struct ImgConvertState {
>>       int min_sparse;
>>       size_t cluster_sectors;
>>       size_t buf_sectors;
>> -    int num_coroutines;
>> +    long num_coroutines;
> Why is this change needed? A hint in the commit message may be
> appropriate (I'm especially wary of 'long', as it differs between 32-
> and 64-bit platforms).

This is long because it is passed as a pointer to qemu_strtol. num_coroutines
was also long.

Peter
