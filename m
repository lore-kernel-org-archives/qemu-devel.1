Received: from eggs.gnu.org ([2001:4830:134:3::10]:39766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1csZL8-0002Vb-TL
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1csZL7-0004jz-OB
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:26:02 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:36033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1csZL7-0004jn-Hm
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:26:01 -0400
Received: by mail-it0-x243.google.com with SMTP id 190so13249092itm.3
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 11:26:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <aea80d19-4a6f-8791-9b10-34734d238206@redhat.com>
References: <1490583036-3683-1-git-send-email-Ashish.Mittal@veritas.com>
	<aea80d19-4a6f-8791-9b10-34734d238206@redhat.com>
From: ashish mittal <ashmit602@gmail.com>
Date: Mon, 27 Mar 2017 11:25:59 -0700
Message-ID: <CAAo6VWPT36ECzr1gDdW0CqmdXtPbZudtec9Tc_xi+9cvbuDmMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v10 1/2] block/vxhs.c: Add support for a
 new block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, "Venkatesha M.G." <venkatesha.mg@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>

On Mon, Mar 27, 2017 at 8:56 AM, Eric Blake <eblake@redhat.com> wrote:
> On 03/26/2017 09:50 PM, Ashish Mittal wrote:
>> Source code for the qnio library that this code loads can be downloaded from:
>> https://github.com/VeritasHyperScale/libqnio.git
>
> When sending a multi-patch series, please include a 0/2 cover letter
> ('git config format.coverletter auto' can help).
>

Will do!

>>
>> Sample command line using JSON syntax:
>> ./x86_64-softmmu/qemu-system-x86_64 -name instance-00000008 -S -vnc 0.0.0.0:0
>> -k en-us -vga cirrus -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5
>> -msg timestamp=on
>> 'json:{"driver":"vxhs","vdisk-id":"c3e9095a-a5ee-4dce-afeb-2a59fb387410",
>> "server":{"host":"172.172.17.4","port":"9999"}}'
>>
>> Sample command line using URI syntax:
>> qemu-img convert -f raw -O raw -n
>> /var/lib/nova/instances/_base/0c5eacd5ebea5ed914b6a3e7b18f1ce734c386ad
>> vxhs://192.168.0.1:9999/c6718f6b-0401-441d-a8c3-1f0064d75ee0
>
> Do we really need URI syntax, now that we have -blockdev-add going into 2.9?
>

Having it just makes manual testing with CLI easier (less to type).
Would like to retain it for now, unless having this is a problem.
Removing it will also require rework and retesting of the qemu-iotests
patch.

>>
>> Sample command line using TLS credentials (run in secure mode):
>> ./qemu-io --object
>> tls-creds-x509,id=tls0,dir=/etc/pki/qemu/vxhs,endpoint=client -c 'read
>> -v 66000 2.5k' 'json:{"server.host": "127.0.0.1", "server.port": "9999",
>> "vdisk-id": "/test.raw", "driver": "vxhs", "tls-creds":"tls0"}'
>>
>> Signed-off-by: Ashish Mittal <Ashish.Mittal@veritas.com>
>> ---
>>
>
> I'm just doing a high-level review of the interface, and leaving the
> actual code review to others.
>
>> +++ b/block/vxhs.c
>> @@ -0,0 +1,595 @@
>> +/*
>> + * QEMU Block driver for Veritas HyperScale (VxHS)
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>
> No Copyright notice?  The GPL works by virtue of copyright law, so
> generally a copyright holder should be mentioned.
>

I guess what's missing is the "Copyright (c) Veritas, LLC. 2017" line.
Is that correct?

>
>> +++ b/qapi/block-core.json
>> @@ -2118,6 +2118,7 @@
>>  # @iscsi: Since 2.9
>>  # @rbd: Since 2.9
>>  # @sheepdog: Since 2.9
>> +# @vxhs: Since 2.10
>>  #
>>  # Since: 2.0
>>  ##
>> @@ -2127,7 +2128,7 @@
>>              'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
>>              'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
>>              'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
>> -            'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat' ] }
>> +            'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
>
> Markus has patches pending (to promote x-blockdev-del over to
> blockdev-del) that will conflict in context with this patch.  You may
> have to rebase again, but hopefully the conflicts should be easy to
> figure out.
>

I will rebase again as needed. Not having vxhs code merged yet does
create conflicts while rebasing. It would have been much easier to
just send out patches for the review comments :)

>>
>>  ##
>>  # @BlockdevOptionsFile:
>> @@ -2820,6 +2821,22 @@
>>    'data': { '*offset': 'int', '*size': 'int' } }
>>
>>  ##
>> +# @BlockdevOptionsVxHS:
>> +#
>> +# Driver specific block device options for VxHS
>> +#
>> +# @vdisk-id:    UUID of VxHS volume
>> +# @server:      vxhs server IP, port
>> +# @tls-creds:   TLS credentials ID
>> +#
>> +# Since: 2.10
>> +##
>> +{ 'struct': 'BlockdevOptionsVxHS',
>> +  'data': { 'vdisk-id': 'str',
>> +            'server': 'InetSocketAddress',
>
> Do you want to use the new InetSocketAddressBase (just host and port,
> eliminating things like 'to' that don't make much sense in this context)?
>

Don't see InetSocketAddressBase in the latest code. Could you please
give me a usage example for reference? Thanks!

>> +            '*tls-creds': 'str' } }
>> +
>> +##
>>  # @BlockdevOptions:
>>  #
>>  # Options for creating a block device.  Many options are available for all
>> @@ -2881,7 +2898,8 @@
>>        'vhdx':       'BlockdevOptionsGenericFormat',
>>        'vmdk':       'BlockdevOptionsGenericCOWFormat',
>>        'vpc':        'BlockdevOptionsGenericFormat',
>> -      'vvfat':      'BlockdevOptionsVVFAT'
>> +      'vvfat':      'BlockdevOptionsVVFAT',
>> +      'vxhs':       'BlockdevOptionsVxHS'
>>    } }
>>
>>  ##
>>
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
