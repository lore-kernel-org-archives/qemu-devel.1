Received: from eggs.gnu.org ([2001:4830:134:3::10]:41907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cRr99-0006TZ-B8
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 20:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cRr98-0004nq-5l
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 20:59:15 -0500
Received: from [45.249.212.189] (port=2377 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cRr97-0004iw-E3
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 20:59:14 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 13 Jan 2017 01:56:03 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA18F954@DGGEMA505-MBX.china.huawei.com>
References: <1481767396-187748-1-git-send-email-arei.gonglei@huawei.com>
	<1481767396-187748-2-git-send-email-arei.gonglei@huawei.com>
	<e235caf4-f51c-dccf-4eb7-548d3fa71644@de.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA182B83@DGGEMA505-MBX.china.huawei.com>
	<c4282723-2afb-1764-2431-ef41f7126371@de.ibm.com>
	<a8384ff8-ff65-c578-c338-e6d8ebf498c4@de.ibm.com>
	<20170112161729-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170112161729-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 1/1] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "Huangweidong
	(C)" <weidong.huang@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, Luonengjun <luonengjun@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, longpeng <longpeng2@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "Wubin (H)" <wu.wubin@huawei.com>

>=20
> On Thu, Jan 12, 2017 at 03:10:25PM +0100, Christian Borntraeger wrote:
> > On 01/10/2017 01:56 PM, Christian Borntraeger wrote:
> > > On 01/10/2017 01:36 PM, Gonglei (Arei) wrote:
> > >> Hi,
> > >>
> > >>>
> > >>> On 12/15/2016 03:03 AM, Gonglei wrote:
> > >>> [...]
> > >>>> +
> > >>>> +static struct crypto_alg virtio_crypto_algs[] =3D { {
> > >>>> +	.cra_name =3D "cbc(aes)",
> > >>>> +	.cra_driver_name =3D "virtio_crypto_aes_cbc",
> > >>>> +	.cra_priority =3D 501,
> > >>>
> > >>>
> > >>> This is still higher than the hardware-accelerators (like intel aes=
ni or the
> > >>> s390 cpacf functions or the arm hw). aesni and s390/cpacf are suppo=
rted
> by the
> > >>> hardware virtualization and available to the guests. I do not see a=
 way
> how
> > >>> virtio
> > >>> crypto can be faster than that (in the end it might be cpacf/aesni =
+
> overhead)
> > >>> instead it will very likely be slower.
> > >>> So we should use a number that is higher than software implementati=
ons
> but
> > >>> lower than the hw ones.
> > >>>
> > >>> Just grepping around, the software ones seem be be around 100 and t=
he
> > >>> hardware
> > >>> ones around 200-400. So why was 150 not enough?
> > >>>
> > >> I didn't find a documentation about how we use the priority, and I a=
ssumed
> > >> people use virtio-crypto will configure hardware accelerators in the
> > >> host. So I choosed the number which bigger than aesni's priority.
> > >
> > > Yes, but the aesni driver will only bind if there is HW support in th=
e guest.
> > > And if aesni is available in the guest (or the s390 aes function from=
 cpacf)
> > > it will always be faster than the same in the host via virtio.So your=
 priority
> > > should be smaller.
> >
> >
> > any opinion on this?
>=20
> Going forward, we might add an emulated aesni device and that might
> become slower than virtio. OTOH if or when this happens, we can solve it
> by adding a priority or a feature flag to virtio to raise its priority.
>=20
> So I think I agree with Christian here, let's lower the priority.
> Gonglei, could you send a patch like this?
>=20
OK, will do.

Thanks,
-Gonglei
