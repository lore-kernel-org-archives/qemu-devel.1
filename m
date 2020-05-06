Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B15C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693362070B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqXrRtm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693362070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGeX-0003tV-HO
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jWGdz-0003Nz-7c
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:47:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20022
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jWGdy-0001Gq-B8
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588758429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZSmXkE5hbHUFGr4fqRhpF9EfEwVQeDRGEVGFjzUmlc=;
 b=KqXrRtm9FhWJmaaSRgPn7rqBdpPsONTs4PdtMpl5UDY5/iP3ayuuJzQii1PKsQFl/7QytN
 dJorNWhgX4tKehyaaEC5tXxe6PF5HmxDjN68G1/IJMlNnxqXZWWSY84sStGmaRhNcLKAPB
 lOBcRJ3SR19UgP1xp9Y3SBEszSkuhnA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-hhVzdKuLOaWGHaUfDJxL-w-1; Wed, 06 May 2020 05:47:06 -0400
X-MC-Unique: hhVzdKuLOaWGHaUfDJxL-w-1
Received: by mail-io1-f69.google.com with SMTP id t130so1081300iod.10
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 02:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rZSmXkE5hbHUFGr4fqRhpF9EfEwVQeDRGEVGFjzUmlc=;
 b=G7niPeZmaR8nPidk69UgIgnohZMvgA6O3CqgojSmMBpbHCXEnM1odbbKt4p6NACiCM
 3Wkk4yPcX8klr7ECRtaCK/usQJDi7k5zww+MDu0IOKIGocYtVttKvxLdlO6l3G+bEQMO
 BoPiZtgvXGZX/qfw2F4+4t1pCCWOKeMZP77csbHxD37WUhJ+wcy5bofT3fGQqtgqhufF
 8Xpl8TnvulIeOIN57HYaMZX0oQk+PZqX6FUhyhcrX8YJpBcCgx88v2HE66eABPovIWFR
 7uI+N5/MPHn97kp/YvLDgwWzzKg2UqiFYRaE5E8yDHa49qYMSgiDeCpRF9xM78bqJtBx
 mkFA==
X-Gm-Message-State: AGi0PubwEj0EpbEp9huthXiK6LJqGlitnhu09hZ+HXQXgXXhDZL0/ePX
 7q6/l9epy9HGwD9+M6lJPtkv8wDB/5QBS3Yzbjzc+ZtoT3Q5vH6368OqW7H05+FkA/gA2+V44d6
 uwel4E26miCKYqk+Oxi4ZPrycEfUGaP4=
X-Received: by 2002:a5e:dd0c:: with SMTP id t12mr7565464iop.82.1588758425588; 
 Wed, 06 May 2020 02:47:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypIHYY9LWcbGo5FOl3fyXEaBJyRmzUFJJJ0vlptdhh8S69K0fyGb25N/Jn/qq8+Dq75hsBGGUSwlXpcqgTdQgq4=
X-Received: by 2002:a5e:dd0c:: with SMTP id t12mr7565442iop.82.1588758425264; 
 Wed, 06 May 2020 02:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <2f783e19d2bfe75946ec677ddd5e979f9a3683d2.1588252862.git.dimastep@yandex-team.ru>
In-Reply-To: <2f783e19d2bfe75946ec677ddd5e979f9a3683d2.1588252862.git.dimastep@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 6 May 2020 11:46:54 +0200
Message-ID: <CAMxuvay_kcOPSfDV3OFKe+FGU9A_oP25pQfEuvo6ZA1stN_ycw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] char-socket: return -1 in case of disconnect
 during tcp_chr_write
To: Dima Stepanov <dimastep@yandex-team.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, "Wolf, Kevin" <kwolf@redhat.com>,
 yc-core@yandex-team.ru, qemu-block <qemu-block@nongnu.org>,
 Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, David Gilbert <dgilbert@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Li Feng <fengli@smartx.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Bonzini, Paolo" <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 3:37 PM Dima Stepanov <dimastep@yandex-team.ru> wro=
te:
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


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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


