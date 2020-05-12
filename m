Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0785CC54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D596206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="mKLnFRYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D596206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLuL-0003Np-Cf
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jYLtT-0002KW-Vx
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:47:48 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:44732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jYLtR-00080q-U2
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:47:47 -0400
Received: by mail-vs1-xe41.google.com with SMTP id z1so7011753vsn.11
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 20:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=u33zBsyKAyFjoZIKnIeHAoOY0Gc0N3wWjOAB45LATZw=;
 b=mKLnFRYRedqi7hvtSKpjqvMyRUdXSrFemqh37Srh8DSTI44XLq+DnsQ+ZYsF/xBjA3
 cj01qBVHL20/TiZvudpiszNkwk+6Z5pjxRvNNUFc410AJthAyyBl874pkYN3wZtu5RLK
 TB3LbaWvTKvoWrhNTGqDkyqUAnDcT9lfUp0e06j5M1ZgtgheF5qI92grzvco0dJNB5WP
 uQmxILfeZtBKP3W66HDAAKiKNMgwfmmjVMnV0puehJb/OCfrEC7Nu3GfXf7y/Zfv6zbC
 z4VdPysyUUVcKPS5W+hSEFI3nQ4pRcL0hpcGMZjc4AjrB8QMcFvW7HvTI2Ht863fXG4l
 ui1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u33zBsyKAyFjoZIKnIeHAoOY0Gc0N3wWjOAB45LATZw=;
 b=jsU4UufoN+AgBb8lb7x45tNLMW7MCnaYiJgY2V2VbuEdYHwZKevmasfmpusYaisfnV
 WVZZSIchQHIn4Y0XqzQikx/n/ld4D1kZBBNGDV9x340PDqKkfEfNPBGXCPIalhlTSDhG
 Z+GvO1psH9Amoxd0LxudI9O4Mv+lWyBevvgJZNhOPRm290SgSFiHdyFwFwaz1eKWF0Fm
 7Iz5e+gdRkFSAT+/k6cDS26mX3Dhbv3S9ycJ7t0RzSpAXSC3Tzi+v9nSTAXaMxvBxb2d
 IIIx7JeuCZuuMm6klmHUPjj4ubkme4QfI2T8IzUp9hdJU+0MR7VENwXHBwhn4lHPRUqB
 cYHw==
X-Gm-Message-State: AOAM5314w9vPgdZwmGZt7ZUPgoyiZXOyVHZbZJRilCrI7qbX1/TlBkwS
 5MYjzztuVXAeQDfWthmiTJgoBFBtd+O3T6I+ExyHKA==
X-Google-Smtp-Source: ABdhPJy7tUinF8SX2qoCyYKWuhw9/pevEUzEF1+liY0uXsc5zPaEY4sxJEgEFMQf2j7CUSB9mQWknkuValesjqeZR/c=
X-Received: by 2002:a67:1342:: with SMTP id 63mr1602636vst.70.1589255264187;
 Mon, 11 May 2020 20:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <ed805147-d87d-5ac2-3196-367981b0679c@redhat.com>
 <20200511092541.GA27558@dimastep-nix>
 <fd260f1f-75f3-46ac-8ca5-bbb7e41e712f@redhat.com>
In-Reply-To: <fd260f1f-75f3-46ac-8ca5-bbb7e41e712f@redhat.com>
From: Li Feng <fengli@smartx.com>
Date: Tue, 12 May 2020 11:47:34 +0800
Message-ID: <CAHckoCx1TE3mShp3eaV-oT2CKw6zFDyFgFgdo+9oc0+TqSAytg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::e41;
 envelope-from=fengli@smartx.com; helo=mail-vs1-xe41.google.com
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
 Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Dima Stepanov <dimastep@yandex-team.ru>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Dima.

If vhost_migration_log return < 0, then vhost_log_global_start will
trigger a crash.
Does your patch have process this abort?
If a disconnect happens in the migration stage, the correct operation
is to stop the migration, right?

 841 static void vhost_log_global_start(MemoryListener *listener)
 842 {
 843     int r;
 844
 845     r =3D vhost_migration_log(listener, true);
 846     if (r < 0) {
 847         abort();
 848     }
 849 }

Thanks,

