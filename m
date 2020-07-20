Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6266C433EB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB19F20672
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjLCmU4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB19F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxYEl-0001Ul-N4
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 12:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jxYCy-00084h-9F
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:00:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28392
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jxYCu-0001pg-Li
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595260799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sNNy2wZVWi1T5WFgh4qbBsf1DQqqMx9JXBREikB0XSQ=;
 b=ZjLCmU4Sysb1DBEmYkCu/isG3vqUnqrC53HYysEtdmJro65UWuVd8Gesm2QbFouCmZfjjg
 4wwkZu2r1vFBa/lTOiARx64OJoivMf1WNCqOJopQkGAx9+wSlLA1TfC0BjVkvZMmHXA7SN
 LgXPxiV3xrnnyQBj2RF+UP8C7yMu2ZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-5EEjvV9mMuaRyMsXuwnDhQ-1; Mon, 20 Jul 2020 11:59:57 -0400
X-MC-Unique: 5EEjvV9mMuaRyMsXuwnDhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2D9C8014D4;
 Mon, 20 Jul 2020 15:59:56 +0000 (UTC)
Received: from localhost (unknown [10.10.67.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79CFB797E4;
 Mon, 20 Jul 2020 15:59:56 +0000 (UTC)
Date: Mon, 20 Jul 2020 11:59:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: sysbus_create_simple Vs qdev_create
Message-ID: <20200720155955.GV1274972@habkost.net>
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
 <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
 <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com>
 <87365t18mp.fsf@dusky.pond.sub.org>
 <CA+aXn+Guvt34PDD=N3FsD5w1C-aDXZ7gS8H_AZN-JEM8j8wBiQ@mail.gmail.com>
 <87lfjkvo81.fsf@dusky.pond.sub.org>
 <20200716222130.GO1274972@habkost.net>
 <87tuy6k9pa.fsf@dusky.pond.sub.org>
 <20200717162312.GR1274972@habkost.net>
 <87r1t6hc0f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87r1t6hc0f.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 21:45:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 20, 2020 at 09:38:24AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Fri, Jul 17, 2020 at 07:10:57AM +0200, Markus Armbruster wrote:
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >> 
> >> > I'd also note that the use of "parent" in the code is also
> >> > ambiguous.  It can mean:
> >> >
> >> > * QOM parent type, i.e. TypeInfo.parent.  Related fields:
> >> >   * parent_class members of class structs
> >> >   * parent_obj members of object structs
> >> 
> >> I hate the use of "parent" and "child" for a super- / subtype relation.
> >> 
> >> Correcting the terminology there would be short term pain for long term
> >> gain.  Worthwhile?
> >
> > I don't know.  It looks like the terminology came from GObject.
> >
> >> 
> >> > * QOM composition tree parent object, i.e. Object::parent
> >> > * qdev device parent bus, i.e. DeviceState::parent_bus
> >> > * parent device of of qdev bus, i.e. BusState::parent
> >> 
> >> These are tree relations.  Use of "parent" and "child" is perfectly
> >> fine.
> >
> > The terms are fine but still ambiguous, as devices belong to two
> > separate trees at the same time (the QOM composition tree, and
> > the qdev tree).
> >
> > I never understood why we have two separate independent object
> > trees.
> 
> When we rebased qdev onto QOM, we left the qdev tree alone, we did not
> embed it into the QOM composition tree.
> 
> The qdev tree edge from bus to device providing the bus is commonly
> mirrored in the QOM composition tree: both are QOM objects, and the bus
> is commonly a QOM composition child of the device providing it.  I hedge
> with "commonly", because nothing enforces this as far as I know.
> 
> We do not mirror the edge from device to the bus it's plugged into.  I
> believe we could have.  I guess we could mirror it as a link even now
> (but note links are not children).

They are already mirrored as links, and guess what's the link
name: "child[...]".

> 
> I don't know why the rebase of qdev onto QOM was done that way.  Perhaps
> Paolo remembers.

I'm guessing this is because QOM parent/child relationships
represent ownership, while there's no ownership relationship
between buses and devices.

-- 
Eduardo


