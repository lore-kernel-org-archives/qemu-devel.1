Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B75AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5782074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZUuiGc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5782074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jidHE-0002Zy-2b
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 08:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdillama@redhat.com>)
 id 1jidGW-000295-ME
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:22:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33644
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jdillama@redhat.com>)
 id 1jidGU-00052Q-V8
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591705321;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZQUp0bV5xzOmyO2ckkIaL7yCyGpCgcgciWIvpSwciHo=;
 b=QZUuiGc8zfObxadI7uNxRfEqcAOghTd/+OpZ6CqeOxrMVvDi/Qsh1MQ6O3ujZiCq7tWczY
 UDQnZ4DwBzaeQ+Q0IyRyIoYUlBbILh0Ea9nsLrvCcCX4MlDToLsZBhdxjh0cuoDKdcv38A
 +u0dPTt+cdtdVjDu/yjtUt4EHAOzcrw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-R04ZuDgfPVq7M70MGpBMxA-1; Tue, 09 Jun 2020 08:20:45 -0400
X-MC-Unique: R04ZuDgfPVq7M70MGpBMxA-1
Received: by mail-wm1-f72.google.com with SMTP id a7so583528wmf.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 05:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=ZQUp0bV5xzOmyO2ckkIaL7yCyGpCgcgciWIvpSwciHo=;
 b=ESqjrbhOgp3CHQzSbXSz4LAJ4DHhoxqxQU8XHYooOT08dEHWg2G/pSDFcqUpFxGQMC
 kxA0g5hb5LS7t1sj5lFeYD6EjAicrws6P2c3KuZY4zinVPNY8DxYZb/HNaIaS1CH0J0H
 leBZ5zI/VS2lkAOz6jVz+c6CCtGUAyJeAhunCEUxoX7r/dXofYh+DiSTzAGZ0F8ylVsc
 oIsFKX1lEeqnCOj2uzsR2tU1KnKEoj/PPI1QMISuBBVTVahHycmv7fYZf53erTq7WEGR
 rF4gsBZyAN3RtMkkjBVyzukWb+s/A8VaL5ACkfrdU/kb3EIRv4sAV/RYVznIxzXoCdmP
 HIxg==
X-Gm-Message-State: AOAM530ZOo7tQLT+FUff8bXEgzzFXzrz57WLceuQHGL9uhEx/k4NcCDb
 AvkCWYMlyMlSripmrMX1NhGhLpPlvGWyZ+tt40ufaFcMjYFAxxvR7hCAVAKc/oktKrbkVI/h3ii
 ziRRm/FRQKz4h5vlUmzzB947KTwFaeQM=
X-Received: by 2002:a1c:4d0c:: with SMTP id o12mr3844282wmh.181.1591705243896; 
 Tue, 09 Jun 2020 05:20:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlCRte4U+3XBiGddwbLrCDnLjWy7vrk+E2P1i0vcKu2nlJzQOHiLK5dbCleBI4cjrmpp57UB9Mj4/qbEoP5S4=
X-Received: by 2002:a1c:4d0c:: with SMTP id o12mr3844251wmh.181.1591705243526; 
 Tue, 09 Jun 2020 05:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200609073001.3668811-1-yili@winhong.com>
