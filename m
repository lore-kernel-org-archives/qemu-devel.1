Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A621C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D891925581
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLt3R6Xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D891925581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwA8-0008W8-Ok
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jpw9L-0007yv-70
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:56:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jpw9J-0007a7-F4
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593446208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oYI8XyX7jYhB71T5zzgqgOklxfvNaB4b6CGYYEoFDE0=;
 b=TLt3R6Xl6X1oNxMvC1wBEMVbnDhVCdiPlekS52A4w4i7SL6VFS1QQEY1na75UKiXMdUBIA
 vKKlqHAiEif+Qw7KPP8ssHWc7rPlSgH6ecsf/vkf/OdU+SIrWCuotg/0870a9RRHnFp0Pg
 FJsnm9ZZKijgb8vGNLVw3m45kRvzvtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-hKvtX-AXPhCqJI9S-PZfhg-1; Mon, 29 Jun 2020 11:56:46 -0400
X-MC-Unique: hKvtX-AXPhCqJI9S-PZfhg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBF3A19200CE;
 Mon, 29 Jun 2020 15:56:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5171E9CFE7;
 Mon, 29 Jun 2020 15:56:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A9AB111384A6; Mon, 29 Jun 2020 17:56:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v2 2/4] smbus: Fix spd_data_generate() error API violation
References: <20200422134815.1584-1-armbru@redhat.com>
 <20200422134815.1584-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004221622140.19234@zero.eik.bme.hu>
 <0af0e0f0-8127-da83-d9d2-89a3fe28f778@redhat.com>
 <alpine.BSF.2.22.395.2004222053070.22480@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006261315070.94870@zero.eik.bme.hu>
 <87k0ztrn9m.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2006271320590.53209@zero.eik.bme.hu>
Date: Mon, 29 Jun 2020 17:56:42 +0200
In-Reply-To: <alpine.BSF.2.22.395.2006271320590.53209@zero.eik.bme.hu>
 (BALATON Zoltan's message of "Sat, 27 Jun 2020 13:30:07 +0200 (CEST)")
Message-ID: <87lfk5n9vp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
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
Cc: qemu-ppc@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Sat, 27 Jun 2020, Markus Armbruster wrote:
>> Quick reply without having thought through the issues at all: I'm not
>
> Does that mean you'll reply later with more detail or this is all you
> had to say about this? (Just to know if I should wait for another
> reply.)

Not sure I can find the time before the soft freeze.  Best not to wait
for me.

>> opposed to you doing work to enable additional or even arbitrary memory
>> sizes where these actually work.  I'm first and foremost opposed to me
>> wasting time on "improving" code that is not used for anything.  That's
>> why I dumbed down spd_data_generate().
>
> It was used by sam460ex until moving ram allocation to memdev broke it.
>
>> Secondly, I'm opposed to QEMU "correcting" user configuration.  I want
>> QEMU do exactly what it's told, and fail with a clear error message when
>> that is not possible.  The error message may include hints for the user
>> on how to correct the configuration.
>
> I don't agree with that. It's already hard enough for non-expert users
> to figure out the needed command line switches, making that even
> harder by throwing back an error for everything that could work just
> not exactly specified is needlessly annoying them further. To the
> point of chasing them away from using QEMU. A lot of people prefer
> VMWare or VirtualBox for this reason and only try QEMU if there's no
> other way.

We don't have to agree on everything.  I'm not the QEMU CLI dictator.
The status quo is pretty clear, though:

    $ qemu-system-ppc64 -help
    [...]
    -m [size=]megs[,slots=n,maxmem=size]
                    configure guest RAM
                    size: initial amount of guest memory
    [...]

It says "Initial amount of guest memory", not "Approximate amount of
guest memory" or something like that.

If we decide we want to change it from "Initial amount of guest memory"
to some "do what I mean" behavior, then that behavior needs to be
documented.

Moreover, if DWIM is appropriate for one machine, it's probably
appropriate for all of them.  The CLI should be as consistent as we can
make it across machines.


