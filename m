Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88908C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 08:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE20F223BD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 08:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6DtxnTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE20F223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZrSj-0005TX-Tv
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 03:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1kZrS7-000537-P1
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 03:14:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1kZrS5-0006Us-UT
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 03:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604391240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5XPqwMXV/cEH5DzGwLL+JPvPX0O0Sq1f005dYrCkG0=;
 b=d6DtxnTZACty19oOsTq5CFRj7h8NG11N0QF3wrToK9dx0FRxRzu5xQhLD6Q2AqL9Xoh7zh
 +Avl15Ce0Ln+pe/5AFjV/prtxygs6pl5bc+nftayhyYxQFkNKOWKMnpUbO53DVll3ynV5V
 FZBFqRt5egB/jm0IefpdDYFot++vey0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-_hAiI5LBMDualqXGqmJBDQ-1; Tue, 03 Nov 2020 03:13:51 -0500
X-MC-Unique: _hAiI5LBMDualqXGqmJBDQ-1
Received: by mail-qv1-f70.google.com with SMTP id v4so9797247qvr.19
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 00:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C5XPqwMXV/cEH5DzGwLL+JPvPX0O0Sq1f005dYrCkG0=;
 b=XoYGgaNYh54qVMYvhZ9HyFThiJz22/NPZPqqdp49DFoemaw5p3iPQcaere2KEo1QQt
 PoRbreAx9cSP/oAwTbICjWgC3TjJqVUVBX+/CX+irUl6YDx68N1QlC40j9lAyhAWFG2x
 0JkJwT1JuaAM0X1jvSye9ODTmwNvJi9tWBiCl2QyNGWFLqamH/aRMFhfiWM7MgwhuoG+
 hi6r1+KbRVi83Vj+vhEL6gzv22sYILAz6aXsQRLxe58hueje9zj25DHxuxwnMzlKbk2d
 f110mzjGwH2pb6JRPs1nds55nj200sJ3nQ0zh9pz43jXEFAJEBy0P+4MDnLoXRcP0qNz
 uYkg==
X-Gm-Message-State: AOAM53333OWonrcw33GWdN8ODDh4WVrrwk1ukFvukcmwmv7kEUz+M1xH
 r6lWowik8frtzmd4lGEVPe7+VvnMB38XDIgncNbNRgVKGlbQLoe9t0kC8vxUiHiQwJTuQ3OZaQA
 RsFzw2njc0M6F+DGJeeHQvTnGsu+Mt9k=
X-Received: by 2002:ad4:4674:: with SMTP id z20mr1733086qvv.16.1604391230772; 
 Tue, 03 Nov 2020 00:13:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzd+TfFwBiL07ckV0FSTFcaoTCQm0NcFGWZCcosfosavMcCOxF3dKa5IsBRIaCbuG+f6S5EnER3S5ZhqohdXLI=
X-Received: by 2002:ad4:4674:: with SMTP id z20mr1733078qvv.16.1604391230621; 
 Tue, 03 Nov 2020 00:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20201102161859.156603-1-mreitz@redhat.com>
In-Reply-To: <20201102161859.156603-1-mreitz@redhat.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 3 Nov 2020 09:13:40 +0100
Message-ID: <CAOssrKd7nu+td7v-=L_utWY-hHOgpD7_9eSsaZHqCDwTOKMBWA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] virtiofsd: Announce submounts to the guest
To: Max Reitz <mreitz@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mszeredi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs-list <virtio-fs@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 2, 2020 at 5:19 PM Max Reitz <mreitz@redhat.com> wrote:
>
> RFC: https://www.redhat.com/archives/virtio-fs/2020-May/msg00024.html
> v1: https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg03598.htm=
l
> v2: https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg09117.htm=
l
>
> Branch: https://github.com/XanClic/qemu.git virtiofs-submounts-v4
> Branch: https://git.xanclic.moe/XanClic/qemu.git virtiofs-submounts-v4
>
>
> Hi,
>
> In an effort to cut this cover letter shorter, I=E2=80=99ll defer to the =
cover
> letter of v2 linked above concerning the general description of this
> series, and limit myself to describing the differences from v2:


Other than the issues in 5/7:

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos


