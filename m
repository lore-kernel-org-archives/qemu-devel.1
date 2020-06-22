Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB23EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACE5206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENZIgEk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACE5206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOIj-0004mB-SZ
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jnOBA-0000hV-Bg
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:16:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37699
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jnOB8-0006w0-Ea
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592838969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2S7JlTygIgLcCPv9jguU7J8r23I6aVZEmkJ0kh+RTEM=;
 b=ENZIgEk3xuoxf57BxWnECQ48dMItnRCNtjWHjRYtFoBBSF94jgprPsqzOuGRVl5AbkSHPC
 rJsJgDYoP8mgsnpfuvKFAUr6rCI/eREgphF3T4FrV8ZqVG4NhKjc4sGiKwd8y+cr3ErTeJ
 WwNKmf7zzCbnLVXqIbyvdHeaA0oQiKU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-c-tffXSvO5y-kckGIspLOg-1; Mon, 22 Jun 2020 11:16:07 -0400
X-MC-Unique: c-tffXSvO5y-kckGIspLOg-1
Received: by mail-oi1-f200.google.com with SMTP id x7so8176613oif.13
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 08:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2S7JlTygIgLcCPv9jguU7J8r23I6aVZEmkJ0kh+RTEM=;
 b=f2QudE4vHiAFaP5/gkc4AaRFq2w7sjCmqe89sDYxjSPjvE7mubeomOjtC+luHnolyP
 /EjwpCXUev/git1h0qfDk4XL4pNSmAVGZVFIwX6wDrCBGtTfymMQ0VUC9HNipavGTI4M
 JeJQncxZ3H7zUOkqXENOX+EfiIkzXGnMLwx55moUk66aw1RQOAcA47v3snqr/EmNLPzO
 ienMmTMpSxZbbMjEyo3xBNcgz9UsquUEdrN44Yofo4bbgzX+l10cQGz581htvjKfz3Sr
 b3VusTF3UlAINXxde8QwYx6+8neXLUImU+GNodOjNERrIXjUFHXf9Wu6k5BN1M1cbZjU
 nYKQ==
X-Gm-Message-State: AOAM533zVf/L7oEgZKAUNdEtySgEQlmIiDR3xVzVj8aZW1NViPW7OMDb
 8iUBOXeVtBWbH3t3WqD7UEbJxUzjt7ZSA69nOMYKNtDc1xDTEfwoLJyCMM4aWhIS4HPEEziY0OP
 2zw4SK0dDFT7bYkrjIF5yqUms5v62uwk=
X-Received: by 2002:a05:6830:18eb:: with SMTP id
 d11mr14985576otf.315.1592838966055; 
 Mon, 22 Jun 2020 08:16:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFt15/YZ0QBqf4Dr1TuMz2qjDbzTb+H9NB3dtBpK6K8CWx8vHrRqiocek540EeCtKwTXuAcQKlfkpmloqk+0U=
X-Received: by 2002:a05:6830:18eb:: with SMTP id
 d11mr14985544otf.315.1592838965737; 
 Mon, 22 Jun 2020 08:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200619104012.235977-1-mreitz@redhat.com>
 <20200619104012.235977-2-mreitz@redhat.com>
 <w51eeqb9f43.fsf@maestria.local.igalia.com>
 <9c14c622-eb30-4619-d33a-b59395a397be@redhat.com>
 <w51r1u788gg.fsf@maestria.local.igalia.com>
 <2d35fdff-6230-18b9-cf99-ca72be53267f@redhat.com>
