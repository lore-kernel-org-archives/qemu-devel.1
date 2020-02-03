Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03001C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75732080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXkJAHdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75732080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybCj-0005Za-0D
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iybBF-0004Fy-La
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:50:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iybBE-0004Wf-9d
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:50:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58159
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iybBE-0004WN-4n
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580734219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAQOGX2KN66sPW040do3aV7DaaxceEAQma4QWo8O16I=;
 b=LXkJAHdxIZf77ksdRpDJOGqfUXRUYk8js+JGVgc4Mkwwl9A4kKAJOmbqy1BJ5hYtdW9/wk
 eHbDV4raV3TAspgU7foERsShWe7AZVj7kaxnIpHFpAPdSdHGwXZXsF3519ItJ8440LNCrV
 8bU+29YzKezhNHxrD5Ew1V3YsjDvSbY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-uq2XfmNINYy-XX0Q3iP8Zw-1; Mon, 03 Feb 2020 07:50:18 -0500
Received: by mail-qv1-f72.google.com with SMTP id z9so9348633qvo.10
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 04:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TYDPlxFsAhQOxWrW1+FfC9DYHAeD7nzMwSSXcH7rbKE=;
 b=FDIthtuP8CBjIhD6wYwAs9B2DOC1TqVza04e24cc012/7+tEOlI6ticGHnbcUAs/nN
 UM/7gJp5y2FadGRE+8XL+gk7cdZ7CAnEwmHYUvUmvEQ1GYkto5mxQH4JAIyEOjPvklec
 UJbtWnwUgWP0CK/2jwoiSbtENIiVW4tKdhbszq0je23zx44RZML52rqaQNxMnIy1RDFL
 ZE/v+ZpEJJS0dDYjXp1KX6NYlC/vL61YOowdx7hKmvst17mTbkxc0JyrIcGcSQnWryrW
 hZ78w62eVBHNGRdTbGQ2AGpqhL+Hz7br+VAqialyDo+980fmdQneg0inDTVqpn0aWeun
 v2qg==
X-Gm-Message-State: APjAAAWF8vYU6dnLnXX1IGjCHci3zYtkO71V1Fs2qeZocA7nFIygqbcv
 PZydMUbFG5VmLrYYQ+lc2csidZe3au5/NBLRoUwrg1u1dlw+uRlVInoi74wscs7DwdSBinJHdtT
 zI6L76HNkt/sXdOQ=
X-Received: by 2002:ac8:6644:: with SMTP id j4mr22447417qtp.90.1580734217633; 
 Mon, 03 Feb 2020 04:50:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqztN2ewZ5OWBzYoqMrm3+N9bWEPZxy4r4P+v15yM2HlMzENw1vYsODz5KVsSJITr5RupcveXw==
X-Received: by 2002:ac8:6644:: with SMTP id j4mr22447400qtp.90.1580734217399; 
 Mon, 03 Feb 2020 04:50:17 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id s26sm9825894qtq.22.2020.02.03.04.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 04:50:16 -0800 (PST)
Date: Mon, 3 Feb 2020 07:50:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v3 17/18] i386:acpi: Remove _HID from the SMBus ACPI entry
Message-ID: <20200203073844-mutt-send-email-mst@kernel.org>
References: <20200123070913.626488-1-mst@redhat.com>
 <20200123070913.626488-18-mst@redhat.com>
 <CAFEAcA98iqJkTp4F6qmO5f4VYNhE3Fs4toBuV1qNtujAo6=OJg@mail.gmail.com>
 <20200203013334-mutt-send-email-mst@kernel.org>
 <CALQyB5EtG2SZ2EBpwXkcAEzkpMNJxjw5s-ZmNJGK-cV9FFKogw@mail.gmail.com>
 <CAFEAcA8c3wQ3AS9JD_NPvbG8pr000LGkRs8NwMSg5CY7dPiWXA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8c3wQ3AS9JD_NPvbG8pr000LGkRs8NwMSg5CY7dPiWXA@mail.gmail.com>
X-MC-Unique: uq2XfmNINYy-XX0Q3iP8Zw-1
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
Cc: Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 12:10:33PM +0000, Peter Maydell wrote:
> On Mon, 3 Feb 2020 at 12:03, Corey Minyard <cminyard@mvista.com> wrote:
> >
> > I checked a few days ago and someone had already beat me to it.
>=20
> Yeah, we had a discussion on IRC about it and came to the
> conclusion that this was a fix. To avoid future confusion,
> my suggestion would be that commit messages that fix bugs
> should explicitly say they fix bugs they refer to; "See $BUG"
> implies to me a looser connection like "this is another bug in
> this area" or "this partially addresses that bug" or
> "this bug report mentioned this issue in passing while
> describing a different bug".
>=20
> thanks
> -- PMM

Right. Probably Fixes: <> that (I think) github pioneered.

--=20
MST


