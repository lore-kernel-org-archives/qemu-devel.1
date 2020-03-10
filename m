Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E287EC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952B02071B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ch/dFFiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952B02071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmmU-0004Td-QC
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBmkf-0002zO-Pi
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBmke-00039O-MX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:49:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBmke-00038z-IZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583876963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esfXJj8y4hqR3xQF+cX6mCp5YQ3hg3k695I94Qg8Cvw=;
 b=Ch/dFFiOpngPpNDBFitR9Unhnxrg/evZCDFoSmWWTA2CtCHunv6T3mYmmMaPpPc6Fj856q
 CU4RPxBtU4j59xwCH8ujTDtWmQwk/mV3jmGDl9fttiB7kOHFpC8JL7xJTvgKOb2/qPjm15
 XL6m6RHUvXMyQ8I4QFy7fo3vVsCO2V8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-tNtOvcWDOiSZPpy0-q4FTw-1; Tue, 10 Mar 2020 17:49:21 -0400
X-MC-Unique: tNtOvcWDOiSZPpy0-q4FTw-1
Received: by mail-qt1-f199.google.com with SMTP id c13so10086365qtq.23
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 14:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ooeP3zqA0RpsGSeNld2QTSFxep7ynogxfhVPJYV0vgw=;
 b=tcpuVw8Vm2g1sh1AgKytvFCKlQsSyXW+oLfFLq0TY8mlL4JD5B6V8WdZg5rm56QKSs
 89DT5lRWvKjZa857vegmR97r/K57xEqRc8baUi4MaNd9YCC48nEWhYvL6tOedYEeullD
 FYAfo1vxX97v2FyOK21u3oavKT7IoTIW3GBdAay39DXAlMpnCF1nsxWN6WRXWmPlux7R
 l+h9lv/Da0E1WSmZK2wBprnoWpT1ZNS6u0hJF2r5nwbgGUkh6Wp5m8CVonF5fVBhjtCj
 ZfDuFz8yWRIfm+DHwEu/v+9fWx35CUuDt++uc7bU1JBvg7Tcy4cFBISV6L7C29f9Ejak
 luhg==
X-Gm-Message-State: ANhLgQ2Yz789/2PdoQetcwW+jK+cggVRyqbWEqnCiLcHYzzRSTRPLxYq
 MW2pago7alofCBDWWWUiW3wmhR7V4iIcqs9mGdFFXsDuvhW2YXhFbtZ9YaM0RYQMzHKppM8t9QO
 HY3G+MqhRK+YRc/Y=
X-Received: by 2002:ad4:4e26:: with SMTP id dm6mr223209qvb.229.1583876961191; 
 Tue, 10 Mar 2020 14:49:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvhUMxceDCxFAW5HbKXRkDwz7OGNvz9MtovSo0L9RlsAmkwUOVSl7gNmVxIQKpM27tIcMem0A==
X-Received: by 2002:ad4:4e26:: with SMTP id dm6mr223193qvb.229.1583876960928; 
 Tue, 10 Mar 2020 14:49:20 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id n74sm2278617qke.125.2020.03.10.14.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 14:49:19 -0700 (PDT)
Date: Tue, 10 Mar 2020 17:49:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
Message-ID: <20200310174604-mutt-send-email-mst@kernel.org>
References: <20200310081144-mutt-send-email-mst@kernel.org>
 <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
 <20200310082730-mutt-send-email-mst@kernel.org>
 <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
 <20200310084758-mutt-send-email-mst@kernel.org>
 <1f4766b2-9683-8ebf-752e-a0378bb0cbc3@oracle.com>
 <20200310094350-mutt-send-email-mst@kernel.org>
 <6d3c248f-f8fe-754d-59e5-8f2740a55263@oracle.com>
 <20200310133646-mutt-send-email-mst@kernel.org>
 <91053e38-8bd1-d316-acd0-561dfc016fd5@oracle.com>
MIME-Version: 1.0
In-Reply-To: <91053e38-8bd1-d316-acd0-561dfc016fd5@oracle.com>
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

On Tue, Mar 10, 2020 at 11:34:00PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 23:16, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 04:46:19PM +0200, Liran Alon wrote:
> > > There is no license issue here. It's only definitions.
> > So it seems that in your opinion
> > - definition names in the interface do not need a license
> > and
> > - it is fair to reuse them without a license for the purpose
> >    of making your compatible interface easier to use for
> >    people familiar with the original
> >=20
> > Did I get that right?
> I'm for sure not an expert on open source code licenses. You probably kno=
w
> this area much more than I do.
> But yes, this is what I would have thought. That it's not an issue to cop=
y
> the enum definition.

I'm not a lawyer. I think attribution is important even for small
things, and it was missing in v1. v2 has it but link would be better.  I
also think respecting author's wishes is important, and a license gives
a hint as to that.

--=20
MST


