Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E696C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 04:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5EF921D93
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 04:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EF921D93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPICA-0004hv-38
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 00:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jPIBS-0003z4-4N
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 00:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jPIBO-0007t8-Sj
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 00:00:52 -0400
Received: from [192.146.154.243] (port=13696 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jPIBO-0007sk-LL
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 00:00:50 -0400
Received: from localhost.localdomain (unknown [10.40.36.165])
 by mcp01.nutanix.com (Postfix) with ESMTP id 47556100DA47;
 Fri, 17 Apr 2020 04:00:49 +0000 (UTC)
Date: Mon, 13 Apr 2020 21:44:35 -0400
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
Subject: Re: [PATCH 2/4] vhost-user-blk: fix invalid memory access
Message-ID: <20200414014435.GA7839@localhost.localdomain>
References: <20200415032826.16701-1-fengli@smartx.com>
 <20200415032826.16701-3-fengli@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415032826.16701-3-fengli@smartx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 192.146.154.243
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 15, 2020 at 11:28:24AM +0800, Li Feng wrote:
>=20
> when s->inflight is freed, vhost_dev_free_inflight may try to access
> s->inflight->addr, it will retrigger the following issue.
>=20
> =3D=3D7309=3D=3DERROR: AddressSanitizer: heap-use-after-free on address=
 0x604001020d18 at pc 0x555555ce948a bp 0x7fffffffb170 sp 0x7fffffffb160
> READ of size 8 at 0x604001020d18 thread T0
>     #0 0x555555ce9489 in vhost_dev_free_inflight /root/smartx/qemu-el7/=
qemu-test/hw/virtio/vhost.c:1473
>     #1 0x555555cd86eb in virtio_reset /root/smartx/qemu-el7/qemu-test/h=
w/virtio/virtio.c:1214
>     #2 0x5555560d3eff in virtio_pci_reset hw/virtio/virtio-pci.c:1859
>     #3 0x555555f2ac53 in device_set_realized hw/core/qdev.c:893
>     #4 0x5555561d572c in property_set_bool qom/object.c:1925
>     #5 0x5555561de8de in object_property_set_qobject qom/qom-qobject.c:=
27
>     #6 0x5555561d99f4 in object_property_set_bool qom/object.c:1188
>     #7 0x555555e50ae7 in qdev_device_add /root/smartx/qemu-el7/qemu-tes=
t/qdev-monitor.c:626
>     #8 0x555555e51213 in qmp_device_add /root/smartx/qemu-el7/qemu-test=
/qdev-monitor.c:806
>     #9 0x555555e8ff40 in hmp_device_add /root/smartx/qemu-el7/qemu-test=
/hmp.c:1951
>     #10 0x555555be889a in handle_hmp_command /root/smartx/qemu-el7/qemu=
-test/monitor.c:3404
>     #11 0x555555beac8b in monitor_command_cb /root/smartx/qemu-el7/qemu=
-test/monitor.c:4296
>     #12 0x555556433eb7 in readline_handle_byte util/readline.c:393
>     #13 0x555555be89ec in monitor_read /root/smartx/qemu-el7/qemu-test/=
monitor.c:4279
>     #14 0x5555563285cc in tcp_chr_read chardev/char-socket.c:470
>     #15 0x7ffff670b968 in g_main_context_dispatch (/lib64/libglib-2.0.s=
o.0+0x4a968)
>     #16 0x55555640727c in glib_pollfds_poll util/main-loop.c:215
>     #17 0x55555640727c in os_host_main_loop_wait util/main-loop.c:238
>     #18 0x55555640727c in main_loop_wait util/main-loop.c:497
>     #19 0x555555b2d0bf in main_loop /root/smartx/qemu-el7/qemu-test/vl.=
c:2013
>     #20 0x555555b2d0bf in main /root/smartx/qemu-el7/qemu-test/vl.c:477=
6
>     #21 0x7fffdd2eb444 in __libc_start_main (/lib64/libc.so.6+0x22444)
>     #22 0x555555b3767a  (/root/smartx/qemu-el7/qemu-test/x86_64-softmmu=
/qemu-system-x86_64+0x5e367a)
>=20
> 0x604001020d18 is located 8 bytes inside of 40-byte region [0x604001020=
d10,0x604001020d38)
> freed by thread T0 here:
>     #0 0x7ffff6f00508 in __interceptor_free (/lib64/libasan.so.4+0xde50=
8)
>     #1 0x7ffff671107d in g_free (/lib64/libglib-2.0.so.0+0x5007d)
>=20
> previously allocated by thread T0 here:
>     #0 0x7ffff6f00a88 in __interceptor_calloc (/lib64/libasan.so.4+0xde=
a88)
>     #1 0x7ffff6710fc5 in g_malloc0 (/lib64/libglib-2.0.so.0+0x4ffc5)
>=20
> SUMMARY: AddressSanitizer: heap-use-after-free /root/smartx/qemu-el7/qe=
mu-test/hw/virtio/vhost.c:1473 in vhost_dev_free_inflight
> Shadow bytes around the buggy address:
>   0x0c08801fc150: fa fa 00 00 00 00 04 fa fa fa fd fd fd fd fd fa
>   0x0c08801fc160: fa fa fd fd fd fd fd fd fa fa 00 00 00 00 04 fa
>   0x0c08801fc170: fa fa 00 00 00 00 00 01 fa fa 00 00 00 00 04 fa
>   0x0c08801fc180: fa fa 00 00 00 00 00 01 fa fa 00 00 00 00 00 01
>   0x0c08801fc190: fa fa 00 00 00 00 00 fa fa fa 00 00 00 00 04 fa
> =3D>0x0c08801fc1a0: fa fa fd[fd]fd fd fd fa fa fa fd fd fd fd fd fa
>   0x0c08801fc1b0: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fa
>   0x0c08801fc1c0: fa fa 00 00 00 00 00 fa fa fa fd fd fd fd fd fd
>   0x0c08801fc1d0: fa fa 00 00 00 00 00 01 fa fa fd fd fd fd fd fa
>   0x0c08801fc1e0: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fd
>   0x0c08801fc1f0: fa fa 00 00 00 00 00 01 fa fa fd fd fd fd fd fa
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone:       fa
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
>   Left alloca redzone:     ca
>   Right alloca redzone:    cb
> =3D=3D7309=3D=3DABORTING
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  hw/block/vhost-user-blk.c | 4 ++++
>  hw/virtio/vhost.c         | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 776b9af3eb..19e79b96e4 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -463,7 +463,9 @@ reconnect:
> =20
>  virtio_err:
>      g_free(s->vhost_vqs);
> +    s->vhost_vqs =3D NULL;
>      g_free(s->inflight);
> +    s->inflight =3D NULL;
>      for (i =3D 0; i < s->num_queues; i++) {
>          virtio_delete_queue(s->virtqs[i]);
>      }
> @@ -484,7 +486,9 @@ static void vhost_user_blk_device_unrealize(DeviceS=
tate *dev, Error **errp)
>      vhost_dev_cleanup(&s->dev);
>      vhost_dev_free_inflight(s->inflight);
>      g_free(s->vhost_vqs);
> +    s->vhost_vqs =3D NULL;
>      g_free(s->inflight);
> +    s->inflight =3D NULL;
> =20
>      for (i =3D 0; i < s->num_queues; i++) {
>          virtio_delete_queue(s->virtqs[i]);
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 01ebe12f28..aff98a0ede 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1514,7 +1514,7 @@ void vhost_dev_set_config_notifier(struct vhost_d=
ev *hdev,
> =20
>  void vhost_dev_free_inflight(struct vhost_inflight *inflight)
>  {
> -    if (inflight->addr) {
> +    if (inflight && inflight->addr) {
>          qemu_memfd_free(inflight->addr, inflight->size, inflight->fd);
>          inflight->addr =3D NULL;
>          inflight->fd =3D -1;
> --=20
> 2.11.0
>=20
>=20
> --=20
> The SmartX email address is only for business purpose. Any sent message=
=20
> that is not related to the business is not authorized or permitted by=20
> SmartX.
> =E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=8C=
=E6=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=EF=
=BC=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=9C=
=AC=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=8E=
=E5=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=AA=
=E5=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=E6=
=98=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.
>=20
>=20
>=20

