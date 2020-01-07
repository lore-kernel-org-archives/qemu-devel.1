Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABDEC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8C821744
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGjcoVwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8C821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopmb-0001sy-Hd
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1iopRB-0000ND-8O
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsuvorov@redhat.com>) id 1iopR9-0007JP-2C
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:02:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56326
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsuvorov@redhat.com>) id 1iopR8-0007Is-U7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578405742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Me1h4NcoK3/YeYbD6wOSOV/PNnZNx3IvPR8UV3C9izQ=;
 b=aGjcoVwhtVOHttdEljbnmIHzAWHUX+uzNVDV1TSOK9qlXrsrAP2dIh2gYkJR8N1J5sWmJl
 6MW0euMdGPBwrKESvDDQGKLE5e+FwTQTPREgOQioeDIZX4jwtQEaT+QK6S9MXEFbnIz5dL
 rnmf2ARBSjRmmnbRYws1piN7nZsvYvw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-dHn3QSFyO8a4uK_hTA6KTQ-1; Tue, 07 Jan 2020 09:01:14 -0500
Received: by mail-lf1-f70.google.com with SMTP id v10so8266226lfa.14
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 06:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Me1h4NcoK3/YeYbD6wOSOV/PNnZNx3IvPR8UV3C9izQ=;
 b=OTF4ZTqoGtriLUdVPwAf3os1jj7mqhwCRG0p2RQG10/Ht0hck3+TXAGH9iC3SShSHY
 WSl2T2r+Ew+r81zJCpbwrBIqQs8sQoP0MK/6F7Tztk2tA/RXSW0BsEpShwUGrH6Y/p1L
 +RAg0daxB5N7thK6zxRXoux5u2Y2wX4LodDKUGcBZ/Z47enkQA6q/tmlFjCXGXUAJO7v
 ueFF9AsICVVoeQCFzkAdzOTd9tG723D4vrI26cCj2Box3dwT53298jhQsfj2/fIbB3yf
 S2zOzUN9b8tH27GxLWJFMDlbNzGK+YUyhZ/wdONyXXkvekXuSH7pyaAttWTG0I0GQQ+W
 4QVw==
X-Gm-Message-State: APjAAAU3oIchOohT3jYl+BTvRBEoGSKEXDOEdLArd1vBwgJuER8XAG0W
 9qKG3CbMlegtvN9GfU4RKNwoR73D79wgmSZC17RkzFaBVgIUrFfF2ig0ILPVCtP8ECuQ8BmUTlA
 GF8XP6U9cVUarL0XV7X6V4saysd9fBqM=
X-Received: by 2002:a2e:9015:: with SMTP id h21mr45731094ljg.69.1578405672692; 
 Tue, 07 Jan 2020 06:01:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZCmF1AIERUpEW4pe5dQui2cl5pANazq/gv0/MGZAuPW5Sjsc/kS7Wds4iPAdWQZA+uXoxZbxiPsJt8GGGBqY=
X-Received: by 2002:a2e:9015:: with SMTP id h21mr45731067ljg.69.1578405672409; 
 Tue, 07 Jan 2020 06:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20191231103434.GA41863@e18g06458.et15sqa>
 <20191231115136.7b967604@Igors-MacBook-Pro>
 <20200102020850.GB41863@e18g06458.et15sqa>
 <20200107130649.GH41863@e18g06458.et15sqa>
In-Reply-To: <20200107130649.GH41863@e18g06458.et15sqa>
From: Julia Suvorova <jusual@redhat.com>
Date: Tue, 7 Jan 2020 15:01:01 +0100
Message-ID: <CAMDeoFXdbJB_nn4MR4uZYTEE7N2BT05-Ucqnm9Hkj7=pMqOWwQ@mail.gmail.com>
Subject: Re: [BUG qemu 4.0] segfault when unplugging virtio-blk-pci device
To: Eryu Guan <eguan@linux.alibaba.com>
X-MC-Unique: dHn3QSFyO8a4uK_hTA6KTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 7, 2020 at 2:06 PM Eryu Guan <eguan@linux.alibaba.com> wrote:
>
> On Thu, Jan 02, 2020 at 10:08:50AM +0800, Eryu Guan wrote:
> > On Tue, Dec 31, 2019 at 11:51:35AM +0100, Igor Mammedov wrote:
> > > On Tue, 31 Dec 2019 18:34:34 +0800
> > > Eryu Guan <eguan@linux.alibaba.com> wrote:
> > >
> > > > Hi,
> > > >
> > > > I'm using qemu 4.0 and hit segfault when tearing down kata sandbox,=
 I
