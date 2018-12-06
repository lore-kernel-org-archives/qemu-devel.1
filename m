Received: from eggs.gnu.org ([2001:4830:134:3::10]:48052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gUsh8-0001U3-C7
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gUsVR-0002dr-DJ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:11:52 -0500
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:47316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1gUsVR-0002aq-45
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:11:49 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	wB6C9irr032920
	for <qemu-devel@nongnu.org>; Thu, 6 Dec 2018 07:11:43 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 16D716D
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 07:11:43 -0500 (EST)
Received: from sendprodmail01.cc.columbia.edu (sendprodmail01.cc.columbia.edu
	[128.59.72.13]) by hazelnut (Postfix) with ESMTP id 014846D
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 07:11:43 -0500 (EST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
	[209.85.208.71])
	by sendprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	wB6CBgEF014622
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 6 Dec 2018 07:11:42 -0500
Received: by mail-ed1-f71.google.com with SMTP id e12so274705edd.16
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 04:11:42 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com.
	[209.85.221.54])
	by smtp.gmail.com with ESMTPSA id e54sm137990edd.71.2018.12.06.04.11.40
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Dec 2018 04:11:40 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id x10so241222wrs.8
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 04:11:40 -0800 (PST)
MIME-Version: 1.0
References: <CAHyh4xgZhGnEvkD5RiUazZ9Eq_jzr4=bXHfwBvCBkbOLN2UyKA@mail.gmail.com>
	<915953bd-cc9c-9456-b619-297138f68ae6@redhat.com>
	<CAHyh4xjNU2ZTvBTqRhVn17SpcqXcKnKvK90oGFeA72t_h3-REw@mail.gmail.com>
	<7cc73aeb-5eee-8b4f-c005-aee64dfb1bf8@redhat.com>
In-Reply-To: <7cc73aeb-5eee-8b4f-c005-aee64dfb1bf8@redhat.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Thu, 6 Dec 2018 07:11:28 -0500
Message-ID: <CAHyh4xhysVpEEiwmYU4cyMZaXwzHZfEyMD4=_4QiNbr9HtKGzA@mail.gmail.com>
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

On Thu, Dec 6, 2018 at 2:33 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2018/12/5 =E4=B8=8B=E5=8D=8810:47, Jintack Lim wrote:
> > On Tue, Dec 4, 2018 at 8:30 PM Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> On 2018/12/5 =E4=B8=8A=E5=8D=882:37, Jintack Lim wrote:
> >>> Hi,
> >>>
> >>> I'm wondering how the current implementation works when logging dirty
> >>> pages during migration from vhost-net (in kernel) when used vIOMMU.
> >>>
> >>> I understand how vhost-net logs GPAs when not using vIOMMU. But when
> >>> we use vhost with vIOMMU, then shouldn't vhost-net need to log the
> >>> translated address (GPA) instead of the address written in the
> >>> descriptor (IOVA) ? The current implementation looks like vhost-net
> >>> just logs IOVA without translation in vhost_get_vq_desc() in
> >>> drivers/vhost/net.c. It seems like QEMU doesn't do any further
> >>> translation of the dirty log when syncing.
> >>>
> >>> I might be missing something. Could somebody shed some light on this?
> >>
> >> Good catch. It looks like a bug to me. Want to post a patch for this?
> > Thanks for the confirmation.
> >
> > What would be a good setup to catch this kind of migration bug? I
> > tried to observe it in the VM expecting to see network applications
> > not getting data correctly on the destination, but it was not
> > successful (i.e. the VM on the destination just worked fine.) I didn't
> > even see anything going wrong when I disabled the vhost logging
> > completely without using vIOMMU.
> >
> > What I did is I ran multiple network benchmarks (e.g. netperf tcp
> > stream and my own one to check correctness of received data) in a VM
> > without vhost dirty page logging, and the benchmarks just ran fine in
> > the destination. I checked the used ring at the time the VM is stopped
> > in the source for migration, and it had multiple descriptors that is
> > (probably) not processed in the VM yet. Do you have any insight how it
> > could just work and what would be a good setup to catch this?
>
>
> According to past experience, it could be reproduced by doing scp from
> host to guest during migration.
>

Thanks. I actually tried that, but didn't see any problem either - I
copied a large file during migration from host to guest (the copy
continued on the destination), and checked md5 hashes using md5sum,
but the copied file had the same checksum as the one in the host.

Do you recall what kind of symptom you observed when the dirty pages
were not migrated correctly with scp?

>
> >
> > About sending a patch, as Michael suggested, I think it's better for
> > you to handle this case - this is not my area of expertise, yet :-)
>
>
> No problem, I will fix this.
>
> Thanks for spotting this issue.
>
>
> >> Thanks
> >>
> >>
> >>> Thanks,
> >>> Jintack
> >>>
> >>>
>
