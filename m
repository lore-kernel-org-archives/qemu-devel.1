Received: from eggs.gnu.org ([208.118.235.92]:35542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiaoguangrong@tencent.com>) id 1gbQPD-00055J-S2
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 08:36:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiaoguangrong@tencent.com>) id 1gbQP9-0007zN-Nd
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 08:36:27 -0500
Received: from mail2.tencent.com ([163.177.67.195]:43358)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiaoguangrong@tencent.com>) id 1gbQP9-0007vg-AP
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 08:36:23 -0500
From: "xiaoguangrong(Xiao Guangrong)" <xiaoguangrong@tencent.com>
Date: Mon, 24 Dec 2018 13:36:14 +0000
Message-ID: <019819C6E743904A88B43F7DDEED99BBA7E71370@EXMBX-SZMAIL008.tencent.com>
References: <20181213075727.23540-1-xiaoguangrong@tencent.com>
	<20181221081055.GD2996@xz-x1>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/2] optimize waiting for free thread to do
 compression(Internet mail)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "guangrong.xiao@gmail.com" <guangrong.xiao@gmail.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "wei.w.wang@intel.com" <wei.w.wang@intel.com>, "eblake@redhat.com" <eblake@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "cota@braap.org" <cota@braap.org>

On 12/21/18 4:11 PM, Peter Xu wrote:=0A=
> On Thu, Dec 13, 2018 at 03:57:25PM +0800, guangrong.xiao@gmail.com wrote:=
=0A=
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>=0A=
>>=0A=
>> Currently we have two behaviors if all threads are busy to do compressio=
n,=0A=
>> the main thread mush wait one of them becoming free if @compress-wait-th=
read=0A=
>> set to on or the main thread can directly return without wait and post=
=0A=
>> the page out as normal one=0A=
>>=0A=
>> Both of them have its profits and short-comes, however, if the bandwidth=
 is=0A=
>> not limited extremely so that compression can not use out all of it band=
width,=0A=
>> at the same time, the migration process is easily throttled if we posted=
 too=0A=
>> may pages as normal pages. None of them can work properly under this cas=
e=0A=
>>=0A=
>> In order to use the bandwidth more effectively, we introduce the third=
=0A=
>> behavior, compress-wait-thread-adaptive, which make the main thread wait=
=0A=
>> if there is no bandwidth left or let the page go out as normal page if t=
here=0A=
>> has enough bandwidth to make sure the migration process will not be=0A=
>> throttled=0A=
>>=0A=
>> Another patch introduces a new statistic, pages-per-second, as bandwidth=
=0A=
>> or mbps is not enough to measure the performance of posting pages out as=
=0A=
>> we have compression, xbzrle, which can significantly reduce the amount o=
f=0A=
>> the data size, instead, pages-per-second if the one we want=0A=
>>=0A=
>> Performance data=0A=
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>> We have limited the bandwidth to 300=0A=
>>=0A=
>>                                  Used Bandwidth     Pages-per-Second=0A=
>> compress-wait-thread =3D on         951.66 mbps         131784=0A=
>>=0A=
>> compress-wait-thread =3D off        2491.74 mbps        93495=0A=
>> compress-wait-thread-adaptive     1982.94 mbps        162529=0A=
>>     =3D on=0A=
> =0A=
> Sounds reasonable to me, though it looks like there're only three=0A=
> options: on, off, adaptive.  Should we squash the two parameters?=0A=
=0A=
Thanks for your review, Peter!=0A=
=0A=
That's good to me, if other guys do not have objects, i will do it in the=
=0A=
next version.=0A=
