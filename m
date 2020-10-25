Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93B4C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 17:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B5E208A9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 17:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKP23Zih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B5E208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWk4Q-0004FM-5p
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 13:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kWk2i-0003O1-MO
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 13:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kWk2f-0002Gy-R7
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 13:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603647772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nt4yu74PNNgWzzbIDY91bx2x4hmZ8zUvdedSGYCdyeY=;
 b=bKP23ZihFed8L/ikX5Bj3dFBchktngVsAjZAYRwcyzJDXrAM9ID/PMmyaWjd2HcFPiz0ed
 S+OxjZ/+qiUWYuCkTgD/zo55wDT9khNSAijQZ2oGA9SCgahtRmlSAx7ldliBQ7NER+35nM
 iYK0sVp96soElMWfY5niFdo283rehCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-o209Qtz7MpWKTA00MdZD6w-1; Sun, 25 Oct 2020 13:42:48 -0400
X-MC-Unique: o209Qtz7MpWKTA00MdZD6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A819D1006C8B;
 Sun, 25 Oct 2020 17:42:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B9041A3D7;
 Sun, 25 Oct 2020 17:42:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DEFE5113865F; Sun, 25 Oct 2020 18:42:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/6] qemu-storage-daemon: QAPIfy --chardev
References: <20201023101222.250147-1-kwolf@redhat.com>
 <20201023103603.GG445638@redhat.com>
 <87blgtoybe.fsf@dusky.pond.sub.org>
 <ae2ffc01-84e3-70bc-c764-b9a69eba6b92@redhat.com>
Date: Sun, 25 Oct 2020 18:42:42 +0100
In-Reply-To: <ae2ffc01-84e3-70bc-c764-b9a69eba6b92@redhat.com> (Paolo
 Bonzini's message of "Fri, 23 Oct 2020 18:08:19 +0200")
Message-ID: <878sbutd65.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 11:55:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 23/10/20 15:40, Markus Armbruster wrote:
>>>
>>> The benefit of the user creatable object approach is that we dont
>>> have to add custom CLI args for different types of object, nor write
>>> code to populate QOM from QAPI. The downside is that we're divorced
>>> from the QAPI schema, so loose introspection, and have a different
>>> type of tedious boilerplate code to write.
>>
>> Loss of QAPI introspection is the killer.
>> 
>> We have QOM introspection, but it's far too weak to serve as
>> replacement.  Besides, two introspection facilities is one too many.
>
> Wouldn't Eduardo+Kevin's work on object-add provide that too?

Yes, the issue "replacing chardev-add by object-add loses QAPI
introspection" evaporates when object-add becomes QAPI-introspectable.

>> Nevertheless, we need Kevin's work now to get a decent storage daemon
>> CLI while that's still easy to do.  We'll have to promise stability
>> soon, and then changes get much harder.
>
> I think we haven't answered the question of whether qsd needs a CLI at all.
>
> I looked recently at qemu_init and it struck me that, in principle, the
> only _really_ necessary command line options for QEMU are -sandbox,
> -name and possibly -trace (only to be able to trace the monitor).  For
> everything else, one could use LISTEN_FDS socket activation mechanism,
> or if there's no LISTEN_FDS environment variable open a QMP socket on
> stdin/stdout.

Nobody argues this can't be done.  Some of us argue it should not be
done :)

> For qemu-standard-daemon, that would be _really_ true and not just in
> principle I understand that having a command-line can be useful to
> developers as it's less unwieldy than JSON, but why does it have to be
> stable?

Let me split this into multiple questions:

1. Does qsd need a CLI beyond whatever is needed to provide QMP?

2. If yes, does it need to be stable?

3. Does it need to be machine-friendly?

4. Does it need to be human-friendly?

5. What does it mean to be human-friendly?

I'd expect Kevin to answer question 1. and 4. with an emphatic yes.  I
concur, because without a usable CLI, ad hoc usability is awful.  My
idea of "usable" is probably less demanding than Kevin's, but that's
question 5 already.

The step from a QMP command that returns nothing to machine-friendly CLI
option is almost trivial: -blockdev with a JSON argument proves it.
This makes me answer 3. with "why not?", and 2. with "this
machine-friendly interface is stable by construction".

We already paid for the step from machine-friendly CLI to a slightly
more human-friendly CLI: -blockdev with a dotted keys argument proves
it.  This makes me answer 4. with "why not / why override the qsd
maintainer?"

Question 5. is open-ended.  I think a truly human-friendly CLI will take
extra work, similar to how HMP does.  I believe it can be done with less
overhead than HMP has today.  I don't plan to sink a lot of time into it
myself, at least not in the immediate future.

>          Could we default to only 2-3 command-line options in the same
> fashion, and only accept --blockdev and friends if the user starts the
> command line with "qemu-storage-daemon --i-am-not-a-script"?

Making people type --i-am-not-a-script is begging for getting pelted
with vegetables at the next non-virtual KVM Forum.

I think what you're trying to accomplish is to tell a program off when
it uses a part of the CLI programs should not use.  My "Configurable
policy for handling deprecated interfaces" series can grow to do exactly
that, but it's opt-in (because I don't fancy getting pelted with
vegetables).


