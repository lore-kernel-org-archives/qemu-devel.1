Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B51BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 07:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B372073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 07:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToknC0QP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B372073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxQO9-0003rw-D8
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 03:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxQNd-0003Su-9O
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 03:38:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54109
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxQNb-0004bk-8J
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 03:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595230709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xxyJ4o2q3BFWqqY88d4VSJM9tSw9mb1wePJ2s2Elj48=;
 b=ToknC0QPNJt9no7Ypw1tLIiyUJeUBfjjglDpoGzI2M+mdUEFbTNxllt+vGCYN+sm4+VI90
 AYRP9JSqYXRNAicJWjOyUvAsVhOu6ztrhuAm3LFBh67SP7Jhpg140lnlkzvpHZ0h6I8VJw
 ToaI9arf8T6TXpiJBiIqetRI31P3AzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-IWuQAJEzPtuM9KdccuImdg-1; Mon, 20 Jul 2020 03:38:26 -0400
X-MC-Unique: IWuQAJEzPtuM9KdccuImdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F38BA106B249;
 Mon, 20 Jul 2020 07:38:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA8D42B5BF;
 Mon, 20 Jul 2020 07:38:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 428331141C54; Mon, 20 Jul 2020 09:38:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: sysbus_create_simple Vs qdev_create
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
 <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
 <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com>
 <87365t18mp.fsf@dusky.pond.sub.org>
 <CA+aXn+Guvt34PDD=N3FsD5w1C-aDXZ7gS8H_AZN-JEM8j8wBiQ@mail.gmail.com>
 <87lfjkvo81.fsf@dusky.pond.sub.org>
 <20200716222130.GO1274972@habkost.net>
 <87tuy6k9pa.fsf@dusky.pond.sub.org>
 <20200717162312.GR1274972@habkost.net>
Date: Mon, 20 Jul 2020 09:38:24 +0200
In-Reply-To: <20200717162312.GR1274972@habkost.net> (Eduardo Habkost's message
 of "Fri, 17 Jul 2020 12:23:12 -0400")
Message-ID: <87r1t6hc0f.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
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
 "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Pratik Parvati <pratikp@vayavyalabs.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Jul 17, 2020 at 07:10:57AM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > I'd also note that the use of "parent" in the code is also
>> > ambiguous.  It can mean:
>> >
>> > * QOM parent type, i.e. TypeInfo.parent.  Related fields:
>> >   * parent_class members of class structs
>> >   * parent_obj members of object structs
>> 
>> I hate the use of "parent" and "child" for a super- / subtype relation.
>> 
>> Correcting the terminology there would be short term pain for long term
>> gain.  Worthwhile?
>
> I don't know.  It looks like the terminology came from GObject.
>
>> 
>> > * QOM composition tree parent object, i.e. Object::parent
>> > * qdev device parent bus, i.e. DeviceState::parent_bus
>> > * parent device of of qdev bus, i.e. BusState::parent
>> 
>> These are tree relations.  Use of "parent" and "child" is perfectly
>> fine.
>
> The terms are fine but still ambiguous, as devices belong to two
> separate trees at the same time (the QOM composition tree, and
> the qdev tree).
>
> I never understood why we have two separate independent object
> trees.

When we rebased qdev onto QOM, we left the qdev tree alone, we did not
embed it into the QOM composition tree.

The qdev tree edge from bus to device providing the bus is commonly
mirrored in the QOM composition tree: both are QOM objects, and the bus
is commonly a QOM composition child of the device providing it.  I hedge
with "commonly", because nothing enforces this as far as I know.

We do not mirror the edge from device to the bus it's plugged into.  I
believe we could have.  I guess we could mirror it as a link even now
(but note links are not children).

I don't know why the rebase of qdev onto QOM was done that way.  Perhaps
Paolo remembers.


