Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010ABC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08D120679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gK0LhhvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08D120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUZcs-0001MN-TE
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iUZbt-0000Qb-2K
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:05:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iUZbq-0005ZY-9p
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:05:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59604
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iUZbq-0005Yg-1e
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573578339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arFwck7l+QK6Dgb5wgD+6uTgKNUuvR3ncd2XqieEKpo=;
 b=gK0LhhvX/6Cergs5WWedeaBRzK5JpCFBxhzTDDZ6+kUGTo/dR5zftDMst112DeS6UE4bgy
 FLUfQgrsysj1TIi5GIlU7xs2nEs9qo0u0PZowxN4dbroojG+wZg3KT82Gyl2+ZpQN5nKoS
 kwjlmgWHp2DGogWdOEi/rGKudRoAeiE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-X06zrwcfPzGpZKHBZEBNog-1; Tue, 12 Nov 2019 12:05:36 -0500
Received: by mail-wr1-f70.google.com with SMTP id p4so6328358wrw.15
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 09:05:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=hlQOoRyzLIF/1kW42Wdr9gDHqSRM9pwLv7pqFJdQtYk=;
 b=Cq07D1qeFi3hU5JLN9673GJHk1rqM2VGO0hDngoPmHNz8hmRJWuq/r+Bw89x9GPbXb
 zixKncBzjDQ9LqoeTiEg5kkpMjtPStkcVAtZoXzN1xM9SkLjieSvqnn0n0wF4bKM9rJe
 XNzfht/AMwRZBfHmb2Z+6M0h2E3qp+p77igPQsNvMzb24kdN0G+PzJnP28IPZu3MegPo
 Cd8yajCjc5hh2N51uZ1aJitYJxkMcjzYmIM++DZ1r4qTpd8HyDdcpsX1syMMP5vIqeMQ
 vRhfJgvpsTrrBsosTgWxtf9rFdMY5ZTQP0glqBMfELsl3Z5Cx5755sll0XASB+m8/7nm
 TVaQ==
X-Gm-Message-State: APjAAAXStt+2dTsDqt4//dUyQJISIL2qKPLaMWNNeAqJDHXDizHov7HB
 B8UxDJlH8mnQi1lJzJ25QpDJtjbG7cKFKkFziVVo+kkPIN/c8Yg6lh3ZofvevVbXPlRhhPHXP87
 yn5NtMV/uqbQ3W+8=
X-Received: by 2002:a1c:bc56:: with SMTP id m83mr4771481wmf.11.1573578335491; 
 Tue, 12 Nov 2019 09:05:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxB35scU4RLgwHLGP3QPo+sEBk4mNkWHxxrHH9My28Q1njgfLOifWeBK33ANRonVr37MUFRbQ==
X-Received: by 2002:a1c:bc56:: with SMTP id m83mr4771461wmf.11.1573578335270; 
 Tue, 12 Nov 2019 09:05:35 -0800 (PST)
Received: from [192.168.3.122] (p4FF23E69.dip0.t-ipconnect.de. [79.242.62.105])
 by smtp.gmail.com with ESMTPSA id p15sm3449371wmb.10.2019.11.12.09.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2019 09:05:34 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] s390x: Properly fetch the short psw on diag308 subc 0/1
Date: Tue, 12 Nov 2019 18:05:33 +0100
Message-Id: <1FDC3957-B9E3-41E0-B766-B4ACD0753EC0@redhat.com>
References: <20191112175827.2d7bdb15.cohuck@redhat.com>
In-Reply-To: <20191112175827.2d7bdb15.cohuck@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: X06zrwcfPzGpZKHBZEBNog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: borntraeger@de.ibm.com, david@redhat.com,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 12.11.2019 um 17:58 schrieb Cornelia Huck <cohuck@redhat.com>:
>=20
> =EF=BB=BFOn Mon, 11 Nov 2019 10:28:08 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> We need to actually fetch the cpu mask and set it. As we invert the
>> short psw indication in the mask, SIE will report a specification
>> exception, if it wasn't present in the reset psw.
>>=20
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>> target/s390x/cpu.c | 12 ++++++++++--
>> target/s390x/cpu.h |  1 +
>> 2 files changed, 11 insertions(+), 2 deletions(-)
>=20
> So, is this change -rc material, or should it go in during the next
> release? I'm a bit confused here.

IMHO, this is not urgent and can wait.
>=20
> [Also, does this need a change in the tcg code, or is that something
> that should just be done eventually? Sorry, drowning a bit in mails
> here...]

We=E2=80=98re missing many checks when loading/running a new PSW for TCG, n=
ot just this scenario. So this should be done at one point but is not urgen=
t at all.


