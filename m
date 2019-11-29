Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651DEC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA542075C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ME4+vDLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA542075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaiRZ-0005nU-22
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 10:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iahMx-0001Dd-8m
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iahMr-0002R7-GO
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:35:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20843
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iahMm-0002Kr-Ue
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575038126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGIbBd7nAnHa+FQGMtvp5Nq5cKWWmwwclo860d8Ww0I=;
 b=ME4+vDLoYDpTYsUadQvdxyU0wQZAiGhXL5kIkhik6q93kAY35BdtVjYN0QTlQnbxCpmFwT
 gtesTbvperlXc9cM9VeX4KJDhmbousdhwd0Jt4fJ7FOfsV+lc8Rsnr5qQVJrdJSUapVEVW
 s/92q4DW1hSpCGlJT5eT/WJ/NfRIODk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-KmJDLW95Oaulbixuk9lb3w-1; Fri, 29 Nov 2019 09:35:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94FB6184CAA2;
 Fri, 29 Nov 2019 14:35:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FF5460BF1;
 Fri, 29 Nov 2019 14:35:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9401B1138606; Fri, 29 Nov 2019 15:35:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6] error: rename errp to errp_in where it is IN-argument
References: <20191127183704.14825-1-vsementsov@virtuozzo.com>
 <878so05bca.fsf@dusky.pond.sub.org>
 <f901e0db-61df-898f-ce18-096bfeadf525@virtuozzo.com>
 <87mucf218w.fsf@dusky.pond.sub.org>
 <80e563ee-31fb-da43-ddde-c8666e4b92c6@virtuozzo.com>
