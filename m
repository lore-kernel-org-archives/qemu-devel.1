Received: from eggs.gnu.org ([2001:4830:134:3::10]:45390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gUYTK-0002OM-Tl
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gUYTG-0005IF-R8
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:48:18 -0500
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:34022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1gUYTD-0005G8-BH
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:48:12 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	wB5ElpmF050604
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 09:48:09 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 420996D
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 09:48:09 -0500 (EST)
Received: from sendprodmail02.cc.columbia.edu (sendprodmail02.cc.columbia.edu
	[128.59.72.14]) by hazelnut (Postfix) with ESMTP id 55B3FAE
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 09:48:06 -0500 (EST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
	[209.85.208.69])
	by sendprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	wB5Em59G060442
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 09:48:06 -0500
Received: by mail-ed1-f69.google.com with SMTP id m19so9987237edc.6
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 06:48:06 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com.
	[209.85.128.53])
	by smtp.gmail.com with ESMTPSA id h9sm624436ede.93.2018.12.05.06.48.03
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Dec 2018 06:48:03 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id r24so11959857wmh.0
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 06:48:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHyh4xgZhGnEvkD5RiUazZ9Eq_jzr4=bXHfwBvCBkbOLN2UyKA@mail.gmail.com>
	<915953bd-cc9c-9456-b619-297138f68ae6@redhat.com>
In-Reply-To: <915953bd-cc9c-9456-b619-297138f68ae6@redhat.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Wed, 5 Dec 2018 09:47:54 -0500
Message-ID: <CAHyh4xjNU2ZTvBTqRhVn17SpcqXcKnKvK90oGFeA72t_h3-REw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Logging dirty pages from vhost-net in-kernel with
 vIOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, "\\ Michael S . Tsirkin \\" <mst@redhat.com>

On Tue, Dec 4, 2018 at 8:30 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2018/12/5 =E4=B8=8A=E5=8D=882:37, Jintack Lim wrote:
> > Hi,
> >
> > I'm wondering how the current implementation works when logging dirty
> > pages during migration from vhost-net (in kernel) when used vIOMMU.
> >
> > I understand how vhost-net logs GPAs when not using vIOMMU. But when
> > we use vhost with vIOMMU, then shouldn't vhost-net need to log the
> > translated address (GPA) instead of the address written in the
> > descriptor (IOVA) ? The current implementation looks like vhost-net
> > just logs IOVA without translation in vhost_get_vq_desc() in
> > drivers/vhost/net.c. It seems like QEMU doesn't do any further
> > translation of the dirty log when syncing.
> >
> > I might be missing something. Could somebody shed some light on this?
>
>
> Good catch. It looks like a bug to me. Want to post a patch for this?

Thanks for the confirmation.

What would be a good setup to catch this kind of migration bug? I
tried to observe it in the VM expecting to see network applications
not getting data correctly on the destination, but it was not
successful (i.e. the VM on the destination just worked fine.) I didn't
even see anything going wrong when I disabled the vhost logging
completely without using vIOMMU.

What I did is I ran multiple network benchmarks (e.g. netperf tcp
stream and my own one to check correctness of received data) in a VM
without vhost dirty page logging, and the benchmarks just ran fine in
the destination. I checked the used ring at the time the VM is stopped
in the source for migration, and it had multiple descriptors that is
(probably) not processed in the VM yet. Do you have any insight how it
could just work and what would be a good setup to catch this?

About sending a patch, as Michael suggested, I think it's better for
you to handle this case - this is not my area of expertise, yet :-)

>
> Thanks
>
>
> >
> > Thanks,
> > Jintack
> >
> >
>
