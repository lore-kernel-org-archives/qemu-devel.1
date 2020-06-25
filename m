Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52A3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 06:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE2920773
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 06:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jV+2Zi+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE2920773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joLXI-0004A7-RE
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 02:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joLWS-0003MK-V2
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 02:38:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25656
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joLWQ-0007pr-BZ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 02:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593067085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HymxzkekFH6JguRLqQNclhKOAHUnbMVMPoKNI5hr4YQ=;
 b=jV+2Zi+zx+x1mh8lz2ohKC4jBaD4SPim+gUbVD26ZlpUc6ecDD6hIr7kOCbsvZAMGDB2BV
 42yDZGIlgp0HSJx9L12hYOB5X8OGK/KbI+nrLeZb98bJ4ubIBCIky7dBcIA+qWDQ4X7nlE
 cEH43FCfQi9asG40TyY8adrX4tczZno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-DDLDEzJoPtWYJB0x_81XKg-1; Thu, 25 Jun 2020 02:38:02 -0400
X-MC-Unique: DDLDEzJoPtWYJB0x_81XKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B357107ACCA;
 Thu, 25 Jun 2020 06:38:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA0D260C87;
 Thu, 25 Jun 2020 06:38:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5672211384D4; Thu, 25 Jun 2020 08:37:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 4/8] hw/misc/pca9552: Add a 'description' property for
 debugging purpose
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-5-f4bug@amsat.org>
 <4d335933-9669-43e1-0966-5f0255142012@kaod.org>
 <34fe3d2b-6b41-0509-f172-5b45486fdf0c@amsat.org>
 <deccf836-48ef-7112-d66e-a8d3cc4a9681@kaod.org>
Date: Thu, 25 Jun 2020 08:37:59 +0200
In-Reply-To: <deccf836-48ef-7112-d66e-a8d3cc4a9681@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Mon, 22 Jun 2020 15:24:50 +0200")
Message-ID: <877dvv4pmg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 6/22/20 10:31 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 6/22/20 8:27 AM, C=C3=A9dric Le Goater wrote:
>>> On 6/21/20 12:58 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Add a description field to distinguish between multiple devices.

Pardon my lack of imagination: how does this help you with debugging?

>>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>
>>> Could it be a QOM attribute ?=20
>>=20
>> What do you call a 'QOM attribute'?
>> Is it what qdev properties implement?
>> (in this case via DEFINE_PROP_STRING).
>
> I meant a default Object property, which would apply to all Objects.=20

Good point.  Many devices have multiple component objects of the same
type.

> What you did is fine, so :
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> but, may be, a well defined child name is enough for the purpose.

object_get_canonical_path() returns a distinct path for each (component)
object.  The path components are the child property names.

Properties can have descriptions: object_property_set_description().

Sufficient?


