Received: from eggs.gnu.org ([209.51.188.92]:48869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1h0sLW-0001uD-MH
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1h0sLU-0004NH-MX
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:29:50 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1h0sLQ-0004BW-U2
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:29:46 -0500
Received: by mail-wr1-x441.google.com with SMTP id w2so6652798wrt.11
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:29:44 -0800 (PST)
References: <20190304084238.13481-1-marcel.apfelbaum@gmail.com>
	<550bead8-a9a5-d9f4-1204-a6130f8c8e14@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <a18b38a0-fd94-f478-d25a-a1a7ba73b1a1@gmail.com>
Date: Mon, 4 Mar 2019 20:30:22 +0200
MIME-Version: 1.0
In-Reply-To: <550bead8-a9a5-d9f4-1204-a6130f8c8e14@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: clang compilation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com



On 3/4/19 8:11 PM, Eric Blake wrote:
> On 3/4/19 2:42 AM, Marcel Apfelbaum wrote:
>> Configuring QEMU with:
>>          ../configure --cc=clang --enable-rdma
>>
>> Leads to compilation error:
>>
>>    CC      migration/rdma.o
>>    CC      migration/block.o
>>    qemu/migration/rdma.c:3615:58: error: taking address of packed 
>> member 'rkey' of class or structure
>>        'RDMARegisterResult' may result in an unaligned pointer value 
>> [-Werror,-Waddress-of-packed-member]
>>                              (uintptr_t)host_addr, NULL, 
>> &reg_result->rkey,
>> ^~~~~~~~~~~~~~~~
>>
>> This is a false warning; even if RDMARegisterResult is "packed", rkey
>> is the first field so is guaranteed to be aligned.
>
> Not so. If you packed struct, gcc is free to abut that struct next to 
> some other unaligned field in a larger struct:
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06743.html
>

I wasn't referring to general case, but to this specific case. Actually 
gcc does not complain, only clang.

Anyway, Dave's suggestion is clean and works for me.

Thanks,
Marcel

>>
>> Fix it by disabling the warning only for this instance.
>
> Ignoring the bug is not the same as fixing the bug.  You need to 
> rework this, as the compiler warning is not a false negative.
>
>>
>> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> ---
>>   migration/rdma.c | 3 +++
>>   1 file changed, 3 insertions(+)
