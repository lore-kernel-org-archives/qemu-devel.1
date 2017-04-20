Received: from eggs.gnu.org ([2001:4830:134:3::10]:34842)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1d1DFX-0002CG-Md
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1d1DFT-0002hf-73
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:39:59 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:36492 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1d1DFS-0002gj-TK
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:39:55 -0400
References: <1488288927-4607-1-git-send-email-pl@kamp.de>
	<20170420140514.GM24486@lemon.lan>
	<7731ccd9-b18f-aba2-3bd4-2663b1b9bbea@redhat.com>
	<ad3d3f20-19ac-4af6-f208-fe7d3a3eeb0e@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <976695f8-7917-a5c9-1159-41541b8b16df@kamp.de>
Date: Thu, 20 Apr 2017 16:39:50 +0200
MIME-Version: 1.0
In-Reply-To: <ad3d3f20-19ac-4af6-f208-fe7d3a3eeb0e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: simplify img_convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, ct@flyingcircus.io, stefanha@gmail.com, qemu-devel@nongnu.org, mreitz@redhat.com

Am 20.04.2017 um 16:18 schrieb Eric Blake:
> On 04/20/2017 09:11 AM, Eric Blake wrote:
>> On 04/20/2017 09:05 AM, Fam Zheng wrote:
>>> On Tue, 02/28 14:35, Peter Lieven wrote:
>>>> img_convert has been around before there was an ImgConvertState or
>>>> a block backend, but it has never been modified to directly use
>>>> these structs. Change this by parsing parameters directly into
>>>> the ImgConvertState and directly use BlockBackend where possible.
>>>> Futhermore variable initalization has been reworked and sorted.
>>>>
>>>> Signed-off-by: Peter Lieven <pl@kamp.de>
>>> I see an iotest failure with this patch, in Kevin's block-next tree:
>>>
>>> 019 1s ... - output mismatch (see 019.out.bad)
>>> --- /stor/work/qemu/tests/qemu-iotests/019.out	2017-04-17 16:19:56.523968474 +0800
>>> +++ 019.out.bad	2017-04-20 22:03:29.868216955 +0800
>>> @@ -1086,8 +1086,8 @@
>>>   
>>>   Checking if backing clusters are allocated when they shouldn't
>>>   
>>> -0/128 sectors allocated at offset 1 MiB
>>> -0/128 sectors allocated at offset 4.001 GiB
>>> +128/128 sectors allocated at offset 1 MiB
>>> +128/128 sectors allocated at offset 4.001 GiB
>> Hmm - I wonder if my patch to make 'zero with unmap' on an image with no
>> backing file prefer pure unallocated clusters over a reads-as-zero would
>> make a difference.
>> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01728.html
>>
>> Testing now...
> Nope, did not make a difference, although it's certainly related; per my
> comment in that thread that:
>
>      Note that technically, we _could_ write a cluster as unallocated
>      rather than zero if a backing file exists but the backing file
>      also reads as zero, but that's more expensive to determine, so
>      this optimization is limited to qcow2 without a backing file.
>
>

I will look into this tomorrow.


Peter

-- 

Mit freundlichen Grüßen

Peter Lieven

...........................................................

   KAMP Netzwerkdienste GmbH
   Vestische Str. 89-91 | 46117 Oberhausen
   Tel: +49 (0) 208.89 402-50 | Fax: +49 (0) 208.89 402-40
   pl@kamp.de | http://www.kamp.de

   Geschäftsführer: Heiner Lante | Michael Lante
   Amtsgericht Duisburg | HRB Nr. 12154
   USt-Id-Nr.: DE 120607556

...........................................................
