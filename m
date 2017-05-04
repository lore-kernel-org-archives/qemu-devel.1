Received: from eggs.gnu.org ([2001:4830:134:3::10]:38684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6GL1-0004BK-A9
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6GKw-0007sT-FF
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:58:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6GKw-0007sH-8H
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:58:26 -0400
References: <20170503072819.14462-1-famz@redhat.com>
	<20170503074240.GC9318@lemon.lan>
	<CAJ+F1CK9sup=RVT2wCuiFMiCPZAryPg1qYX9HtDGwvnTy73oRA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e9180c7-dc77-a300-2638-9a1b8c9a1a31@redhat.com>
Date: Thu, 4 May 2017 14:58:20 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CK9sup=RVT2wCuiFMiCPZAryPg1qYX9HtDGwvnTy73oRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump: Acquire BQL around vm_start() in
 dump thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, peterx@redhat.com



On 03/05/2017 10:37, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, May 3, 2017 at 11:42 AM Fam Zheng <famz@redhat.com
> <mailto:famz@redhat.com>> wrote:
>=20
>     On Wed, 05/03 15:28, Fam Zheng wrote:
>     > This fixes an assertion failure in the following backtrace:
>=20
> Do you know if it's a regression? Is this a racy case? (I couldn't
> reproduce)

I think it's never worked since separate-thread dump was introduced.

Paolo

>=20
>     >     __GI___assert_fail
>     >     memory_region_transaction_commit
>     >     memory_region_add_eventfd
>     >     virtio_pci_ioeventfd_assign
>     >     virtio_bus_set_host_notifier
>     >     virtio_blk_data_plane_start
>     >     virtio_bus_start_ioeventfd
>     >     virtio_vmstate_change
>     >     vm_state_notify
>     >     vm_prepare_start
>     >     vm_start
>     >     dump_cleanup
>     >     dump_process
>     >     dump_thread
>     >     start_thread
>     >     clone
>     >
>     > vm_start need BQL, acquire it if doing cleaning up from main thre=
ad.
>=20
>     Oops, s/need/needs and s/main thread/detached thread/.
>=20
> =20
> With that fixed,
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com
> <mailto:marcandre.lureau@redhat.com>>
>=20
> --=20
> Marc-Andr=C3=A9 Lureau
