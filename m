Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B86C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C0E21775
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCipQzh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C0E21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUkN7-000561-Bl
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 01:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUkMT-0004SM-Tv
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jUkMS-0004fg-HR
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:06:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60833
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUkMR-0004bq-VT
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588396005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fevKTvZheA4wZDNF82i7BNE3o/b2HRtojl4rmCBgVag=;
 b=eCipQzh24kCE0a2SYdCGi4vygTqUSFKyLKzq+iTY2iRb6om7qm4ch4fS1huHGhBXbChbwF
 pzVxnLXd5xoG9QBm/UDszNVxGeTqdq7fd66tF2aScN2VRUqXtwut1+2xRiWYH6oW4hCpxa
 WVCPbzMEXlPHeM+dzuUK60U9mxkB1NI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-f1iqIdhdMjK2Xj8r3O-aew-1; Sat, 02 May 2020 01:06:40 -0400
X-MC-Unique: f1iqIdhdMjK2Xj8r3O-aew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2FF480183C
 for <qemu-devel@nongnu.org>; Sat,  2 May 2020 05:06:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADB191002388;
 Sat,  2 May 2020 05:06:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2491511358BC; Sat,  2 May 2020 07:06:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 02/17] qom: Clean up inconsistent use of gchar * vs. char *
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-3-armbru@redhat.com>
 <79e0bb4c-d524-994d-865e-3422702f44db@redhat.com>
Date: Sat, 02 May 2020 07:06:38 +0200
In-Reply-To: <79e0bb4c-d524-994d-865e-3422702f44db@redhat.com> (Eric Blake's
 message of "Tue, 28 Apr 2020 12:41:34 -0500")
Message-ID: <87y2qb6i3l.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 01:06:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 4/28/20 11:34 AM, Markus Armbruster wrote:
>> Uses of gchar * in qom/object.h:
>>
>
> Nice audit.  I don't know if we can blindly assume that 'gchar' is a
> (stupid) typedef to 'char', or if they can ever differ, but avoiding
> gchar where possible always makes sense to me.

GLib's "basic types" are one of the most misguided aspects of its
interface.

Quote https://developer.gnome.org/glib/stable/glib-Basic-Types.html

    GLib defines a number of commonly used types, which can be divided
    into several groups:

        New types which are not part of standard C (but are defined in
        various C standard library header files) =E2=80=94 gboolean, gssize=
.

Stuck in the 90s.

        Integer types which are guaranteed to be the same size across
        all platforms =E2=80=94 gint8, guint8, gint16, guint16, gint32, gui=
nt32,
        gint64, guint64.

Again.

        Types which are easier to use than their standard C counterparts
        - gpointer, gconstpointer, guchar, guint, gushort, gulong.

Surely, you're joking Mr. GLib.

        Types which correspond exactly to standard C types, but are
        included for completeness =E2=80=94 gchar, gint, gshort, glong, gfl=
oat,
        gdouble.

This answers your question: yes, gchar is exactly char.

It also reminds me of "It has been said that XML is like violence; if a
little doesn't solve the problem, use more."

        Types which correspond exactly to standard C99 types, but are
        available to use even if your compiler does not support C99 =E2=80=
=94
        gsize, goffset, gintptr, guintptr.

And the 90s again.

Purge with fire.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


