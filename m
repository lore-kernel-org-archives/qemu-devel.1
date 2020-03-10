Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC42C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6680E208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhOgEKfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6680E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdKW-0004Y6-KI
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBdJK-0002yH-0c
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBdJI-0008WQ-Qz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:44:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBdJI-0008Ut-M4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583840672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTwRAJ3LNF1O9otFXMNVuRgN0vuzrSLngHBFXgqG0Cc=;
 b=hhOgEKfLaLDl4RFlE9NAKM7NameOQxVfqdIx0GKXKXM+hhpRJkVt5/GVkgC1XA5s0VXUVp
 vikAeEr4LGZucCalbMp+LMVi9mSy42N9NHNMFRiRGQLwWgbuhiFfzfl0D3C1PTYTtkSEss
 C4BFXWbSP9FwMHAky4g/eQJiNzRluUw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-yuYI92GvNNaXD2V-5GiZqA-1; Tue, 10 Mar 2020 07:44:30 -0400
X-MC-Unique: yuYI92GvNNaXD2V-5GiZqA-1
Received: by mail-qt1-f198.google.com with SMTP id k20so8904404qtm.11
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 04:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H3KCJixxh3Z0Kxp9RwH1KEoyvWhDg/ZX78PZop0lPeg=;
 b=ErMZa7bl+fb3vECAwVx61pCBI5aO6q3HtNmhOQeJsltJXDSeayd3FGewr5j2p7i/+u
 LnayotOrmutwjpu4uVrTC0NT++yJ0QziZa0ize9m80JOUGYrGykuZsvRxHBWhhQX6/VE
 bKkwZEu2XQnGJQT5PyFFs4xNUoHb6rD7uiw32uphM1b0R6ZVLOd/qBIZU1ZIejAJunHS
 sQZqQxkQYmOnd41sVO+zRhGQAiX8o6uE+MFB5TgBmFumM6YS6OOoYJjoUJPEwNLr3z8e
 ZxqadPlCYatk43RHD+OpZLOrIPP57L/Epc4y4vlADUCuNb2lpjEzO9kwHR1Xr4rYJYgQ
 qxUw==
X-Gm-Message-State: ANhLgQ1CN3uOUpnkZpKZreEmnhkq5KY5yqBwSgqMhA1FEh5KALrYjvVQ
 YFIIZyqDPwgtHqQZKPmyOhFHqbRigj3uHxWn3U6VVMSolfhDjTwQhSbsS3VoY0fR4bHJ4WZbKj1
 NHQvwo9mp3C1b0bg=
X-Received: by 2002:a05:6214:928:: with SMTP id
 dk8mr3250227qvb.170.1583840670326; 
 Tue, 10 Mar 2020 04:44:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvQ8dolH/tXyHVc89emF3+k8dbf4Gi/48wvlkPCSZGFq9HL2gHqcPGqJqzlGJbn+jMCC2oNrQ==
X-Received: by 2002:a05:6214:928:: with SMTP id
 dk8mr3250212qvb.170.1583840670070; 
 Tue, 10 Mar 2020 04:44:30 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id s56sm8450667qtk.9.2020.03.10.04.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 04:44:28 -0700 (PDT)
Date: Tue, 10 Mar 2020 07:44:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 04/14] hw/i386/vmport: Introduce vmx-version property
Message-ID: <20200310073629-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-5-liran.alon@oracle.com>
 <20200310053210-mutt-send-email-mst@kernel.org>
 <0dd22d9c-e1d2-db1e-372e-5009be705dab@oracle.com>
 <20200310071453-mutt-send-email-mst@kernel.org>
 <10ffd04f-30f9-6333-26ef-169cd1615341@oracle.com>
MIME-Version: 1.0
In-Reply-To: <10ffd04f-30f9-6333-26ef-169cd1615341@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 01:28:32PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 13:18, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 01:05:02PM +0200, Liran Alon wrote:
> > > On 10/03/2020 11:32, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 10, 2020 at 01:54:01AM +0200, Liran Alon wrote:
> > > > > Instead of hard-coding the VMX version, make it a VMPORT object p=
roperty.
> > > > > This would allow user to control it's value via "-global vmport.v=
mx-version=3DX".
> > > > >=20
> > > > > Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> > > > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > > More detail on why this is useful?
> > > It's more useful than returning a hard-coded "6" as the vmx-version..=
.
> >=20
> > Maybe default should be 6 (a bit of explanation why 6 could be nice).
> The default is indeed defined as 6. As it was before this patch.
> There is not much to explain besides the fact that recent VMware products
> returns 6 here.
>=20
> I don't recall any mapping between the returned version here and the
> supported set of VMPort commands. There is a separate mechanism (which we
> implement in another patch) to signal that a command is unsupported /
> failed.
>=20
> The term "vmx-version" refers to the version of the Userspace-VMM of VMwa=
re
> which is called (confusingly) "vmx".

Short for Virtual Machine eXecutable. Sigh.  People do come up with
names that aren't great. I don't even know whether vmware was there
first and intel shouldn't have shortened virtual machine extensions to
vmx, but in KVM and QEMU it's quite entrenched by now. So let's try to
avoid this in code. If you like how about VMPortExec and
vm-exec-version?  Also lets you use CamelCase consistently and not a mix
of underscores and CamelCase.

> > > We have used it to preserve compatibility for some VMware guests that=
 we run
> > > as-is on top of QEMU/KVM which expects specific vmx-version or else t=
hey
> > > fail to run properly.
> > >=20
> > > -Liran
> > Any detail on which guest it is?
> I will need to dig in production history to find it... They are usually
> proprietary appliances specially made to run as VMware VMs.
> > Pretending to be a very advanced version has its pitfalls if we
> > then don't behave the way vmware does, right?
> In all those cases, we have taken the version number backwards, not forwa=
rd.
> > Figuring out the version number is I suspect a bit much to ask of users=
.
> Most users will indeed not need to touch this. This is for advanced users=
,
> such as Ravello.
> We usually figured this out by reverse-engineering the failed guest and/o=
r
> examining the original VMware environment it used to run on.
>=20
> -Liran


Right if you want this for debugging, prefix property with "x-" so it does
not need to be maintained. Point being, maintaining low level interfaces
has real cost ...

--=20
MST


