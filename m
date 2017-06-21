Received: from eggs.gnu.org ([2001:4830:134:3::10]:51106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1dNlPd-00013B-79
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 15:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1dNlPa-0003X9-4T
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 15:35:37 -0400
Received: from mail5.windriver.com ([192.103.53.11]:34566 helo=mail5.wrs.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1dNlPZ-0003WS-RK
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 15:35:34 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v5LJZUwD032074
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 12:35:30 -0700
Message-ID: <594ACA81.3010402@windriver.com>
Date: Wed, 21 Jun 2017 13:35:29 -0600
From: Chris Friesen <chris.friesen@windriver.com>
MIME-Version: 1.0
References: <CAOE=1Z1Bbgb494m6mYRnX1-80eT0tSnF0F6zNM7efEie4rd7DA@mail.gmail.com>	<CAOE=1Z1LJr9rpaEQ9+b7D5vM3N=Wy0oGunRnzoQ79x3dWA3oaw@mail.gmail.com>	<CALkUq2gp+x-nkALLTLqrSGmw8nfo5FzNeDpr1Gm3qh8N9mDn0Q@mail.gmail.com>	<CAOE=1Z0h+Dd=T8QKyVnTHwFjeYwm-qz_Da7HWEDk=pcrMbp9ug@mail.gmail.com>
	<20170621191601.GB2425@work-vm>
In-Reply-To: <20170621191601.GB2425@work-vm>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [dpdk-dev] Will huge page have negative effect on
 guest vm in qemu enviroment?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 06/21/2017 01:16 PM, Dr. David Alan Gilbert wrote:
> * Sam (batmanustc@gmail.com) wrote:
>> Thank you~
>>
>> 1. We have a compare test on qemu-kvm enviroment with huge page and wi=
thout
>> huge page. Qemu start process is much longer in huge page enviromwnt. =
And I
>> write an email titled with '[DPDK-memory] how qemu waste such long tim=
e
>> under dpdk huge page envriment?'. I could resend it later.
>
>> 2. Then I have another test on qemu-kvm enviroment with huge page and
>> without huge page, which I didn't start ovs-dpdk and vhostuser port in=
 qemu
>> start process. And I found Qemu start process is also much longer in h=
uge
>> page enviroment.
>>
>> So I think huge page enviroment, which grub2.cfg file is specified in
>> =E2=80=98[DPDK-memory]
>> how qemu waste such long time under dpdk huge page envriment?=E2=80=99=
, will really
>> have negative effect on qemu start up process.
>>
>> That's why we don't like to use ovs-dpdk. Althrough ovs-dpdk is faster=
, but
>> the start up process of qemu is much longer then normal ovs, and the r=
eason
>> is nothing with ovs but huge page. For customers, vm start up time is
>> important then network speed.
>
> How are you setting up hugepages?  What values are you putting in the
> various /proc or cmdline options and how are you specifying them on
> QEMU's commandline.
>
> I think one problem is that with hugepages qemu normally allocates them
> all at the start;  I think there are cases where that means moving a lo=
t
> of memory about, especially if you lock it to particular NUMA nodes.


For what it's worth, we use something like this:

-object=20
memory-backend-file,id=3Dram-node0,prealloc=3Dyes,mem-path=3D/mnt/huge-20=
48kB/libvirt/qemu,share=3Dyes,size=3D2147483648,host-nodes=3D0,policy=3Db=
ind=20
-numa node,nodeid=3D0,cpus=3D0-3,memdev=3Dram-node0

and I haven't noticed it taking particularly long to start up.  All our=20
hugepages are reserved at host startup though.

Chris
