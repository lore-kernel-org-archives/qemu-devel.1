Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59475C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 18:00:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A12E218BE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 18:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEG+TK0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A12E218BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36511 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpccJ-0001sn-8B
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 14:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60865)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpcc6-0001U2-OB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpcc5-0005Rh-H6
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:00:42 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpcc5-0005RO-Bu
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:00:41 -0400
Received: by mail-ot1-x343.google.com with SMTP id d17so41207700oth.5
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=d7QD043L9VsbY1JCYBgdX6RDcKwOJUsypH+s95wNO1Y=;
 b=DEG+TK0aGxTk45hI231+mzmdqrBeq7N7XYB+8NmdSyeo/WV+UUn7WSaVXscHmcAdKd
 4irjb6iEPy+/xGTRRyNmRVD+fQIRQ3Xq+e3O0TE7TZQAQch7zWvxHL4vHQOq6fA4N2pS
 +jeywbPPJdYMtS53VnLChZeesUye5Z+2rtOfzqo794o6qQ3xwdgWEVsuSyMVP29ULWCL
 aJ/U6Rjyd3u2bI64f1RKgLdeFwJ7shI3aJGDInGXjw/j9mWGabyXt5FpvWlqgWR0HGH6
 +KtXFwGkIhGATja51C5JiqxXTL3YlytXpKtAwJ61yILSqOsNvhETqq+NuV9ZLnVt/w3g
 o2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d7QD043L9VsbY1JCYBgdX6RDcKwOJUsypH+s95wNO1Y=;
 b=gWlyScOjqrXGa7aZPGBQUt/8Y/+/BmSPt5ig28Nl8BRfDUalooaDGufAEvvBT127Nt
 f8u+0mluc3ON0DToHpTKkRUmDTVlfciVEmH9+6FueoOt25X3uosyxhGXWmT2IZoyjg6x
 i32avUG+8fYDEWyPoo7aQoq6xOpoNYF7OKeHCu2f1+9U0w0xaBH3emsWz/o5pGnrhcHf
 KTMh5eI0V2ojx3UN0i7vpMDXs+KEFI7e3GWj/e5lhv+eLsct/la6urIo25cglJDYi4yN
 B6mDCIgO6oCj3yBa53fV4gpGrRm7tLzTTJEqtsx637Jbg8/itb0Z1JRnbvH1UOigC4a+
 owZg==
X-Gm-Message-State: APjAAAWtz7eUS4Avbf8uo5JoHlFeaIGrhkE+nzE2WUTb2g+8Y6E1KkiR
 bpuPxhv+Zfvgt5BvhG6SE+2taZMXy3mMJ0IA5e3Ixg==
X-Google-Smtp-Source: APXvYqxOCewz3tGiXGE3vCKA5BJzsFHHMnsspGtjiAKzf6yB0bg20jkr0pTStgAls1a5hbwGuP6EaTTD+STlQVDK0oQ=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr45725954otr.232.1563818440304; 
 Mon, 22 Jul 2019 11:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190722161657.8188-1-pbonzini@redhat.com>
 <20190722161657.8188-2-pbonzini@redhat.com>
