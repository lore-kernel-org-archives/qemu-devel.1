Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2D6C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649452073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5O4Oi/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649452073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK09t-0005UP-Kd
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jK09H-00054T-Kh
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jK09G-0007YZ-AP
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:44:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59768
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jK09G-0007Xa-5f
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585835085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cLXVzBqh9zhhwh/CVXGrcgRs/dfHXfqYNtY+tAoSi+Y=;
 b=W5O4Oi/1Q8yhSCscqpBHHn1oTM2zGnD/6sNGEhNoTp1kDLkyzblO0IW17jHQfsluog1hia
 B++fUpT4YsrxNg/ZRHa2CZ0M8Sh59l8AgkUNpC3zV6a1bUp1PH1kuHaYepo8JQ0iD9jBfd
 lBy3jbsD3wuqaqHro3se/gj68pwVw34=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-X0FmSxGBO82IxbgrbgCM8g-1; Thu, 02 Apr 2020 09:44:44 -0400
X-MC-Unique: X0FmSxGBO82IxbgrbgCM8g-1
Received: by mail-wr1-f70.google.com with SMTP id b2so1496424wrq.8
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 06:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gvQ2R8y99CBBi8RZRazk2nffx/pgU8Suz+ahqIPXbdM=;
 b=NJx2Q9b7/PTYGO0GYFW6Ju+XEhRMkx3tQLWTu2Oq6aOY37aXwWXjX72m8e+SUdzLH2
 SWTSDlBanSnVnu4GzV2tman+PV6npsh0g/wJpeTruVZ7hzErI1z8oc/wwvXdkF65xMFf
 oBAq3BA35U5m1HJ7/GT9mdthrisR/YtWQi6AEyF6/KdFoPiXrCMjjyz5pm1yqyFy3YLr
 U5NSbtNKAGlbEzKNUotxJBzp0JuwjVPYJYjG3/Qp3lw2+XoVIMD/51fG3X0O+gIncNW1
 tQrau6llyjiUSXJva6ToEGAG1ciKSjUjLf1JXBA3IN7h25AUJ8+/521bGOIt+kbyfiDI
 rlxQ==
X-Gm-Message-State: AGi0PuZnOKY3HHZIwK8nkFpOJQN14+iqUd9eT8/BWEEca2o/OjeIkDLB
 A+bBk67FKCEGHy7zpoVb6HB9PJqLMnJeUNhcTsHqkAcqohcx6JmwAg9YAZTQHrQf3P5Ikl0yeMf
 b//qRBuE8xejOJJI=
X-Received: by 2002:a7b:c148:: with SMTP id z8mr3475053wmi.31.1585835082983;
 Thu, 02 Apr 2020 06:44:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypLx20559FBmzYn1zSgVJF/1OJmxG/m/FZix8ZKxUksypGr3hxHYdG87RbmNwxVxHM8SPltmSw==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr3475005wmi.31.1585835082622;
 Thu, 02 Apr 2020 06:44:42 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id z129sm7277739wmb.7.2020.04.02.06.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 06:44:41 -0700 (PDT)
Date: Thu, 2 Apr 2020 09:44:36 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 13/22] intel_iommu: add PASID cache management
 infrastructure
Message-ID: <20200402134436.GI7174@xz-x1>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-14-git-send-email-yi.l.liu@intel.com>
 <20200402000225.GC7174@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A21EAAD@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A21EAAD@SHSMSX104.ccr.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 06:46:11AM +0000, Liu, Yi L wrote:

[...]

