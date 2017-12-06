Received: from eggs.gnu.org ([2001:4830:134:3::10]:49828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMWK2-0001pN-S7
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMWJy-0004oD-1H
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:48:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eMWJx-0004nn-Ra
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:48:53 -0500
References: <1511505030-3669-1-git-send-email-yang.zhong@intel.com>
	<5A1A5C6E.9060409@huawei.com> <20171201105622.GB26237@yangzhon-Virtual>
	<74cccd14-e485-90d4-82d9-03355c05faca@redhat.com>
	<20171204120322.GA32151@yangzhon-Virtual> <5A253EF5.6040300@huawei.com>
	<20171205060047.GA4102@yangzhon-Virtual>
	<024fd897-a16a-f69e-94dc-07affb3ef724@redhat.com>
	<20171206092625.GA19639@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6bfac215-b5ba-fd09-d17b-310a2c843a2b@redhat.com>
Date: Wed, 6 Dec 2017 10:48:45 +0100
MIME-Version: 1.0
In-Reply-To: <20171206092625.GA19639@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] rcu: reduce more than 7MB heap memory
 by malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, stefanha@redhat.com, berrange@redhat.com
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, zhaoshenglong@huawei.com

On 06/12/2017 10:26, Yang Zhong wrote:
>   Hello Paolo,
>=20
>   The best option is only trim one time after guest kernel bootup or VM=
 bootup, and as for
>   hotplug/unhotplug operations during the VM running, the trim still ca=
n do for each batch
>   memory free because trim will not impact VM performance during VM run=
ning status.
>=20
>   So, the key point is qemu is hard to know when guest ernel bootup is =
over. If you have some=20
>   suggestions, please let me know. thanks!

It shouldn't be hard.  Does QEMU's RCU thread actually get any
significant activity after bootup?  Hence the suggestion of keeping
malloc_trim in the RCU thread, but only do it if some time has passed
since the last time.

Maybe something like this every time the RCU thread runs:

 static uint64_t next_trim_time, last_trim_time;
 if (current time < next_trim_time) {
     next_trim_time -=3D last_trim_time / 2    /* or higher */
     last_trim_time -=3D last_trim_time / 2    /* same as previous line *=
/
 } else {
     trim_start_time =3D current time
     malloc_trim(...)
     last_trim_time =3D current time - trim_start_time
     next_trim_time =3D current time + last_trim_time
 }

Where the "2" factor should be tuned so that both your and Shannon's
scenario work fine.

Thanks,

Paolo
