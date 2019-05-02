Received: from eggs.gnu.org ([209.51.188.92]:49283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM5Po-0007Ai-JT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM5Pn-00036j-Nx
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:41:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hM5Pn-0002wD-Eb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:41:55 -0400
Date: Thu, 2 May 2019 08:41:29 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190502064129.tklft35yvgaj6pq3@sirius.home.kraxel.org>
References: <1556605301-44112-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1556605301-44112-1-git-send-email-longpeng2@huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] usb/xchi: avoid trigger assertion if
 guest write wrong epid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>

On Tue, Apr 30, 2019 at 02:21:41PM +0800, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
>=20
> we found the following core in our environment:
> 0  0x00007fc6b06c2237 in raise ()
> 1  0x00007fc6b06c3928 in abort ()
> 2  0x00007fc6b06bb056 in __assert_fail_base ()
> 3  0x00007fc6b06bb102 in __assert_fail ()
> 4  0x0000000000702e36 in xhci_kick_ep (...)
> 5  0x000000000047897a in memory_region_write_accessor (...)
> 6  0x000000000047767f in access_with_adjusted_size (...)
> 7  0x000000000047944d in memory_region_dispatch_write (...)
> (mr=3Dmr@entry=3D0x7fc6a0138df0, addr=3Daddr@entry=3D156, data=3D164889=
2416,
> size=3Dsize@entry=3D4, attrs=3Dattrs@entry=3D...)
> 8  0x000000000042df17 in address_space_write_continue (...)
> 10 0x000000000043084d in address_space_rw (...)
> 11 0x000000000047451b in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x1ab11b0)
> 12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=3D0x1ab11b0)
> 13 0x0000000000870631 in qemu_thread_start (args=3Dargs@entry=3D0x1acfb=
50)
> 14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=3D<optimiz=
ed out>)
> 15 0x00007fc6b0a60dd5 in start_thread ()
> 16 0x00007fc6b078a59d in clone ()
>=20
> (gdb) f 5
> 5  0x000000000047897a in memory_region_write_accessor (...)
> 529	    mr->ops->write(mr->opaque, addr, tmp, size);
> (gdb) p /x tmp
> $9 =3D 0x62481a00 <-- last byte 0x00 is @epid
>=20
> xhci_doorbell_write() already check the upper bound of @slotid an @epid=
,
> it also need to check the lower bound.
>=20
> Cc: Gonglei <arei.gonglei@huawei.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Longpeng <longpeng2@huawei.com>

Added to usb queue.

thanks,
  Gerd
