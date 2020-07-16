Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01729C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF24206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOfKOXqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF24206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzEB-00014P-2V
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 04:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvzD3-0008OW-J2
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:25:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24326
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvzD1-0001go-IM
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594887938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r2RFYxyJn2iZHVuAZBZKyOl//x+mdagGqnh97iZwQ6s=;
 b=GOfKOXqBLKwOoM50OSfFyM83czETTZ4Ve8vBscuen1lrxcWhTc6p0ePP0JqdUoM9qcrxM8
 ISRrfHvBS5+KeRbHxmaSrVfPqkrtFQFJT3WZsn0l9RUoC36zL/jYKomdy+eKi2Hxv37gEi
 QiricJOb8E+f6R6/Li2/FjIU4nFuOz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-BY-84WSmNBiljL5AVMYCIw-1; Thu, 16 Jul 2020 04:25:36 -0400
X-MC-Unique: BY-84WSmNBiljL5AVMYCIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 953251080
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 08:25:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6266F5C1C3;
 Thu, 16 Jul 2020 08:25:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CBD8811385E0; Thu, 16 Jul 2020 10:25:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH-for-5.2 0/5] qom: Let ObjectPropertyGet functions
 return a boolean value
References: <20200715175835.27744-1-philmd@redhat.com>
Date: Thu, 16 Jul 2020 10:25:33 +0200
In-Reply-To: <20200715175835.27744-1-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 15 Jul 2020 19:58:30
 +0200")
Message-ID: <87sgdrrhmq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> RFC series to follow Markus direction to simplify error
> propagation. Not sure it is worth it yet. It starts to
> be interesting when using the QEMU_WARN_UNUSED_RESULT
> attribute in the visitors, such:
>
> -- >8 --
> @@ -525,6 +533,7 @@ bool visit_type_uint8(Visitor *v, const char *name, u=
int8_t *obj,
>   * Visit a uint16_t value.
>   * Like visit_type_int(), except clamps the value to uint16_t range.
>   */
> +QEMU_WARN_UNUSED_RESULT
>  bool visit_type_uint16(Visitor *v, const char *name, uint16_t *obj,
>                         Error **errp);

QEMU_WARN_UNUSED_RESULT is problematic with functions taking an Error **
argument, because using &error_abort or &error_fatal the intended way
triggers the warning.

Does that make &error_abort and &error_fatal bad ideas?  They do help
keeping the code concise in places...  Hundreds of places, according to
git-grep.

> ---
>
> But to get there we need to update the QAPI generators first :)


