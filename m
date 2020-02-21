Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E267BC35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6DD20722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJxYfWE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6DD20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BHn-0005jw-SL
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j5BFu-0003Vy-BJ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j5BFr-00019R-Pi
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:34:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56015
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j5BFr-00018z-KQ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582302859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKj4cP4FGitqAYdpkXtqPuo1McOAdhjb7cNvze2C/Ag=;
 b=dJxYfWE8D51geJfn+1iW1rqQpEm1YWOmU2yYaso2otZiRKejOQA6upT3DmFybabyfs86Lp
 y+jHDhecNeEo0qnVPx/7b44hWZNNGPYigUaY8RF/SbSS52plX7OnuIDSeH0+k7W31KpHhw
 gwXFcVk26iKmh2gPgnxy+3YMtt+kYgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-RPD7Q-_SMcy4O4MKRGRnYA-1; Fri, 21 Feb 2020 11:34:17 -0500
X-MC-Unique: RPD7Q-_SMcy4O4MKRGRnYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7646107ACC5;
 Fri, 21 Feb 2020 16:34:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D96687B08;
 Fri, 21 Feb 2020 16:34:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C683811386A6; Fri, 21 Feb 2020 17:34:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 01/11] qapi/error: add (Error **errp) cleaning APIs
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <20200131130118.1716-2-vsementsov@virtuozzo.com>
 <87d0a88k6d.fsf@dusky.pond.sub.org>
 <7856fcbb-8c01-aba3-a11b-63058c117362@virtuozzo.com>
Date: Fri, 21 Feb 2020 17:34:06 +0100
In-Reply-To: <7856fcbb-8c01-aba3-a11b-63058c117362@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 21 Feb 2020 12:20:23 +0300")
Message-ID: <875zfz6gsh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 21.02.2020 10:38, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>
>>> Add functions to clean Error **errp: call corresponding Error *err
>>> cleaning function an set pointer to NULL.
>>>
>>> New functions:
>>>    error_free_errp
>>>    error_report_errp
>>>    warn_report_errp
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>
>>> CC: Eric Blake <eblake@redhat.com>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Max Reitz <mreitz@redhat.com>
>>> CC: Greg Kurz <groug@kaod.org>
>>> CC: Stefano Stabellini <sstabellini@kernel.org>
>>> CC: Anthony Perard <anthony.perard@citrix.com>
>>> CC: Paul Durrant <paul@xen.org>
>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>>> CC: Laszlo Ersek <lersek@redhat.com>
>>> CC: Gerd Hoffmann <kraxel@redhat.com>
>>> CC: Stefan Berger <stefanb@linux.ibm.com>
>>> CC: Markus Armbruster <armbru@redhat.com>
>>> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
>>> CC: qemu-block@nongnu.org
>>> CC: xen-devel@lists.xenproject.org
>>>
>>>   include/qapi/error.h | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>> index ad5b6e896d..d34987148d 100644
>>> --- a/include/qapi/error.h
>>> +++ b/include/qapi/error.h
>>> @@ -309,6 +309,32 @@ void warn_reportf_err(Error *err, const char *fmt,=
 ...)
>>>   void error_reportf_err(Error *err, const char *fmt, ...)
>>>       GCC_FMT_ATTR(2, 3);
>>>   +/*
>>> + * Functions to clean Error **errp: call corresponding Error *err clea=
ning
>>> + * function, then set pointer to NULL.
>>> + */
>>> +static inline void error_free_errp(Error **errp)
>>> +{
>>> +    assert(errp && *errp);
>>> +    error_free(*errp);
>>> +    *errp =3D NULL;
>>> +}
>>> +
>>> +static inline void error_report_errp(Error **errp)
>>> +{
>>> +    assert(errp && *errp);
>>> +    error_report_err(*errp);
>>> +    *errp =3D NULL;
>>> +}
>>> +
>>> +static inline void warn_report_errp(Error **errp)
>>> +{
>>> +    assert(errp && *errp);
>>> +    warn_report_err(*errp);
>>> +    *errp =3D NULL;
>>> +}
>>> +
>>> +
>>>   /*
>>>    * Just like error_setg(), except you get to specify the error class.
>>>    * Note: use of error classes other than ERROR_CLASS_GENERIC_ERROR is
>>
>> These appear to be unused apart from the Coccinelle script in PATCH 03.
>>
>> They are used in the full "[RFC v5 000/126] error: auto propagated
>> local_err" series.  Options:
>>
>> 1. Pick a few more patches into this part I series, so these guys come
>>     with users.
>
> It needs some additional effort for this series.. But it's possible. Stil=
l,
> I think that we at least should not pull out patches which should be in
> future series (for example from ppc or block/)..

Yes, we want to keep related stuff together.

> Grepping through v5:
>  for x in {warn_report_errp,error_report_errp,error_free_errp}; do echo =
=3D=3D $x =3D=3D; git grep -l $x | grep -v coccinelle | grep -v 'error\.h';=
 echo; done
> =3D=3D warn_report_errp =3D=3D
> block/file-posix.c
> hw/ppc/spapr.c
> hw/ppc/spapr_caps.c
> hw/ppc/spapr_irq.c
> hw/vfio/pci.c
> net/tap.c
> qom/object.c
>
> =3D=3D error_report_errp =3D=3D
> hw/block/vhost-user-blk.c
> util/oslib-posix.c
>
> =3D=3D error_free_errp =3D=3D
> block.c
> block/qapi.c
> block/sheepdog.c
> block/snapshot.c
> blockdev.c
> chardev/char-socket.c
> hw/audio/intel-hda.c
> hw/core/qdev-properties.c
> hw/pci-bridge/pci_bridge_dev.c
> hw/pci-bridge/pcie_pci_bridge.c
> hw/scsi/megasas.c
> hw/scsi/mptsas.c
> hw/usb/hcd-xhci.c
> io/net-listener.c
> migration/colo.c
> qga/commands-posix.c
> qga/commands-win32.c
> util/qemu-sockets.c
>
> What do you want to add?

PATCH v5 032 uses both error_report_errp() and error_free_errp().
Adding warn_report_errp() without a user is okay with me.  What do you
think?

If there are patches you consider related to 032, feel free to throw
them in.

>>
>> 2. Punt this patch to the first part that has users, along with the
>>     part of the Coccinelle script that deals with them.
>
> But coccinelle script would be wrong, if we drop this part from it. I thi=
nk,
> that after commit which adds coccinelle script, it should work with any f=
ile,
> not only subset of these series.
>
> So, it's probably OK for now to drop these functions, forcing their addit=
ion if
> coccinelle script will be applied where these functions are needed. We ca=
n, for
> example comment these three functions.
>
> Splitting coccinelle script into two parts, which will be in different se=
ries will
> not help any patch-porting processes.
>
> Moreover, this will create dependencies between future series updating ot=
her files.
>
> So, I don't like [2.]..

And it's likely more work than 1.

>> 3. Do nothing: accept the functions without users.
>
> OK for me)
>
>>
>> I habitually dislike 3., but reviewing the rest of this series might
>> make me override that dislike.
[...]


