Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97E5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A949822B43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1kN3ifX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A949822B43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0n99-0007BE-Uh
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 10:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k0n8U-0006jC-48
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:32:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20727
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k0n8P-0002RR-Un
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596033164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LKKOJoH79LnQqm0NV+mp2kAX3wkkSa5wHFM6gaio/z0=;
 b=b1kN3ifX4PIBJ9kjw508YS/cbkjPL0VrkxpSLpzB1Xi/1vpB4uX9VOgHCb95nXogAh2ary
 uK3/Vic+B1ASJj35qT4Gmvti1IzJUIzoA0cvjS+P4UJbjv01n3q+GKVMEH6R8sMJOJ0TY+
 20kAubxdKc5T0vZ5ufgN++w/9x2b8eI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-e-kau4nVNfeIu5_ddGuaOw-1; Wed, 29 Jul 2020 10:32:43 -0400
X-MC-Unique: e-kau4nVNfeIu5_ddGuaOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5360C801504;
 Wed, 29 Jul 2020 14:32:42 +0000 (UTC)
Received: from localhost (ovpn-120-33.rdu2.redhat.com [10.10.120.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1740C5DA6A;
 Wed, 29 Jul 2020 14:32:41 +0000 (UTC)
Date: Wed, 29 Jul 2020 10:32:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: sysbus_create_simple Vs qdev_create
Message-ID: <20200729143241.GS225270@habkost.net>
References: <87tuy6k9pa.fsf@dusky.pond.sub.org>
 <20200717162312.GR1274972@habkost.net>
 <87r1t6hc0f.fsf@dusky.pond.sub.org>
 <20200720155955.GV1274972@habkost.net>
 <87v9ihbe6u.fsf@dusky.pond.sub.org>
 <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com>
 <87lfj4f6nz.fsf@dusky.pond.sub.org>
 <759959d1-f320-734a-ac5e-a60db6b1bc23@redhat.com>
 <20200728224733.GP225270@habkost.net>
 <422d7879-3fdc-d38e-259f-2477b9d3c169@redhat.com>
MIME-Version: 1.0
In-Reply-To: <422d7879-3fdc-d38e-259f-2477b9d3c169@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 29, 2020 at 11:54:35AM +0200, Paolo Bonzini wrote:
> On 29/07/20 00:47, Eduardo Habkost wrote:
[...]
> > Do we really need need QOM children to be accessible using the QOM
> > property API?
> > 
> > Using the same code for both user-configurable properties and for
> > the list of children of a QOM object might have saved some time
> > years ago, but I'm not sure this is still a necessary or useful
> > abstraction.
> 
> The main thing we get from it is that the QOM paths treat children and
> links the same, and links are properties.  To be honest it's not a
> feature that is very much developed, so perhaps we can remove it but we
> need to evaluate the impact of losing it.

Are link properties usable by -device/device_add/-object/object-add?

-- 
Eduardo


