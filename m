Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC48C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 06:45:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF9820674
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 06:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CU32wuq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF9820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZr54-0007zv-ST
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 01:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZr3k-0006vs-6P
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZr3i-0000Sw-Jb
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:44:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZr3i-0000RF-Fc
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574837057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w265chdTqMs+ixkwjHqa1aAQU6GyIok+U9D1Zxr1EP0=;
 b=CU32wuq2CLhC3IvcNuFcY9n/IdnUk/UzCiai+Js+AZwPca+TjAEboAO2kHYYLuTWU4rZmC
 ktD9+/vzKgGCCnxj74a9K8fTOPnU5kObm9W6fUBaA5/wnQhVIuCKY/swyDqcoeuapN8n+2
 3KOGmLrai9L8o+UzXAnNltQUnqWI5SE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-POEZKRUJMJKKPtS4JIWfhw-1; Wed, 27 Nov 2019 01:44:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE714802C82;
 Wed, 27 Nov 2019 06:44:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CBC15D9E2;
 Wed, 27 Nov 2019 06:44:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C0D801138606; Wed, 27 Nov 2019 07:44:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v17 01/14] util/cutils: Add Add qemu_strtold and
 qemu_strtold_finite
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-2-tao3.xu@intel.com>
 <8088b091-8f7c-a637-6333-e7c40935974f@intel.com>
 <87a78ispyc.fsf@dusky.pond.sub.org>
 <aaac6a06-0484-ceb7-7230-77b8362744b0@intel.com>
Date: Wed, 27 Nov 2019 07:44:07 +0100
In-Reply-To: <aaac6a06-0484-ceb7-7230-77b8362744b0@intel.com> (Tao Xu's
 message of "Wed, 27 Nov 2019 12:37:24 +0800")
Message-ID: <874kyplsy0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: POEZKRUJMJKKPtS4JIWfhw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "sw@weilnetz.de" <sw@weilnetz.de>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> On 11/26/2019 9:54 PM, Markus Armbruster wrote:
>> Tao Xu <tao3.xu@intel.com> writes:
>>
>>> Hi Markus,
>>>
>>> Do you have any comments on this patch and 02/14 05/14 06/14.
>>> Thank you!
>>
>> These provide a new QAPI built-in type 'time'.  It's like 'uint64' with
>> an implied nanoseconds unit, and additional convenience syntax in the
>> opts visitor and the keyval qobject input visitor.  Patterned after
>> 'size'.
>>
>> The only use of 'time' so far is member @latency of NumaOptions member
>> @hmap-lb.  Uses of that:
>>
>> * QMP command set-numa-node
>>
>>    The convenience syntax does not apply, as QMP uses the regular qobjec=
t
>>    input visitor, not the keyval one.
>>
>> * CLI option -numa
>>
>>    We first parse the option argument with QemuOpts, then convert it to
>>    NumaOptions with the opts visitor.
>>
>>    The new built-in type 'time' gets used in -numa hmat-lb,...,latency=
=3DT
>>
>> Questions / observations:
>>
>> * The keyval qobject input visitor's support for 'time' appears to be
>>    unused for now.
>>
>> * What's the anticipated range of values for -numa
>>    hmat-lb,...,latency=3DT?  I'm asking because I wonder whether we real=
ly
>>    need convenience syntax there.
>>
>> * Sure you want fractions?
>>
>>    Supporting fractions for byte counts (e.g.  1.5G) has been a mixed
>>    blessing, to put it charitably.
>>
>>    Use of fractions that aren't representable as double is not advisable=
.
>>    For instance, 1.1G is 1181116006 bytes rounded from
>>    1181116006.4000001.  Why would anybody want that?
>>
>>    Use of "nice" fractions is unproblematic, but the additional
>>    convenience is rather minor.  Is being able to write 1536M as 1.5G
>>    worth the trouble?  Meh.
>>
>>    With "metric" rather than "binary" suffixes, fractions provide even
>>    less convenience: 1.5ms vs. 1500us.
>>
>>    The implementation is limited to 53 bits of precision, which has been
>>    a source of confusion.  Even that has arguably taken far more patches
>>    than it's worth.  We're now talking about more patches to lift the
>>    restriction.  Meh.
>>
>>    What exactly are we trying to achieve by supporting fractions?
>>
>> * What about all the other time-valued things in the QAPI schema?
>>
>>    There are many more, and some of them are also visible in CLI or HMP.
>>    By providing convenience syntax for just -numa hmat-lb,...,latency=3D=
T,
>>    we create inconsistency.
>>
>>    To avoid it, we'd have to hunt down all the others.  But some of them
>>    aren't in nanoseconds.  Your new built-in type 'time' is only
>>    applicable to the ones in nanoseconds.  Do we need more built-in
>>    types?
>>
>> This series is at v17.  I really, really want to tell you it's ready for
>> merging.  But as you see, I can't.
>>
>> Maybe the convenience syntax is a good idea, maybe it's a bad idea.  But
>> it's definitely not a must-have idea.
>>
>> If you want to pursue the idea, I recommend to split this series in two:
>> one part without the convenience, and a second part adding it.
>> Hopefully, we can then merge the first part without too much fuss.  The
>> second part will have to deal with the questions above.
>>
>> You can also shelve the idea, i.e. do just the first part now.  It's
>> what I'd do.
>>
> Thank you for your suggestion and support! Considering ACPI HMAT can
> only store unsigned integer data, and for the memory latency
> nanoseconds is enough. So we can use integer for latency data. I am
> wondering if we can use this solution:
>
> * Still add builtin type time, but use qemu_strtou64() to parse.
> * Still refactor do_strtosz() to support suffixes list, but add a
> extra parameter to decide use qemu_strtou64() or qemu_strtod_finite(),
> so time use qemu_strtou64() and qemu_strtod_finite()

We'd still have to grapple with "What about all the other time-valued
things in the QAPI schema?"

> * Second part dealing with the questions.
>
> Then the only influence on HMAT patch is we need add a comments to
> tell user to input integer.

Considerung we're already at v17, I recommend to keep the first part as
focused as possible.  Since plain integer types are good enough for time
values elsewhere in our external interfaces, they'll do for HMAT
latency, too.

Once the first part is accepted, you're free to tackle the wider problem
of providing convenience syntax for time values.  Fair warning: I
consider this a swamp.


