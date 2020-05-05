Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13ABC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C872073B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LD35oRVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C872073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzT0-00019u-Kf
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzRo-0008PU-Qo
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:25:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60139
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzRn-0007q2-SR
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmcX3sB31tHADwW4hgk9klz77jULA4TMG8my0sH3AUk=;
 b=LD35oRVJHWmySsnTQvWW2w5aok6DSFiO7GeiMDrCOYjRWGN1f0KQdj/e3gXOqgKWKakKH8
 iflY1xbeXCaLArdTdFmHWEuUnqgW5FUKqAoqaR2yk77zCqal1MiNh2Kz/s2lKJO8a7DqK0
 nq/PHw5yQgMQXKXgjfPX4+88ITdL1jo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-BeSswr0qMC22vqcv75gWCA-1; Tue, 05 May 2020 11:25:24 -0400
X-MC-Unique: BeSswr0qMC22vqcv75gWCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A4E8100CC87;
 Tue,  5 May 2020 15:25:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCCEC70542;
 Tue,  5 May 2020 15:25:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6347F11358BC; Tue,  5 May 2020 17:25:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 12/17] qdev: Clean up qdev_connect_gpio_out_named()
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-13-armbru@redhat.com>
 <e8fe9402-493d-d7fc-b424-d8874e5deca8@redhat.com>
Date: Tue, 05 May 2020 17:25:21 +0200
In-Reply-To: <e8fe9402-493d-d7fc-b424-d8874e5deca8@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 May 2020 16:40:12
 +0200")
Message-ID: <87imha8kv2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 berrange@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 4/28/20 6:34 PM, Markus Armbruster wrote:
>> Both qdev_connect_gpio_out_named() and device_set_realized() put
>> objects without a parent into the "/machine/unattached/" orphanage.
>>
>> qdev_connect_gpio_out_named() needs a lengthy comment to explain how
>> it works.  It exploits that object_property_add_child() can fail only
>> when we got a parent already, and ignoring that error does what we
>> want.  True.  If it failed due to "duplicate property", we'd be in
>> trouble, but that would be a programming error.
>>
>> device_set_realized() is cleaner: it checks whether we need a parent,
>> then calls object_property_add_child(), aborting on failure.  No need
>> for a comment, and programming errors get caught.
>
> I suppose it was not that obvious at the time of that comment :)

Safe guess :)

> commit 615c4895703164134379b68214130dd502721174
> Author: Andreas F=C3=A4rber <afaerber@suse.de>
> Date:   Wed Jun 18 00:57:08 2014 -0700
>
>     irq: Slim conversion of qemu_irq to QOM
>
>     As a prequel to any big Pin refactoring plans,
>     do an in-place conversion of qemu_irq to an Object,
>     so that we can reference it in link<> properties.
>
>
> commit 02757df2ad2d5dfc96482e2cdfa046f439dafc3d
> Author: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Date:   Thu Sep 25 22:20:25 2014 -0700
>
>     qdev: gpio: Re-implement qdev_connect_gpio QOM style
>
>     Re-implement as a link setter. This should allow the
>     QOM framework to keep track of ref counts properly etc.
>
>     We need to add a default parent for the connecting
>     input in case it's coming from a non-qdev source.
>     We simply parent the IRQ to the machine in this case.
>
>>
>> Change qdev_connect_gpio_out_named() to match.
>>
>> Cc: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!


