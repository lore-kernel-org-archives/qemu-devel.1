Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6528C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6A020707
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYGSV0XB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6A020707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHT2-0008Im-0m
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnHSG-0007kT-J9
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:05:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41200
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnHSD-0005Ps-TI
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592813120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qMfk74iK4l6u2z9/YpvJYuNaWVJBuzEVNrXDQoO8/bA=;
 b=gYGSV0XBl7SzSf7B+ntLAjOERfGlQIcgiUB6NdI6MAOh3Ymx+T9Nxi7GkezUILdBQvrNhM
 Na4TOMAOH86Fatuqismrhn/6HsLjXj8IRybzx+QgLNVWGwLTsuH0besSjR0x93gStJyFUL
 FAN61FI4b9WTlwD6ejLXzWNwcl9ReOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-Yn4KbcINOPSgHygpxLGHBQ-1; Mon, 22 Jun 2020 04:05:16 -0400
X-MC-Unique: Yn4KbcINOPSgHygpxLGHBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE981835B40
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 08:05:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B22B6FDD1;
 Mon, 22 Jun 2020 08:05:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AFE15113846D; Mon, 22 Jun 2020 10:05:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] hmp: Make json format optional for qom-set
References: <20200610075153.33892-1-david@redhat.com>
 <87pna0c0pr.fsf@dusky.pond.sub.org>
 <70d42699-f17b-320e-3a21-4454978ca8d6@redhat.com>
Date: Mon, 22 Jun 2020 10:05:11 +0200
In-Reply-To: <70d42699-f17b-320e-3a21-4454978ca8d6@redhat.com> (David
 Hildenbrand's message of "Mon, 15 Jun 2020 09:45:52 +0200")
Message-ID: <87d05rr0eg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

> On 15.06.20 08:17, Markus Armbruster wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> Commit 7d2ef6dcc1cf ("hmp: Simplify qom-set") switched to the json
>>> parser, making it possible to specify complex types. However, with this
>>> change it is no longer possible to specify proper sizes (e.g., 2G, 128M),
>>> turning the interface harder to use for properties that consume sizes.
>>>
>>> Let's switch back to the previous handling and allow to specify passing
>>> json via the "-j" parameter.
>> 
>> Two issues:
>> 
>> 1. Makes qom-get and qom-set inconsistent
>> 
>>    qom-get formats as JSON, always.
>> 
>>    qom-set parses the string visitor's undocumented ad hoc language by
>>    default.  You can make it parse JSON by passing -j.
>
> This is the same language the QEMU cmdline uses, no?

The CLI uses many, many languages.  The string visitor's language may
well be among them; can't tell offhand.

>
>> 
>>    Not a show stopper, but sure ugly.  I feel documentation should point
>>    it out.
>
> Sure, we can fine-tune the documentation. For now we didn't have any
> qom-get users, in contrast to qom-set. Not sure if it makes sense to
> implement the same functionality for qom-get.
>
> For now I can e.g.,
>
> "echo "qom-set vm1 requested-size 256M" | sudo nc -U /var/tmp/mon_src"
>
> then I can
>
> echo "qom-get vm1 requested-size " | sudo nc -U /var/tmp/mon_src
> -> 268435456
>
> which is a value I can punch back into qom-set. At least for sizes this
> works. Not perfect, not bad. Opinions?

It happens to work in this case, because the JSON number returned by
qom-get happens to get parsed the right way by qom-set.

Is this the case for all properties where qom-set isn't deadly due to
issue 2.?  Nobody knows.

>> 2. Rearms the string visitor death trap
>> 
>>    If you try to qom-set a property whose ->set() uses something the
>>    string input visitor doesn't support, QEMU crashes.  I'm not aware of
>>    such a ->set(), but this is a death trap all the same.  Mind, I
>>    didn't actually *look* for such a ->set().  Details:
>
> Thanks. Maybe I am missing something important, but this sounds like we
> are missing a bunch of checks+errors.

The string visitor feels like a quick hack to get something that is
human-friendly.  It provides just enough functionality for its initial
uses.  The trouble is new uses that violate its restrictions are hard to
spot.

In my opinion, what we're really missing a replacement of the
ill-conceived string visitor.  The less it's used, the better.

Since a replacement isn't being worked on, we may have to make it less
dangerous to use.  Patches welcome.

>                                       (wouldn't we be able to crash
> using the QEMU cmdline as well when setting such properties?).

If the string visitor is used there.  Nobody knows.

>>     Subject: Re: [RFC PATCH] qom: Implement qom-get HMP command
>>     Date: Sat, 02 May 2020 08:02:43 +0200 (6 weeks, 2 days, 4 minutes ago)
>>     Message-ID: <87a72q6fi4.fsf@dusky.pond.sub.org>
>>     https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg00178.html
>> 
>>    Since we've had this death trap in the code for a number of years, I
>>    can't call its restoration a show stopper.  It does feel like an
>>    unadvisable risk, though.
>> 
>
> As long as there are no better alternatives to punch in data in the same
> format the QEMU cmdline consumes, I think this is perfectly reasonable.
> No good reason to make a HMP interface harder to use by humans IMHO.

Yes, HMP should be human-friendly.  Not at any cost, though; I reiterate
my conviction that this is an unadvisable risk.

A crash is the most unfriendly response of all.


