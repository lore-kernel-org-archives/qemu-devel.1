Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466F5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 04:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A4A2078C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 04:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpxmuTTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A4A2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdo19-0000fL-7w
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 00:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdo0X-00009D-El
 for qemu-devel@nongnu.org; Wed, 27 May 2020 00:49:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56186
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdo0W-0006Qx-4M
 for qemu-devel@nongnu.org; Wed, 27 May 2020 00:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590554974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecKVTx36dObNRq5jRVgGmQ5fiGaQvOOEN1wndtDJXhI=;
 b=bpxmuTTiFSGg5uBzE0aP1KIowDYN8rWojtRao5KReXDr1Z+yNT8JLLtyflHH8H6Uxcy/xo
 t2FOEf71+vz2XoFpMzBnhjx3IZN+AxaKellBA8vIcYnrRLuKJXvidUAPP0O5ELZJk13+Tg
 EfDJMF+z+Upfqz3R/fYDdiFsZwUaVK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-kRb7G1jKOGe_gBWoOwTcOA-1; Wed, 27 May 2020 00:49:33 -0400
X-MC-Unique: kRb7G1jKOGe_gBWoOwTcOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC6BF107ACCA;
 Wed, 27 May 2020 04:49:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D996960C05;
 Wed, 27 May 2020 04:49:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6F528113864A; Wed, 27 May 2020 06:49:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 4/9] qapi/misc: Restrict balloon-related commands to
 machine code
References: <20200525150640.30879-1-philmd@redhat.com>
 <20200525150640.30879-5-philmd@redhat.com>
 <87eer787tr.fsf@dusky.pond.sub.org>
 <7e926561-c2c3-e815-8518-b283db7c60fd@redhat.com>
 <87mu5v3w3t.fsf@dusky.pond.sub.org>
 <7fb7564d-23cc-28b8-bf5f-a80797c518ec@redhat.com>
 <67d74bcb-ac60-a6f7-e485-7e419dbf50dc@redhat.com>
Date: Wed, 27 May 2020 06:49:23 +0200
In-Reply-To: <67d74bcb-ac60-a6f7-e485-7e419dbf50dc@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 26 May 2020 17:36:34
 +0200")
Message-ID: <87r1v60yp8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 22:58:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Lieven <pl@kamp.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/26/20 11:31 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> +Laurent
>>=20
>> On 5/26/20 11:04 AM, Markus Armbruster wrote:
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>
>>>> On 5/26/20 9:38 AM, Markus Armbruster wrote:
>>>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>>
>>>>> A brief note on why restricting "to machine code" is useful would be
>>>>> nice.  Same for the other patches.
>>>>>
>>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>>
>>>>
>>>> What about this?
>>>>
>>>> "QEMU can do system-mode and user-mode emulation.
>>>> Only system mode emulate a machine.
>>>> Remove this feature from the user-mode emulation."
>>>
>>> Is is a feature of user-mode emulation before the patch?  Or is it just
>>> dead code?
>>>
>>> Hint: QMP commands tend to be dead code when the program doesn't expose
>>> a QMP monitor :)
>>=20
>> Maybe a 'corollary' question, "How user-mode users use QMP?"
>>=20
>
> I can't find a way to start a user-mode process with a QMP socket, is
> there one?

As far as I can tell, only qemu-system-FOO and qemu-storage-daemon
provide QMP monitors:

* Monitors need to be initialized with monitor_init().  Two callers:
  monitor_init_hmp(), monitor_init_qmp().

* monitor_init() calls both, and is the common wat to create a monitor.
  Called by vl.c via monitor_init_opts(), and by qemu-storage-daemon.

* monitor_init_hmp() has additional callers, but HMP doesn't matter
  here.


