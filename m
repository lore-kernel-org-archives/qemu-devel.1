Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD41C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 20:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402F620828
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 20:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjCiRGm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402F620828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDDqO-0005Zo-EB
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 16:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDDpZ-00054X-Ol
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 16:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDDpY-0000XO-LH
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 16:56:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51106
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDDpY-0000M0-GY
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 16:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584219383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GoEUqr34bzyQ+r75IsktQYZ29xQqK8bUm5CV0HYXgm4=;
 b=HjCiRGm7vFNPXNY7ngUie0ifJc21oW4yeC0NLsMpSvQnVB2ebmy5KPtBue70sem0FtSy6D
 +S2qQiTdHOHIWqGhsr8Q/y/jFg3Yy1T/w/GYVfw5bHClJaQIM3k7w2bzHiDuqxHMi3OpQt
 tOYFWUFbOyKXH28W6pr/SwJz4hdur3Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-EXkQaNp6Or2uD781FiqUng-1; Sat, 14 Mar 2020 16:56:19 -0400
X-MC-Unique: EXkQaNp6Or2uD781FiqUng-1
Received: by mail-qv1-f69.google.com with SMTP id k16so11908870qvj.7
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 13:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=omM5/R7WrcmNYzROpSTxhwPlE0fKnhhbhFQvm695f/o=;
 b=XZgQdjfr5QcsiI9G6RVbZ4CUVnjHskigYWk0TbkublV2PMWCEvWVHyGEDdZYmo5yoP
 esQdtbVC8vkPt/8NjmuAcJDkU7FMaJZv4l2M27HJnOwNlyWvS9wsgiBmjddGs+Bc5vTS
 ZU4Q5qk36AJSSmOkeZpGsU69w5gwGX3yKoT/zDpwTHVRLldwL9k1p/wNW40I7Igtr4Oa
 HhjXusQc86vtZzVcEujYLuRE1BWDIlXlybIsX+tEqE0uKBreg62SmR2SMB/5qsWtWNIQ
 x6i6tb3LkfcwVI4QCcJXDcJCCo63vHlmvo+zh0Q6QQQAUf2t/uCLEWDHLIQPynaxwbw6
 u+pw==
X-Gm-Message-State: ANhLgQ01FOBcrdZwtlbvaF4F9uUeaB/Ko4rdkAnKUs+64526NBYfrK2i
 jLUSEEBcWKQNyafe3wbssol7FSl1Sc360A3JMYwYAuW76xxP62+DZ5QGv4XEHUEJFaW0UbT4cYS
 ST5nDB4mQpJdlJ4s=
X-Received: by 2002:a37:4b4c:: with SMTP id y73mr19152039qka.467.1584219379102; 
 Sat, 14 Mar 2020 13:56:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsGiQMLHlx1ZtkHP/E6lfAKvwym3F/sLvBpDnZNmuzFpu6CQuDLI3Vq2iDp7qfgePMk14gWLg==
X-Received: by 2002:a37:4b4c:: with SMTP id y73mr19152030qka.467.1584219378907; 
 Sat, 14 Mar 2020 13:56:18 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 h25sm11623507qkg.87.2020.03.14.13.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2020 13:56:17 -0700 (PDT)
Date: Sat, 14 Mar 2020 16:56:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
Message-ID: <20200314164850-mutt-send-email-mst@kernel.org>
References: <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
 <20200313113049-mutt-send-email-mst@kernel.org>
 <3c0d9308-f56c-0766-9815-241a28d9a246@oracle.com>
 <20200313170914-mutt-send-email-mst@kernel.org>
 <67d158f3-9d6c-cba8-6b3a-87702abdc6f0@oracle.com>
 <20200314151236-mutt-send-email-mst@kernel.org>
 <a9ac1106-67be-5d5d-fd30-669a483f09b0@oracle.com>
 <20200314152119-mutt-send-email-mst@kernel.org>
 <C3D0DD6C-592E-4230-A7D6-FF423265DF03@oracle.com>
 <5f9f6b13-d382-b9a6-52cd-80014c2f01b8@oracle.com>
MIME-Version: 1.0
In-Reply-To: <5f9f6b13-d382-b9a6-52cd-80014c2f01b8@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 14, 2020 at 10:05:20PM +0200, Liran Alon wrote:
> Michael, you can also refer to this VMware time-keeping whitepaper:
> https://www.vmware.com/pdf/vmware_timekeeping.pdf.
> According to section "Initializing and Correcting Wall-Clock Time":
> """
> VMware Tools can also optionally be used to correct long=E2=80=90term dri=
ft and
> errors by periodically
> resynchronizing the virtual machine=E2=80=99s clock to the host=E2=80=99s=
 clock, but the
> current version at this writing is limited.
> In particular, in guest operating systems other than NetWare, it does not
> correct errors in which the guest clock
> is ahead of real time, only those in which the guest clock is behind.
>=20
> """

This talks about guest time.
What this does not mention is whether hosts need to employ any mechanisms
to synchronise wall clock between hosts.

> If I understand correctly, this seems to validate my assumption that curr=
ent
> implementation for CMD_GETTIME is sufficient.

So I am concerned this does not interact well with other time sources
in QEMU. For example, it's very useful to set guest time with -rtc base
flag.

Can you use qemu_get_timedate?



--=20
MST


