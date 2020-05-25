Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D583C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 09:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351CD206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 09:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsvUOHE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351CD206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd912-0003CS-BG
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 05:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jd90B-0002FT-2u
 for qemu-devel@nongnu.org; Mon, 25 May 2020 05:02:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33238
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jd90A-00019P-4s
 for qemu-devel@nongnu.org; Mon, 25 May 2020 05:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590397348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsXuH5ekzD9608RHToOF5NccYsk+1lwAWa8ohZy+Ubw=;
 b=LsvUOHE7qpp71zQwtptX8+ffdJ947NRnqducE4xeQU60QdJxdCYsRJhjPdHZFovh9M/egL
 DYWztu9KMWo8apZyy9rjB+BVKPAS5omd5rw7tct0BZ3U5FnCmIiw9qwjj43brQbPDg0+mE
 l3Q2se66m82vbJamobGpZJp3QL4T0uU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-U3RCoT-zM2unESrhVnRG7w-1; Mon, 25 May 2020 05:02:26 -0400
X-MC-Unique: U3RCoT-zM2unESrhVnRG7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9319D800688;
 Mon, 25 May 2020 09:02:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A5875D9C5;
 Mon, 25 May 2020 09:02:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC893113864A; Mon, 25 May 2020 11:02:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/2] hmp: Implement qom-get HMP command
References: <20200520151108.160598-1-dgilbert@redhat.com>
 <20200520151108.160598-2-dgilbert@redhat.com>
Date: Mon, 25 May 2020 11:02:23 +0200
In-Reply-To: <20200520151108.160598-2-dgilbert@redhat.com> (David Alan
 Gilbert's message of "Wed, 20 May 2020 16:11:07 +0100")
Message-ID: <87sgfoe6ao.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, afaerber@suse.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> This started off as Andreas F=C3=A4rber's implementation from
> March 2015, but after feedback from Paolo and Markus it morphed into
> using the json output which handles structs reasonably.
>
> Use with qom-list to find the members of an object.
>
> (qemu) qom-get /backend/console[0]/device/vga.rom[0] size
> 65536
> (qemu) qom-get /machine smm
> "auto"
> (qemu) qom-get /machine rtc-time
> {
>     "tm_year": 120,
>     "tm_sec": 51,
>     "tm_hour": 9,
>     "tm_min": 50,
>     "tm_mon": 4,
>     "tm_mday": 20
> }
> (qemu) qom-get /machine frob
> Error: Property '.frob' not found

  (qemu) qom-get /machine peripheral
  "/machine/peripheral"

Not this patch's fault, but WTF?

Turns out it's simply what object_get_child_property() does.

Paolo, is this what we want for qom-get?

Also not this patch's fault: separating path and property feels like a
pointless complication of the interface to me.  Why

    {"execute": "qom-get", "arguments": {"path": "/machine", "property": "s=
mm"}}

and not

    {"execute": "qom-get", "arguments": {"path": "/machine/smm"}}

?

Too late to change for QMP, I guess.


