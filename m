Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B201DC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4F420737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRHXyrqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4F420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHUqZ-0000AP-KY
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 11:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jHUpf-0007aW-Ia
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jHUpd-0001Vc-7h
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:54:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jHUpd-0001V9-1f
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585238047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uYtnX1tGaRMdm86aZcWNXOaNLmsumQ+jJf17rMWGB5E=;
 b=dRHXyrqHbuDL1GdEwuwSb3tjb1EdYtd9l5l61g5Uv/npGjU9CnIfgv15PEsSMqWswTjHk8
 VFQ7jOQ1vOMgxEDqt7hrUTjzQg+K4PkJu3xeb5Q2KNN8B2eXwe7U58Fw2/tUlHYvjc9RBq
 RdXqi+lQKHyfsIS2Ae+HKa+HmeqqNc0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-t6GFc3A7NHSI4IIuqjxTdA-1; Thu, 26 Mar 2020 11:54:05 -0400
X-MC-Unique: t6GFc3A7NHSI4IIuqjxTdA-1
Received: by mail-wr1-f70.google.com with SMTP id d17so3229473wrs.7
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 08:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S5DJ6QK01BmwdDk552tAG2Zi2XOLg5i0a0o7HaVOz+w=;
 b=CstO6qa/xA+bte9XBxSrtjzwB8ykYvzq0jSBuDIbh8ovMaMX/Xa7N/B5jaj3meZkW4
 +XMtJ9og8UvM6N/tgWBWeLsCIwnYqEIUxgyMKkP61CWwOlMxI6yAfzB2AnZJYeci21KK
 +t7leLl7cNRijCsGlg2jgivVIqrn0PLxER2XOURsaX534zR6EvR9a3if6ebz6sX6zG/R
 mGKuCCnaHZmmXGz9pgA3QqgxktLfXpbJ66N9KtesC+zXE9YSk38vwgB4l82ydWGr2fgZ
 xokuZFUb77zLpZ71d49GIyZSv2cJ2aBsCBRBNug4YoCK2QtERjPXFxXL6gwxwieJHOzb
 ioGA==
X-Gm-Message-State: ANhLgQ1CMtokEZklmpgoq22k3ttYaf4H+5bq47dl1TPUZHeLvcXIPxEm
 TuZbOwn2djF9gW0Z62ovbuCVyazNdYn2NgXW8buSZOpikakD0jNZ9bDFg5rNLHmVIF32w2BwCI0
 JZtzhnXYmuvWMXQ4=
X-Received: by 2002:a1c:4805:: with SMTP id v5mr581359wma.98.1585238044054;
 Thu, 26 Mar 2020 08:54:04 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtlFQYlQd328+mMi3dIqX4jAyny83CHtgc3eyoWdwWwcS51fQ3CqxyWFrS9r3K7zirLruw+Xg==
X-Received: by 2002:a1c:4805:: with SMTP id v5mr581316wma.98.1585238043713;
 Thu, 26 Mar 2020 08:54:03 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id a13sm4149275wrh.80.2020.03.26.08.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 08:54:02 -0700 (PDT)
Date: Thu, 26 Mar 2020 11:53:58 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 12/22] intel_iommu: add PASID cache management
 infrastructure
Message-ID: <20200326155358.GE422390@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-13-git-send-email-yi.l.liu@intel.com>
 <20200324173209.GW127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A20213D@SHSMSX104.ccr.corp.intel.com>
 <20200325145209.GA354390@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A203F2C@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A204614@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A204614@SHSMSX104.ccr.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On Thu, Mar 26, 2020 at 01:57:10PM +0000, Liu, Yi L wrote:
