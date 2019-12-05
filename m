Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9732CC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663A724651
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/mb4+bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663A724651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ics80-0005xY-IX
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1ics17-0006ku-M8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1ics15-0007az-6r
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:22:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48089)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1ics12-0007Z8-V8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575555719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Vr0Gig3Nbjr/9Im+n7OJHPEbRRkSiW7mNmtuEC70fo=;
 b=Y/mb4+bJxkPNpT7BJ69rmOQ6EdlegafD9rsiz6gtifRPAL8bjmyVEAzh2DupbWBBzvFiTe
 4VOgjiVgytB+3JJs2njDl9dtTosCsDFEOyZERXdOQfHzwV/8itrkh5cT2Uz7vfNARSQ3oX
 O4HVTQWTzhQ1ZNrAdz1cqJshmF+otbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-6s-N3LCCPSOmN3yqtK1ETQ-1; Thu, 05 Dec 2019 09:21:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C54F1005514;
 Thu,  5 Dec 2019 14:21:57 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14D135C1B5;
 Thu,  5 Dec 2019 14:21:53 +0000 (UTC)
Subject: Re: [PATCH v3] qga: fence guest-set-time if hwclock not available
To: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20191205115350.18713-1-cohuck@redhat.com>
 <5aaa7f3a-e3d1-0057-5fe2-07dea4864bc7@redhat.com>
 <20191205141212.6cb05ac7.cohuck@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <189346a8-62f1-02d1-00e4-23d2485646cd@redhat.com>
Date: Thu, 5 Dec 2019 15:21:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205141212.6cb05ac7.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 6s-N3LCCPSOmN3yqtK1ETQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 2:12 PM, Cornelia Huck wrote:
> On Thu, 5 Dec 2019 14:05:19 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> Hi Cornelia,
>>
>> On 12/5/19 12:53 PM, Cornelia Huck wrote:
>>> The Posix implementation of guest-set-time invokes hwclock to
>>> set/retrieve the time to/from the hardware clock. If hwclock
>>> is not available, the user is currently informed that "hwclock
>>> failed to set hardware clock to system time", which is quite
>>> misleading. This may happen e.g. on s390x, which has a different
>>> timekeeping concept anyway.
>>>
>>> Let's check for the availability of the hwclock command and
>>> return QERR_UNSUPPORTED for guest-set-time if it is not available.
>>>
>>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>
>>> v2->v3:
>>>     - added 'static' keyword to hwclock_path
>>>
>>> Not sure what tree this is going through; if there's no better place,
>>> I can also take this through the s390 tree.
>>
>> s390 or trivial trees seems appropriate.
>>
>>>
>>> ---
>>>    qga/commands-posix.c | 13 ++++++++++++-
>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>>> index 1c1a165daed8..0be301a4ea77 100644
>>> --- a/qga/commands-posix.c
>>> +++ b/qga/commands-posix.c
>>> @@ -156,6 +156,17 @@ void qmp_guest_set_time(bool has_time, int64_t tim=
e_ns, Error **errp)
>>>        pid_t pid;
>>>        Error *local_err =3D NULL;
>>>        struct timeval tv;
>>> +    static const char hwclock_path[] =3D "/sbin/hwclock";
>>> +    static int hwclock_available =3D -1;
>>> +
>>> +    if (hwclock_available < 0) {
>>> +        hwclock_available =3D (access(hwclock_path, X_OK) =3D=3D 0);
>>> +    }
>>> +
>>> +    if (!hwclock_available) {
>>> +        error_setg(errp, QERR_UNSUPPORTED);
>>
>> In include/qapi/qmp/qerror.h we have:
>>
>> /*
>>    * These macros will go away, please don't use in new code, and do not
>>    * add new ones!
>>    */
>=20
> Sigh, it is really hard to keep track here :( I just copied from other
> callers in this file...
>=20
>>
>> Maybe we can replace it by "this feature is not supported on this
>> architecture"? (or without 'on this architecture').
>=20
> This is not really architecture specific, you'd get this on any setup
> that does not have /sbin/hwclock.
>=20
> Q: Is libvirt doing anything with such an error message from QEMU? Do
> we have the freedom to say e.g "guest-set-time is not supported" or so?
> Or is it beneficial to print the same error message for any unsupported
> feature?

No. Libvirt threats error messages as an opaque data. In a few cases we=20
check for the class of the error and for instance issue a different=20
command if class was CommandNotFound. You are free to change error=20
messages as you wish.

Note that this is not true for HMP - there libvirt does some parsing to=20
figure out the source of error. For instance:

https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dblob;f=3Dsrc/qemu/qemu_monitor=
_text.c;h=3D9054682d608b13347880f36cacd0e023151322e6;hb=3DHEAD#l36

Michal


