Received: from eggs.gnu.org ([2001:4830:134:3::10]:43558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1d10T6-0005xE-0d
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 21:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1d10T4-00050O-QP
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 21:01:08 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:34763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1d10T4-0004zn-MG
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 21:01:06 -0400
Received: by mail-io0-x241.google.com with SMTP id h41so9718887ioi.1
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 18:01:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170419162705.GG3343@stefanha-x1.localdomain>
References: <1491277689-24949-1-git-send-email-Ashish.Mittal@veritas.com>
	<1491277689-24949-2-git-send-email-Ashish.Mittal@veritas.com>
	<20170419162705.GG3343@stefanha-x1.localdomain>
From: ashish mittal <ashmit602@gmail.com>
Date: Wed, 19 Apr 2017 18:01:03 -0700
Message-ID: <CAAo6VWMxwOXAV8PJ5dBmKmB5O3UE9X5Hsj83iti=4BGYdbepeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v11 1/2] block/vxhs.c: Add support for a
 new block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, "Venkatesha M.G." <venkatesha.mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>, Eric Blake <eblake@redhat.com>, Abhijit Dey <Abhijit.Dey@veritas.com>

On Wed, Apr 19, 2017 at 9:27 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Apr 03, 2017 at 08:48:08PM -0700, Ashish Mittal wrote:
>> Source code for the qnio library that this code loads can be downloaded from:
>> https://github.com/VeritasHyperScale/libqnio.git
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
>>
>> Sample command line using TLS credentials (run in secure mode):
>> ./qemu-io --object
>> tls-creds-x509,id=tls0,dir=/etc/pki/qemu/vxhs,endpoint=client -c 'read
>> -v 66000 2.5k' 'json:{"server.host": "127.0.0.1", "server.port": "9999",
>> "vdisk-id": "/test.raw", "driver": "vxhs", "tls-creds":"tls0"}'
>>
>> Signed-off-by: Ashish Mittal <Ashish.Mittal@veritas.com>
>> ---
>> v11 changelog:
>> (1) Replaced InetSocketAddress with InetSocketAddressBase.
>> (2) Removed access to qemu_uuid.
>> (3) Removed unnecessary g_strdup()/g_free().
>> (4) Removed unused acb->qiov.
>> (5) Changed vxhs_init_and_ref() and vxhs_unref() per suggestion.
>> (6) Removed unnecessary initializations from local variables.
>
> QEMU code:
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
Thanks!

> libvxhs is not robust yet.  Here are two examples:
>
> 1. If the response from the server has an invalid magic number then the
>    whole VM is aborted:
>
>    QNIO_API_(void) kvset_unmarshal(qnio_byte_t * bs, kvset_t * *p)
>    {
>        ...
>        assert(magic == kvset_magic);
>
> 2. There are buffer overflows and other memory corruptions.  For example
>    when kv_binary_unpack() gets size=-1 over the wire.
>

We will continue to audit the library code and fix potential security
issues with libvxhs.

> The code needs to be audited line-by-line by someone aware of secure
> coding practices.  Please look into this.
>
> Also, is there a plan for getting libvxhs into Fedora and Debian?

At the moment, our requirement is only RHEL. The library should build
and work fine with any distro.
We also plan to build source tarballs and checkin to github for every
release of libvxhs.
