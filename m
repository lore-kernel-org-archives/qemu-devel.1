Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB4EC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D3F208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CT3ft5CX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D3F208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9nDj-0004nm-F8
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1j9nCu-0003x3-5u
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1j9nCs-0003f8-RM
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:54:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1j9nCs-0003c6-NO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583402057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpQwTX6rFgd+J7TGeYNfoXyO8Q28zM3gmYTbPVJg9qo=;
 b=CT3ft5CX/2bo6LTeMuGJwhXNh1u931MV1fPAGhxopORv1QN95ROs29uWHMTyRbe8duDYe/
 gL1HbOU6CvrVxHJObH2RgWWDLjpJ3RJpON6ky0kLwJnhCEnQNGOajh84VAaIQByzWSJoax
 36RoZRxC2Un3wt26t56fVmJVqj2EXCQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-R3hos_81PACPzWZdCXSOyA-1; Thu, 05 Mar 2020 04:54:13 -0500
X-MC-Unique: R3hos_81PACPzWZdCXSOyA-1
Received: by mail-wr1-f72.google.com with SMTP id z16so2074409wrm.15
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 01:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AueDNYRzjb6zvVf8u2dbaAFqkvxA14DFweVB5xzTenU=;
 b=JSFzmXQiyjqkJRo39KQD4DG/lljazBhyOHUxQr7WuGeY5kfqjSz4gw8r8ywnhM+llP
 R4UK0wC1H953lQc4E9e2kjdXhL3NmA9XydaOYssebraQacBGJ6M1flyKLEufIN086yp7
 lXAcrz8sTHQHoFVDlfSKq69UL0Xcvf3fmq7d+lyVb/Vj8V/VH90s8EdXxVZ9bvTD93Qn
 EM9EoDiz1YtPkRCGYh7PgeSWRIU0ZoHltaP2XDyK5BZFWRx12IrbEDCA68qY1xc4A4Ni
 uvR60oMi1f9x41MBgJLyuqcwDZnzfv9gcoeNjHl0dZNvNcdeaD8cxuMsX0SgYaZOppco
 LgIw==
X-Gm-Message-State: ANhLgQ3RqBbCeFp7bl7ILe3b6l4OYTS5nQBNFI7yUuYmMy8G4h7rEWwG
 tR1CkUFwcXA5NusZUsbaOL3kGVUMZEwwupAXik73MzdgfbcCeNPmTqfPqEyjMLCrU+NbFNrPr+J
 s75bmjDIf11zPQTo=
X-Received: by 2002:adf:e9c2:: with SMTP id l2mr8996077wrn.86.1583402052029;
 Thu, 05 Mar 2020 01:54:12 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs1Rt3xvHCyPx2q2O+U1+gj2iJoGFuu1a5B6EMMz6S1TSWHbqL5LDQ2sVT53X3WlMT1eBQQmA==
X-Received: by 2002:adf:e9c2:: with SMTP id l2mr8996053wrn.86.1583402051791;
 Thu, 05 Mar 2020 01:54:11 -0800 (PST)
Received: from steredhat (host34-204-dynamic.43-79-r.retail.telecomitalia.it.
 [79.43.204.34])
 by smtp.gmail.com with ESMTPSA id b12sm16260813wro.66.2020.03.05.01.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 01:54:11 -0800 (PST)
Date: Thu, 5 Mar 2020 10:53:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/3] hw/net,virtfs-proxy-helper: Reduce .data footprint
Message-ID: <20200305095357.nvhjz7q7tuquys4k@steredhat>
References: <20200305010446.17029-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200305010446.17029-1-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 02:04:43AM +0100, Philippe Mathieu-Daud=E9 wrote:
> More memory footprint reduction, similar to:
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg00984.html
>=20
> The elf-dissector tool [1] [2] helped to notice the big array.
>=20
> [1] https://phabricator.kde.org/source/elf-dissector/
> [2] https://www.volkerkrause.eu/2019/06/22/elf-dissector-aarch64-support.=
html
>=20

Thanks to share these links!

> Philippe Mathieu-Daud=E9 (3):
>   hw/net/e1000: Add readops/writeops typedefs
>   hw/net/e1000: Move macreg[] arrays to .rodata to save 1MiB of .data
>   virtfs-proxy-helper: Make the helper_opts[] array const
>=20
>  fsdev/virtfs-proxy-helper.c | 2 +-
>  hw/net/e1000.c              | 6 ++++--
>  hw/net/e1000e_core.c        | 6 ++++--
>  3 files changed, 9 insertions(+), 5 deletions(-)
>=20

Cool and clear changes!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


