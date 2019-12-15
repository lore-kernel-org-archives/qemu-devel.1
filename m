Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A64C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 09:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41799206DA
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 09:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6ybkNYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41799206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igQdG-0005ye-88
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 04:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1igQc3-0005LE-4E
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 04:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1igQc2-0008A1-4K
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 04:54:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22956
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1igQc1-000871-Us
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 04:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576403693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTxGehGAWcnP8d+3tSJ5HofRU1UwAOCQCbBRPOrzAWw=;
 b=Y6ybkNYGu/1PbyPEvElcfD9k1p1fjbKQWhRtayd67TsryPkjKytyMtI3NOnU2yKIjpTber
 uXgL7CibX0KFYjdmFZ3DbFQ28hCD/pGS9k1PAyTZcy11AOxkF32cVzLzqJkgS4YJeeyYQK
 X3g4u9amtBNJ8ZSER6KvZQ11qbMe/PU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-fC3FQ3gePeGzeKQbDZMbPA-1; Sun, 15 Dec 2019 04:54:49 -0500
Received: by mail-qk1-f197.google.com with SMTP id g28so2613363qkl.6
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2019 01:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=T1f/gy7GAu+tVHMgArCL2bMPC9tQyMSsCzhr+i5i4NQ=;
 b=pkAdE2N6UddKuRQ7rjuGvk5nHbTBFWeQQg3Um3S6yv4CNhUCohpkW4/BcmWCVwr62+
 jz9G5AblRhymJbcEdgaNroeMIUgcz/llMaV4Dgf52LdS7GZfL4FeRerhxv84/264L7RL
 EVEe0vQEIco9f3GhCAZGbofCPlNksRu2HuSSh6Fhq0IXgpuS5OIwJyRs6C3IGJgR1JTX
 hxLWo2HukYFuQOxBig8rsQCoJ6cqMpernHt/3PtEz30QzpdDUS9k8jTTGl0LeoigdUaO
 DidXM3z5BS5WkLT1UUiIXiqDSvINVbGAIdlpzNbjc9LTB9+F7W3Pbm9NGTn42C0l7cFj
 TL8Q==
X-Gm-Message-State: APjAAAVltaRGzREryerZMOEbHR6vPG6BQoJPMwT46u0fueXduALMCwB6
 LlEFXEsJASQ1rbtybKbrYUwB0aAXizJ7PNlbelipMI1bzDJKP1M5x2ojv4iB80wOxIqmPMtOk6h
 jS1PAwwyA1dvRDJA=
X-Received: by 2002:a37:a98e:: with SMTP id
 s136mr22239269qke.253.1576403689154; 
 Sun, 15 Dec 2019 01:54:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBjQGeI+OUxK2u+rGe7U2c1Ycf3YvIBLfP1X5FXOC3InLvwFd942CELbUy2R722482FVQ3BQ==
X-Received: by 2002:a37:a98e:: with SMTP id
 s136mr22239245qke.253.1576403688946; 
 Sun, 15 Dec 2019 01:54:48 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id n7sm4780899qke.121.2019.12.15.01.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2019 01:54:48 -0800 (PST)
Date: Sun, 15 Dec 2019 04:54:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/8] Simplify memory_region_add_subregion_overlap(...,
 priority=0)
Message-ID: <20191215045230-mutt-send-email-mst@kernel.org>
References: <20191214155614.19004-1-philmd@redhat.com>
 <CAFEAcA_QZtU9X4fxZk2oWAkN-zxXdQZejrSKZbDxPKLMwdFWgw@mail.gmail.com>
 <31acb07b-a61b-1bc4-ee6e-faa511745a61@redhat.com>
 <CAFEAcA-UdDF2pd24NoOqpXSTnHHFWdvcexi5bRzq6ewt5vrrWQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-UdDF2pd24NoOqpXSTnHHFWdvcexi5bRzq6ewt5vrrWQ@mail.gmail.com>
X-MC-Unique: fC3FQ3gePeGzeKQbDZMbPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Dec 14, 2019 at 08:01:46PM +0000, Peter Maydell wrote:
> On Sat, 14 Dec 2019 at 18:17, Philippe Mathieu-Daud=E9 <philmd@redhat.com=
> wrote:
> > Maybe we can a warning if priority=3D0, to force board designers to use
> > explicit priority (explicit overlap).
>=20
> Priority 0 is fine, it's just one of the possible positive and
> negative values. I think what ideally we would complain about
> is where we see an overlap and both the regions involved
> have the same priority value, because in that case which
> one the guest sees is implicitly dependent on (I think) which
> order the subregions were added, which is fragile if we move
> code around. I'm not sure how easy that is to test for or how
> much of our existing code violates it, though.
>=20
> thanks
> -- PMM

Problem is it's not uncommon for guests to create such
configs, and then just never access them.
So the thing to do would be to complain *on access*.

--=20
MST


