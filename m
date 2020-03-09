Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53411C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D82620828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7YIztI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D82620828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKvt-0002WT-AW
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jBKiY-0007Mt-HT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jBKiW-0006zp-A6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:53:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49762
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jBKiW-0006zE-5o
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583769199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3selgosqe81iHKKWeIq+bCUz6NF8r7dmwXWy8sl0tg=;
 b=Y7YIztI8wVANGgITOKB4IjJW2cnWX/YifhciQXzUZs2rfwkMJjr19FdmaD6428TAN1avc0
 fd0kD+abmFwKDuIEjN4x/aSlJYKnPIrOVzI+AxysmZZpyh0lBbTkGnK4fI9kGIPl4JFivm
 lBLFMFuKAOUUvs9kHXrQTwch65kwjW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-gprlnQYZO-OPizgSZM2ItA-1; Mon, 09 Mar 2020 11:53:01 -0400
X-MC-Unique: gprlnQYZO-OPizgSZM2ItA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C345477;
 Mon,  9 Mar 2020 15:52:59 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2FBC9051C;
 Mon,  9 Mar 2020 15:52:55 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] block: Add trivial backing_fmt support to qcow,
 sheepdog, vmdk
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-2-eblake@redhat.com>
 <20200309152112.GC6478@linux.fritz.box>
 <7b7f12f8-ca03-12d4-b93d-2edefb51cb42@redhat.com>
 <20200309154412.GL3033513@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8c54a809-4fbb-8a77-550f-679c646880cb@redhat.com>
Date: Mon, 9 Mar 2020 10:52:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309154412.GL3033513@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 pkrempa@redhat.com, "open list:Sheepdog" <sheepdog@lists.wpkg.org>,
 qemu-block@nongnu.org, libvir-list@redhat.com,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, mreitz@redhat.com,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Liu Yuan <namei.unix@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 10:44 AM, Daniel P. Berrang=C3=A9 wrote:

> Consider the user creates an image with "-F raw". We can validate the bac=
king
> image is raw, and so our check succeeds.  Later the malicious <something>=
 can
> write a qcow header into this raw file and QEMU will thereafter probe the
> image as qcow, not raw.
>=20
> IOW, in the case of "-F raw", even if we immediately check the format, we=
're
> still not offering the protection promised by the "-F" flag, because that
> promise refers to the runtime behaviour of the QEMU emulator, not the
> immediate qemu-img cmd.
>=20
> We could support "-F ..." and validate any non-raw formats, while raising=
 a
> runtime error in the case of "-F raw", as only the "raw" backing format h=
as
> the probing security risk.
>=20
> Users who need  to use qcow, with a backing file, without a format can
> just not pass "-F" and in doing so will be insecure.

And the warning will remind them of that.

>=20
> We could take this opportunity to deprecate 'qcow' perhaps, declare it
> a read-only format, restricted to qemu-img/qemu-io for purpose of data
> liberation ?

I'm fine with that, although it makes for a bigger task.

>=20
> For sheepdog, if it is something we genuinely still care about, then
> adding a backing file format record seems neccessary, unless we either
> forbid use of raw backing files, or forbid use of non-raw backing files,
> either way would be safe.

I concur - as long as you either have ONLY non-raw (in which case=20
probing is safe), or ONLY raw (in which case no probing is necessary),=20
then not recording the backing format is safe.  It is only for formats=20
that allow both raw and non-raw backing, but which do not have space in=20
the image to document which of the two backing formats is expected,=20
where we have problems.

>=20
>> I'm guessing that qcow works with either raw or qcow as backing format (=
and
>> anything else is odd - a qcow2 backing to a qcow is unusual, and would b=
e
>> better to reject).  I'm not sure if sheepdog can be backed by anything b=
ut
>> another sheepdog, similarly, I'm not sure if a vmdk can be backed by
>> anything but another vmdk.  If so, it should be simple enough to do a v4=
 of
>> this patch which requires -F to be a known-acceptable probe type for the=
se
>> images.
>>
>> Still, the point of this patch is that I want to add -F into all the
>> iotests, and without something along the lines of this patch, all of tho=
se
>> iotests are broken for these image formats.  Patch 2 is a lot harder to
>> write if we have to make our use of -F conditional on the image format i=
n
>> question.
>>
>> --=20
>> Eric Blake, Principal Software Engineer
>> Red Hat, Inc.           +1-919-301-3226
>> Virtualization:  qemu.org | libvirt.org
>>
>=20
> Regards,
> Daniel
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


