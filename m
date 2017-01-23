Received: from eggs.gnu.org ([2001:4830:134:3::10]:55332)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cVgQY-0003Qn-OD
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cVgQV-00047o-I9
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:21:02 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:52660 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cVgQV-00046T-92
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:20:59 -0500
References: <1484843730-23848-1-git-send-email-pl@kamp.de>
	<a9fa5294-acbe-a034-febb-a149dfe320f8@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <c79c63af-213e-43ec-d4da-2a6ec61762a3@kamp.de>
Date: Mon, 23 Jan 2017 16:20:54 +0100
MIME-Version: 1.0
In-Reply-To: <a9fa5294-acbe-a034-febb-a149dfe320f8@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2] qemu-img: optimize
 is_allocated_sectors_min
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

Am 21.01.2017 um 20:58 schrieb Max Reitz:
> On 19.01.2017 17:35, Peter Lieven wrote:
>> the current implementation always splits requests if a buffer
>> begins or ends with zeroes independent of the length of the
>> zero area. Change this to really only split off zero areas
>> that have at least a length of 'min' bytes.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>   qemu-img.c | 44 ++++++++++++++------------------------------
>>   1 file changed, 14 insertions(+), 30 deletions(-)
> That is because the idea is that you should delay the write operation as
> much as possible. Say you have some empty space at the beginning of the
> buffer and then some used space. Of course you should then only start
> writing at the point where you actually have to write something. The
> same goes for the end of the buffer. Why write zeroes when you can just
> not do it?
>
> On the other hand, it makes sense to not split a single write operation
> into two just because there is some empty space in the middle. This is
> because just writing that empty space may take less time than issuing
> two operations, especially if that empty space is e.g. in the middle of
> a qcow2 cluster anyway.
>
> This is why empty space in the middle is treated differently than empty
> space at the beginning or the end of the buffer.
>
> Do you have a reason for changing this other than because it simplifies
> the code? Which it does, admittedly, but I think the code does have a
> reason for being how it is.

Hi Max,

thanks for looking into this. I was wrong about my analysis what was
going on with a problem I tried to track down. After your explanation
I think the current implementation is fine and it makes perfect sense
to cut off leading and trailing zeroes.

Peter
