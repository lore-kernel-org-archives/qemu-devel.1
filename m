Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73001C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8F920656
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ko3krrzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8F920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0lzb-0002qQ-EF
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 09:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0lyp-0002Gw-VM
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:18:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52120
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0lyn-0008Kk-W0
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596028725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y1drjgg9NtXLdxWfJBGKkhi9KaG1wzOnYdux8JvmSoQ=;
 b=Ko3krrzjjY/wuTfpY5xZbNnFMobFvlDoMyjaoQq9SDtSIvwmKeaEb36rz1fJs/scXNLB0k
 Tcn2/C2JJtEAce3FfoMOYII7Tce8S4927ou6051/hAQRlz217DBdwYqrHQ7WX65HfEZxW/
 EIUExN4I1lyYl+zcEqQgWFlaw7FL7vM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-Lrw6NVzSMy2OtK2PiK4y6Q-1; Wed, 29 Jul 2020 09:18:41 -0400
X-MC-Unique: Lrw6NVzSMy2OtK2PiK4y6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABE5B80183C;
 Wed, 29 Jul 2020 13:18:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5423E8A177;
 Wed, 29 Jul 2020 13:18:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E38E41132FD2; Wed, 29 Jul 2020 15:18:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: sysbus_create_simple Vs qdev_create
References: <87lfjkvo81.fsf@dusky.pond.sub.org>
 <20200716222130.GO1274972@habkost.net>
 <87tuy6k9pa.fsf@dusky.pond.sub.org>
 <20200717162312.GR1274972@habkost.net>
 <87r1t6hc0f.fsf@dusky.pond.sub.org>
 <20200720155955.GV1274972@habkost.net>
 <87v9ihbe6u.fsf@dusky.pond.sub.org>
 <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com>
 <87lfj4f6nz.fsf@dusky.pond.sub.org>
 <759959d1-f320-734a-ac5e-a60db6b1bc23@redhat.com>
 <20200728224733.GP225270@habkost.net>
 <422d7879-3fdc-d38e-259f-2477b9d3c169@redhat.com>
Date: Wed, 29 Jul 2020 15:18:38 +0200
In-Reply-To: <422d7879-3fdc-d38e-259f-2477b9d3c169@redhat.com> (Paolo
 Bonzini's message of "Wed, 29 Jul 2020 11:54:35 +0200")
Message-ID: <87zh7i5uj5.fsf@dusky.pond.sub.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Philippe =?utf-8?Q?Mathieu-Dau?= =?utf-8?Q?d=C3=A9?= <philmd@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/07/20 00:47, Eduardo Habkost wrote:
>> On Tue, Jul 28, 2020 at 07:38:27PM +0200, Paolo Bonzini wrote:
>>> On 28/07/20 09:19, Markus Armbruster wrote:
>>>>> the composition tree generally mirrors things that are born and die
>>>>> at the same time, and creating children is generally reserved to the
>>>>> object itself.
>>>>
>>>> Yes.  Notable exceptions: containers /machine/peripheral,
>>>> /machine/peripheral-anon, /machine/unattached.
>>>
>>> And /objects too.  Apart from /machine/unattached, all these dynamic
>>> objects are created by the monitor or the command line.
>>>
>>>>>                 Children are usually embedded directly in a struct, for
>>>>> example.
>>>>
>>>> We sometimes use object_new() + object_property_add_child() instead.
>>>> Extra indirection.  I guess we'd be better off without the extra
>>>> indirection most of the time.  Implementation detail.
>>>>
>>>> We sometimes use object_new() without object_property_add_child(), and
>>>> have qdev_realize() put the device in the /machine/unattached orphanage.
>>>> Meh.  I guess the orphanage feature exists to make conversion to QOM
>>>> slightly easier.  Could we ban its use for new boards at least?
>>>
>>> Banning perhaps is too strong, but yes /machine/unattached is an
>>> anti-pattern.
>>>
>>>>> 3) accessing the QOM graph is slow (it requires hash table lookups,
>>>>> string comparisons and all that), so the pointers that cache the
>>>>> parent-child links are needed for use in hot paths.
>>>>
>>>> True, but only because QOM's design opts for generality, efficiency be
>>>> damned :)
>>>
>>> Remember that QOM's essential feature is the visitors: unlike GObject,
>>> QOM is not targeted at programming languages but rather at CLI and RPC.
>> 
>> This is surprising to me.  I never thought QOM was targeted at
>> the CLI or RPC.  (Every single property mentioned in this message
>> don't seem to be related to the CLI or RPC.)
>
> See https://www.mail-archive.com/qemu-devel@nongnu.org/msg674110.html
> for an explanation.
>
>> About the visitors: I always had the impression that usage of
>> visitors inside QOM is unnecessary and avoidable (compared to
>> QAPI, where the visitors are an essential feature).
>
> But as I explained in that other message, the main difference between
> QOM and something like GObject is eactly the QAPI integration, and that
> is where CLI and RPC enter the game: for example the possibility to
> share code between -object and HMP object_add on one side and QMP
> object-add on the other side.
>
> Even code riddled by backwards-compatibility special cases, such as
> -accel and -machine, can share code between themselves and -object to
> some extent; this is thanks to functions such as object_property_parse,
> whose parsing is deferred to visitors and hence to QAPI.

QOM relies on QAPI visitors to access properties.  There is no
integration with the QAPI schema.

Going through a visitor enables property access from QMP, HMP and CLI.

Access from C *also* goes through a visitor.  We typically go from C
type to QObject and back.  Comically inefficient (which hardly matters),
verbose to use and somewhat hard to understand (which does).

Compare to what QOM replaced: qdev.  Properties are a layer on top of
ordinary C.  From C, you can either use the C layer (struct members,
basically), or the property layer for C (functions taking C types, no
conversion to string and back under the hood), or the "text" layer
(parse from text / format to text).

My point is not that qdev was great and QOM is terrible.  There are
reasons we replaced qdev with QOM.  My point is QOM doesn't *have* to be
the way it is.  It is the way it is because we made it so.

>> Do we really need need QOM children to be accessible using the QOM
>> property API?
>> 
>> Using the same code for both user-configurable properties and for
>> the list of children of a QOM object might have saved some time
>> years ago, but I'm not sure this is still a necessary or useful
>> abstraction.
>
> The main thing we get from it is that the QOM paths treat children and
> links the same, and links are properties.  To be honest it's not a
> feature that is very much developed, so perhaps we can remove it but we
> need to evaluate the impact of losing it.

I've long had the nagging feeling that if we had special-cased
containers, children and links, we could have made a QOM that was easier
to reason about, and much easier to integrate with a QAPI schema.