> > > +/**
> > > + * This function replay the guest pasid bindings to hots by
> > > + * walking the guest PASID table. This ensures host will have
> > > + * latest guest pasid bindings. Caller should hold iommu_lock.
> > > + */
> > > +static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
> > > +                                            VTDPASIDCacheInfo
> > > +*pc_info) {
> > > +    VTDHostIOMMUContext *vtd_dev_icx;
> > > +    int start =3D 0, end =3D VTD_HPASID_MAX;
> > > +    vtd_pasid_table_walk_info walk_info =3D {.flags =3D 0};
> >=20
> > So vtd_pasid_table_walk_info is still used.  I thought we had reached a=
 consensus
> > that this can be dropped?
>=20
> yeah, I did have considered your suggestion and plan to do it. But when
> I started coding, it looks a little bit weird to me:
> For one, there is an input VTDPASIDCacheInfo in this function. It may be
> nature to think about passing the parameter to further calling
> (vtd_replay_pasid_bind_for_dev()). But, we can't do that. The vtd_bus/dev=
fn
> fields should be filled when looping the assigned devices, not the one
> passed by vtd_replay_guest_pasid_bindings() caller.

Hacky way is we can directly modify VTDPASIDCacheInfo* with bus/devfn
for the loop.  Otherwise we can duplicate the object when looping, so
that we can avoid introducing a new struct which seems to contain
mostly the same information.

> For two, reusing the VTDPASIDCacheInfo for passing walk info may require
> the final user do the same thing as what the vtd_replay_guest_pasid_bindi=
ngs()
> has done here.

I don't see it happen, could you explain?

>=20
> So kept the vtd_pasid_table_walk_info.

[...]

> > > +/**
> > > + * This function syncs the pasid bindings between guest and host.
> > > + * It includes updating the pasid cache in vIOMMU and updating the
> > > + * pasid bindings per guest's latest pasid entry presence.
> > > + */
> > > +static void vtd_pasid_cache_sync(IntelIOMMUState *s,
> > > +                                 VTDPASIDCacheInfo *pc_info) {
> > > +    /*
> > > +     * Regards to a pasid cache invalidation, e.g. a PSI.
> > > +     * it could be either cases of below:
> > > +     * a) a present pasid entry moved to non-present
> > > +     * b) a present pasid entry to be a present entry
> > > +     * c) a non-present pasid entry moved to present
> > > +     *
> > > +     * Different invalidation granularity may affect different devic=
e
> > > +     * scope and pasid scope. But for each invalidation granularity,
> > > +     * it needs to do two steps to sync host and guest pasid binding=
.
> > > +     *
> > > +     * Here is the handling of a PSI:
> > > +     * 1) loop all the existing vtd_pasid_as instances to update the=
m
> > > +     *    according to the latest guest pasid entry in pasid table.
> > > +     *    this will make sure affected existing vtd_pasid_as instanc=
es
> > > +     *    cached the latest pasid entries. Also, during the loop, th=
e
> > > +     *    host should be notified if needed. e.g. pasid unbind or pa=
sid
> > > +     *    update. Should be able to cover case a) and case b).
> > > +     *
> > > +     * 2) loop all devices to cover case c)
> > > +     *    - For devices which have HostIOMMUContext instances,
> > > +     *      we loop them and check if guest pasid entry exists. If y=
es,
> > > +     *      it is case c), we update the pasid cache and also notify
> > > +     *      host.
> > > +     *    - For devices which have no HostIOMMUContext, it is not
> > > +     *      necessary to create pasid cache at this phase since it
> > > +     *      could be created when vIOMMU does DMA address translatio=
n.
> > > +     *      This is not yet implemented since there is no emulated
> > > +     *      pasid-capable devices today. If we have such devices in
> > > +     *      future, the pasid cache shall be created there.
> > > +     * Other granularity follow the same steps, just with different =
scope
> > > +     *
> > > +     */
> > > +
> > > +    vtd_iommu_lock(s);
> > > +    /* Step 1: loop all the exisitng vtd_pasid_as instances */
> > > +    g_hash_table_foreach_remove(s->vtd_pasid_as,
> > > +                                vtd_flush_pasid, pc_info);
> >=20
> > OK the series is evolving along with our discussions, and /me too on un=
derstanding
> > your series... Now I'm not very sure whether this operation is still us=
eful...
> >=20
> > The major point is you'll need to do pasid table walk for all the regis=
tered
> > devices
> > below.  So IIUC vtd_replay_guest_pasid_bindings() will be able to also =
detect
> > addition, removal or modification of pasid address spaces.  Am I right?
>=20
> It's true if there is only assigned pasid-capable devices. If there is
> emualted pasid-capable device, it would be a problem as emualted devices
> won't register HostIOMMUContext. Somehow, the pasid cahce invalidation
> for emualted device would be missed. So I chose to make the step 1 cover
> the "real" cache invalidation(a.k.a. removal), while step 2 to cover
> addition and modification.

OK.  Btw, I think modification should still belongs to step 1 then (I
think you're doing that, though).

Thanks,

--=20
Peter Xu


