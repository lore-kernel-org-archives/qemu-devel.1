Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB877C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEE921D80
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/HyotJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEE921D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHmZV-0008Mj-4c
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHmXp-0005yd-5k
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:21:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26358
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHmXn-0007tn-DZ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600082470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxjBnyWJ9Tkn7p6RyaZTNmd3tk/STrgA2yn0kwKxbig=;
 b=c/HyotJr+7ijSoibvTXecqK90lyOsOtUtIjrJnOx8DdSAg4lggQoGMTzNEP/mNvhQg+HSk
 I0BcyScYIIqkUHzmXmLGHFkdiVO+nU7BfvUAjVCo8xPez2f9IYMTH2IYP7b58ULZIvUAc9
 mc5n5IkLdqO3DjNZp0vAWjQaIyhlEEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-gN5tdGX9MgmPwNMOZLiK_g-1; Mon, 14 Sep 2020 07:21:09 -0400
X-MC-Unique: gN5tdGX9MgmPwNMOZLiK_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B32321084D63;
 Mon, 14 Sep 2020 11:21:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 764F060BE2;
 Mon, 14 Sep 2020 11:21:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0DF9D113864A; Mon, 14 Sep 2020 13:21:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 3/8] qapi: Restrict balloon-related commands to
 machine code
References: <b9401e89-2598-74f7-5e92-885c522b7599@redhat.com>
 <CD01CCE8-2E17-4234-82E8-37DE94E62DD3@redhat.com>
Date: Mon, 14 Sep 2020 13:21:02 +0200
In-Reply-To: <CD01CCE8-2E17-4234-82E8-37DE94E62DD3@redhat.com> (David
 Hildenbrand's message of "Mon, 14 Sep 2020 11:48:53 +0200")
Message-ID: <87lfhcppsx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:33:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

>> Am 14.09.2020 um 11:42 schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com>:
>>=20
>> =EF=BB=BF+Laurent and David
>>=20
>>> On 9/14/20 11:16 AM, Markus Armbruster wrote:
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>=20
>>>> Only qemu-system-FOO and qemu-storage-daemon provide QMP
>>>> monitors, therefore such declarations and definitions are
>>>> irrelevant for user-mode emulation.
>>>>=20
>>>> Restricting the balloon-related commands to machine.json
>>>> allows pulling less declarations/definitions to user-mode.
>>>=20
>>> How this affects user mode is not obvious to (ignorant) me.  Can you
>>> provide a clue?
>>=20
>> I guess this was discussed with David at some point.
>>=20
>> Maybe the QMP commands are not exposed via HMP, making this
>> code unreachable?
>>=20
>> Anyhow user-mode binaries don't use the memory ballooning feature,
>> this is specific to system-mode emulation.
>>=20
>> Laurent/David, do you have some more trivial explanation?
>
> Agreed.
>
> No memory ballooning device -> no memory ballooning :)

I understand why user mode doesn't need device models.  What I don't
understand offhand is how balloon-related stuff in misc.json ends up
pulling "declarations/definitions to user-mode".  What exactly is being
pulled where before the series, and no more afterwards?

Is it just the code generated for the QAPI stuff you move, or is it
more?


