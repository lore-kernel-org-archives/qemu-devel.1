Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E338FC4727F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4DF2087D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMGt3ReX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4DF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNxlR-0000Ai-4h
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 08:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNxeN-0005nG-RS
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 08:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNxeG-00081v-EB
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 08:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601555108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPaQ8QYI5e1n8hIQNkin/EhdBV9x93K5yltK5C+QwtI=;
 b=cMGt3ReXye86xIJgeU2cMx9AxXCLFsnJZUm8s/CUtNrWDWZW9+xnz/ZcFRngTkI9o3/qck
 7uSJFWsEAZxj6wqlVcMmWDosTQ5WK8nRXxKzN46n9rCrgbydARpSLPaOqql0geCIx/VQX4
 Rfwu+PQgz+D+3bo1aWG9D11ZnBepkJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-vRWcbM_aN6WzWSaz2bIOCg-1; Thu, 01 Oct 2020 08:25:06 -0400
X-MC-Unique: vRWcbM_aN6WzWSaz2bIOCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB13D8C9E66;
 Thu,  1 Oct 2020 12:24:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45F667366F;
 Thu,  1 Oct 2020 12:24:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C002E1132784; Thu,  1 Oct 2020 14:24:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 01/11] qapi: Restrict query-uuid command to block code
References: <20200930164949.1425294-1-philmd@redhat.com>
 <20200930164949.1425294-2-philmd@redhat.com>
 <87r1qi4jvj.fsf@dusky.pond.sub.org>
 <38e2b34b-7bb8-9e4b-680c-22e1fd21c3ef@redhat.com>
Date: Thu, 01 Oct 2020 14:24:56 +0200
In-Reply-To: <38e2b34b-7bb8-9e4b-680c-22e1fd21c3ef@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 1 Oct 2020 12:22:12
 +0200")
Message-ID: <87r1qiyvzb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> +Igor
>
> On 10/1/20 7:04 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>=20
>>> In commit f68c01470b we restricted the query-uuid command to
>>> machine code, but it is incorrect, as it is also used by the
>>> tools.  Therefore move this command again, but to block.json,
>>> which is shared by machine code and tools.
>>>
>>> Fixes: f68c01470b ("qapi: Restrict query-uuid command to machine code")
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>=20
>> UUIDs are not really a block-specific thing.
>
> This is the discussion we had in v1 with Igor...
>
> UuidInfo is a iSCSI-specific "thing", the original commit
> is f9dadc9855 ("iSCSI: add configuration variables for iSCSI")
> then Paolo introduced 'UuidInfo' in commit 5accc8408f
> ("scsi: prefer UUID to VM name for the initiator name") but
> is misnamed?

UuidInfo is also used by query-uuid and info uuid.  query-uuid returns
whatever was set with option -uuid.  Option's help text calls it
"machine UUID".

>> QMP query-uuid and HMP info uuid are about the VM, like query-name.
>> That's why they used to be next to query-name in misc.json.
>
> This is GuidInfo, not UuidInfo...
>
> GuidInfo is correctly in machine.json.

GuidInfo is used by query-vm-generation-id and info vm-generation-id.
query-vm-generation-id returns the value of property "guid" of the
vmgenid device.

I don't know why we have both.

>> There's one additional use in block/iscsi.c's get_initiator_name().  I
>> figure that's what pulls it into tools via qemu-img.
>
> Yes.
>
>>=20
>> Which other QAPI modules are shared by all the executables that use it?
>
> None?

I'd expect at least all the modules block.json includes:
block-core.json, common.json, crypto.json, job.json, sockets.json.

>> What about reverting the commit?  How bad would that be for user mode?
>>=20
>
> The problem is not user-mode, is linking tools.

Which modules are linked now?


