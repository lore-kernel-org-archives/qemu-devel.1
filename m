Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE35C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 09:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876372053B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 09:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NH3SF0Cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876372053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ip0-0008J8-RO
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 05:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0inO-0006xN-8N
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 05:54:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0inL-0005m6-2F
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 05:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596016482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nay3RuzQJeWwVdKRGkaWIGNw3CG+Y2B8ADLKPgLMk3E=;
 b=NH3SF0CsW48mfOeGFcvgqVT7cagVa/fgfed1a9+mWRalK/px9j0vMYH4c3x7bnAKd/QS/b
 dV5VqHmNESJnhPJOltsT5FMqP2B2iwXkEH7ANQbKbbnUG522ACTyITWQ8DNbX0w4ZzgOvj
 +bu4aTxCK3yFpFOa3LAjFRpIUxGirEA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-qZy888c_PYq9qUNhkVk-wg-1; Wed, 29 Jul 2020 05:54:38 -0400
X-MC-Unique: qZy888c_PYq9qUNhkVk-wg-1
Received: by mail-wm1-f71.google.com with SMTP id s2so471525wmj.7
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 02:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nay3RuzQJeWwVdKRGkaWIGNw3CG+Y2B8ADLKPgLMk3E=;
 b=OaUTA1XJcApTtYLogV3S4Cy/1bwIjaoaWL7EIvgMFG+TUauhaD049Ox0Ei7KWHSCn2
 iK9Vza8QuBxJx6qz7XdtrGxAHudtaHAoTqiAXm2m3qK0NsdhjYFwPM4BI3H++fcVRoWJ
 8jyLjpbN3TjoiQVaciIvLhtC9JXEMWKxhcHY+67iKtw9NBa4/MQf3MesSQ5jAHpvnvp/
 h95Xfu9U8qjVoOeMYOFtpTfApcQg9z5D+5myA37CL5wg9B8V1I/ZKWbG1F7ss17/T9RQ
 JeN8eGdkXI/O3F7au7EYoKf5byUhNp+DVjjKtXOAkiCyWatL5paRifIqLloHamCU2MUs
 E1ng==
X-Gm-Message-State: AOAM5300paQhBpN0KeLD6aRag5v9XCoR6836wxGqyn7z7C7nu8lsn1PZ
 xc4flWK5IEtHhXE90fVVelGy4sY02PYgMMf5mdsyFOtkBP2AMoJH6De+R7oGJzimWPqCprf1Iqa
 +gkXjFdHsfkDT0hk=
X-Received: by 2002:adf:f806:: with SMTP id s6mr29747481wrp.252.1596016477471; 
 Wed, 29 Jul 2020 02:54:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwFZVqSmU08DSWxEyznJgyN9TClwgG7nFg19yH1w2Y0UzV8s9TcWfc+QeJ9yDuPAFayMe+Cw==
X-Received: by 2002:adf:f806:: with SMTP id s6mr29747467wrp.252.1596016477203; 
 Wed, 29 Jul 2020 02:54:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2943:38b:308c:e0b2?
 ([2001:b07:6468:f312:2943:38b:308c:e0b2])
 by smtp.gmail.com with ESMTPSA id g18sm4692356wru.27.2020.07.29.02.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 02:54:36 -0700 (PDT)
Subject: Re: sysbus_create_simple Vs qdev_create
To: Eduardo Habkost <ehabkost@redhat.com>
References: <87lfjkvo81.fsf@dusky.pond.sub.org>
 <20200716222130.GO1274972@habkost.net> <87tuy6k9pa.fsf@dusky.pond.sub.org>
 <20200717162312.GR1274972@habkost.net> <87r1t6hc0f.fsf@dusky.pond.sub.org>
 <20200720155955.GV1274972@habkost.net> <87v9ihbe6u.fsf@dusky.pond.sub.org>
 <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com>
 <87lfj4f6nz.fsf@dusky.pond.sub.org>
 <759959d1-f320-734a-ac5e-a60db6b1bc23@redhat.com>
 <20200728224733.GP225270@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <422d7879-3fdc-d38e-259f-2477b9d3c169@redhat.com>
Date: Wed, 29 Jul 2020 11:54:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200728224733.GP225270@habkost.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.74; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 03:32:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/20 00:47, Eduardo Habkost wrote:
> On Tue, Jul 28, 2020 at 07:38:27PM +0200, Paolo Bonzini wrote:
>> On 28/07/20 09:19, Markus Armbruster wrote:
>>>> the composition tree generally mirrors things that are born and die
>>>> at the same time, and creating children is generally reserved to the
>>>> object itself.
>>>
>>> Yes.  Notable exceptions: containers /machine/peripheral,
>>> /machine/peripheral-anon, /machine/unattached.
>>
>> And /objects too.  Apart from /machine/unattached, all these dynamic
>> objects are created by the monitor or the command line.
>>
>>>>                 Children are usually embedded directly in a struct, for
>>>> example.
>>>
>>> We sometimes use object_new() + object_property_add_child() instead.
>>> Extra indirection.  I guess we'd be better off without the extra
>>> indirection most of the time.  Implementation detail.
>>>
>>> We sometimes use object_new() without object_property_add_child(), and
>>> have qdev_realize() put the device in the /machine/unattached orphanage.
>>> Meh.  I guess the orphanage feature exists to make conversion to QOM
>>> slightly easier.  Could we ban its use for new boards at least?
>>
>> Banning perhaps is too strong, but yes /machine/unattached is an
>> anti-pattern.
>>
>>>> 3) accessing the QOM graph is slow (it requires hash table lookups,
>>>> string comparisons and all that), so the pointers that cache the
>>>> parent-child links are needed for use in hot paths.
>>>
>>> True, but only because QOM's design opts for generality, efficiency be
>>> damned :)
>>
>> Remember that QOM's essential feature is the visitors: unlike GObject,
>> QOM is not targeted at programming languages but rather at CLI and RPC.
> 
> This is surprising to me.  I never thought QOM was targeted at
> the CLI or RPC.  (Every single property mentioned in this message
> don't seem to be related to the CLI or RPC.)

See https://www.mail-archive.com/qemu-devel@nongnu.org/msg674110.html
for an explanation.

> About the visitors: I always had the impression that usage of
> visitors inside QOM is unnecessary and avoidable (compared to
> QAPI, where the visitors are an essential feature).

But as I explained in that other message, the main difference between
QOM and something like GObject is eactly the QAPI integration, and that
is where CLI and RPC enter the game: for example the possibility to
share code between -object and HMP object_add on one side and QMP
object-add on the other side.

Even code riddled by backwards-compatibility special cases, such as
-accel and -machine, can share code between themselves and -object to
some extent; this is thanks to functions such as object_property_parse,
whose parsing is deferred to visitors and hence to QAPI.

> Do we really need need QOM children to be accessible using the QOM
> property API?
> 
> Using the same code for both user-configurable properties and for
> the list of children of a QOM object might have saved some time
> years ago, but I'm not sure this is still a necessary or useful
> abstraction.

The main thing we get from it is that the QOM paths treat children and
links the same, and links are properties.  To be honest it's not a
feature that is very much developed, so perhaps we can remove it but we
need to evaluate the impact of losing it.

Paolo


