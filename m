Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCAAC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57271215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fw3qBNIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57271215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6fL-0001Cs-At
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iT6dU-00085B-Lx
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iT6dT-0007ys-Ee
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:57:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42209
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iT6dT-0007ye-Ar
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573228638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1SYoTVDsJbaU4D7fQl4/1zDQhYwuZVtjgHeBmFZwYms=;
 b=fw3qBNItyWC3AQPzaLorp1/mo5TiCe6rAOiljH0MJ5c4PVt82P1MvzgIfHrO0ah+fo2Aay
 vEVJjiuumC8Q48SMRge8QTMFoHfvRBQzWQyBUD/UzCc0Zq5BJrMsstuMaVwPrAu3vDDxYT
 56Fod2asc9IYtdZGdgdQbVTp9DPcaOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-K0yeljMiMRK40kV24uVxkw-1; Fri, 08 Nov 2019 10:57:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD39E800686;
 Fri,  8 Nov 2019 15:57:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EC305DA7F;
 Fri,  8 Nov 2019 15:57:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E924011385C9; Fri,  8 Nov 2019 16:57:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 08/18] qemu-storage-daemon: Add --export option
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-9-kwolf@redhat.com>
 <5d920618-219a-6dd2-5823-3fc3f09e6a61@redhat.com>
 <20191106133458.GB7548@dhcp-200-226.str.redhat.com>
Date: Fri, 08 Nov 2019 16:57:09 +0100
In-Reply-To: <20191106133458.GB7548@dhcp-200-226.str.redhat.com> (Kevin Wolf's
 message of "Wed, 6 Nov 2019 14:34:58 +0100")
Message-ID: <877e4a744q.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: K0yeljMiMRK40kV24uVxkw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 06.11.2019 um 14:11 hat Max Reitz geschrieben:
>> On 17.10.19 15:01, Kevin Wolf wrote:
>> > Add a --export option to qemu-storage-daemon to export a block node. F=
or
>> > now, only NBD exports are implemented. Apart from the 'type' option
>> > (which is the implied key), it maps the arguments for nbd-server-add t=
o
>> > the command line. Example:
>> >=20
>> >     --export nbd,device=3Ddisk,name=3Dtest-export,writable=3Don
>> >=20
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > ---
>> >  qapi/block.json       | 27 +++++++++++++++++++++++++++
>> >  qemu-storage-daemon.c | 31 +++++++++++++++++++++++++++++++
>> >  2 files changed, 58 insertions(+)
>>=20
>> Would it be better to collect the BlockExports in a list and work on it
>> after all arguments have been parsed?  As it is, it=E2=80=99s important =
that
>> users define block devices and things like NBD servers before --export.
>>  Yes, I know, that=E2=80=99s exactly how it works with qemu, but is that=
 really
>> the best way?
>
> It's actually not how QEMU works generally. QEMU collects things in
> QemuOptsLists and then tries to interpret them in the right order. Of
> course, we never get the order actually right, which results in constant
> reshuffling of the order of initialisations in vl.c.
>
> It also means that vl.c (!) has a list of -object types that need to be
> created early so that other backends can make use of them, and of those
> types that actually depend on a backend already being present (see
> object_create_initial() for details).
>
> I think it's much cleaner to simply use the order in the command line
> instead of adding magic that tries to resolve (and fails at actually
> resolving) all the dependencies.

Seconded.

The "process arguments strictly left to right" strategy is also visible
in PATCH 02 and 05.

>                                  I seem to remember that this was in
> fact one of the things Markus keeps mentioning he would change if he
> were to rewrite the QEMU command line parser from scratch without
> compatibility requirements.

E.g.
Message-ID: <87poomg77m.fsf@dusky.pond.sub.org>
https://lists.nongnu.org/archive/html/qemu-devel/2016-09/msg00163.html


