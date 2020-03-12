Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEFFC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 05:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A23020663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 05:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1zITaxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A23020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCGkf-0007TN-NK
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 01:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jCGk5-00074Y-Hr
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 01:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jCGk2-0003Vl-QA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 01:50:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35996
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jCGk2-0003Tg-Lb
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 01:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583992245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujPZoIrogHpMCzdmDsMv9AxyDGRpV4swnq5eWfusq/Y=;
 b=D1zITaxl5fTauEjsYc4ZrN4TVGfvniCgRltsASEM+hSIAKbplSFnSDJsH9UoPVOAnuOr/R
 /ldVIWzmC3fwHSgX1Nc44CQnzT0utfsW0ZgEqHki5YXFb0Zj4bKs89N+oOOTxQxyuH9xDC
 NKKtd4Px6LxfhqTKg2r4ny/1XvCnXxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-A0Bl0bqvN5SvBsAyKboktg-1; Thu, 12 Mar 2020 01:50:40 -0400
X-MC-Unique: A0Bl0bqvN5SvBsAyKboktg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AA241005509;
 Thu, 12 Mar 2020 05:50:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E932B8FBEB;
 Thu, 12 Mar 2020 05:50:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 80BC511386A6; Thu, 12 Mar 2020 06:50:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RESEND 1/3] vfio/pci: fix a null pointer reference in
 vfio_rom_read
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-2-longpeng2@huawei.com>
 <20200224090458.080152c0@w520.home>
 <87k13rl6df.fsf@dusky.pond.sub.org>
 <20200311093939.494bfe27@w520.home>
Date: Thu, 12 Mar 2020 06:50:30 +0100
In-Reply-To: <20200311093939.494bfe27@w520.home> (Alex Williamson's message of
 "Wed, 11 Mar 2020 09:39:39 -0600")
Message-ID: <87zhcmrujd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: weifuqiang@huawei.com, mst@redhat.com, qemu-devel@nongnu.org,
 arei.gonglei@huawei.com, huangzhichao@huawei.com,
 "Longpeng\(Mike\)" <longpeng2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Williamson <alex.williamson@redhat.com> writes:

