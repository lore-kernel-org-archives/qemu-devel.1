Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1DFC433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC8D2087C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjpSRz3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC8D2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNwq-0001yk-30
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDNva-0000T5-5E
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:15:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27431
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDNvY-0002s2-Pl
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599034532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQJKHpot4c6uspshmywfzJykIZy5wv13h4yti1lCgAs=;
 b=OjpSRz3qMsUp0Ojr+MXPFWHUAs3gb00wJCBwcPDZYxOzOF/QzY1KtEHYeHWS1W3HhOVIZq
 mV/okGgcmWNXpjlhlvjR+mUP8l6wLKnM0WIrYm50D/CFX7rYXQQh3U0AUqSIYr3t2APfWJ
 UHdB2BWkoTgMlNy4yn7re6TvN7Rx48o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-ehemqOxWPRecWhk2YW9CTA-1; Wed, 02 Sep 2020 04:15:28 -0400
X-MC-Unique: ehemqOxWPRecWhk2YW9CTA-1
Received: by mail-qk1-f198.google.com with SMTP id u23so2846576qku.17
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YQJKHpot4c6uspshmywfzJykIZy5wv13h4yti1lCgAs=;
 b=MBIAPuG58s/Q/QegElcXv4OiG2LrzbY48xH0Pi+eqSY1A4sKilNAvXVx1r2jMIUqeL
 Eu9SeV3/laAYa859T7jEiHkUxoEJ5A1sXOYTkvjXiDVCYLXwytN1hD/MrKr9L/bYmcwj
 KTvE9pBE/sc+y4rzW4nmbUJ4Qj0Xz4JJ9KP9KK8ec/VNtZCN1L01epwTQ0VLW9QPH55e
 lxFAFUsrjse4hc+6X8CcxXq3SAZv+cgrtBGxwpC39/Lr36+HyWrbIjy1/v17f35kmwGp
 0zYBB+V6waqBoyJaRX6OBQH0zvHSc3UaLvDxPcxkpd3O4mi2z7iolxgh0wAYVlnbhS1r
 jTNQ==
X-Gm-Message-State: AOAM533nDmNflbCqmqZdTo24I5dS/n1HbVqiKWoQzebYMbGx4w4NySHw
 Z0OxrZz7ByrakbPfGge8kfYSAtOaj7P4lpoPlA5BNAovXrZA7GQHYP/YiYoWNOm+VCbyVJYlVIN
 EbLjtWyL4UIOzcmouciXycIxSJV9D1sA=
X-Received: by 2002:a05:620a:b1a:: with SMTP id
 t26mr5745404qkg.353.1599034528183; 
 Wed, 02 Sep 2020 01:15:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZyjfIfEVBtvA9aXcgxfeSp0D+gam18FAA53vhCeJYgbEuwGfokmaxgNULEP9btO5O02yWYkxz6pW16C7T3HQ=
X-Received: by 2002:a05:620a:b1a:: with SMTP id
 t26mr5745387qkg.353.1599034527966; 
 Wed, 02 Sep 2020 01:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-3-eperezma@redhat.com>
 <20200901205458.GD3053@xz-x1>
In-Reply-To: <20200901205458.GD3053@xz-x1>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 2 Sep 2020 10:14:51 +0200
Message-ID: <CAJaqyWfSHPH=ULrGxEZc+bvWhN7Sk_YBU194a7YPJv9MTHCjNQ@mail.gmail.com>
Subject: Re: [RFC v8 2/5] memory: Add IOMMUTLBEvent
To: Peter Xu <peterx@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eperezma@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 1, 2020 at 10:55 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Sep 01, 2020 at 04:26:05PM +0200, Eugenio P=C3=A9rez wrote:
> > This way we can tell between regulars IOMMURLBEntries (entry of IOMMU
> > hardware) and notifications.
>
> s/regulars IOMMURLBEntries/regular IOMMUTLBEntry/
>
> >
> > In the notifications, we set explicitly if it is a MAPs or an UNMAP,
> > instead of trusting in entry permissions to differenciate them.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> [...]
>
> >  struct IOMMUTLBEntry {
> > -    AddressSpace    *target_as;
> > -    hwaddr           iova;
> > -    hwaddr           translated_addr;
> > -    hwaddr           addr_mask;  /* 0xfff =3D 4k translation */
> > -    IOMMUAccessFlags perm;
> > +    AddressSpace            *target_as;
> > +    hwaddr                   iova;
> > +    hwaddr                   translated_addr;
> > +    hwaddr                   addr_mask;  /* 0xfff =3D 4k translation *=
/
> > +    IOMMUAccessFlags         perm;
> >  };
>
> If these lines are identical, then we can avoid touching the spaces.
>

Thanks for the catches! Didn't notice them rebasing.

> With above changes, please feel free to add:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> --
> Peter Xu
>