> > > > think it's because io completion hits use-after-free when device is
> > > > already gone. Is this a known bug that has been fixed? (I went thro=
ugh
> > > > the git log but didn't find anything obvious).
> > > >
> > > > gdb backtrace is:
> > > >
> > > > Core was generated by `/usr/local/libexec/qemu-kvm -name sandbox-5b=
8df8c6c6901c3c0a9b02879be10fe8d69d6'.
> > > > Program terminated with signal 11, Segmentation fault.
> > > > #0 object_get_class (obj=3Dobj@entry=3D0x0) at /usr/src/debug/qemu-=
4.0/qom/object.c:903
> > > > 903        return obj->class;
> > > > (gdb) bt
> > > > #0  object_get_class (obj=3Dobj@entry=3D0x0) at /usr/src/debug/qemu=
-4.0/qom/object.c:903
> > > > #1  0x0000558a2c009e9b in virtio_notify_vector (vdev=3D0x558a2e7751=
d0,
> > > >     vector=3D<optimized out>) at /usr/src/debug/qemu-4.0/hw/virtio/=
virtio.c:1118
> > > > #2  0x0000558a2bfdcb1e in virtio_blk_discard_write_zeroes_complete =
(
> > > >     opaque=3D0x558a2f2fd420, ret=3D0)
> > > >     at /usr/src/debug/qemu-4.0/hw/block/virtio-blk.c:186
> > > > #3  0x0000558a2c261c7e in blk_aio_complete (acb=3D0x558a2eed7420)
> > > >     at /usr/src/debug/qemu-4.0/block/block-backend.c:1305
> > > > #4  0x0000558a2c3031db in coroutine_trampoline (i0=3D<optimized out=
>,
> > > >     i1=3D<optimized out>) at /usr/src/debug/qemu-4.0/util/coroutine=
-ucontext.c:116
> > > > #5  0x00007f45b2f8b080 in ?? () from /lib64/libc.so.6
> > > > #6  0x00007fff9ed75780 in ?? ()
> > > > #7  0x0000000000000000 in ?? ()
> > > >
> > > > It seems like qemu was completing a discard/write_zero request, but
> > > > parent BusState was already freed & set to NULL.
> > > >
> > > > Do we need to drain all pending request before unrealizing virtio-b=
lk
> > > > device? Like the following patch proposed?
> > > >
> > > > https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02945.html
> > > >
> > > > If more info is needed, please let me know.
> > >
> > > may be this will help: https://patchwork.kernel.org/patch/11213047/
> >
> > Yeah, this looks promising! I'll try it out (though it's a one-time
> > crash for me). Thanks!
>
> After applying this patch, I don't see the original segfaut and
> backtrace, but I see this crash
>
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> Core was generated by `/usr/local/libexec/qemu-kvm -name sandbox-a2f34a11=
a7e1449496503bbc4050ae040c0d3'.
> Program terminated with signal 11, Segmentation fault.
> #0  0x0000561216a57609 in virtio_pci_notify_write (opaque=3D0x5612184747e=
0, addr=3D0, val=3D<optimized out>, size=3D<optimized out>) at /usr/src/deb=
ug/qemu-4.0/hw/virtio/virtio-pci.c:1324
> 1324        VirtIOPCIProxy *proxy =3D VIRTIO_PCI(DEVICE(vdev)->parent_bus=
->parent);
> Missing separate debuginfos, use: debuginfo-install glib2-2.42.2-5.1.alio=
s7.x86_64 glibc-2.17-260.alios7.x86_64 libgcc-4.8.5-28.alios7.1.x86_64 libs=
eccomp-2.3.1-3.alios7.x86_64 libstdc++-4.8.5-28.alios7.1.x86_64 numactl-lib=
s-2.0.9-5.1.alios7.x86_64 pixman-0.32.6-3.1.alios7.x86_64 zlib-1.2.7-16.2.a=
lios7.x86_64
> (gdb) bt
> #0  0x0000561216a57609 in virtio_pci_notify_write (opaque=3D0x5612184747e=
0, addr=3D0, val=3D<optimized out>, size=3D<optimized out>) at /usr/src/deb=
ug/qemu-4.0/hw/virtio/virtio-pci.c:1324
> #1  0x0000561216835b22 in memory_region_write_accessor (mr=3D<optimized o=
ut>, addr=3D<optimized out>, value=3D<optimized out>, size=3D<optimized out=
>, shift=3D<optimized out>, mask=3D<optimized out>, attrs=3D...) at /usr/sr=
c/debug/qemu-4.0/memory.c:502
> #2  0x0000561216833c5d in access_with_adjusted_size (addr=3Daddr@entry=3D=
0, value=3Dvalue@entry=3D0x7fcdeab1b8a8, size=3Dsize@entry=3D2, access_size=
_min=3D<optimized out>, access_size_max=3D<optimized out>, access_fn=3D0x56=
1216835ac0 <memory_region_write_accessor>, mr=3D0x56121846d340, attrs=3D...=
)
>     at /usr/src/debug/qemu-4.0/memory.c:568
> #3  0x0000561216837c66 in memory_region_dispatch_write (mr=3Dmr@entry=3D0=
x56121846d340, addr=3D0, data=3D<optimized out>, size=3D2, attrs=3Dattrs@en=
try=3D...) at /usr/src/debug/qemu-4.0/memory.c:1503
> #4  0x00005612167e036f in flatview_write_continue (fv=3Dfv@entry=3D0x5612=
1852edd0, addr=3Daddr@entry=3D841813602304, attrs=3D..., buf=3Dbuf@entry=3D=
0x7fce7dd97028 <Address 0x7fce7dd97028 out of bounds>, len=3Dlen@entry=3D2,=
 addr1=3D<optimized out>, l=3D<optimized out>, mr=3D0x56121846d340)
