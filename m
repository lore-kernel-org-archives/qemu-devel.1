Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC79C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D992075B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0hSgH+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D992075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irI3P-0001sJ-EB
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 04:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1irI2o-0001Ns-A9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 03:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1irI2m-0007Zp-2z
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 03:59:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57752
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1irI2m-0007Zd-03
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 03:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578992363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dJMmsXdoA6huBXa0xhsiMffQui5qpFsk32GpCC0Vvk=;
 b=S0hSgH+WGnaVkr16nSip/jLQQddMR1tOjzSp36WlVhqUwvVgST76gx4AGGrTn6CFmPnVi+
 TCpJxHBMpbBmhrydBnnwDrKTHGPxe69IhNn/gIkb/oVDIf1cK4BlGnUjozqC1X3s7IQiFR
 WdOkeGm/S0r1mq82XhtnRAuZERE/qkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-rOCVM3TEPqC0-TcC_SGlRg-1; Tue, 14 Jan 2020 03:59:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5084C1005502;
 Tue, 14 Jan 2020 08:59:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F263F5C1D6;
 Tue, 14 Jan 2020 08:59:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 175CB1138600; Tue, 14 Jan 2020 09:59:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Priority of -accel
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <1A5859EA-4403-4921-B527-DFD07C59C702@redhat.com>
 <360fa010-ba80-b02b-3a35-19c2b48a462d@redhat.com>
 <87d0bnwct1.fsf@dusky.pond.sub.org>
 <ff78d961-9432-c84d-4bba-6df14b1a5a79@redhat.com>
Date: Tue, 14 Jan 2020 09:59:10 +0100
In-Reply-To: <ff78d961-9432-c84d-4bba-6df14b1a5a79@redhat.com> (Paolo
 Bonzini's message of "Mon, 13 Jan 2020 17:25:04 +0100")
Message-ID: <87lfqajtwh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: rOCVM3TEPqC0-TcC_SGlRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel Berrange <berrange@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Christophe de Dinechin <dinechin@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 13/01/20 17:17, Markus Armbruster wrote:
>> Perfect opportunity to change the default to something more useful.
>
> I am not sure acutally if it's that more useful, now that we have
> sanctioned qemu-kvm as the fast alternative.

If there is a fast alternative, why ship the slow one?

> Particularly it would be confusing for qemu-system-x86_64 to use
> hardware virtualization on Linux, but not on other operating systems
> where the accelerators are not stable enough.

Hardly more confusing than qemu-kvm not using hardware virtualization
when /dev/kvm is unavailable.

No matter what we do, somebody is going to be confused.  How to resolve
such a conundrum?  Utilitarian philosophy teaches us to pursue the
greatest confusion of the greatest numbers.  I think not using x86
hardware virtualization by default has been admirably successful there.

;-P


