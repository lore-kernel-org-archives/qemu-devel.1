Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CB2C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB08F20FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKMN6UCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB08F20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVxL4-00069D-S0
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kVxJq-0004ni-Hk
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kVxJm-00040n-Km
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603460476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24USLKaX0C7fVHdgB3iRgbBthN0DOh2vvObYCPqssXo=;
 b=WKMN6UCAzCh5ep1+tb0HSz7VD95peugiCPpeqAXWGVj98q6DQoozO7XjGuEjfTlrTH/JI2
 hMMW2aH4qFCZl9uBK/2PqhzJ76rBkHG7C5vjJgQ6wAPJDvHz29V8NEZuUalbWz8bv6leDB
 dwL7tJqyQUXUTCmWEr0gRHNSd2FA/yM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-fdNFnPuGMyyBxg4hcyEe-Q-1; Fri, 23 Oct 2020 09:41:15 -0400
X-MC-Unique: fdNFnPuGMyyBxg4hcyEe-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5422A85C737;
 Fri, 23 Oct 2020 13:40:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6E7055785;
 Fri, 23 Oct 2020 13:40:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 55FAF113865F; Fri, 23 Oct 2020 15:40:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/6] qemu-storage-daemon: QAPIfy --chardev
References: <20201023101222.250147-1-kwolf@redhat.com>
 <20201023103603.GG445638@redhat.com>
Date: Fri, 23 Oct 2020 15:40:21 +0200
In-Reply-To: <20201023103603.GG445638@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Fri, 23 Oct 2020 11:36:03 +0100")
Message-ID: <87blgtoybe.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Oct 23, 2020 at 12:12:16PM +0200, Kevin Wolf wrote:
>> While the qemu-storage-daemon command line is still considered unstable,
>> let's change --chardev from the old QemuOpts-based parser to QAPI, so
>> that it becomes a simple mapping of chardev-add to the command line and
>> will fit in a future fully QAPIfied command line without later
>> incompatible changes or additional compatibility glue.
>
> NB, I am *not* objecting to this series in what I'm about to write,
> but I want to point out that I don't think we should assume that
> this proposed QAPIified CLI is neccessarily the long term end point.
> Below I outline potential incompatible changes that would end up
> turning -chardev into legacy / deprecated syntax.
>
>
> The chardev QAPI-ification is a good example of the gap between QOM
> and QAPI.
>
> The chardev backends are QOM classes, but they lack the "user creatable"
> interface.
>
> Thus instead of configuring them using -object / object_add, we have a
> QAPI model, custom args/commands -chardev / chardev_add, and then code
> that populates the object instance properties from the QAPI model. Except
> we've not really exposed them as object instance properties - they are
> mostly just struct fields directly accessed.
>
>
> The benefit of the chardev approach is that we have an introspectable
> QAPI model. The downside is that we have a bunch of conversion code
> for QAPI to QOM mapping.
>
> The benefit of the user creatable object approach is that we dont
> have to add custom CLI args for different types of object, nor write
> code to populate QOM from QAPI. The downside is that we're divorced
> from the QAPI schema, so loose introspection, and have a different
> type of tedious boilerplate code to write.

Loss of QAPI introspection is the killer.

We have QOM introspection, but it's far too weak to serve as
replacement.  Besides, two introspection facilities is one too many.

> The fact that we have this custom -chardev arg, instead of just using
> -object is related to the ordering problems we have in main() in the
> system emulators.
>
> We have some -object types that need creating before the chardev
> types, and some -object types that need creating after the chardevs.
>
> If -chardev didn't exist, and we used -object for chardev creation,
> then the ordering problem would trivially not exist, as we would
> simply be processing all -object args in order that we receive them.
>
>
> IOW, if we're considering our ideal long term configuration goals
> for QEMU, then I think we should be looking at a solution to bridge
> the gap, so that we can get the best of both worlds, and have a single
> way todo things.
>
> IMHO, ideally none of -netdev, -chardev, -device, etc would exist
> in any "modern" CLI, they would just be considered legacy syntax.
> Essentially everything would be created using the same -object arg
> and object_add  commands.
>
>
> What I think this means is that we need to use QAPI to represent
> the properties of an object, and auto-generate the QOM code to
> register properties, provider setters/getters, constructors, etc.

Use of a QAPI schema rather than code to define user-facing QOM
properties provides QAPI introspection for QOM.  Having that would be
lovely.

Bonus: in QOM, documenting types takes effort.  Consequently,
user-facing QOM is mostly undocumented.  In a QAPI schema, *not*
documenting stuff takes effort: the QAPI generator insists on
documentation.

Eduardo (cc'ed) mentioned he'd like to work towards defining properties
in a QAPI schema.

> For existing user creatable objects this would largely involve
> deleting lots of existing code and defining some simple QAPI
> schemas. This is probably quite easy, if tedious.
>
> For the chardev/netdev/etc objects we already have the QAPI schema,
> but would need to add code genration parts to turn them into full
> user creatable object classes. This is likely harder more involved
> work, especially to keep backcompat working well.

I sympathize with this long term vision.

Nevertheless, we need Kevin's work now to get a decent storage daemon
CLI while that's still easy to do.  We'll have to promise stability
soon, and then changes get much harder.


