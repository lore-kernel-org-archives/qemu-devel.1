Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD62CC11D09
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986F0208C4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsABp+fT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986F0208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4mCk-0003s9-RF
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4mBq-0003RD-Fa
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4mBp-0000Go-LU
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:48:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44139
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4mBp-0000GQ-HI
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582206509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MdfleQk3kMqK2n2lLyqiIhxV2tSNZODxKHqGEiSWZxk=;
 b=PsABp+fTPefxZwkGK6XhYMZSEyjiYPoScpTDpl5E6Fux+57RaWQj8lTrKZZ6S5yBmYWGon
 4KsET0cL2PB2acUY6liqecU0izrgXtv+C9khJVWQSBn5yMfoe+j/+Wi+SadgMuUXtBij7R
 fB1b+rQZkT5sgiQQwm4BZsJaa/bdr/g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-9PD1tZUjOUa2pub7BHhWug-1; Thu, 20 Feb 2020 08:48:24 -0500
Received: by mail-qk1-f197.google.com with SMTP id k133so2707651qke.13
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yhiiYZ1fcHyTkKmlkwe2E4LHdLYh2tKCB3et9iK5qXk=;
 b=o6if2W+gvydetN4SDIlyEyARrwFxTTdJdpfYYKFkglcdGR6DPv7zLBzJzHKb7N1J1l
 RK9cSCtwh4e0NrpVVFsbsIrnPVkcb/gZkYEG+Xy5tMhWGA7JKVb11zM4K0tesVCkGAsW
 zvSXqWF8i17iDZxuhldUkelJXTPdW/+bSHy3Mkx45rJIIelGF2NHeM3+LUVNtwIAYc34
 3flDTP6hSQRfDjcY3IzNbSMHJikgbo201BdhUCuynSHlfc07+WE75hGD0DzVPjvrgoNv
 wLaBoXg29pjQnOE9Y44lpzgujqqaPkxpQcgeERsFfGbrL36EfTWmA8hiMMIgZ3vnn1V3
 hEAw==
X-Gm-Message-State: APjAAAUZrOIl15R5c/gC4iowcbi6yxdaF9d8AJDEpq2TxHy61cE2BDZm
 uTeJdG/XrT6yKOi3X6nFRDy8g3xoW0J86MTRW2pZaMY4zSrGzjahuWZdAosdfWqyDaIBw/v/dGC
 JfyDD+42nzqo0FMc=
X-Received: by 2002:ac8:f7d:: with SMTP id l58mr12466892qtk.50.1582206504459; 
 Thu, 20 Feb 2020 05:48:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOJHlGWJkpls/MP3YRUENuDdIRH6A/R1s7OwVBgsgQneBho7PCiqwYam17TUoBA3V+fkrNRA==
X-Received: by 2002:ac8:f7d:: with SMTP id l58mr12466870qtk.50.1582206504175; 
 Thu, 20 Feb 2020 05:48:24 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id k7sm1743730qtd.79.2020.02.20.05.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:48:23 -0800 (PST)
Date: Thu, 20 Feb 2020 08:48:20 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 07/13] migrate/ram: Get rid of "place_source" in
 ram_load_postcopy()
Message-ID: <20200220134820.GE42076@xz-x1>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-8-david@redhat.com>
 <20200219204730.GB37550@xz-x1> <20200219205533.GG37550@xz-x1>
 <899dc544-757f-29ac-3a97-f45a92e68040@redhat.com>
MIME-Version: 1.0
In-Reply-To: <899dc544-757f-29ac-3a97-f45a92e68040@redhat.com>
X-MC-Unique: 9PD1tZUjOUa2pub7BHhWug-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 20, 2020 at 02:22:48PM +0100, David Hildenbrand wrote:
> > For resizing test, an easy way (I can think of) is to temporarily
> > remove the size check below in your test branch:
>=20
> Yeah, it's especially hard to have a reliable test one can materialize.
> I played with manual tests like this myself.

Great!

>=20
> I'm thinking about testing this with a device that can trigger resizes
> on demand, e.g., virtio-mem, for now on my private branch. But I'd
> really like to have some test one can automate at one point ... however,
> there seems to be no easy way to achieve that right now.

Yes I totally agree.

Thanks,

--=20
Peter Xu


