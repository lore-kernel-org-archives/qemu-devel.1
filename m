Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26E5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAA42078B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHOKa0hC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAA42078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtZGj-0000wL-MZ
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 12:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtZG9-0000WY-9h
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:18:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37775
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtZG6-00031n-6G
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594311528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ByT3+9XzxBI/T1x9+9cI+wWAbLp5p4KbxqSVDfKjIg=;
 b=iHOKa0hCjUNZgA9VCe4jjQ+TH50RHpwCfxhUJWsWkpBmGRG4TnefP1YDVhCWnTBOScj8bI
 jXicfCMgIQTwN9U/p+zZLIzBrZ46JgQ1Hc71yF9Vo5ekOT9BNspZWMgn69UQy5a5Mzrwy/
 9zNM65aV0LnEDXjfao1NPGUzgeiPBvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-ruxwdub1PayXfvKgvPPe0w-1; Thu, 09 Jul 2020 12:18:45 -0400
X-MC-Unique: ruxwdub1PayXfvKgvPPe0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8317107ACCA
 for <qemu-devel@nongnu.org>; Thu,  9 Jul 2020 16:18:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B28DB1001B07;
 Thu,  9 Jul 2020 16:18:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 290A41132FD2; Thu,  9 Jul 2020 18:18:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] tests: improve performance of device-introspect-test
References: <20200709112857.3760116-1-berrange@redhat.com>
 <1b401730-4a54-d42f-a069-2125bd71e1f1@redhat.com>
 <20200709115906.GM3753300@redhat.com>
 <b474592d-ab56-eef7-b340-df9881f3327c@redhat.com>
Date: Thu, 09 Jul 2020 18:18:43 +0200
In-Reply-To: <b474592d-ab56-eef7-b340-df9881f3327c@redhat.com> (Laurent
 Vivier's message of "Thu, 9 Jul 2020 14:14:40 +0200")
Message-ID: <87tuygr7a4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:02:51
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
Cc: Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> writes:

> On 09/07/2020 13:59, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, Jul 09, 2020 at 01:44:45PM +0200, Laurent Vivier wrote:
>>> On 09/07/2020 13:28, Daniel P. Berrang=C3=A9 wrote:
>>>> Total execution time with "-m slow" and x86_64 QEMU, drops from 3
>>>> minutes 15 seconds, down to 54 seconds.
>>>>
>>>> Individual tests drop from 17-20 seconds, down to 3-4 seconds.
>>>>
>>>> The cost of this change is that any QOM bugs resulting in the test
>>>> failure will not be directly associated with the device that caused
>>>> the failure. The test case is not frequently identifying such bugs
>>>> though, and the cause is likely easily visible in the patch series
>>>> that causes the failure. So overall the shorter running time is
>>>> considered the more important factor.
>>>
>>> You don't report the test to test_device_intro_none() and
>>> test_device_intro_abstract(): is it intended ?
>>=20
>> Since neither of those tests will result in any device being created the=
re
>> didn't seem any point in chceking the qtree output.
>>=20
>> IIUC, both of those tests should result in an error being reported from
>> the device_add command, but I see nothing actually validates that is the
>> case.=20
>
> I think the purpose of these tests is precisely to ensure nothing is
> created. This is why they check the qtree and not the reported error.
>
> Markus?

Before I answer the question, let me provide a bit of background.

The tests we're discussing exercise QMP command device-list-properties.
We're trying to catch two kinds of bugs:

* device introspection crashes or hangs outright, and

* device introspection has unwelcome side effects.

We're vulnerable to such bugs since device introspection has to create
and destroy an instance (consequence of QOM's design), and the device
code that gets run on creation and destruction can do anything.

To catch crashs or hangs, we execute one introspection, throwing away
its result.

Catching general side effects is impossible, so we instead catch special
side effects that (a) have a history of actual bugs, and (b) are easy to
observe: changes to the qdev tree visible in info qtree, and changes to
the QOM composition tree visible in info qom-tree.

Now I'm ready to answer the question.

test_device_intro_none() covers introspection of nonexistent device type
"nonexistent".  device-list-properties is expected to fail without
creating a device instance, let alone run device code.

test_device_intro_abstract() covers introspection of abstract device
type "abstract".  device-list-properties is again expected to fail
without creating a device instance.

The test neglects to cover "type exists, but is not a device" (my
fault).  Same thing.

In all these cases, side effects on "info qtree" and "info qom-tree" in
the (tiny amount of) generic code they run are theoretically possible,
but vanishingly unlikely.  If generic code ever gets confused enough to
somehow create an instance, all bets are off, of course.

Daniel's patch loses us some insurance against this kind of confusion.
Do we care?

I guess the insurance is nice to have when it costs basically nothing.