Date: Fri, 29 Nov 2019 15:35:19 +0100
In-Reply-To: <80e563ee-31fb-da43-ddde-c8666e4b92c6@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 29 Nov 2019 08:28:41 +0000")
Message-ID: <87eexqda3c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: KmJDLW95Oaulbixuk9lb3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 28.11.2019 23:29, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>=20
>>> 28.11.2019 17:23, Markus Armbruster wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>
>>>>> Error **errp is almost always OUT-argument: it's assumed to be NULL, =
or
>>>>> pointer to NULL-initialized pointer, or pointer to error_abort or
>>>>> error_fatal, for callee to report error.
>>>>>
>>>>> But very few functions instead get Error **errp as IN-argument:
>>>>> it's assumed to be set (or, maybe, NULL), and callee should clean it,
>>>>> or add some information.
>>>>>
>>>>> In such cases, rename errp to errp_in.
>>>>
>>>> Missing: why is the rename useful?
>>>
>>> The main reason is to prepare for coccinelle part.
>>=20
>> It's not a prerequisite for applying the patches Coccinelle produces,
>> only a prerequisite for running Coccinelle.
>>=20
>>>> It's useful if it helps readers recognize unusual Error ** parameters,
>>>> and recognizing unusual Error ** parameters is actually a problem.  I'=
m
>>>> not sure it is, but my familiarity with the Error interface may blind
>>>> me.
>>>>
>>>> How many functions have unusual Error **parameters?  How are they used=
?
>>>> Any calls that could easily be mistaken as the usual case?  See [*]
>>>> below.
[...]
>>>> [*] The information I asked for above is buried in these patches.  I'l=
l
>>>> try to dig it up as I go reviewing them.
>>>>
>>>> Second, it risks some of these "further patches" overtake this one, an=
d
>>>> then its commit message will be misleading.  Moreover, the other commi=
ts
>>>> will lack context.
[...]
>>>>> diff --git a/util/error.c b/util/error.c
>>>>> index d4532ce318..275586faa8 100644
>>>>> --- a/util/error.c
>>>>> +++ b/util/error.c
[...]
>>>>> @@ -271,11 +271,11 @@ void error_free(Error *err)
>>>>>        }
>>>>>    }
>>>>>   =20
>>>>> -void error_free_or_abort(Error **errp)
>>>>> +void error_free_or_abort(Error **errp_in)
>>>>>    {
>>>>> -    assert(errp && *errp);
>>>>> -    error_free(*errp);
>>>>> -    *errp =3D NULL;
>>>>> +    assert(errp_in && *errp_in);
>>>>> +    error_free(*errp_in);
>>>>> +    *errp_in =3D NULL;
>>=20
>> This one is actually in/out.
>>=20
>> To make the compiler check errp_in is truly an in-argument, we can
>> declare it as Error *const *errp_in.
>>=20
>> But we can save ourselves the trouble of renaming it; the const should
>> suffice to tell both human readers and Coccinelle that this is not your
>> common out-argument.  I think I like this better than relying on a
>> naming convention.  What about you?
>
> I think it's good idea... But what to do with error_free_or_abort, and ot=
her functions
> which get filled errp, and want to set it to NULL? Patch 21 adds three su=
ch functions..
>
> Maybe, add assert(errp) at start of such functions, and catch it by cocci=
nelle (not sure
> that it is possible)?

I went through the git branch you provided.

These get rid of unusual Error ** parameters:

    01e10667d1 hmp: drop Error pointer indirection in hmp_handle_error
    606bfb7520 vnc: drop Error pointer indirection in vnc_client_io_error

    Get rid of them by peeling off an indirection.

These try to make unusual Error ** parameters stand out:

    51e73b3305 error: rename errp to errp_in where it is IN-argument

    Four renames.

    Three functions modify the error, name @errp_in is okay, my const
    proposal works.

    error_free_or_abort() clears *errp_in, name @errp_in is misleading,
    const doesn't work.

    f7bdfd42da qdev-monitor: well form error hint helpers

    Two renames.  Both functions modify the error, rename is okay, const
    works.

    9d4aac7299 nbd: well form nbd_iter_channel_error errp handler

    One rename, from @local_err.  nbd_iter_channel_error() clears *errp_in,
    name @errp_in is misleading, const doesn't work.

    fb1bd83c40 ppc: well form kvmppc_hint_smt_possible error hint helper

    One rename.  The function modify the error, rename is okay, const works=
.

    e024e89b10 9pfs: well form error hint helpers

    Two renames.  Both functions modify the error, rename is okay, const
    works.

These make usual Error ** parameters look, well, more usual:

    c01649d999 hw/core/qdev: cleanup Error ** variables
    a5f6424163 block/snapshot: rename Error ** parameter to more common err=
p
    ae200ca21e hw/i386/amd_iommu: rename Error ** parameter to more common =
errp
    561f73e681 qga: rename Error ** parameter to more common errp
    12589a96cd monitor/qmp-cmds: rename Error ** parameter to more common e=
rrp
    f608fc5999 hw/s390x: rename Error ** parameter to more common errp
    747a90d044 hw/tpm: rename Error ** parameter to more common errp
    3d19e66610 hw/usb: rename Error ** parameter to more common errp
    07366648ef include/qom/object.h: rename Error ** parameter to more comm=
on errp

These don't touch Error ** parameter declarations:

    f6e4fffc16 hw/core/loader-fit: fix freeing errp in fit_load_fdt
    b5bba880ae net/net: Clean up variable shadowing in net_client_init()
    4a4462ce4c hw/sd: drop extra whitespace in sdhci_sysbus_realize() heade=
r
    d52d44e822 backends/cryptodev: drop local_err from cryptodev_backend_co=
mplete()
    7e95d30766 hw/vfio/ap: drop local_err from vfio_ap_realize

Unusual Error ** parameters that can be made Error *const *errp should
not also need a rename, neither to avoid confusion about @errp's role,
nor to help Coccinelle.

Unusual Error ** parameters that can't be made Error *const *errp:

    nbd_iter_channel_error(): parameter is called @local_err.  Confusion
    seems as unlikely without the rename as with it.  Coccinelle should
    not need the rename.  No need to touch.  I'm willing to accept your
    assertion change.

    error_free_or_abort(): parameter is called @errp.  Confusion seems
    as unlikely without the rename as with it.  Coccinelle should not
    need the rename.  I'm willing to accept a rename to @local_err
    regardless.

I pushed my fixups to git://repo.or.cz/qemu/armbru.git branch error-prep
for your convenience.  The commit messages of the fixed up commits need
rephrasing, of course.