> > From: Liu, Yi L
> > Sent: Thursday, March 26, 2020 2:15 PM
> > To: 'Peter Xu' <peterx@redhat.com>
> > Subject: RE: [PATCH v1 12/22] intel_iommu: add PASID cache management
> > infrastructure
> >=20
> > > From: Peter Xu <peterx@redhat.com>
> > > Sent: Wednesday, March 25, 2020 10:52 PM
> > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > Subject: Re: [PATCH v1 12/22] intel_iommu: add PASID cache management
> > > infrastructure
> > >
> > > On Wed, Mar 25, 2020 at 12:20:21PM +0000, Liu, Yi L wrote:
> > > > > From: Peter Xu <peterx@redhat.com>
> > > > > Sent: Wednesday, March 25, 2020 1:32 AM
> > > > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > > > Subject: Re: [PATCH v1 12/22] intel_iommu: add PASID cache
> > > > > management infrastructure
> > > > >
> > > > > On Sun, Mar 22, 2020 at 05:36:09AM -0700, Liu Yi L wrote:
> > > > > > This patch adds a PASID cache management infrastructure based o=
n
> > > > > > new added structure VTDPASIDAddressSpace, which is used to trac=
k
> > > > > > the PASID usage and future PASID tagged DMA address translation
> > > > > > support in vIOMMU.
> [...]
> > > > >
> > > > > <START>
> > > > >
> > > > > > +    /*
> > > > > > +     * Step 2: loop all the exisitng vtd_dev_icx instances.
> > > > > > +     * Ideally, needs to loop all devices to find if there is =
any new
> > > > > > +     * PASID binding regards to the PASID cache invalidation r=
equest.
> > > > > > +     * But it is enough to loop the devices which are backed b=
y host
> > > > > > +     * IOMMU. For devices backed by vIOMMU (a.k.a emulated dev=
ices),
> > > > > > +     * if new PASID happened on them, their vtd_pasid_as insta=
nce could
> > > > > > +     * be created during future vIOMMU DMA translation.
> > > > > > +     */
> > > > > > +    QLIST_FOREACH(vtd_dev_icx, &s->vtd_dev_icx_list, next) {
> > > > > > +        VTDPASIDAddressSpace *vtd_pasid_as;
> > > > > > +        VTDPASIDCacheEntry *pc_entry;
> > > > > > +        VTDPASIDEntry pe;
> > > > > > +        VTDBus *vtd_bus =3D vtd_dev_icx->vtd_bus;
> > > > > > +        uint16_t devfn =3D vtd_dev_icx->devfn;
> > > > > > +        int bus_n =3D pci_bus_num(vtd_bus->bus);
> > > > > > +
> > > > > > +        /* i) fetch vtd_pasid_as and check if it is valid */
> > > > > > +        vtd_pasid_as =3D vtd_add_find_pasid_as(s, vtd_bus,
> > > > > > +                                             devfn, pasid);
> > > > >
> > > > > I don't feel like it's correct here...
> > > > >
> > > > > Assuming we have two devices assigned D1, D2.  D1 uses PASID=3D1,=
 D2
> > > > > uses
> > > PASID=3D2.
> > > > > When invalidating against PASID=3D1, are you also going to create=
 a
> > > > > VTDPASIDAddressSpace also for D2 with PASID=3D1?
> > > >
> > > > Answer is no. Before going forward, let's see if the below flow loo=
ks good to you.
> > > >
> > > > Let me add one more device besides D1 and D2. Say device D3 which
> > > > also uses PASID=3D1. And assume it begins with no PASID usage in gu=
est.
> > > >
> > > > Then the flow from scratch is:
> > > >
> > > > a) guest IOMMU driver setup PASID entry for D1 with PASID=3D1,
> > > >    then invalidates against PASID #1
> > > > b) trap to QEMU, and comes to this function. Since there is
> > > >    no previous pasid cache invalidation, so the Step 1 of this
> > > >    function has nothing to do, then goes to Step 2 which is to
> > > >    loop all assigned devices and check if the guest pasid entry
> > > >    is present. In this loop, should find D1's pasid entry for
> > > >    PASID#1 is present. So create the VTDPASIDAddressSpace and
> > > >    initialize its pasid_cache_entry and pasid_cache_gen fields.
> > > > c) guest IOMMU driver setup PASID entry for D2 with PASID=3D2,
> > > >    then invalidates against PASID #2
> > > > d) same with b), only difference is the Step 1 of this function
> > > >    will loop the VTDPASIDAddressSpace created in b), but its
> > > >    pasid is 1 which is not the target of current pasid cache
> > > >    invalidation. Same with b), in Step 2, it will create a
> > > >    VTDPASIDAddressSpace for D2+PASID#2
> > > > e) guest IOMMU driver setup PASID entry for D3 with PASID=3D1,
> > > >    then invalidates against PASID #1
> > > > f) trap to QEMU and comes to this function. Step 1 loops two
> > > >    VTDPASIDAddressSpace created in b) and d), and it finds there
> > > >    is a VTDPASIDAddressSpace whose pasid is 1. vtd_flush_pasid()
> > > >    will check if the cached pasid entry is the same with the one
> > > >    in guest memory. In this flow, it should be the same, so
> > > >    vtd_flush_pasid() will do nothing for it. Then comes to Step 2,
> > > >    it loops D1, D2, D3.
> > > >    - For D1, no need to do more since there is already a
> > > >      VTDPASIDAddressSpace created for D1+PASID#1.
> > > >    - For D2, its guest pasid entry for PASID#1 is not present, so
> > > >      no need to do anything for it.
> > > >    - For D3, its guest pasid entry for PASID#1 is present and it
> > > >      is exactly the reason for this invalidation. So create a
> > > >      VTDPASIDAddressSpace for and init the pasid_cache_entry and
> > > >      pasid_cache_gen fields.
> > > >
> > > > > I feel like we shouldn't create VTDPASIDAddressSpace only if it
> > > > > existed, say, until when we reach vtd_dev_get_pe_from_pasid() bel=
ow with
> > retcode=3D=3D0.
> > > >
> > > > You are right. I think I failed to destroy the VTDAddressSpace when
> > > > vtd_dev_get_pe_from_pasid() returns error. Thus the code won't
> > > > create a VTDPASIDAddressSpace for D2+PASID#1.
> > >
> > > OK, but that free() is really not necessary...  Please see below.
> > >
> > > >
> > > > > Besides this...
> > > > >
> > > > > > +        pc_entry =3D &vtd_pasid_as->pasid_cache_entry;
> > > > > > +        if (s->pasid_cache_gen =3D=3D pc_entry->pasid_cache_ge=
n) {
> > > > > > +            /*
> > > > > > +             * pasid_cache_gen equals to s->pasid_cache_gen me=
ans
> > > > > > +             * vtd_pasid_as is valid after the above s->vtd_pa=
sid_as
> > > > > > +             * updates in Step 1. Thus no need for the below s=
teps.
> > > > > > +             */
> > > > > > +            continue;
> > > > > > +        }
> > > > > > +
> > > > > > +        /*
> > > > > > +         * ii) vtd_pasid_as is not valid, it's potentailly a n=
ew
> > > > > > +         *    pasid bind. Fetch guest pasid entry.
> > > > > > +         */
> > > > > > +        if (vtd_dev_get_pe_from_pasid(s, bus_n, devfn, pasid,
> > > > > > + &pe)) {
> > > >
> > > > Yi: should destroy pasid_as as there is no valid pasid entry. Thus
> > > > to ensure all the pasid_as in hash table are valid.
> > > >
> > > > > > +            continue;
> > > > > > +        }
> > > > > > +
> > > > > > +        /*
> > > > > > +         * iii) pasid entry exists, update pasid cache
> > > > > > +         *
> > > > > > +         * Here need to check domain ID since guest pasid entr=
y
> > > > > > +         * exists. What needs to do are:
> > > > > > +         *   - update the pc_entry in the vtd_pasid_as
> > > > > > +         *   - set proper pc_entry.pasid_cache_gen
> > > > > > +         *   - pass down the latest guest pasid entry config t=
o host
> > > > > > +         *     (will be added in later patch)
> > > > > > +         */
> > > > > > +        if (domain_id =3D=3D vtd_pe_get_domain_id(&pe)) {
> > > > > > +            vtd_fill_in_pe_in_cache(s, vtd_pasid_as, &pe);
> > > > > > +        }
> > > > > > +    }
> > > > >
> > > > > <END>
> > > > >
> > > > > ... I'm a bit confused on the whole range between <START> and
> > > > > <END> on how it differs from the vtd_replay_guest_pasid_bindings(=
) you're
> > going to introduce.
> > > > > Shouldn't the replay code do similar thing?  Can we merge them?
> > > >
> > > > Yes, there is similar thing which is to create VTDPASIDAddressSpace
> > > > per the guest pasid entry presence.
> > > >
> > > > But there are differences. For one, the code here is to loop all
> > > > assigned devices for a specific PASID. While the logic in
> > > > vtd_replay_guest_pasid_bindings() is to loop all assigned devices
> > > > and the PASID tables behind them. For two, the code here only cares
> > > > about the case which guest pasid entry from INVALID->VALID.
> > > > The reason is in Step 1 of this function, VALID->INVALID and
> > > > VALID->VALID cases are already covered. While the logic in
> > > > vtd_replay_guest_pasid_bindings() needs to cover all the three case=
s.
> > > > The last reason I didn't merge them is in
> > > > vtd_replay_guest_pasid_bindings() it needs to divide the pasid entr=
y
> > > > fetch into two steps and check the result (if fetch pasid directory
> > > > entry failed, it could skip a range of PASIDs). While the code in
> > > > this function, it doesn't care about it, it only cares if there is =
a
> > > > valid pasid entry for this specific pasid.
> > > >
> > > > >
> > > > > My understanding is that we can just make sure to do it right onc=
e
> > > > > in the replay code (the three cases: INVALID->VALID,
> > > > > VALID->INVALID,
> > > > > VALID->VALID), then no matter whether it's DSI/PSI/GSI, we call
> > > > > VALID->the
> > > > > replay code probably with VTDPASIDCacheInfo* passed in, then the
> > > > > replay code
> > > will
> > > > > know what to look after.
> > > >
> > > > Hmmm, let me think more to abstract the code between the <START> an=
d
> > > > <END> to be a helper function to be called by
> > > > vtd_replay_guest_pasid_bindings(). Also, in that case, I need to
> > > > apply the two step concept in the replay function.
> > >
> > > ... I think your vtd_sm_pasid_table_walk() is already suitable for
> > > this because it allows to specify "start" and "end" pasid.  Now you'r=
e
> > > always passing in the (0, VTD_MAX_HPASID) tuple, here you can simply
> > > pass in (pasid, pasid+1).  But I think you need to touch up
> > > vtd_sm_pasid_table_walk() a bit to make sure it allows the pasid to b=
e
> > > not aliged to VTD_PASID_TBL_ENTRY_NUM.
> > >
> > > Another thing is I think vtd_sm_pasid_table_walk_one() didn't really
> > > check vtd_pasid_table_walk_info.did domain information...  When that'=
s
> > > fixed, this case is the same as the DSI walk with a specific pasid
> > > range.
> >=20
> > got it, let me refactor them (PSI and replay).
> >=20
> > > And again, please also consider to use VTDPASIDCacheInfo to be used
> > > directly during the page walk, so vtd_pasid_table_walk_info can be
> > > replaced I think, because IIUC VTDPASIDCacheInfo contains all
> > > information the table walk will need.
> >=20
> > yes, no need to have the walk_info structure.
> I'm not quite get here. Why cache_gen increase only happen in PSI
> hook? I think cache_gen used to avoid drop all pasid_as when a pasid
> cache reset happened.

