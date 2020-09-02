Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F14C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C6820773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPuv+9IE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C6820773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOKa-0000Bd-2y
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDOJs-0007YQ-Lz
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:40:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36123
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDOJq-0006JJ-0L
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599036037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4AHlCLlqmcmE+6uLWQAq0dRJmN6qkZrwy0hyROQlqxE=;
 b=LPuv+9IE3CfTnGHpaho6TMKQUZPR3gwGumYlOGWyyRW4IOr/rcNd5ZJ0egCz2zH7k46B6Y
 PrQQI6fPyVICSbpgBqcedzMccfEY0x4GnZpwV1gJrodo97joVLZOqg5wR8C2VHrasPPrgy
 EkU9Vne5PgUDRChSCYHm55o8YuBXL28=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-80iiSylcNw64IZyQlcREFA-1; Wed, 02 Sep 2020 04:40:35 -0400
X-MC-Unique: 80iiSylcNw64IZyQlcREFA-1
Received: by mail-qt1-f199.google.com with SMTP id r22so3016455qtc.9
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4AHlCLlqmcmE+6uLWQAq0dRJmN6qkZrwy0hyROQlqxE=;
 b=Koi9D5eBlKs3GKtmbIN4LH3RSGeAoGeiZEFD3mXLcM1loB2jTs8NFC9vVZ9b8446sW
 HzXro2zpuKsEaHsf1X69TdO9G7s7jQ0x4MevKgjjOZvpCPovwWnTDNeEDHMsR5doDtoX
 upPPiXVSdZyPSVbDd2ylr3tdLTkxRrAjtFWnY1cS/r1zI0aOIFo44EEA/Cfb6e3kOBis
 wuaSlt7Lu+AF/kbTVAeP7ww5lkr0yE+6TVVMoKgHXCNXeOW3mgegX5EUA3xC0oeHMUk7
 Wj6he2sWP+7IMol0VJ8KY1rIjaP1djBFT3habb4VRJCKhPM2Xl5udwoXp3fii10De9EV
 /GdQ==
X-Gm-Message-State: AOAM5303CvdWGU95BnVZKrI9bbEy3EDdLGLWi0/vjhjaCICljVCiQBaE
 26yBsJ+K/dcT8gvxGXVa1JkbsinJUEE3iiL3iXIJAFt2l1BMR3OkiGJQHFusGBhX/c7xnZDTByp
 9vCp4LudxRUnHp8EMJ0pwSNcowGIP0N8=
X-Received: by 2002:aed:3882:: with SMTP id k2mr5710763qte.308.1599036035254; 
 Wed, 02 Sep 2020 01:40:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7znP+uN7OzRYvz0Gk+gcXrr6hH/++ReUN3Ctuge8qjVW3/xekbm1bmalMCVnwo9rt8TNOdD7Fj2lDHbzdq3w=
X-Received: by 2002:aed:3882:: with SMTP id k2mr5710740qte.308.1599036035042; 
 Wed, 02 Sep 2020 01:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-3-eperezma@redhat.com>
 <87a6y8r4ut.fsf@secure.mitica>
In-Reply-To: <87a6y8r4ut.fsf@secure.mitica>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 2 Sep 2020 10:39:59 +0200
Message-ID: <CAJaqyWcwhVhJnPRmb4Laee+Wrp4MZ5wsm0Ec+YM288CxY8CDUA@mail.gmail.com>
Subject: Re: [RFC v8 2/5] memory: Add IOMMUTLBEvent
To: Juan Quintela <quintela@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
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
 Jason Wang <jasowang@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Applying both, thanks!

On Wed, Sep 2, 2020 at 9:54 AM Juan Quintela <quintela@redhat.com> wrote:
>
> Eugenio P=C3=A9rez <eperezma@redhat.com> wrote:
> > This way we can tell between regulars IOMMURLBEntries (entry of IOMMU
> > hardware) and notifications.
> >
> > In the notifications, we set explicitly if it is a MAPs or an UNMAP,
> > instead of trusting in entry permissions to differenciate them.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> if you have to respin for whatever other reasons, two suggestions.
>
>
> > @@ -1430,10 +1435,10 @@ static int vtd_dev_to_context_entry(IntelIOMMUS=
tate *s, uint8_t bus_num,
> >      return 0;
> >  }
> >
> > -static int vtd_sync_shadow_page_hook(IOMMUTLBEntry *entry,
> > +static int vtd_sync_shadow_page_hook(IOMMUTLBEvent *event,
> >                                       void *private)
> >  {
> > -    memory_region_notify_iommu((IOMMUMemoryRegion *)private, 0, *entry=
);
> > +    memory_region_notify_iommu((IOMMUMemoryRegion *)private, 0, *event=
);
>
> I know that it already was there, but if you respin, you can remove the c=
ast.
>
>
>
> > @@ -1281,12 +1286,12 @@ void memory_region_notify_iommu(IOMMUMemoryRegi=
on *iommu_mr,
> >   * notifies a specific notifier, not all of them.
> >   *
> >   * @notifier: the notifier to be notified
> > - * @entry: the new entry in the IOMMU translation table.  The entry
> > - *         replaces all old entries for the same virtual I/O address r=
ange.
> > - *         Deleted entries have .@perm =3D=3D 0.
> > + * @event: TLB event with the new entry in the IOMMU translation table=
.
> > + *         The entry replaces all old entries for the same virtual I/O=
 address
> > + *         range.
> >   */
> >  void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
> > -                              IOMMUTLBEntry *entry);
> > +                                    IOMMUTLBEvent *event);
>
> I didn't catch the missing of indentation on the previous patch ....
> O:-)
>


