Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62852C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34093204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhbxzDdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34093204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Yia-0002ng-LI
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 01:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3Yhp-0002In-Eb
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 01:44:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28960
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3Yhm-0005rb-Ku
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 01:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596692680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6QF9hKJGDHxG3XnIwFh68ZlZjWBEPo7q2mqeZ2NJRcQ=;
 b=JhbxzDdvgdIALD8JysxjYe/O0HRJbmjjO2DShuCfqvVMlw7iKDaxYox9YzHs6sThigBJ4a
 Nb6o1wNaMuQWUo4mbBvFvwtu1um37ToK+gLiOhIPbyjmg9KCYoh0xKHyruxuU7c5ibvZjp
 rEgwnJLRUyY33swXZmdatYK75g1tBYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-C8zdVDvHMyuSKeRs7YHZUg-1; Thu, 06 Aug 2020 01:44:39 -0400
X-MC-Unique: C8zdVDvHMyuSKeRs7YHZUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14AD480183C;
 Thu,  6 Aug 2020 05:44:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA2D174F4D;
 Thu,  6 Aug 2020 05:44:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5143C1132801; Thu,  6 Aug 2020 07:44:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: cleanups with long-term benefits
References: <87k0yeg7mc.fsf@dusky.pond.sub.org>
 <6e5df5fc-94f8-ee8e-0c14-f56135de25e4@redhat.com>
 <87o8np5ysp.fsf@dusky.pond.sub.org>
 <9f83eb93-5389-7aad-3031-0777de0c35b0@redhat.com>
 <20200805083949.GA3004@work-vm>
 <241436db-1aec-b804-314f-7893954e981b@redhat.com>
 <20200805090540.GC4127670@redhat.com>
 <20200805111155.25abfd26.cohuck@redhat.com>
 <20200805100802.GG4127670@redhat.com>
 <20200805162323.GB37318@linux.fritz.box>
 <20200805164618.GO225270@habkost.net>
Date: Thu, 06 Aug 2020 07:44:27 +0200
In-Reply-To: <20200805164618.GO225270@habkost.net> (Eduardo Habkost's message
 of "Wed, 5 Aug 2020 12:46:18 -0400")
Message-ID: <87h7tg5nwk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Juan Quintela <quintela@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Aug 05, 2020 at 06:23:23PM +0200, Kevin Wolf wrote:
>> We're basically weighing "git blame" against syntax highlighting
>> defaults. I don't think the latter has an obviously higher weight.
>
> I think "syntax highlight defaults" is far from being an accurate
> description of the motivations behind this discussion.

The motivation and the expected benefits are far from clear to me,
because all I have so far is a meandering e-mail thread.

For a change proposal as massive as "throw out working code and touch
basically every line in the QAPI schema", I'd like to see a concise memo
stating the goals, their benefits, the possible ways to get there, and
their cost.  I don't think that's too much to ask.


