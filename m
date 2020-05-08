Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8768C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7359E249A4
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyZuUjrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7359E249A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2kU-0007us-CO
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jX2d3-0003eh-6J
 for qemu-devel@nongnu.org; Fri, 08 May 2020 09:01:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51418
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jX2cx-0000cK-JH
 for qemu-devel@nongnu.org; Fri, 08 May 2020 09:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588942876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9bv+IvwU1JVdJT6Na2PKEdPF9l/Chz715FKIVQ4vTk=;
 b=gyZuUjrDeXFxO2hIfUoBwyY2FVFJU3e1hwEAVeLczRQi93QmX1oDY+EETMll2b5Cd219J9
 5tmPTv3bUtenPG+Ov6qyNKnWzKLetaV4HA/zU6iMRNzU1qHw6NhtJv35buoNzKv9XKtssD
 Q3UB0M5qctmClJWOsPicBbesQtIcqXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-ATqexkDjN9OE73ss6oPNbw-1; Fri, 08 May 2020 09:01:14 -0400
X-MC-Unique: ATqexkDjN9OE73ss6oPNbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D258EC1A9;
 Fri,  8 May 2020 13:01:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 696F31002380;
 Fri,  8 May 2020 13:01:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E468611358BC; Fri,  8 May 2020 15:01:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v4 00/34] Configurable policy for handling deprecated
 interfaces
References: <20200317115459.31821-1-armbru@redhat.com>
 <20200504082439.GC2102825@angien.pipo.sk>
Date: Fri, 08 May 2020 15:01:05 +0200
In-Reply-To: <20200504082439.GC2102825@angien.pipo.sk> (Peter Krempa's message
 of "Mon, 4 May 2020 10:24:39 +0200")
Message-ID: <874ksqy41a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com,
 marcandre.lureau@gmail.com, libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Krempa <pkrempa@redhat.com> writes:

> On Tue, Mar 17, 2020 at 12:54:25 +0100, Markus Armbruster wrote:
>> This series extends QMP introspection to cover deprecation.
>> Additionally, new option -compat lets you configure what to do when
>> deprecated interfaces get used.  This is intended for testing users of
>> the management interfaces.  It is experimental.
>>=20
>> -compat deprecated-input=3D<in-policy> configures what to do when
>> deprecated input is received.  Available policies:
>>=20
>> * accept: Accept deprecated commands and arguments (default)
>> * reject: Reject them
>> * crash: Crash
>
> I've noticed that the 'crash' option doesn't manage to log the reason to
> stderr. Relevant section of libvirt's log file which agregates the
> stderr/out
>
> 2020-04-30 13:24:22.006+0000: 2072883: debug : virCommandHandshakeChild:4=
18 : Handshake with parent is done
> char device redirected to /dev/pts/0 (label charserial0)
> 2020-04-30 13:24:31.879+0000: Domain id=3D4 is tainted: custom-monitor
> 2020-04-30 13:24:32.330+0000: shutting down, reason=3Dcrashed
>
> 'handshake' line is last of libvirt's messages pre-start of the qemu
> process. 'char device redirected' is reported by qemu. 'domain is
> tainted' is added by libvirt when I've issued the deprecated API via
> virsh qemu-monitor-command. 'reason=3Dcrashed' is added by libvirts VM
> shutdown hanlder.

I'm up to my ears in QOM right now.  I'd like to follow up when I pivot
back to QAPI/QMP.  Please pester me if that takes too long.

>>=20
>> -compat deprecated-output=3D<out-policy> configures what to do when
>> deprecated output is sent.  Available output policies:
>>=20
>> * accept: Emit deprecated command results and events (default)
>> * hide: Suppress them
>>=20
>> For now, -compat covers only deprecated syntactic aspects of QMP.  We
>> may want to extend it to cover semantic aspects, CLI, and experimental
>> features.
>>=20
>> PATCH 01-04: Documentation fixes
>> PATCH 05-10: Test improvements
>> PATCH 11-24: Add feature flags to remaining user-defined types and to
>>       =09     struct members
>> PATCH 25-26: New special feature 'deprecated', visible in
>>       =09     introspection
>
> These are cool. I've added support for verifying that any command
> excercised by the libvirt unit test suite is not deprecated, or we at
> least know that it is and have a replacement.
>
> https://www.redhat.com/archives/libvir-list/2020-April/msg01444.html

Awesome!

>> PATCH 27-34: New -compat to set policy for handling stuff marked with
>>       =09     feature 'deprecated'
>
> While implementing support for this feature I noticed that it's
> impossible for libvirt to detect that it's available. The idea is to
> make a developer-centred setting in our config which will enable the
> compat setting if available and ignore it if not available to prevent us
> having to fiddle with the settings when testing various qemu versions.

Again, I'd like to follow up when I pivot back to QAPI/QMP.


