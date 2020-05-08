Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CC6C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4128320735
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdvlU5u8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4128320735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWyHE-0001tx-F8
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWyGK-0000mz-AU
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:21:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23550
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWyGJ-0001YU-8W
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588926097;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=maHgRF+ilqsvHd0XsrIV+9iWxWLFqJu4Oy3nDK+OX7E=;
 b=GdvlU5u8p3PW97x3PK1Un8p9GC7gkOzkde5YF0ujMWw1FlHPqb3Lm2Xcp3LH5XfJPbG160
 1LHWTosw4c2Qx3WzoMHwoDx9TtMfuq26yivtiuW2Y2RfnIj0ky9Osbdr/WYV7w+ERqT4Gn
 rigynbcC8+kVjfKSVe/2TPSbRhsRHAY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-6EFYtj8pMiS_QRrcRkc13w-1; Fri, 08 May 2020 04:21:34 -0400
X-MC-Unique: 6EFYtj8pMiS_QRrcRkc13w-1
Received: by mail-wr1-f72.google.com with SMTP id 90so480451wrg.23
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=maHgRF+ilqsvHd0XsrIV+9iWxWLFqJu4Oy3nDK+OX7E=;
 b=FEgrw4ScXbPd2pipOpYBnjTGjNxaBtAQhc3DLlcOJ9bxDQdaIKVMlO/2xR7ZQ8mO2k
 7xK187Z6G93U1vspkoSLi1tIURJjGdjaKnfX0zQJdfYMCddoDzPgv7gtJfOJjBHiYsDY
 J9FWwbaDFkFsPOd/LjiRhAm/G0pKMi4G8h/sEgwe+6Nd0WdAyn6ZaW6HD5oSPLl4MOn9
 AqVkvLZSYERQgWR7pc568en8qCgXZMb6l4MxTWsnlVMwnXE8L1o+YQkmtAvmMzAnIYc9
 bx80sBDQjZX6S6MXd+JIVJKCLrbmwKu4cy5+/nMfl/Swnn315Tnx+IFECDld7hp0gGk6
 FsZA==
X-Gm-Message-State: AGi0PuZygBx87vGHfW7uDr295Jdxn5+jzXTXKUh/rxRv7cEWkKaxJpLE
 ZaREQpoiMoh9e4e3QLqboMy4eEhPptL+vRzU6ueTjElmP8gRixzKZdY6fqn0KOta9MrVph06min
 ySPpJ1RFUVRdP+HM=
X-Received: by 2002:a1c:2042:: with SMTP id g63mr14829580wmg.70.1588926093883; 
 Fri, 08 May 2020 01:21:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypJzWytOef06ibth82GDIgn/BS1NwyHC/lV7hYUC4I1DKjzucs1abKb8IMp756vMjMiA8qW3JQ==
X-Received: by 2002:a1c:2042:: with SMTP id g63mr14829552wmg.70.1588926093655; 
 Fri, 08 May 2020 01:21:33 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id y70sm12762561wmc.36.2020.05.08.01.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:21:33 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/10] exec: Shear 'exec/ram_addr.h' and make NVMe device
 target-agnostic
In-Reply-To: <6109af19-24d0-1fdc-4f5c-772cfe9ec087@redhat.com> (Paolo
 Bonzini's message of "Fri, 8 May 2020 00:15:07 +0200")
References: <20200507173958.25894-1-philmd@redhat.com>
 <6109af19-24d0-1fdc-4f5c-772cfe9ec087@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 10:21:32 +0200
Message-ID: <871rnug7lf.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: quintela@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 07/05/20 19:39, Philippe Mathieu-Daud=C3=A9 wrote:
>> Stefan suggested to make qemu_ram_writeback() target agnostic,
>> Paolo to add memory_region_msync(), and Peter to remove
>> "exec/ram_addr.h" [*].
>>=20
>> I let a single function in this file,
>> cpu_physical_memory_sync_dirty_bitmap(), to let the maintainer
>> have the pleasure to remove this header definitively himself :)
>
> I don't think this is a good idea. :)
>
> "exec/ram_addr.h" is a good place for functions that work on ram-addr_t
> and/or RAMBlock data.  There should very few of these, since these are
> mostly an internal concept that should only be used for live migration.
>  You could:
>
> - figure out which files actually need to include exec/ram_addr.h.
> There's already very few of them.

ram_addr.h looks really "not dangerous", I think that I preffer the
memory-internal.h or whatever name that implies that you should think
twice before using that file.

My main problem with that include are:

- cpu_physical_memory_set_dirty_lebitmap()
- cpu_physical_memory_sync_dirty_bitmap()

Both are long, both are complex, and if one changes them, it is very
probably that you end breaking some random architecture in TCG (being
there, done that).

As you said, that functions are used only in a couple of places.  I
haven't meassured the impact of moving it to a .c file, but I would
preffer it if performance don't suffer.

>
> - move the large functions to a new .c file, ramblock.c.  Figure out
> which can be static, move the declarations for the others to ramblock.h

Ok, it appears that we kind of agree.

> - kill ram_addr.h and include ramblock.h instead.

I created ramblock.h initially (/me checks) because if you just need to
walk a ramblock (that is clearly target independent code), you needed to
become target dependent, due to the definitions that are there inside.

I don't care one way or another, just that we don't create the old
dependency.

> Not coincidentially, qemu_ram_writeback() takes a RAMBlock*, and it ends
> up in ramblock.h.

Thanks, Juan.


