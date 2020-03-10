Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D03DC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19308222D9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYkK54yN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19308222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbFQ-0005YF-9n
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBbE3-0003sa-Tv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBbE2-0004pR-02
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:30:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50064
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBbE1-0004m0-QW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583832657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkblQ/mvRQB15m+fcNk5kfkjqVrehaUYTvgxyQH/lhQ=;
 b=iYkK54yNmvxlUuo4fcx3+qe+4hCNmt37PFmiQjZuEIKGSk3tC5ZsubsodKMGkioQKU5Fw4
 whr/bwKGH0mZEwdAeGzxsjLlUu62grqQPZWPsoeYbsLDijSWO/JUH7XcaUOBFW7jsWaDc4
 WFtGVr2XLmphV1O8wiWpkqDBgI6t53U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-ZOtLt0m6OnSbjoEUyr1kXw-1; Tue, 10 Mar 2020 05:30:55 -0400
X-MC-Unique: ZOtLt0m6OnSbjoEUyr1kXw-1
Received: by mail-qt1-f197.google.com with SMTP id r16so8752622qtt.13
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 02:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=q1ysSkYdfKTghMMyRvgkc7jgHIFFUD7Qqi1mTHd/RvM=;
 b=Zhgc9ue7DBn0v4977u57mQBZhMAEDVqNT3bpLmvT7HznL9hJg17kuMWZqDgO+qP6vJ
 X3sPLmIr1zGHqI9LbwFHTf9T1z8esmNVx6WsJiFNJ3IpteJpoGjxZLcJkbFnaObNmrsd
 tK1ca0uDLtoPflFOorcw1BJ3N8Tw5dQqrZwRNcP/242cNcXv56yn+k/wuHvfJgkXEoYN
 JA4KAre5+60wmim4/fgoxqDcW6YkTDqsKJurKERPbM9lUQVEVWWdD1T1rMcar/sqMbJO
 AI2x+1ZiOYXwMfOy14TbgvKpew1KAO5YWfdu3mwlv8/Di+Ted9hvrfG9yQ+5Igi4EdXj
 ZTTw==
X-Gm-Message-State: ANhLgQ0Ditv16PJIzNOaU3xO3XVbf46Td0z5exGS2ZuDV/tUs2/54Q1+
 rEybGVfcQcUyFLuKTBpGmYRH+D74EwrtNmzV7Ffq1lX01zBRDJYnxg4DWoWXZ7zvFrwqed0BZph
 t50I+4yg3PEB+96U=
X-Received: by 2002:ac8:6c6:: with SMTP id j6mr18163987qth.231.1583832654913; 
 Tue, 10 Mar 2020 02:30:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtOBJ2+7NTZEx/oCqG0DkK/xrOLf3STICQALM9lyKpaVfCSCqvaJVUgDyQtirnAIuFbkzcsbg==
X-Received: by 2002:ac8:6c6:: with SMTP id j6mr18163972qth.231.1583832654677; 
 Tue, 10 Mar 2020 02:30:54 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id w2sm23735330qto.73.2020.03.10.02.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 02:30:53 -0700 (PDT)
Date: Tue, 10 Mar 2020 05:30:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 14/14] hw/i386/vmport: Assert vmport initialized before
 registering commands
Message-ID: <20200310053029-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-15-liran.alon@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200309235411.76587-15-liran.alon@oracle.com>
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

On Tue, Mar 10, 2020 at 01:54:11AM +0200, Liran Alon wrote:
> vmport_register() is also called from other modules such as vmmouse.
> Therefore, these modules rely that vmport is realized before those call
> sites. If this is violated, vmport_register() will NULL-deref.
>=20
> To make such issues easier to debug, assert in vmport_register() that
> vmport is already realized.
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>


Hmm and what does actually make sure it is realized?

> ---
>  hw/i386/vmport.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index 95d4a23ce9ba..659a323e8448 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -68,6 +68,8 @@ static VMPortState *port_state;
>  void vmport_register(VMPortCommand command, VMPortReadFunc *func, void *=
opaque)
>  {
>      assert(command < VMPORT_ENTRIES);
> +    assert(port_state);
> +
>      trace_vmport_register(command, func, opaque);
>      port_state->func[command] =3D func;
>      port_state->opaque[command] =3D opaque;
> --=20
> 2.20.1