Feng Li

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8811:33=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 2020/5/11 =E4=B8=8B=E5=8D=885:25, Dima Stepanov wrote:
> > On Mon, May 11, 2020 at 11:15:53AM +0800, Jason Wang wrote:
> >> On 2020/4/30 =E4=B8=8B=E5=8D=889:36, Dima Stepanov wrote:
> >>> If vhost-user daemon is used as a backend for the vhost device, then =
we
> >>> should consider a possibility of disconnect at any moment. If such
> >>> disconnect happened in the vhost_migration_log() routine the vhost
> >>> device structure will be clean up.
> >>> At the start of the vhost_migration_log() function there is a check:
> >>>    if (!dev->started) {
> >>>        dev->log_enabled =3D enable;
> >>>        return 0;
> >>>    }
> >>> To be consistent with this check add the same check after calling the
> >>> vhost_dev_set_log() routine. This in general help not to break a
> >>> migration due the assert() message. But it looks like that this code
> >>> should be revised to handle these errors more carefully.
> >>>
> >>> In case of vhost-user device backend the fail paths should consider t=
he
> >>> state of the device. In this case we should skip some function calls
> >>> during rollback on the error paths, so not to get the NULL dereferenc=
e
> >>> errors.
> >>>
> >>> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> >>> ---
> >>>   hw/virtio/vhost.c | 39 +++++++++++++++++++++++++++++++++++----
> >>>   1 file changed, 35 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >>> index 3ee50c4..d5ab96d 100644
> >>> --- a/hw/virtio/vhost.c
> >>> +++ b/hw/virtio/vhost.c
> >>> @@ -787,6 +787,17 @@ static int vhost_dev_set_features(struct vhost_d=
ev *dev,
> >>>   static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log=
)
> >>>   {
> >>>       int r, i, idx;
> >>> +
> >>> +    if (!dev->started) {
> >>> +        /*
> >>> +         * If vhost-user daemon is used as a backend for the
> >>> +         * device and the connection is broken, then the vhost_dev
> >>> +         * structure will be reset all its values to 0.
> >>> +         * Add additional check for the device state.
> >>> +         */
> >>> +        return -1;
> >>> +    }
> >>> +
> >>>       r =3D vhost_dev_set_features(dev, enable_log);
> >>>       if (r < 0) {
> >>>           goto err_features;
> >>> @@ -801,12 +812,19 @@ static int vhost_dev_set_log(struct vhost_dev *=
dev, bool enable_log)
> >>>       }
> >>>       return 0;
> >>>   err_vq:
> >>> -    for (; i >=3D 0; --i) {
> >>> +    /*
> >>> +     * Disconnect with the vhost-user daemon can lead to the
> >>> +     * vhost_dev_cleanup() call which will clean up vhost_dev
> >>> +     * structure.
> >>> +     */
> >>> +    for (; dev->started && (i >=3D 0); --i) {
> >>>           idx =3D dev->vhost_ops->vhost_get_vq_index(
> >>
> >> Why need the check of dev->started here, can started be modified outsi=
de
> >> mainloop? If yes, I don't get the check of !dev->started in the beginn=
ing of
> >> this function.
> >>
> > No dev->started can't change outside the mainloop. The main problem is
> > only for the vhost_user_blk daemon. Consider the case when we
> > successfully pass the dev->started check at the beginning of the
> > function, but after it we hit the disconnect on the next call on the
> > second or third iteration:
> >       r =3D vhost_virtqueue_set_addr(dev, dev->vqs + i, idx, enable_log=
);
> > The unix socket backend device will call the disconnect routine for thi=
s
> > device and reset the structure. So the structure will be reset (and
> > dev->started set to false) inside this set_addr() call.
>
>
> I still don't get here. I think the disconnect can not happen in the
> middle of vhost_dev_set_log() since both of them were running in
> mainloop. And even if it can, we probably need other synchronization
> mechanism other than simple check here.
>
>
> >   So
> > we shouldn't call the clean up calls because this virtqueues were clean
> > up in the disconnect call. But we should protect these calls somehow, s=
o
> > it will not hit SIGSEGV and we will be able to pass migration.
> >
> > Just to summarize it:
> > For the vhost-user-blk devices we ca hit clean up calls twice in case o=
f
> > vhost disconnect:
> > 1. The first time during the disconnect process. The clean up is called
> > inside it.
> > 2. The second time during roll back clean up.
> > So if it is the case we should skip p2.
> >
> >>> dev, dev->vq_index + i);
> >>>           vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
> >>>                                    dev->log_enabled);
> >>>       }
> >>> -    vhost_dev_set_features(dev, dev->log_enabled);
> >>> +    if (dev->started) {
> >>> +        vhost_dev_set_features(dev, dev->log_enabled);
> >>> +    }
> >>>   err_features:
> >>>       return r;
> >>>   }
> >>> @@ -832,7 +850,15 @@ static int vhost_migration_log(MemoryListener *l=
istener, int enable)
> >>>       } else {
> >>>           vhost_dev_log_resize(dev, vhost_get_log_size(dev));
> >>>           r =3D vhost_dev_set_log(dev, true);
> >>> -        if (r < 0) {
> >>> +        /*
> >>> +         * The dev log resize can fail, because of disconnect
> >>> +         * with the vhost-user-blk daemon. Check the device
> >>> +         * state before calling the vhost_dev_set_log()
> >>> +         * function.
> >>> +         * Don't return error if device isn't started to be
> >>> +         * consistent with the check above.
> >>> +         */
> >>> +        if (dev->started && r < 0) {
> >>>               return r;
> >>>           }
> >>>       }
> >>> @@ -1739,7 +1765,12 @@ int vhost_dev_start(struct vhost_dev *hdev, Vi=
rtIODevice *vdev)
> >>>   fail_log:
> >>>       vhost_log_put(hdev, false);
> >>>   fail_vq:
> >>> -    while (--i >=3D 0) {
> >>> +    /*
> >>> +     * Disconnect with the vhost-user daemon can lead to the
> >>> +     * vhost_dev_cleanup() call which will clean up vhost_dev
> >>> +     * structure.
> >>> +     */
> >>> +    while ((--i >=3D 0) && (hdev->started)) {
> >>>           vhost_virtqueue_stop(hdev,
> >>>                                vdev,
> >>>                                hdev->vqs + i,
> >>
> >> This should be a separate patch.
> > Do you mean i should split this patch to two patches?
>
>
> Yes.
>
> Thanks
>
>
> >
> > Thanks.
> >
> >> Thanks
> >>
>

