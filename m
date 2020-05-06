Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4B1C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1DC206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="ANsk9BDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1DC206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFqO-0001Fd-0o
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jWFpb-0000D7-FX
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:55:07 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:38295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jWFpZ-0007Cn-Be
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:55:07 -0400
Received: by mail-ua1-x942.google.com with SMTP id a16so204994uaq.5
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 01:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KAjhdhqcjhWnw9uO2k9dl6KRGiAyZqLqm1kJz9wpmDg=;
 b=ANsk9BDNow7iqtXQf0vjzDKPEHkJwkPuIj3YoVLbBGmcQMZ1DnRPtqDs8lro2y3eXP
 twmfTROmTSm3PQFM+3Fg4RlPLtLzuOrwCjoUSs1gNY4jLqjYzPJ37tY9E4cyauWwMQKC
 JCfFgL6WCPzlXUQ9WNBlY6QKfKgL2fHH3IBbvX+iWEWn4MfTqxyq4xuQ7J431eRdglDv
 6pReJ1ony9N+AVIc1XrUjCGeKXG3bI2QuC1QYtu6uCyFk47v5HdVjPddwcHWXIU/Q3oL
 H8tXL+PN7mrJFqhmUNDHBkkepNgVFCuHlQkTcry8iuuLqtjBaUxKOqe1UBtaPM6sgxm0
 AaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KAjhdhqcjhWnw9uO2k9dl6KRGiAyZqLqm1kJz9wpmDg=;
 b=ssW1+3Ba8aS0lyumGMPhRE+D2oZ/6ABLuMw5g3UHk8MeAqzNM6rPjFxQ18AUpjhfr0
 WbEqyX4xaEpb754AE5jK8q/MNzIoyUPIzSj5WC/+d7faPpiPH/jrKQ8cpWlKkirjGdW9
 VJtbREJqJWCOwf2kgrcxee+3lJ+/PYiISxp5mygeLAsuNefh9i7T6CnvAiQFB0bxlGnz
 UxL90zwIb9PmlII1OJvvkI/yLo6QvW4mdVjqKfdfB6r7xSr3hHc9NoRxgyzJKlcqZBHC
 uqewqJQpmrTn+rg5mdV70gmkz0wgGUBL4dfbrRwE5quIx8hFuKg59eTLhRQfxE00CMHm
 Ky4Q==
X-Gm-Message-State: AGi0PuYK2ViOVa3AxIcaVYYIb/3XErM7XytNQCJFbhJ9/2Bufah2N7V7
 Pl256EnrBiCwzlMQnSeCoeIkVd68VsTE2HQnM40smg==
X-Google-Smtp-Source: APiQypKOGGADvBP2pLqxUAknxgDQfMfcgJjkfyI3zmanxqSE3dZ5s/87tyDezbTcU3YmCotKFqyofeT0ZPs8tf8Hck8=
X-Received: by 2002:ab0:b13:: with SMTP id b19mr5896941uak.91.1588755303791;
 Wed, 06 May 2020 01:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <2f783e19d2bfe75946ec677ddd5e979f9a3683d2.1588252862.git.dimastep@yandex-team.ru>
In-Reply-To: <2f783e19d2bfe75946ec677ddd5e979f9a3683d2.1588252862.git.dimastep@yandex-team.ru>
From: Li Feng <fengli@smartx.com>
Date: Wed, 6 May 2020 16:54:52 +0800
Message-ID: <CAHckoCyb8XT3Pg9b_xNXHZ-gnd6ep92VJ0anU0Jit+5uDciPUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] char-socket: return -1 in case of disconnect
 during tcp_chr_write
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::942;
 envelope-from=fengli@smartx.com; helo=mail-ua1-x942.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 yc-core@yandex-team.ru, "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks,

Feng Li

Dima Stepanov <dimastep@yandex-team.ru> =E4=BA=8E2020=E5=B9=B44=E6=9C=8830=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=889:36=E5=86=99=E9=81=93=EF=BC=
=9A
>
> During testing of the vhost-user-blk reconnect functionality the qemu
> SIGSEGV was triggered:
>  start qemu as:
>  x86_64-softmmu/qemu-system-x86_64 -m 1024M -M q35 \
>    -object memory-backend-file,id=3Dram-node0,size=3D1024M,mem-path=3D/de=
v/shm/qemu,share=3Don \
>    -numa node,cpus=3D0,memdev=3Dram-node0 \
>    -chardev socket,id=3Dchardev0,path=3D./vhost.sock,noserver,reconnect=
=3D1 \
>    -device vhost-user-blk-pci,chardev=3Dchardev0,num-queues=3D4 --enable-=
kvm
>  start vhost-user-blk daemon:
>  ./vhost-user-blk -s ./vhost.sock -b test-img.raw
>
> If vhost-user-blk will be killed during the vhost initialization
> process, for instance after getting VHOST_SET_VRING_CALL command, then
> QEMU will fail with the following backtrace:
>
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x00005555559272bb in vhost_user_read (dev=3D0x7fffef2d53e0, msg=3D0x7fff=
ffffd5b0)
>     at ./hw/virtio/vhost-user.c:260
> 260         CharBackend *chr =3D u->user->chr;
>
>  #0  0x00005555559272bb in vhost_user_read (dev=3D0x7fffef2d53e0, msg=3D0=
x7fffffffd5b0)
>     at ./hw/virtio/vhost-user.c:260
>  #1  0x000055555592acb8 in vhost_user_get_config (dev=3D0x7fffef2d53e0, c=
onfig=3D0x7fffef2d5394 "", config_len=3D60)
>     at ./hw/virtio/vhost-user.c:1645
>  #2  0x0000555555925525 in vhost_dev_get_config (hdev=3D0x7fffef2d53e0, c=
onfig=3D0x7fffef2d5394 "", config_len=3D60)
>     at ./hw/virtio/vhost.c:1490
>  #3  0x00005555558cc46b in vhost_user_blk_device_realize (dev=3D0x7fffef2=
d51a0, errp=3D0x7fffffffd8f0)
>     at ./hw/block/vhost-user-blk.c:429
>  #4  0x0000555555920090 in virtio_device_realize (dev=3D0x7fffef2d51a0, e=
rrp=3D0x7fffffffd948)
>     at ./hw/virtio/virtio.c:3615
>  #5  0x0000555555a9779c in device_set_realized (obj=3D0x7fffef2d51a0, val=
ue=3Dtrue, errp=3D0x7fffffffdb88)
>     at ./hw/core/qdev.c:891
>  ...
>
> The problem is that vhost_user_write doesn't get an error after
> disconnect and try to call vhost_user_read(). The tcp_chr_write()
> routine should return -1 in case of disconnect. Indicate the EIO error
> if this routine is called in the disconnected state.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  chardev/char-socket.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 185fe38..c128cca 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -175,14 +175,16 @@ static int tcp_chr_write(Chardev *chr, const uint8_=
t *buf, int len)
>          if (ret < 0 && errno !=3D EAGAIN) {
>              if (tcp_chr_read_poll(chr) <=3D 0) {
>                  tcp_chr_disconnect_locked(chr);
> -                return len;
> +                /* Return an error since we made a disconnect. */
> +                return ret;
The `return` statement could be deleted.
The outside has a return statement.

>              } /* else let the read handler finish it properly */
>          }
>
>          return ret;
>      } else {
> -        /* XXX: indicate an error ? */
> -        return len;
> +        /* Indicate an error. */
> +        errno =3D EIO;
> +        return -1;
>      }
>  }
>
> --
> 2.7.4
>

