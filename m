Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F85AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F192070B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPcBrYp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F192070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsNxW-0001Wj-9t
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jsNwP-0000XB-Sc
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:01:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38645
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jsNwN-0003aU-3N
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594029693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2PoSHfLvZYYyAhaNzGNJIFSEA0jdVd2Q91HeAITdRuk=;
 b=aPcBrYp7fo6M00vn2Qwvh0hJLZsgOdXFirQ2T1ZtYDmnbi7I28k3j6j5kz/VJiB57CkDbD
 dUAvNoegUAF7lv7HwaFgiYNIPs0CZbMmt3WTFA0rMeVNQrWRsFOPRkUhKmFUUbV5bOA5So
 DHspHpsnAO7IWCwpmtPPf89loSAzIEc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-KlNRPGiLO2KrHxIKeKswXg-1; Mon, 06 Jul 2020 06:01:31 -0400
X-MC-Unique: KlNRPGiLO2KrHxIKeKswXg-1
Received: by mail-io1-f72.google.com with SMTP id g11so22709255ioc.20
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 03:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2PoSHfLvZYYyAhaNzGNJIFSEA0jdVd2Q91HeAITdRuk=;
 b=KbDAQMFI5jjdW+eRD0Iaw4E8Hd/Ug4C5Hu3zqNcBkhQKgv77a40wODV/V5Rvsa6Y37
 6SgajrpLUeroQQSbM1JiVG/noYiA1pViBjDdd/Ha/5nDZnQgdZceXMOkfXakdnryKAmn
 plMHwdiWQWigNoGgIN7Zu+3QxsVT3vZh3oZr4/OkZmZRqd5t9upcIifsvzvkDXJX18jt
 0Tuoo91pA+8IsmqHYPcbEYwKS8OswtNi+ud1Byp05VW4ESuZKh4jCGROEZDbs+DJcRl7
 9rg1kQXowlB4szNBUUpQo8fLapM06PR32YTQRS3H5LXK6TkdbEDIS/4W30ba7nStElVo
 mwKw==
X-Gm-Message-State: AOAM530UXsKzbLLAlV5JXuIVda4UHCp02roMV8NcwZRDjIT+SVPCUD3J
 0jm2KwSHofK0g7xpFvm0IMFFx0G2Tn8syaq0viJBe60hYg4nl5g2x9acrqQjnumD37ftrY1jQaR
 5xeY/o3wQ/IWbiScr4sSsX+v+SVAsHD4=
X-Received: by 2002:a92:79cb:: with SMTP id
 u194mr29587254ilc.161.1594029691028; 
 Mon, 06 Jul 2020 03:01:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwL8Pymtn9Jd0hFABPvOpimIN/+TalTEYzsFBM912BG6WTQivuZfI2RoylLFMB7V4UWNpROLW318GdLOFmtvwk=
X-Received: by 2002:a92:79cb:: with SMTP id
 u194mr29587186ilc.161.1594029690315; 
 Mon, 06 Jul 2020 03:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
 <20200107150442.1727958-37-marcandre.lureau@redhat.com>
 <13c91f97-a7e6-adbd-9c23-2464f2b1b46e@amsat.org>
