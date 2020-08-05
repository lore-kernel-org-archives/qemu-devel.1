Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41F5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 22:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB0722CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 22:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3PGX4LL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB0722CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Rh0-0002s8-Su
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 18:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k3Rg9-0002My-P8
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 18:14:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38602
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k3Rg6-0007Pp-PR
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 18:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596665670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vAi74ZkZF1Jgxfy+HujM0KXTJHlptu5NMRDtBGHjwao=;
 b=Y3PGX4LL9xJtpyAehSzpJGLeDen3HY4f31p+dwZu+OeCvI/Vv5jxiz6FmMAE4Q1GorBnP3
 +50z2bt/3dLzQE8iIoEehHJ6xCKpTLwwk6zXcOhmUU9HahyxipupKM0GOcaJ1quea9Lqhp
 hhYoVrN26SBOFVk48jARXY/d4LwxtkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-vE14NzUoMWOfplRyH5AcvQ-1; Wed, 05 Aug 2020 18:14:22 -0400
X-MC-Unique: vE14NzUoMWOfplRyH5AcvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D55FA1009440;
 Wed,  5 Aug 2020 22:14:21 +0000 (UTC)
Received: from localhost (ovpn-112-108.rdu2.redhat.com [10.10.112.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9799A1944D;
 Wed,  5 Aug 2020 22:14:18 +0000 (UTC)
Date: Wed, 5 Aug 2020 18:14:17 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] ide: Get rid of IDEDrive struct
Message-ID: <20200805221417.GC1700540@habkost.net>
References: <20200805194812.1735218-1-ehabkost@redhat.com>
 <CAFEAcA8-REfRgq=713Tq9PfSNmRPZVzBKmLzoWLauZjqF5q5eQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8-REfRgq=713Tq9PfSNmRPZVzBKmLzoWLauZjqF5q5eQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 18:14:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 05, 2020 at 09:41:25PM +0100, Peter Maydell wrote:
> On Wed, 5 Aug 2020 at 20:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > The struct had a single field (IDEDevice dev), and is only used
> > in the QOM type declarations and property lists.  We can simply
> > use the IDEDevice struct directly instead.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > @@ -327,7 +323,6 @@ static void ide_hd_class_init(ObjectClass *klass, void *data)
> >  static const TypeInfo ide_hd_info = {
> >      .name          = "ide-hd",
> >      .parent        = TYPE_IDE_DEVICE,
> > -    .instance_size = sizeof(IDEDrive),
> >      .class_init    = ide_hd_class_init,
> >  };
> 
> This is one of those areas where this change works and reduces
> amount of code, but on the other hand it means the QOM type
> doesn't follow the common pattern for a leaf type of:
>  * it has a struct
>  * it has cast macros that cast to that struct
>  * the typeinfo instance_size is the size of that struct
> (it wasn't exactly following this pattern before, of course).

Is this really a pattern that exists and we want to follow?
I don't see why that pattern would be useful for simple leaf
types.

Also, in this case the code wasn't even following that pattern:
it was using the same IDEDrive struct for all TYPE_IDE_DEVICE
subtypes.

> 
> We define in https://wiki.qemu.org/Documentation/QOMConventions
> (in the 'When to create class types and macros' bit at the bottom)
> what we expect for whether to provide class cast macros/a
> class struct/class_size in the TypeInfo, essentially recommending
> that types follow one of two patterns (simple leaf class with no
> methods or class members, vs everything else) even if in a
> particular case you could take a short-cut and not define
> everything. We haven't really defined similar "this is the
> standard pattern, provide it all even if you don't strictly
> need it" rules for the instance struct/macros. Maybe we should?

I think we should include the instance struct/macros in the
recommendations there, but I would expect those recommendations
to apply only to non-leaf types.

> 
> Just a thought, not a nak; I know we have quite a number
> of types that take this kind of "we don't really need to
> provide all the standard QOM macros/structs/etc" approach
> (some of which I wrote!).
> 
> thanks
> -- PMM
> 

-- 
Eduardo