>     at /usr/src/debug/qemu-4.0/exec.c:3279
> #5  0x00005612167e0506 in flatview_write (fv=3D0x56121852edd0, addr=3D841=
813602304, attrs=3D..., buf=3D0x7fce7dd97028 <Address 0x7fce7dd97028 out of=
 bounds>, len=3D2) at /usr/src/debug/qemu-4.0/exec.c:3318
> #6  0x00005612167e4a1b in address_space_write (as=3D<optimized out>, addr=
=3D<optimized out>, attrs=3D..., buf=3D<optimized out>, len=3D<optimized ou=
t>) at /usr/src/debug/qemu-4.0/exec.c:3408
> #7  0x00005612167e4aa5 in address_space_rw (as=3D<optimized out>, addr=3D=
<optimized out>, attrs=3D..., attrs@entry=3D..., buf=3Dbuf@entry=3D0x7fce7d=
d97028 <Address 0x7fce7dd97028 out of bounds>, len=3D<optimized out>, is_wr=
ite=3D<optimized out>) at /usr/src/debug/qemu-4.0/exec.c:3419
> #8  0x0000561216849da1 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x56121849aa00)=
 at /usr/src/debug/qemu-4.0/accel/kvm/kvm-all.c:2034
> #9  0x000056121682255e in qemu_kvm_cpu_thread_fn (arg=3Darg@entry=3D0x561=
21849aa00) at /usr/src/debug/qemu-4.0/cpus.c:1281
> #10 0x0000561216b794d6 in qemu_thread_start (args=3D<optimized out>) at /=
usr/src/debug/qemu-4.0/util/qemu-thread-posix.c:502
> #11 0x00007fce7bef6e25 in start_thread () from /lib64/libpthread.so.0
> #12 0x00007fce7bc1ef1d in clone () from /lib64/libc.so.6
>
> And I searched and found
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1706759 , which has the sam=
e
> backtrace as above, and it seems commit 7bfde688fb1b ("virtio-blk: Add
> blk_drain() to virtio_blk_device_unrealize()") is to fix this particular
> bug.
>
> But I can still hit the bug even after applying the commit. Do I miss
> anything?

Hi Eryu,
This backtrace seems to be caused by this bug (there were two bugs in
1706759): https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
Although the solution hasn't been tested on virtio-blk yet, you may
want to apply this patch:
    https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg05197.html
Let me know if this works.

Best regards, Julia Suvorova.