(Is this paragraph for the other thread?  Let me know if it's not, or
 I'll skip it)

>=20
>=20
> Today, I'm trying to replace vtd_pasid_table_walk_info with
> VTDPASIDCacheInfo. But I found it may be a little bit strange.
> The vtd_pasid_table_walk_info include vtd_bus/devfn/did and a
> flag to indicate if did is useful.

vtd_pasid_table_walk_info.flags can only be either
VTD_PASID_TABLE_DID_SEL_WALK or nothing, but IIUC that's the same as
checking against VTDPASIDCacheInfo.flags with:

    (VTD_PASID_CACHE_DOMSI | VTD_PASID_CACHE_PASIDSI)

> The final user of the walk
> info is vtd_sm_pasid_table_walk_one() which only cares about
> the the vtd_bus/devfn/did. But VTDPASIDCacheInfo has an extra
> pasid field and also has multiple flag definitions

We can simply ignore the pasid field when walking the pasid table?
Just like we'll also ignore the domain id field if flag not set.

> , which are
> not necessary for the table work. So it appears to me use
> separate structure would be better. Maybe I can show you when
> sending out the code.

I still keep my previous comment that I think VTDPASIDCacheInfo can do
all the work, especially because all the pasid table walk triggers
from a pasid flush, so we can really reuse exactly the same
VTDPASIDCacheInfo structure that we just allocated, iiuc.

>=20
> > > >
> > > > > > +
> > > > > > +    vtd_iommu_unlock(s);
> > > > > >      return 0;
> > > > > >  }
> > > > > >
> > > > > > +/**
> > > > > > + * Caller of this function should hold iommu_lock  */ static
> > > > > > +void vtd_pasid_cache_reset(IntelIOMMUState *s) {
> > > > > > +    VTDPASIDCacheInfo pc_info;
> > > > > > +
> > > > > > +    trace_vtd_pasid_cache_reset();
> > > > > > +
> > > > > > +    pc_info.flags =3D VTD_PASID_CACHE_GLOBAL;
> > > > > > +
> > > > > > +    /*
> > > > > > +     * Reset pasid cache is a big hammer, so use
> > > > > > +     * g_hash_table_foreach_remove which will free
> > > > > > +     * the vtd_pasid_as instances, indicates the
> > > > > > +     * cached pasid_cache_gen would be set to 0.
> > > > > > +     */
> > > > > > +    g_hash_table_foreach_remove(s->vtd_pasid_as,
> > > > > > +                           vtd_flush_pasid, &pc_info);
> > > > >
> > > > > Would this make sure the per pasid_as pasid_cache_gen will be res=
et to zero?
> > > I'm
> > > > > not very sure, say, what if the memory is stall during a reset an=
d
> > > > > still have the
> > > old
> > > > > data?
> > > > >
> > > > > I'm not sure, but I feel like we should simply drop all pasid_as
> > > > > here, rather than using the same code for a global pasid invalida=
tion.
> > > >
> > > > I see. Maybe I can get another helper function which always returns
> > > > true, and replace vtd_flush_pasid with the new function. This shoul=
d
> > > > ensure all pasid_as are dropped. How do you think?
> > >
> > > g_hash_table_remove_all() might be easier. :)
> >=20
> > right. I'll make it.
>=20
> Sorry to reclaim my reply here. I think here still needs a function (say
> vtd_flush_pasid) to check if needs to notify host do unbind. e.g. If gues=
t
> unbind a pasid in guest, and issues a GSI (pasid cache), remove_all()
> will drop all pasid_as, this would be a problem. The guest unbind will
> not be propagated to host. And even we add a replay after it, it can
> only shadow the bindings in guest to host, but cannot figure out an
> unbind. But I agree with you that vtd_pasid_cache_reset() should drop
> all pasid_as but also needs to notify host properly.

Agreed, anyway we should not depend on the pasid entry but we should
simply loop over all items and force unbind all of them before the
g_hash_table_remove_all().

--=20
Peter Xu