> On Wed, 11 Mar 2020 08:04:28 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Alex Williamson <alex.williamson@redhat.com> writes:
>>=20
>> > On Mon, 24 Feb 2020 14:42:17 +0800
>> > "Longpeng(Mike)" <longpeng2@huawei.com> wrote:
>> > =20
>> >> From: Longpeng <longpeng2@huawei.com>
>> >>=20
>> >> vfio_pci_load_rom() maybe failed and then the vdev->rom is NULL in
>> >> some situation (though I've not encountered yet), maybe we should
>> >> avoid the VM abort. =20
>>=20
>> What "VM abort" exactly?
>
> There is none because memcpy() does something sane when size is zero,
> but to be ISO whatever spec compliant we shouldn't rely on that.
>
>> >>=20
>> >> Signed-off-by: Longpeng <longpeng2@huawei.com>
>> >> ---
>> >>  hw/vfio/pci.c | 13 ++++++++-----
>> >>  1 file changed, 8 insertions(+), 5 deletions(-)
>> >>=20
>> >> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> >> index 5e75a95..ed798ae 100644
>> >> --- a/hw/vfio/pci.c
>> >> +++ b/hw/vfio/pci.c
>> >> @@ -768,7 +768,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>> >>      }
>> >>  }
>> >> =20
>> >> -static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>> >> +static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>> >>  {
>> >>      struct vfio_region_info *reg_info;
>> >>      uint64_t size;
>> >> @@ -778,7 +778,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev=
)
>> >>      if (vfio_get_region_info(&vdev->vbasedev,
>> >>                               VFIO_PCI_ROM_REGION_INDEX, &reg_info)) =
{
>> >>          error_report("vfio: Error getting ROM info: %m");
>> >> -        return;
>> >> +        return false;
>> >>      }
>> >> =20
>> >>      trace_vfio_pci_load_rom(vdev->vbasedev.name, (unsigned long)reg_=
info->size,
>> >> @@ -797,7 +797,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev=
)
>> >>          error_printf("Device option ROM contents are probably invali=
d "
>> >>                      "(check dmesg).\nSkip option ROM probe with romb=
ar=3D0, "
>> >>                      "or load from file with romfile=3D\n");
>> >> -        return;
>> >> +        return false;
>> >>      }
>> >> =20
>> >>      vdev->rom =3D g_malloc(size);
>> >> @@ -849,6 +849,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev=
)
>> >>              data[6] =3D -csum;
>> >>          }
>> >>      }
>> >> +
>> >> +    return true;
>> >>  }
>> >> =20
>> >>  static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned si=
ze)
>> >> @@ -863,8 +865,9 @@ static uint64_t vfio_rom_read(void *opaque, hwadd=
r addr, unsigned size) =20
>>     {
>>         VFIOPCIDevice *vdev =3D opaque;
>>         union {
>>             uint8_t byte;
>>             uint16_t word;
>>             uint32_t dword;
>>             uint64_t qword;
>>         } val;
>> >>      uint64_t data =3D 0;
>> >> =20
>> >>      /* Load the ROM lazily when the guest tries to read it */
>> >> -    if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
>> >> -        vfio_pci_load_rom(vdev);
>> >> +    if (unlikely(!vdev->rom && !vdev->rom_read_failed) &&
>> >> +        !vfio_pci_load_rom(vdev)) {
>> >> +        return 0;
>> >>      }
>> >> =20
>> >>      memcpy(&val, vdev->rom + addr, =20
>> >
>> > Looks like an obvious bug, until you look at the rest of this memcpy()=
:
>> >
>> > memcpy(&val, vdev->rom + addr,
>> >            (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) =
: 0);
>> >
>> > IOW, we'll do a zero sized memcpy() if rom_size is zero, so there's no
>> > risk of the concern identified in the commit log.  This patch is
>> > unnecessary.  Thanks, =20
>>=20
>> I'm blind: why does !vdev->rom imply !vdev->rom_size?
>
> See vfio_pci_load_rom(), rom_size and rom are set and allocated
> together.

What if vfio_pci_load_rom() isn't called, or returns before it sets
these guys?

>> Moreover, when MIN(size, vdev->rom_size - addr) < size, we seem to read
>> uninitialized data from @val:
>
> This is fixed in my patch
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg02778.html

Yes.

>>=20
>>         switch (size) {
>>         case 1:
>>             data =3D val.byte;
>>             break;
>>         case 2:
>>             data =3D le16_to_cpu(val.word);
>>             break;
>>         case 4:
>>             data =3D le32_to_cpu(val.dword);
>>             break;
>>         default:
>>             hw_error("vfio: unsupported read size, %d bytes\n", size);
>>             break;
>>         }
>>=20
>>         trace_vfio_rom_read(vdev->vbasedev.name, addr, size, data);
>>=20
>>         return data;
>>     }
>>=20
>> Why is that okay?
>>=20
>> Why do we initialize @data?
>
> Bug.  The switch was only added later (75bd0c7253f3) and we failed to
> catch it.  Prior to that we were initializing val and the memcpy() only
> overwrote it as necessary.  In any case, getting back garbage for the
> rom when there isn't one generally works ok since the chances of
> generating a proper rom signature are infinitesimal.  Clearly not what
> was intended though.
>
>> How can we get to the default case?  If we can get there, is hw_error()
>> really the right thing to do?  It almost never is...  If getting there
>> is the guest's fault, we need to tell it off the same way physical
>> hardware does.  If we should not ever get there (i.e. it's a QEMU bug),
>> then a plain abort() would be clearer.
>
> AFAIK this is relatively standard, if not somewhat paranoid, handling
> for a MemoryRegion ops callback.  The MemoryRegionOps code only allows
> certain size accesses, so it would effectively be an internal error to
> hit the default case, which seems to be not an uncommon use case of
> hw_error.  Thanks,

Using hw_error() for such programming errors is not helpful.  Everything
it adds to abort() is useless or misleading.

In fact, most uses of hw_error() are not helpful.

But you're going with the flow here.  I accept that.


