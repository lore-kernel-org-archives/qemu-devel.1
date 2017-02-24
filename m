Received: from eggs.gnu.org ([2001:4830:134:3::10]:56330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1chCg8-0001U9-5q
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:00:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1chCg5-00083T-0w
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:00:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1chCg4-0007yO-PG
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:00:40 -0500
References: <589D83CE.1090803@huawei.com> <589DDC05.9010807@windriver.com>
	<58AA51D6.6020508@huawei.com> <1487565495.3740.27.camel@intel.com>
	<58AD0094.90304@windriver.com>
	<4dd92012-626a-2d80-9adb-0be398f73eb1@redhat.com>
	<58AD92AE.6040502@windriver.com>
	<6c5567f4-192d-aefd-90e4-89f53479c24e@redhat.com>
	<58AF9921.6060201@huawei.com> <58AFFE55.20306@huawei.com>
	<20170224095951.GA11626@kroah.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <044a553e-83d4-7c1b-fc93-292da7e678a4@redhat.com>
Date: Fri, 24 Feb 2017 11:00:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170224095951.GA11626@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] kvm bug in __rmap_clear_dirty during live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg KH <gregkh@linuxfoundation.org>, "Herongguang (Stephen)" <herongguang.he@huawei.com>
Cc: Chris Friesen <chris.friesen@windriver.com>, "Han, Huaitong" <huaitong.han@intel.com>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>, stable@vger.kernel.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "fangying1@huawei.com" <fangying1@huawei.com>, "xudong.hao@linux.intel.com" <xudong.hao@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxinxin.wang@huawei.com" <wangxinxin.wang@huawei.com>, "kai.huang@linux.intel.com" <kai.huang@linux.intel.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "guangrong.xiao@linux.intel.com" <guangrong.xiao@linux.intel.com>, linux-kernel@vger.kernel.org



On 24/02/2017 10:59, Greg KH wrote:
> On Fri, Feb 24, 2017 at 05:35:17PM +0800, Herongguang (Stephen) wrote:
>>
>>
>> On 2017/2/24 10:23, Herongguang (Stephen) wrote:
>>>
>>>
>>> On 2017/2/22 22:43, Paolo Bonzini wrote:
>>>>
>>>>
>>>> On 22/02/2017 14:31, Chris Friesen wrote:
>>>>>>>
>>>>>>
>>>>>> Can you reproduce it with kernel 4.8+?  I'm suspecting commmit
>>>>>> 4e59516a12a6 ("kvm: vmx: ensure VMCS is current while enabling PML=
",
>>>>>> 2016-07-14) to be the fix.
>>>>>
>>>>> I can't easily try with a newer kernel, the software package we're =
using
>>>>> has kernel patches that would have to be ported.
>>>>>
>>>>> I'm at a conference, don't really have time to set up a pair of tes=
t
>>>>> machines from scratch with a custom kernel.
>>>>
>>>> Hopefully Gaohuai and Rongguang can help with this too.
>>>>
>>>> Paolo
>>>>
>>>> .
>>>>
>>> Yes, we are looking into and testing this.
>>>
>>> I think this can result in any memory corruption, if VM1 writes its
>>> PML buffer into VM2=E2=80=99s VMCS (since sched_in/sched_out notifier=
 of VM1
>>> is not registered yet), then VM1 is destroyed (hence its PML buffer
>>> is freed back to kernel), after that, VM2 starts migration, so CPU
>>> logs VM2=E2=80=99s dirty GFNS into a freed memory, results in any mem=
ory corruption.
>>>
>>> As its severity, this commit (http://git.kernel.org/cgit/linux/kernel=
/git/torvalds/linux.git/commit/?id=3D4e59516a12a6ef6dcb660cb3a3f70c64bd60=
cfec)
>>> is eligible to back port to kernel stable.
>>
>> Hi, Greg, can you cherry pick commit 4e59516a12a6ef6dcb660cb3a3f70c64b=
d60cfec to 4.4-y?
>=20
> If the KVM maintainers say it is ok to do so, yes, I will.

Yes, he beat me by minutes. :)

Paolo
