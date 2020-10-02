Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971FCC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B7E206B2
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKNEoT7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B7E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJrZ-00033i-Rk
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOJqD-0002We-H8
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOJqB-0002xQ-U5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UJcxPxwfPLM4cKxwkLCNQV4Y0dVq86uKCXc2wKWVOoY=;
 b=QKNEoT7MXCqg0QDJGSKM5mbq2DfsEqSz0ia/afA5WBa0k7XLFdFIFqP9nSHSsDghLZD8Pn
 0CevtArotL2A2FGAhJFVx2g4eHKNPFR8fvQriWhClgSqO8PQJaDpbq8zkw3HdNm8J+CmoY
 EH0Oo3Okn0E5XYdrQny3vNsm6UBntxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-SQMACxheMzW8zUYtYSGN-Q-1; Fri, 02 Oct 2020 08:07:07 -0400
X-MC-Unique: SQMACxheMzW8zUYtYSGN-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4CE710BBED1;
 Fri,  2 Oct 2020 12:07:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 349B67881E;
 Fri,  2 Oct 2020 12:07:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4B2241132784; Fri,  2 Oct 2020 14:07:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [PATCH qemu 1/4] drive-mirror: add support for sync=bitmap
 mode=never
References: <20200922091418.53562-1-f.gruenbichler@proxmox.com>
 <20200922091418.53562-2-f.gruenbichler@proxmox.com>
 <87o8llrtse.fsf@dusky.pond.sub.org>
 <1601627258.kk9bqebpq1.astroid@nora.none>
Date: Fri, 02 Oct 2020 14:07:03 +0200
In-Reply-To: <1601627258.kk9bqebpq1.astroid@nora.none> ("Fabian
 =?utf-8?Q?Gr=C3=BCnbichler=22's?=
 message of "Fri, 02 Oct 2020 10:45:15 +0200")
Message-ID: <87h7rckf14.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Ma Haocong <mahaocong@didichuxing.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com> writes:

> On October 2, 2020 9:06 am, Markus Armbruster wrote:
>> Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com> writes:
>>=20
>>> From: John Snow <jsnow@redhat.com>
>>>
>>> This patch adds support for the "BITMAP" sync mode to drive-mirror and
>>> blockdev-mirror. It adds support only for the BitmapSyncMode "never,"
>>> because it's the simplest mode.
>>>
>>> This mode simply uses a user-provided bitmap as an initial copy
>>> manifest, and then does not clear any bits in the bitmap at the
>>> conclusion of the operation.
>>>
>>> Any new writes dirtied during the operation are copied out, in contrast
>>> to backup. Note that whether these writes are reflected in the bitmap
>>> at the conclusion of the operation depends on whether that bitmap is
>>> actually recording!
>>>
>>> This patch was originally based on one by Ma Haocong, but it has since
>>> been modified pretty heavily.
>>>
>>> Suggested-by: Ma Haocong <mahaocong@didichuxing.com>
>>> Signed-off-by: Ma Haocong <mahaocong@didichuxing.com>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> Signed-off-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>
>>> ---
>> [...]
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 2d94873ca0..dac5497084 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -1961,10 +1961,19 @@
>>>  #        (all the disk, only the sectors allocated in the topmost imag=
e, or
>>>  #        only new I/O).
>>>  #
>>> +# @bitmap: The name of a bitmap to use for sync=3Dbitmap mode. This ar=
gument must
>>> +#          be present for bitmap mode and absent otherwise. The bitmap=
's
>>=20
>> What is "bitmap mode"?  Do you mean "present when @bitmap-mode is, else
>> absent"?
>
> bitmap mode is sync=3Dbitmap , as in the first sentence. if you set=20
> sync=3Dbitmap, you must specify a bitmap and a bitmap-mode. if you use=20
> another sync mode, you must not specify a bitmap or a bitmap-mode.

Got it.

> there is also a 'sugar' sync mode 'incremental' that desugars to=20
> sync=3Dbitmap with bitmap-mode=3Don-success.  I guess that should also be=
=20
> mentioned somewhere in QAPI, it's mainly there since MirrorSyncMode has=
=20
> it as possible value, it's semantics are straight-forward to map onto=20
> this combination, and it's how the sync modes are known from backup=20
> jobs.
>
> maybe the following is easier to understand and more aligned with=20
> bitmap-mode:
>
> The name of the bitmap to use for sync=3Dbitmap/sync=3Dincremental mode.=
=20
> Must be present if sync is "bitmap" or "incremental". Must NOT be=20
> present otherwise.

Better.

>>> +#          granularity is used instead of @granularity (since 5.2).
>>> +#
>>> +# @bitmap-mode: Specifies the type of data the bitmap should contain a=
fter
>>> +#               the operation concludes. Must be present if sync is "b=
itmap".
>>> +#               Must NOT be present otherwise. (Since 5.2)
>
> Specifies the type of data the bitmap should contain after the operation=
=20
> concludes. Must be present if sync is "bitmap". Must be "on-success" or=
=20
> absent if sync is "incremental". Must NOT be present otherwise.

Thanks for closing the gaps.

>>> +#
>>>  # @granularity: granularity of the dirty bitmap, default is 64K
>>>  #               if the image format doesn't have clusters, 4K if the c=
lusters
>>>  #               are smaller than that, else the cluster size.  Must be=
 a
>>> -#               power of 2 between 512 and 64M (since 1.4).
>>> +#               power of 2 between 512 and 64M. Must not be specified =
if
>>> +#               @bitmap is present (since 1.4).
>>>  #
>>=20
>> Is @granularity forbidden with @bitmap because it makes no sense?
>
> yes.
>
>>=20
>> If yes, then it doesn't actually default to anything then, does it?
>
> we must use the same granularity as the sync bitmap passed in via=20
> 'bitmap', so the caller can't set a different one.

Contradicts the doc comment :)  Shouldn't be hard to fix.

>> Looks like we have
>>=20
>>     sync            'bitmap'            anything else
>>     -------------------------------------------------
>>     bitmap          required            forbidden
>>     bitmap-mode     required            forbidden
>>     granularity     forbidden           optional
>>=20
>> Correct?
>
> yes. with the addition of sync=3Dincremental as subset of sync=3Dbitmap, =
as=20
> described above.

When you have members that make sense only for certain values of another
member, you should consider (flat) unions.  I'm not sure a flat union
makes sense here, but I wanted to mention it.

>>>  # @buf-size: maximum amount of data in flight from source to
>>>  #            target (since 1.4).
>>> @@ -2002,7 +2011,9 @@
>>>  { 'struct': 'DriveMirror',
>>>    'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
>>>              '*format': 'str', '*node-name': 'str', '*replaces': 'str',
>>> -            'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
>>> +            'sync': 'MirrorSyncMode', '*bitmap': 'str',
>>> +            '*bitmap-mode': 'BitmapSyncMode',
>>> +            '*mode': 'NewImageMode',
>>>              '*speed': 'int', '*granularity': 'uint32',
>>>              '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
>>>              '*on-target-error': 'BlockdevOnError',
>> [Same for blockdev-mirror...]


