Received: from eggs.gnu.org ([209.51.188.92]:48168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1h0sIx-0007up-6r
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1h0sIw-00006q-5r
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:27:11 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1h0sIv-000063-RQ
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:27:10 -0500
Received: by mail-wr1-x443.google.com with SMTP id o17so6668275wrw.3
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:27:09 -0800 (PST)
References: <20190304084238.13481-1-marcel.apfelbaum@gmail.com>
	<550bead8-a9a5-d9f4-1204-a6130f8c8e14@redhat.com>
	<20190304181827.GD2596@work-vm>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <b0d49a13-1e0f-4f34-ca2c-738563671aa7@gmail.com>
Date: Mon, 4 Mar 2019 20:27:46 +0200
MIME-Version: 1.0
In-Reply-To: <20190304181827.GD2596@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

Hi David,

On 3/4/19 8:18 PM, Dr. David Alan Gilbert wrote:
> * Eric Blake (eblake@redhat.com) wrote:
>> On 3/4/19 2:42 AM, Marcel Apfelbaum wrote:
>>> Configuring QEMU with:
>>>           ../configure --cc=clang --enable-rdma
>>>
>>> Leads to compilation error:
>>>
>>>     CC      migration/rdma.o
>>>     CC      migration/block.o
>>>     qemu/migration/rdma.c:3615:58: error: taking address of packed member 'rkey' of class or structure
>>>         'RDMARegisterResult' may result in an unaligned pointer value [-Werror,-Waddress-of-packed-member]
>>>                               (uintptr_t)host_addr, NULL, &reg_result->rkey,
>>>                                                            ^~~~~~~~~~~~~~~~
>>>
>>> This is a false warning; even if RDMARegisterResult is "packed", rkey
>>> is the first field so is guaranteed to be aligned.
>> Not so. If you packed struct, gcc is free to abut that struct next to some
>> other unaligned field in a larger struct:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06743.html
>>
>>> Fix it by disabling the warning only for this instance.
>> Ignoring the bug is not the same as fixing the bug.  You need to rework
>> this, as the compiler warning is not a false negative.
> In this case it is, however, I think it's easy enough to work around;
> all we need is something like:
>
>    uint23_t tmp_rkey;
>                    if (qemu_rdma_register_and_get_keys(rdma, block,
>                              (uintptr_t)host_addr, NULL, &tmp_rkey,
>                              chunk, chunk_start, chunk_end)) {
>                      error_report("cannot get rkey");
>                      ret = -EINVAL;
>                      goto out;
>                    }
>                    reg_result->rkey = tmp_rkey

Thanks for the suggestion, looks OK for me, I will re-spin.

Thanks,
Marcel

> Note that I think the structure pointed to by reg_result is
> visible over the wire, so we can't change it's (unfortunate) layout.
>
> Dave
>
>>> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>> ---
>>>    migration/rdma.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>> -- 
>> Eric Blake, Principal Software Engineer
>> Red Hat, Inc.           +1-919-301-3226
>> Virtualization:  qemu.org | libvirt.org
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
