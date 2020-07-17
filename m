Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C183C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D777C2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpVqAIi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D777C2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwT9m-0000J1-4w
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 12:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jwT8p-0007vb-Lz
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:23:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22802
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jwT8n-0002DG-PD
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595002996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FWX12EeH7LdHS3AYYf6WZc1okRRKVYrdEKWIE+9W0Uo=;
 b=BpVqAIi9TOcABjOcJH0RKayKHw98DpUVaWyCbmPsZYtaisVzFooMUI/JqAvODVRbL5oGbY
 NfXkk/W0Qnwv2r83WpAfvG2rwnYtXusAGF47oy3AWR5eYfdOyA9PvIGchXMbKLqHqtsybY
 qXbe87+zDeYBh0JfuFWd1B1ct+WxYL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-fjFBbT-AMaKNCKlq3qN98Q-1; Fri, 17 Jul 2020 12:23:14 -0400
X-MC-Unique: fjFBbT-AMaKNCKlq3qN98Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DB768005B0;
 Fri, 17 Jul 2020 16:23:13 +0000 (UTC)
Received: from localhost (ovpn-119-232.rdu2.redhat.com [10.10.119.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 165A4619C4;
 Fri, 17 Jul 2020 16:23:12 +0000 (UTC)
Date: Fri, 17 Jul 2020 12:23:12 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: sysbus_create_simple Vs qdev_create
Message-ID: <20200717162312.GR1274972@habkost.net>
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
 <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
 <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com>
 <87365t18mp.fsf@dusky.pond.sub.org>
 <CA+aXn+Guvt34PDD=N3FsD5w1C-aDXZ7gS8H_AZN-JEM8j8wBiQ@mail.gmail.com>
 <87lfjkvo81.fsf@dusky.pond.sub.org>
 <20200716222130.GO1274972@habkost.net>
 <87tuy6k9pa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87tuy6k9pa.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 03:33:51
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Pratik Parvati <pratikp@vayavyalabs.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 17, 2020 at 07:10:57AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > I'd also note that the use of "parent" in the code is also
> > ambiguous.  It can mean:
> >
> > * QOM parent type, i.e. TypeInfo.parent.  Related fields:
> >   * parent_class members of class structs
> >   * parent_obj members of object structs
> 
> I hate the use of "parent" and "child" for a super- / subtype relation.
> 
> Correcting the terminology there would be short term pain for long term
> gain.  Worthwhile?

I don't know.  It looks like the terminology came from GObject.

> 
> > * QOM composition tree parent object, i.e. Object::parent
> > * qdev device parent bus, i.e. DeviceState::parent_bus
> > * parent device of of qdev bus, i.e. BusState::parent
> 
> These are tree relations.  Use of "parent" and "child" is perfectly
> fine.

The terms are fine but still ambiguous, as devices belong to two
separate trees at the same time (the QOM composition tree, and
the qdev tree).

I never understood why we have two separate independent object
trees.

-- 
Eduardo


