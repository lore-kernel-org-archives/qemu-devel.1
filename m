Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7CEC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756A920CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgc/Ew3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756A920CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZK3-0007v9-6Z
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6Z0L-0003hL-Tr
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6Z0G-0003YL-Fe
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33046
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6Z0G-0003Wy-B0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582632474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUV6MdpemBBMuJvYonDAbRJQvhuEwsBrq+PN3s5psdA=;
 b=dgc/Ew3R2lue+OU9eMoEmVEh8ok657T4R0WsfoelCgmzl17DXeyJ56rjA2HN9hAAcj4/D6
 qRZH4xX2pK0mVM6CtLR1HmvlkgqA4P+lL2gLdx+CK4XUjtryiWMnwnCcnAY0vX38wMgN7U
 sVDNTljMbWr1/gkM4aRLcgc5p9TVFAI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-0T3C7xF6PiOaA5f5mExtWw-1; Tue, 25 Feb 2020 07:07:52 -0500
X-MC-Unique: 0T3C7xF6PiOaA5f5mExtWw-1
Received: by mail-qv1-f72.google.com with SMTP id cp3so12622617qvb.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4ssfqURimZVQE3PLVMknFWonjbS7Sj8ozSgUIZ0veYI=;
 b=BHSRRkxPVhDawv9XRp9V28HpB5Hct6O+b3wXWnIyMxsqPizd6CS0kqISzKB7R7Q0Ux
 glomTZtM91P4a9Ul6SA5MPwrQIe6Pa3p1xFLm6YLS5Or5XSjI9gmdynf+IJk4fE5Y/d6
 Ek9CSFqkHxZWr1Up0E1kk35bUYlmuu+03LKsvyo3ls/Vu85p1XROOK2u8E/ui0jDzBZr
 3hO1ydBgARQn7so8kJaBEgbhLt3E8sq0HX9a8G6YLhpo0F+ynLCEqS65Y+6dRjJvtYoX
 AOdDz98f0/NSJoHJLyHl9ClWC3t0NlrhGZVAPxL1cKV9B6UT228UIfhzXZLx4HEMcdNV
 QkCQ==
X-Gm-Message-State: APjAAAUWIdSCjlofquouLfa2EXz1tA9qfBpjH9KrxtMd+eLzCAmZ8fp+
 OzHl9Khjp3JOO8kihPYsTprRseRaP0owwaBiXJCwpQLVm/5DSHaCXGS+SHdQMQaM1YPz2cM5jYn
 UBELF1KnAQsH9Gd0=
X-Received: by 2002:ac8:3489:: with SMTP id w9mr55168526qtb.181.1582632472063; 
 Tue, 25 Feb 2020 04:07:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxSzewph2kK7Xh+wmI+nYMrQIDbdXdJIiY29Ng1FXT7JlynhgnLARF2ltrWPk6TCV7X9Ujm6w==
X-Received: by 2002:ac8:3489:: with SMTP id w9mr55168501qtb.181.1582632471840; 
 Tue, 25 Feb 2020 04:07:51 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 w21sm7803526qth.17.2020.02.25.04.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:07:50 -0800 (PST)
Date: Tue, 25 Feb 2020 07:07:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v2 3/3] Lift max memory slots limit imposed by vhost-user
Message-ID: <20200225070027-mutt-send-email-mst@kernel.org>
References: <1579143426-18305-1-git-send-email-raphael.norwitz@nutanix.com>
 <1579143426-18305-4-git-send-email-raphael.norwitz@nutanix.com>
 <20200206032332-mutt-send-email-mst@kernel.org>
 <20200209174335.GA15050@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200209174335.GA15050@localhost.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, Prerna Saxena <prerna.saxena@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Feb 09, 2020 at 12:43:35PM -0500, Raphael Norwitz wrote:
> > > The current feature implementation does not work with postcopy migrat=
ion
> > > and cannot be enabled if the VHOST_USER_PROTOCOL_F_REPLY_ACK feature =
has
> > > also been negotiated.
> >=20
> > Hmm what would it take to lift the restrictions?
> > conflicting features like this makes is very hard for users to make
> > an informed choice what to support.
> >
>=20
> We would need a setup with a backend which supports these features (REPLY=
_ACK
> and postcopy migration). At first glance it looks like DPDK could work bu=
t
> I'm not sure how easy it will be to test postcopy migration with the reso=
urces
> we have.

Yes, DPDK works with postcopy. I understand it's of no
immediate interest to you but I'm afraid it just becomes too messy
if everyone keeps breaking it.
VHOST_USER_PROTOCOL_F_REPLY_ACK was added by a contributor from
nutanix, surely you can ping them internally for a test-case :).
=20

--=20
MST


