Received: from eggs.gnu.org ([2001:4830:134:3::10]:39419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gN87t-0008ID-2r
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 22:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gN87s-0006iO-7u
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 22:15:29 -0500
MIME-Version: 1.0
References: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
	<CAKXe6SL=6m5u1utFoJCG65ucuBeGTiuu8rA9wEj_X-tO1jHzEA@mail.gmail.com>
	<20181113101704.GB4830@localhost.localdomain>
	<2db2eb88-bc7c-d3c0-93ca-43d6a2f79b0a@redhat.com>
	<CAKXe6S+e8zBgYU8DnU2tUqQm2C1w14pgqg55YmxwPn1UUW3E7g@mail.gmail.com>
	<9e733597-36bf-0b64-892f-1b35e67a632c@redhat.com>
In-Reply-To: <9e733597-36bf-0b64-892f-1b35e67a632c@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 15 Nov 2018 11:14:49 +0800
Message-ID: <CAKXe6S+Atz0M9NgUEuuN-2e5XDUyGMA0Ser7kipy1yfvuLguSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nvme: fix oob access issue(CVE-2018-16847)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kwolf@redhat.com, keith.busch@intel.com, mreitz@redhat.com, P J P <ppandit@redhat.com>, qemu-block@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:44=E5=86=99=E9=81=93=EF=BC=9A

> On 14/11/2018 02:38, Li Qiang wrote:
> >
> >
> > Paolo Bonzini <pbonzini@redhat.com <mailto:pbonzini@redhat.com>> =E4=BA=
=8E2018
> > =E5=B9=B411=E6=9C=8814=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:2=
7=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     On 13/11/2018 11:17, Kevin Wolf wrote:
> >     > Am 13.11.2018 um 02:45 hat Li Qiang geschrieben:
> >     >> Ping.... what't the status of this patch.
> >     >>
> >     >> I see Kevin's new pr doesn't contain this patch.
> >     >
> >     > Oh, I thought you said that you wanted to fix this at a higher
> >     level so
> >     > that the problem is caught before even getting into nvme code? If
> you
> >     > don't, I can apply the patch for my next pull request.
> >
> >     As far as I know the bug doesn't exist.  Li Qiang, if you have a
> >     reproducer please send it.
> >
> >
> > Hello Paolo,
> > Though I've send the debug information and ASAN output in the mail to
> > secalert@redhat.com <mailto:secalert@redhat.com>, I'm glad provide here=
.
> > This is for read, I think the write the same but as the PoC is in
> > userspace, the mmap can only map the exact size of the MMIO,
> > So we can only write within the area. But if we using a module we can
> > write the out of MMIO I think
> > The nvme device's parameter should set as 'cmb_size_mb=3D2' and the PCI
> > address may differ in your system.
>
> Ok, thanks.  I've created a reproducer using qtest (though I have to run
> now and cannot post it properly).
>
> The patch for the fix is simply:
>
>
So do you send this or me?



> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index fc7dacb816..6385033af3 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1192,7 +1192,7 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
>      .write =3D nvme_cmb_write,
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .impl =3D {
> -        .min_access_size =3D 2,
> +        .min_access_size =3D 1,
>          .max_access_size =3D 8,
>      },
>  };
>
>

> The memory subsystem _is_ recognizing the out-of-bounds 32-bit access,
>

Thanks, this strengthen my understanding of memory subsystem.

Thanks,
Li Qiang


> but because min_access_size=3D2 it sends down a write at offset 2097151
> and size 2.


> Paolo
>