In-Reply-To: <20190722161657.8188-2-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2019 19:00:29 +0100
Message-ID: <CAFEAcA-+H00__skDZd9A29kDd=rdKQUcmJ-hQRZzoxS4etoN8Q@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 1/2] virtio-scsi: fixed
 virtio_scsi_ctx_check failed when detaching scsi disk
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
Cc: Zhengui li <lizhengui@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jul 2019 at 17:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Zhengui li <lizhengui@huawei.com>
>
> commit a6f230c move blockbackend back to main AioContext on unplug. It se=
t the AioContext of
> SCSIDevice to the main AioContex, but s->ctx is still the iothread AioCon=
tex=C3=AF=C2=BC=CB=86if the scsi controller
> is configure with iothread=C3=AF=C2=BC=E2=80=B0. So if there are having i=
n-flight requests during unplug, a failing assertion
> happend. The bt is below:
> (gdb) bt
> #0  0x0000ffff86aacbd0 in raise () from /lib64/libc.so.6
> #1  0x0000ffff86aadf7c in abort () from /lib64/libc.so.6
> #2  0x0000ffff86aa6124 in __assert_fail_base () from /lib64/libc.so.6
> #3  0x0000ffff86aa61a4 in __assert_fail () from /lib64/libc.so.6
> #4  0x0000000000529118 in virtio_scsi_ctx_check (d=3D<optimized out>, s=
=3D<optimized out>, s=3D<optimized out>) at /home/qemu-4.0.0/hw/scsi/virtio=
-scsi.c:246
> #5  0x0000000000529ec4 in virtio_scsi_handle_cmd_req_prepare (s=3D0x2779e=
c00, req=3D0xffff740397d0) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:559
> #6  0x000000000052a228 in virtio_scsi_handle_cmd_vq (s=3D0x2779ec00, vq=
=3D0xffff7c6d7110) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:603
> #7  0x000000000052afa8 in virtio_scsi_data_plane_handle_cmd (vdev=3D<opti=
mized out>, vq=3D0xffff7c6d7110) at /home/qemu-4.0.0/hw/scsi/virtio-scsi-da=
taplane.c:59
> #8  0x000000000054d94c in virtio_queue_host_notifier_aio_poll (opaque=3D<=
optimized out>) at /home/qemu-4.0.0/hw/virtio/virtio.c:2452
>
> assert(blk_get_aio_context(d->conf.blk) =3D=3D s->ctx) failed.
>
> To avoid assertion failed,  moving the "if" after qdev_simple_device_unpl=
ug_cb.
>
> In addition, to avoid another qemu crash below, add aio_disable_external =
before
> qdev_simple_device_unplug_cb, which disable the further processing of ext=
ernal clients
> when doing qdev_simple_device_unplug_cb.
> (gdb) bt
> #0  scsi_req_unref (req=3D0xffff6802c6f0) at hw/scsi/scsi-bus.c:1283
> #1  0x00000000005294a4 in virtio_scsi_handle_cmd_req_submit (req=3D<optim=
ized out>,
>     s=3D<optimized out>) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:589
> #2  0x000000000052a2a8 in virtio_scsi_handle_cmd_vq (s=3Ds@entry=3D0x9c90=
e90,
>     vq=3Dvq@entry=3D0xffff7c05f110) at /home/qemu-4.0.0/hw/scsi/virtio-sc=
si.c:625
> #3  0x000000000052afd8 in virtio_scsi_data_plane_handle_cmd (vdev=3D<opti=
mized out>,
>     vq=3D0xffff7c05f110) at /home/qemu-4.0.0/hw/scsi/virtio-scsi-dataplan=
e.c:60
> #4  0x000000000054d97c in virtio_queue_host_notifier_aio_poll (opaque=3D<=
optimized out>)
>     at /home/qemu-4.0.0/hw/virtio/virtio.c:2447
> #5  0x00000000009b204c in run_poll_handlers_once (ctx=3Dctx@entry=3D0x6ef=
ea40,
>     timeout=3Dtimeout@entry=3D0xffff7d7f7308) at util/aio-posix.c:521
> #6  0x00000000009b2b64 in run_poll_handlers (ctx=3Dctx@entry=3D0x6efea40,
>     max_ns=3Dmax_ns@entry=3D4000, timeout=3Dtimeout@entry=3D0xffff7d7f730=
8) at util/aio-posix.c:559
> #7  0x00000000009b2ca0 in try_poll_mode (ctx=3Dctx@entry=3D0x6efea40, tim=
eout=3D0xffff7d7f7308,
>     timeout@entry=3D0xffff7d7f7348) at util/aio-posix.c:594
> #8  0x00000000009b31b8 in aio_poll (ctx=3D0x6efea40, blocking=3Dblocking@=
entry=3Dtrue)
>     at util/aio-posix.c:636
> #9  0x00000000006973cc in iothread_run (opaque=3D0x6ebd800) at iothread.c=
:75
> #10 0x00000000009b592c in qemu_thread_start (args=3D0x6efef60) at util/qe=
mu-thread-posix.c:502
> #11 0x0000ffff8057f8bc in start_thread () from /lib64/libpthread.so.0
> #12 0x0000ffff804e5f8c in thread_start () from /lib64/libc.so.6
> (gdb) p bus
> $1 =3D (SCSIBus *) 0x0
>
> Signed-off-by: Zhengui li <lizhengui@huawei.com>
> Message-Id: <1563696502-7972-1-git-send-email-lizhengui@huawei.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index d0bdbff090..aa33819d59 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -841,14 +841,16 @@ static void virtio_scsi_hotunplug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
>          virtio_scsi_release(s);
>      }
>
> +    aio_disable_external(s->ctx);
> +    qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
> +    aio_enable_external(s->ctx);

These new calls assume s->ctx is non-NULL...

> +
>      if (s->ctx) {

...but the existing code believes it might be NULL.
Coverity would have complained about this even if 'make check'
didn't catch the bug.

>          virtio_scsi_acquire(s);
>          /* If other users keep the BlockBackend in the iothread, that's =
ok */
>          blk_set_aio_context(sd->conf.blk, qemu_get_aio_context(), NULL);
>          virtio_scsi_release(s);
>      }
> -
> -    qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
>  }

thanks
-- PMM

