Received: from eggs.gnu.org ([2001:4830:134:3::10]:38491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwoIH-0002lW-G3
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwoID-0005h9-LI
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:49:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fwoID-0005gb-EY
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:49:21 -0400
Date: Mon, 3 Sep 2018 13:49:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180903124917.GF14377@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-7-sameeh@daynix.com>
	<20180903115406.GA14377@redhat.com>
	<CAKPgXcGp=YNE8qH-A7bKAiFQHHnWmo8+KQBVDnbgw8gPwPgJOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKPgXcGp=YNE8qH-A7bKAiFQHHnWmo8+KQBVDnbgw8gPwPgJOA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 6/6] virtio-net: rss: Add bpf filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>

On Mon, Sep 03, 2018 at 03:35:02PM +0300, Sameeh Jubran wrote:
> On Mon, Sep 3, 2018 at 2:54 PM, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > On Thu, Aug 30, 2018 at 05:27:08PM +0300, Sameeh Jubran wrote:
> >> From: Sameeh Jubran <sjubran@redhat.com>
> >>
> >> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> >> ---
> >>  hw/net/rss_bpf_insns.h       | 3992 +++++++++++++++++++++++++++++++=
+++++++++++
> >>  hw/net/rss_tap_bpf.h         |   40 +
> >>  hw/net/rss_tap_bpf_program.c |  175 ++
> >>  hw/net/virtio-net.c          |   99 +-
> >>  4 files changed, 4305 insertions(+), 1 deletion(-)
> >>  create mode 100644 hw/net/rss_bpf_insns.h
> >>  create mode 100644 hw/net/rss_tap_bpf.h
> >>  create mode 100644 hw/net/rss_tap_bpf_program.c
> >>
> >> diff --git a/hw/net/rss_bpf_insns.h b/hw/net/rss_bpf_insns.h
> >> new file mode 100644
> >> index 0000000000..1a92110b8d
> >> --- /dev/null
> >> +++ b/hw/net/rss_bpf_insns.h
> >> @@ -0,0 +1,3992 @@
> >> +/*
> >> + * RSS ebpf instructions for virtio-net
> >> + *
> >> + * Copyright (c) 2018 RedHat.
> >
> > Why copyright RedHat ?
> >
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2 =
or later.
> >> + * See the COPYING file in the top-level directory.
> >> + *
> >> + */
> >> +
> >> +#include <linux/bpf.h>
> >> +
> >> +#ifndef BPF_RSS_INSNS
> >> +#define BPF_RSS_INSNS
> >> +
> >> +/* bpf_insn array matching l3_l4 section. see tap_bpf_program.c fil=
e */
> >> +struct bpf_insn l3_l4_hash_insns[] =3D {
> >> +{0xbf , 0x6 , 0x1 , 0x0000 , 0x00000000},
> >> +{0x28 , 0x0 , 0x0 , 0x0000 , 0x0000000c},
> >> +{0xbf , 0x8 , 0x0 , 0x0000 , 0x00000000},
> >
> > [snip]
> >
> >> +};
> >
> > This massive array is presumably an auto-generated content.
> >
> > We shouldn't be storing this in GIT. We need to store the
> > original preferred source format, and providing makefile
> > rules to generate it.
> >
> >
> >> +
> >> +#endif
> >> diff --git a/hw/net/rss_tap_bpf.h b/hw/net/rss_tap_bpf.h
> >> new file mode 100644
> >> index 0000000000..54b88cfb76
> >> --- /dev/null
> >> +++ b/hw/net/rss_tap_bpf.h
> >> @@ -0,0 +1,40 @@
> >> +/*
> >> + * RSS ebpf header for virtio-net
> >> + *
> >> + * Copyright (c) 2018 RedHat.
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2 =
or later.
> >> + * See the COPYING file in the top-level directory.
> >> + *
> >> + * This code is heavily based on the following bpf code from dpdk
> >> + * https://git.dpdk.org/dpdk/tree/drivers/net/tap/
> >
> > There are alot of files in this directory, with varying different
> > copyright claims on them, while you're claiming Red Hat copyright.
> > This looks dubious.
> >
> >> + *
> >> + */
> >> +
> >> +#ifndef RSS_TAP_BPF_H
> >> +#define RSS_TAP_BPF_H
> >> +
> >> +/* hashed fields for RSS */
> >> +enum hash_field {
> >> +  HASH_FIELD_IPV4_L3,  /* IPv4 src/dst addr */
> >> +  HASH_FIELD_IPV4_L3_L4,  /* IPv4 src/dst addr + L4 src/dst ports *=
/
> >> +  HASH_FIELD_IPV6_L3,  /* IPv6 src/dst addr */
> >> +  HASH_FIELD_IPV6_L3_L4,  /* IPv6 src/dst addr + L4 src/dst ports *=
/
> >> +  HASH_FIELD_L2_SRC,  /* Ethernet src addr */
> >> +  HASH_FIELD_L2_DST,  /* Ethernet dst addr */
> >> +  HASH_FIELD_L3_SRC,  /* L3 src addr */
> >> +  HASH_FIELD_L3_DST,  /* L3 dst addr */
> >> +  HASH_FIELD_L4_SRC,  /* TCP/UDP src ports */
> >> +  HASH_FIELD_L4_DST,  /* TCP/UDP dst ports */
> >> +};
> >> +
> >> +struct rss_key {
> >> +  __u32 hash_fields;
> >> +  __u32 nb_queues;
> >> +    __u32 *indirection_table;
> >> +    __u32 indirection_table_size;
> >> +  __u8 *key;
> >> +  __u32 key_size;
> >> +} __attribute__((packed));
> >> +
> >> +#endif
> >> diff --git a/hw/net/rss_tap_bpf_program.c b/hw/net/rss_tap_bpf_progr=
am.c
> >> new file mode 100644
> >> index 0000000000..2744436e86
> >> --- /dev/null
> >> +++ b/hw/net/rss_tap_bpf_program.c
> >> @@ -0,0 +1,175 @@
> >> +/*
> >> + * RSS ebpf code for virtio-net
> >> + *
> >> + * Copyright (c) 2018 RedHat.
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2 =
or later.
> >> + * See the COPYING file in the top-level directory.
> >> + *
> >> + * This code is heavily based on the following bpf code from dpdk
> >> + * https://git.dpdk.org/dpdk/tree/drivers/net/tap/tap_bpf_program.c
> >
> > That file says
> >
> >    * Copyright 2017 Mellanox Technologies, Ltd
> >
> > while you are claiming RedHat copyright. That can't be right attribut=
ion
> > if this is indeed a derived work.
> I am not an expert when it comes to licensing, I gave credits Mellanox
> for the work but I have introduced some new changes as well to suit my
> usage.
> Moreover the license for the original code is 3BSD or GPL, I have no
> idea how this is possible and which license I should take into
> account?
> Anyways I'd love some guidance on this topic so I can give the
> appropriate credit where it is needed.

I can't give legal advice - it is best to ask your own company's experts
if you need such advice.

I will just say from a code review POV, I'd generally expect the original
source license and copyright lines to be preserved, and extra copyright
line added to reflect changes made.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