In-Reply-To: <20200609073001.3668811-1-yili@winhong.com>
From: Jason Dillaman <jdillama@redhat.com>
Date: Tue, 9 Jun 2020 08:20:31 -0400
Message-ID: <CA+aFP1C-BvFM+9OTvaLD0aGramXF3+dO3pJiU5xTALTC54YTyQ@mail.gmail.com>
Subject: Re: [PATCH] rbd: Use RBD fast-diff for querying actual allocation
To: Yi Li <yili@winhong.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jdillama@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: dillaman@redhat.com
Cc: yilikernel@gmail.com, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 9, 2020 at 3:31 AM Yi Li <yili@winhong.com> wrote:
>
> Since Ceph version Infernalis (9.2.0) the new fast-diff mechanism
> of RBD allows for querying actual rbd image usage.
>
> Prior to this version there was no easy and fast way to query how
> much allocation a RBD image had inside a Ceph cluster.
>
> To use the fast-diff feature it needs to be enabled per RBD image
> and is only supported by Ceph cluster running version Infernalis
> (9.2.0) or newer.
>
> Without the fast-diff feature enabled qemu-img will report an allocation
> identical to the image capacity.
>
> 'qemu-img info rbd:cepharm/liyi-rbd' might output for example:
>
>   image: json:{"driver": "raw", "file": {"pool": "cepharm",
>   "image": "liyi-rbd", "driver": "rbd"}}
>   file format: raw
>   virtual size: 20 GiB (21474836480 bytes)
>   disk size: 0 B
>   cluster_size: 4194304
>
> Newly created rbds will have the fast-diff feature enabled.
>
> Signed-off-by: Yi Li <yili@winhong.com>
> ---
>  block/rbd.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 617553b022..f231653f7b 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -1107,6 +1107,65 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
>      return info.size;
>  }
>
> +#if LIBRBD_VERSION_CODE > 265
> +static int disk_usage_callback(uint64_t offset, size_t len, int exists,
> +                               void *arg)
> +{
> +  uint64_t *used_size = (uint64_t *)(arg);
> +  if (exists) {
> +    (*used_size) += len;
> +  }
> +  return 0;
> +}
> +#endif
> +
> +static int64_t qemu_rbd_allocated_file_size(BlockDriverState *bs)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    rbd_image_info_t info;
> +    int r;
> +    uint64_t used_size = 0;
> +    uint64_t features = 0;
> +
> +    r = rbd_stat(s->image, &info, sizeof(info));
> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    r = rbd_get_features(s->image, &features);
> +    if (r < 0) {
> +        return r;
> +    }

You should probably test the flags to ensure that the
RBD_FLAG_FAST_DIFF_INVALID flag is not set [1]. It's potentially very
slow and expensive to calculate the disk usage w/o a fast-diff (on
large images) since it requires iterating over every possible 4MiB
backing data object (by default) to query its actual usage.

> +   /*
> +    * rbd_diff_iterate2() is available in versions above Ceph 0.94 (Hammer)
> +    * It uses a object map inside Ceph which is faster than rbd_diff_iterate()
> +    * which iterates all objects.
> +    * LIBRBD_VERSION_CODE for Ceph 0.94 is 265. In 266 and upwards diff_iterate2
> +    * is available
> +    */
> +#if LIBRBD_VERSION_CODE > 265
> +    if (features & RBD_FEATURE_FAST_DIFF) {
> +
> +        /*
> +         * RBD image fast-diff feature enabled
> +         * Querying for actual allocation.
> +         */
> +        r = rbd_diff_iterate2(s->image, NULL, 0, info.size, 0, 1,
> +                              &disk_usage_callback,
> +                              &used_size);
> +        if (r < 0) {
> +            return r;
> +        }
> +    } else {
> +        used_size = info.size;
> +    }
> +#else
> +    used_size = info.size;
> +#endif
> +    return used_size;
> +}
> +
>  static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
>                                               int64_t offset,
>                                               bool exact,
> @@ -1316,6 +1375,7 @@ static BlockDriver bdrv_rbd = {
>      .bdrv_get_info          = qemu_rbd_getinfo,
>      .create_opts            = &qemu_rbd_create_opts,
>      .bdrv_getlength         = qemu_rbd_getlength,
> +    .bdrv_get_allocated_file_size = qemu_rbd_allocated_file_size,
>      .bdrv_co_truncate       = qemu_rbd_co_truncate,
>      .protocol_name          = "rbd",
>
> --
> 2.25.3
>
>
>
>

[1] https://github.com/libvirt/libvirt/commit/21deeaf02fdf216b08210fc899579736973ca81d#diff-107c5451015e5980c90048ff615becb8

-- 
Jason


