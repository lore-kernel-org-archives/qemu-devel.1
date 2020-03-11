Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47168C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126A32146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/1t4prD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126A32146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBzrk-0004HT-7I
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 07:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBzqn-0003T4-Gf
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBzqm-0003up-2i
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:48:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56886
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBzql-0003uL-Uk
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583927315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdGAvKoBgRfjE7jabkPR5CQArWyknseFZMt8o4s2ZhI=;
 b=U/1t4prD0ipwuslLSWTsWnnJ1f0OzZ3saV/kTxl+nRIJJL2qYBOrXvSsn0R1S/WNiGeX9u
 92eYIOm5aLHSWXwQ00Alkxvndy7dhCBd6jRbcrHVkXh4dNNHsqlRpW1Kxx7pQDOtEN6GnW
 1yacjLLQY3biSKHZNSUEd4vmU2yiuck=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-kdDx8VKONomezIC8EP1y5A-1; Wed, 11 Mar 2020 07:48:33 -0400
X-MC-Unique: kdDx8VKONomezIC8EP1y5A-1
Received: by mail-qk1-f197.google.com with SMTP id d14so1279956qkj.5
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 04:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=LSgUVDioEtI8z/MQ7ScZ69F1FISd+cKSH2BMI66Rp60=;
 b=t+5wdw6kRRn4v+LXhXv5LLyzcq5qBeiKy/1bpK7nf/1YjRjIeMIlYDPeZ/O8DQTJ38
 2j95TSI3HNntR+prncIE5F30WQjgzqYYOq0FiQ+9B0JH7hPcAuSNUHj95Pf3iZwrClZh
 gQRC+mofoyzh/F/JTiO3NAyL7McffgFtLPri/6ss4jYPFmcwlLKV0ndvxTtxLVzhCwG4
 nWlKQdFBOHjdsD9fE8RPksd1xgx3GbN/k6RQqk1H8C5Asb7w4RXVm3L4ZnlPU3YgLPHm
 mEpNQSTei6xOKCkL5tut4ZlimFDEnLtWm2dUzYOSB3zGVjpKGPBJzoAjIVQz0QCGkYGM
 jbrA==
X-Gm-Message-State: ANhLgQ29q6KtAjGkluEzidxbJboTCbIjdBWh8z0aH8j8mXHzELUz/DO3
 loJvZO0Qg6Irdv/Pj2xKxS4ElbqKU3s9zCrvXTsCuIfi4fi6DefqPwFwnaYopBvYbQKVFCyOOtH
 M85McdbeM78yiCjo=
X-Received: by 2002:ac8:6ec3:: with SMTP id f3mr2221781qtv.328.1583927312843; 
 Wed, 11 Mar 2020 04:48:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtIXjhBumbvzSMfyZnRBIBllTIDCfq4vycKbD/kMdNjeNRzPCpCheOLsya00AK6LYndYnE3KA==
X-Received: by 2002:ac8:6ec3:: with SMTP id f3mr2221762qtv.328.1583927312584; 
 Wed, 11 Mar 2020 04:48:32 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id x7sm19348569qkx.110.2020.03.11.04.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 04:48:31 -0700 (PDT)
Date: Wed, 11 Mar 2020 07:48:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: Upstream QEMU guest support policy ? Re: [PATCH v3 0/2] spapr:
 Use vIOMMU translation for virtio by default
Message-ID: <20200311073145-mutt-send-email-mst@kernel.org>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200310114343.GD3234052@redhat.com>
 <20200311011247.GT660117@umbus.fritz.box>
 <20200311100127.GC3614859@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200311100127.GC3614859@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pair@us.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 paulus@samba.org, clg@kaod.org, mdroth@us.ibm.com, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 10:01:27AM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Mar 11, 2020 at 12:12:47PM +1100, David Gibson wrote:
> > On Tue, Mar 10, 2020 at 11:43:43AM +0000, Daniel P. Berrang=E9 wrote:
> > > On Thu, Mar 05, 2020 at 03:30:07PM +1100, David Gibson wrote:
> > > > Upcoming Secure VM support for pSeries machines introduces some
> > > > complications for virtio, since the transfer buffers need to be
> > > > explicitly shared so that the hypervisor can access them.
> > > >=20
> > > > While it's not strictly speaking dependent on it, the fact that vir=
tio
> > > > devices bypass normal platform IOMMU translation complicates the is=
sue
> > > > on the guest side.  Since there are some significan downsides to
> > > > bypassing the vIOMMU anyway, let's just disable that.
> > > >=20
> > > > There's already a flag to do this in virtio, just turn it on by
> > > > default for forthcoming pseries machine types.
> > >=20
> > > Breaking existing guest OS to support a new secure VM feature that
> > > may not even be used/wanted doesn't seems like a sensible tradeoff
> > > for default out of the box behaviour.
> > >=20
> > > IOW, if Secure VM needs this, can we tie the change in virtio and
> > > IOMMU defaults to the machine type flag that enables the use of
> > > Secure VM.
> >=20
> > There is no such flag.
> >=20
> > In the POWER secure VM model, the secure mode option isn't something
> > that's constructed in when the hypervisor builds the VM.  Instead the
> > VM is started normally and transitions itself to secure mode by
> > talking directly with the ultravisor (it then uses TPM shenannigans to
> > safely get the keys to its real storage backend(s)).
>=20
> This is pretty suprising to me. The ability to use secure VM mode surely
> depends on host hardware features. We would need to be able to block the
> use of this, in order to allow VMs to be live migrated to hosts which
> lack the feature. Automatically & silently enabling a feature that
> has a hardware dependancy is something we aim to avoid, unless the user
> has opted in via some flag (such as -cpu host, or a -cpu $NAME, that
> implies the feature).

That's something I don't know. Is migration supported in this mode?

--=20
MST


