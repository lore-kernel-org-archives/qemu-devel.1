Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44346C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3BB21655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OApqrLfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3BB21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmFd-00009n-2a
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBmEv-0007kv-7A
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBmEt-0008PK-C9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:16:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26722
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBmEs-0008Mp-Mu
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583874993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qXVrRTy5PusYQV1NrQkAzVH2Ph8zXUoagGTDxOVYXSQ=;
 b=OApqrLfOUz2oDU7g9xNzd297jB/OEJT8LdvAwbOAxs9vwltu6nbov6YTEIp8bi27uCOvVm
 oeOnTOoeizdwi8HJwGTdBIf/nv10oByBj1ECXAEgPvABC+EOLFA6nC0uiI2RGe30qsl14M
 kvhExfuC+EEmuykO8QLCkR1jbtockYo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-uQYKqyu2P0yOlZC1ifARjA-1; Tue, 10 Mar 2020 17:16:30 -0400
X-MC-Unique: uQYKqyu2P0yOlZC1ifARjA-1
Received: by mail-qk1-f198.google.com with SMTP id l27so51737qkl.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 14:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zUECbWuL0hUFfD6j1kfLiUHH9par0CrcTojNtA0TQPI=;
 b=ad9COTJwHUpsYQN+5tkQMAW1tuPD2GKxHg9krglNcXZsjb0zVyblklqMaEkgsXDcg9
 hj7cbp7UOeie6jgmp2JW39VWP6xoE2W8w5VXfjcw2DaWPNGGn7ftk7MGBf/WVZHvL9RJ
 9dm9LC3P54IvmcLDp6VmlDHiNqcTrfE7rPC/c+lTWTdHdSPQ24Jj71NzjHkdblbYMSeq
 ZYTqJgWw2SG17lNWE/8w3YRQ1Ftj8XOJdwUC1TYVOeezTGhPiqlZIlLF9ll3DuIPXPCA
 jKRBJZDD+pb7vwwM+UDdmUXGs3CCNwhErI65PpP3X1Y/gll28zUpkEw/2UUkyA0LGZfH
 z37Q==
X-Gm-Message-State: ANhLgQ1BVFvUrloM59p0aB61iGEwp++JCPZSoynE8CD1icqEvVN15sw6
 iNO3dWx9CdGMTtbhPXh1o3KupHMa0rwl9qct+bU+2cFBGJxHxk/+Qagckts6HUOzsdxCcPT5vMy
 Tum5D7yq6fXtcAIQ=
X-Received: by 2002:a37:4548:: with SMTP id s69mr10877517qka.371.1583874989670; 
 Tue, 10 Mar 2020 14:16:29 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvXRcHovdKESmOOoMMhUFoZ4GRUXtAprZR96lYzQAbXQeHg8iCu8oY58F6B7MRpWhfeKlLOYA==
X-Received: by 2002:a37:4548:: with SMTP id s69mr10877504qka.371.1583874989418; 
 Tue, 10 Mar 2020 14:16:29 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id r207sm2426369qke.136.2020.03.10.14.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 14:16:28 -0700 (PDT)
Date: Tue, 10 Mar 2020 17:16:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
Message-ID: <20200310133646-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-6-liran.alon@oracle.com>
 <20200310081144-mutt-send-email-mst@kernel.org>
 <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
 <20200310082730-mutt-send-email-mst@kernel.org>
 <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
 <20200310084758-mutt-send-email-mst@kernel.org>
 <1f4766b2-9683-8ebf-752e-a0378bb0cbc3@oracle.com>
 <20200310094350-mutt-send-email-mst@kernel.org>
 <6d3c248f-f8fe-754d-59e5-8f2740a55263@oracle.com>
MIME-Version: 1.0
In-Reply-To: <6d3c248f-f8fe-754d-59e5-8f2740a55263@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Tue, Mar 10, 2020 at 04:46:19PM +0200, Liran Alon wrote:
> There is no license issue here. It's only definitions.=20

So it seems that in your opinion
- definition names in the interface do not need a license
and
- it is fair to reuse them without a license for the purpose
  of making your compatible interface easier to use for
  people familiar with the original

Did I get that right?

--=20
MST


