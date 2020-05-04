Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA830C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342FE206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKsBMVLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342FE206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVd1W-0002CK-5s
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVd0d-0000p2-10
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:27:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48151
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVd0b-0003HI-Ow
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588606072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aM3FFIxuypOBpAj9dKWKuwfbR4vJ0hFFnI6pitA5jjw=;
 b=DKsBMVLdmE0SeTTzmkJr9qwFSlorTGVVeSA1xD0r1EDTaAOPIiSak4glRdyfBh0pbnUd+R
 XP7KTiB5R5gJ3POWfGjMndD7DXFKHZZ0Rk+nxe5oxNZRHhOFmU91aqezEVc5EYrnzh72Hd
 2TUPBTq9uVtChKwOZujDtcFEwoKlnqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-mwO2Ir-zO-m4mqjP42kUbw-1; Mon, 04 May 2020 11:27:40 -0400
X-MC-Unique: mwO2Ir-zO-m4mqjP42kUbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94B5919200C0
 for <qemu-devel@nongnu.org>; Mon,  4 May 2020 15:27:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63FFC5C1B2;
 Mon,  4 May 2020 15:27:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E1E0211358BC; Mon,  4 May 2020 17:27:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 02/17] qom: Clean up inconsistent use of gchar * vs. char *
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-3-armbru@redhat.com>
 <79e0bb4c-d524-994d-865e-3422702f44db@redhat.com>
 <87y2qb6i3l.fsf@dusky.pond.sub.org>
 <20200504093256.GE115875@redhat.com>
Date: Mon, 04 May 2020 17:27:37 +0200
In-Reply-To: <20200504093256.GE115875@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Mon, 4 May 2020 10:32:56 +0100")
Message-ID: <87lfm7zpna.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Sat, May 02, 2020 at 07:06:38AM +0200, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>=20
>> > On 4/28/20 11:34 AM, Markus Armbruster wrote:
>> >> Uses of gchar * in qom/object.h:
>> >>
>> >
>> > Nice audit.  I don't know if we can blindly assume that 'gchar' is a
>> > (stupid) typedef to 'char', or if they can ever differ, but avoiding
>> > gchar where possible always makes sense to me.
>>=20
>> GLib's "basic types" are one of the most misguided aspects of its
>> interface.
>
> There is work to re-define them in terms of stdint.h
>
>    https://gitlab.gnome.org/GNOME/glib/issues/1484
>
> with long term possible plan to deprecate them

Long overdue.

>> Quote https://developer.gnome.org/glib/stable/glib-Basic-Types.html
>>=20
>>     GLib defines a number of commonly used types, which can be divided
>>     into several groups:
>>=20
>>         New types which are not part of standard C (but are defined in
>>         various C standard library header files) =E2=80=94 gboolean, gss=
ize.
>>=20
>> Stuck in the 90s.
>
> snip
>
>> Purge with fire.
>
> Note  gboolean is a trap door. Any code integrating with GLib APIs that
> use "gboolean" in their signature must keep using that. It is *NOT*
> interchangable with the "bool" from stdbool.h.
>
>   "gboolean" is a typedef for "gint"
>   "bool" is a "_Bool" which is just a single byte.
>
> Also note TRUE and true are not the same value.
>
>   'TRUE' is bitwise !FALSE
>   'true' is 1

Yes, gboolean is the worst of the lot, and pretty much impossible to
eliminate.