In-Reply-To: <13c91f97-a7e6-adbd-9c23-2464f2b1b46e@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 6 Jul 2020 14:01:19 +0400
Message-ID: <CAMxuvaxx0bM5yhZcmc7LPmpMt-qvuB+zjhRR1mpUiNm=DyasoQ@mail.gmail.com>
Subject: Re: [PULL 36/37] qdev: remove QDEV_PROP_PTR
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Jul 6, 2020 at 12:44 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 1/7/20 4:04 PM, Marc-Andr=C3=A9 Lureau wrote:
> > No longer used in the tree. The comment about user_creatable is still
> > quite relevant, but there is already a similar comment in qdev-core.h.
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/hw/qdev-properties.h | 22 ----------------------
> >  hw/core/qdev-properties.c    | 18 ------------------
> >  2 files changed, 40 deletions(-)
> >
> > diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.=
h
> > index 16837ab5dd..a90a9cec80 100644
> > --- a/include/hw/qdev-properties.h
> > +++ b/include/hw/qdev-properties.h
> > @@ -18,7 +18,6 @@ extern const PropertyInfo qdev_prop_size;
> >  extern const PropertyInfo qdev_prop_string;
> >  extern const PropertyInfo qdev_prop_chr;
> >  extern const PropertyInfo qdev_prop_tpm;
> > -extern const PropertyInfo qdev_prop_ptr;
> >  extern const PropertyInfo qdev_prop_macaddr;
> >  extern const PropertyInfo qdev_prop_on_off_auto;
> >  extern const PropertyInfo qdev_prop_losttickpolicy;
> > @@ -171,25 +170,6 @@ extern const PropertyInfo qdev_prop_pcie_link_widt=
h;
> >  #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
> >      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
> >
> > -/*
> > - * Please avoid pointer properties.  If you must use them, you must
> > - * cover them in their device's class init function as follows:
> > - *
> > - * - If the property must be set, the device cannot be used with
> > - *   device_add, so add code like this:
> > - *   |* Reason: pointer property "NAME-OF-YOUR-PROP" *|
> > - *   DeviceClass *dc =3D DEVICE_CLASS(class);
> > - *   dc->user_creatable =3D false;
> > - *
> > - * - If the property may safely remain null, document it like this:
> > - *   |*
> > - *    * Note: pointer property "interrupt_vector" may remain null, thu=
s
> > - *    * no need for dc->user_creatable =3D false;
> > - *    *|
> > - */
> > -#define DEFINE_PROP_PTR(_n, _s, _f)             \
> > -    DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, void*)
>
> So the replacement is DEFINE_PROP_LINK()? It is not documented, but
> it takes a TYPENAME argument, so I assume we can only LINK QOM types.
> Can the documentation be improved?

Certainly, although we already have some documentation in
object_property_add_link(). It's annoying that we have several places
documenting similar/close API, or API docs in docs/ that quickly
becomes outdated, or more difficult to find. Root of the issue is that
there are at least 3 ways to add props: object_{,class}_property &
QDEV_PROPS ...

> Yet another sneaky way to force forks to either update to QOM or die...

You can't blame upstream from doing cleanups and modernization, or
stagnating. Forks are forks, with all the pain they carry. If they
want to avoid the maintenance cost, they have to do the extra effort
to get it upstream. This is also a "sneaky way" to remind them that
effort is better spent in this direction.

> > -
> >  #define DEFINE_PROP_CHR(_n, _s, _f)             \
> >      DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)
> >  #define DEFINE_PROP_STRING(_n, _s, _f)             \
> > @@ -262,8 +242,6 @@ void qdev_prop_set_drive(DeviceState *dev, const ch=
ar *name,
> >  void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
> >                             const uint8_t *value);
> >  void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)=
;
> > -/* FIXME: Remove opaque pointer properties.  */
> > -void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value=
);
> >
> >  void qdev_prop_register_global(GlobalProperty *prop);
> >  int qdev_prop_check_globals(void);
> > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > index ac28890e5a..6ca7697599 100644
> > --- a/hw/core/qdev-properties.c
> > +++ b/hw/core/qdev-properties.c
> > @@ -501,13 +501,6 @@ const PropertyInfo qdev_prop_string =3D {
> >      .set   =3D set_string,
> >  };
> >
> > -/* --- pointer --- */
> > -
> > -/* Not a proper property, just for dirty hacks.  TODO Remove it!  */
> > -const PropertyInfo qdev_prop_ptr =3D {
> > -    .name  =3D "ptr",
> > -};
> > -
> >  /* --- mac address --- */
> >
> >  /*
> > @@ -1165,17 +1158,6 @@ void qdev_prop_set_enum(DeviceState *dev, const =
char *name, int value)
> >                              name, &error_abort);
> >  }
> >
> > -void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value=
)
> > -{
> > -    Property *prop;
> > -    void **ptr;
> > -
> > -    prop =3D qdev_prop_find(dev, name);
> > -    assert(prop && prop->info =3D=3D &qdev_prop_ptr);
> > -    ptr =3D qdev_get_prop_ptr(dev, prop);
> > -    *ptr =3D value;
> > -}
> > -
> >  static GPtrArray *global_props(void)
> >  {
> >      static GPtrArray *gp;
> >
>