In-Reply-To: <2d35fdff-6230-18b9-cf99-ca72be53267f@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 22 Jun 2020 18:15:49 +0300
Message-ID: <CAMRbyytkKjdAqH0hFiiAUEv7NeA9beC5CXx9LmBBSJd0r=5qQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] qcow2: Force preallocation with data-file-raw
To: Max Reitz <mreitz@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 6:07 PM Max Reitz <mreitz@redhat.com> wrote:
>
> On 22.06.20 16:46, Alberto Garcia wrote:
> > On Mon 22 Jun 2020 11:35:59 AM CEST, Max Reitz wrote:
> >>>> +    if (qcow2_opts->data_file_raw &&
> >>>> +        qcow2_opts->preallocation =3D=3D PREALLOC_MODE_OFF)
> >>>> +    {
> >>>> +        /*
> >>>> +         * data-file-raw means that "the external data file can be
> >>>> +         * read as a consistent standalone raw image without lookin=
g
> >>>> +         * at the qcow2 metadata."  It does not say that the metada=
ta
> >>>> +         * must be ignored, though (and the qcow2 driver in fact do=
es
> >>>> +         * not ignore it), so the L1/L2 tables must be present and
> >>>> +         * give a 1:1 mapping, so you get the same result regardles=
s
> >>>> +         * of whether you look at the metadata or whether you ignor=
e
> >>>> +         * it.
> >>>> +         */
> >>>> +        qcow2_opts->preallocation =3D PREALLOC_MODE_METADATA;
> >>>
> >>> I'm not convinced by this,
> >>
> >> Why not?
> >>
> >> This is how I read the spec.  Furthermore, I see two problems that we
> >> have right now that are fixed by this patch (namely (1) using a device
> >> file as the external data file, which may have non-zero data at
> >> creation; and (2) assigning a backing file at runtime must not show
> >> the data).
> >
> > What happens if you first create the image (which would be preallocated
> > with this patch), then you resize it and finally you assign the backing
> > file? Would the resized part be preallocated?
>
> Good point, when resizing an image with data-file-raw we also need to
> preallocate the L2 tables.
>
> >>> but your comment made me think of another possible alternative: in
> >>> qcow2_get_cluster_offset(), if the cluster is unallocated and we are
> >>> using a raw data file then we return _ZERO_PLAIN:
> >>>
> >>> --- a/block/qcow2-cluster.c
> >>> +++ b/block/qcow2-cluster.c
> >>> @@ -654,6 +654,10 @@ out:
> >>>      assert(bytes_available - offset_in_cluster <=3D UINT_MAX);
> >>>      *bytes =3D bytes_available - offset_in_cluster;
> >>>
> >>> +    if (type =3D=3D QCOW2_CLUSTER_UNALLOCATED && data_file_is_raw(bs=
)) {
> >>> +        type =3D QCOW2_CLUSTER_ZERO_PLAIN;
> >>> +    }
> >>> +
> >>>      return type;
> >>>
> >>> You could even add a '&& bs->backing' to the condition and emit a
> >>> warning to make it more explicit.
> >>
> >> No, this is wrong.  This still wouldn=E2=80=99t fix the problem of hav=
ing a
> >> device file as the external data file, when it already has non-zero
> >> data during creation.  (Reading the qcow2 file would return zeroes,
> >> but reading the device would not.)
> >
> > But you wouldn't fix that preallocating the metadata either, you would
> > need to fill the device with zeroes.
>
> What it fixes is that reading the qcow2 image and the raw device returns
> the same data.
>
> Initially, I also thought that we should initialize raw data files to be
> zero during creation, but Eric changed my mind:
>
> https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg00223.html
>
> >> I interpret the spec in that the metadata can be ignored, but it does
> >> not need to be ignored.  So the L1/L2 tables must be 1:1 mapping of
> >> QCOW2_CLUSTER_NORMAL entries.
> >>
> >> We could also choose to interpret it as =E2=80=9CWith data-file-raw, t=
he L1/L2
> >> tables must be ignored=E2=80=9D.  In that case, our qcow2 driver would=
 need to
> >> be modified to indeed fully ignore the L1/L2 tables with
> >> data-file-raw.  (I certainly don=E2=80=99t interpret the spec this way=
, but I
> >> suppose we could call it a bug fix and amend it.)
> >
> > The way I interpret it is that regardless of whether you read the data
> > through the qcow2 file or directly from the data file you should get th=
e
> > same results, but how that should be reflected in the L1/L2 metadata is
> > not specified.
>
> That=E2=80=99s an absolute given, but the question is what does =E2=80=9C=
reading through
> the qcow2 file=E2=80=9D mean.  Respecting the metadata?  Ignoring it?  So=
mething
> in between?
>
> As I noted in my reply to myself, data-file-raw is an autoclear flag.
> That means, an old version of qemu that doesn=E2=80=99t recognize the fla=
g must
> read the same data as a new version.  It follows that the the L2 tables
> must be a 1:1 mapping.  (Or the flag can=E2=80=99t be an autoclear flag.)

Being able to read sounds like a nice to have feature, but what about writi=
ng?

I hope that the image is not writable by older versions that do not underst=
and
data_file. Otherwise older qemu versions can corrupt the image silently.


