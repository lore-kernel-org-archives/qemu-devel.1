Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5EEC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5172133F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5172133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHO1L-0001rh-HD
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 04:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHO0N-0001Eg-DD
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHO0M-000767-CR
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:04:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53132)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iHO0J-000749-6j; Mon, 07 Oct 2019 04:04:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0677C058CA4;
 Mon,  7 Oct 2019 08:04:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 756025D70D;
 Mon,  7 Oct 2019 08:04:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB5361138648; Mon,  7 Oct 2019 10:04:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 09/11] block/qcow2: implement blockdev-amend
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-10-mlevitsk@redhat.com>
 <c26f4f4a-2f2e-84d9-a516-36c7150b6332@redhat.com>
Date: Mon, 07 Oct 2019 10:04:09 +0200
In-Reply-To: <c26f4f4a-2f2e-84d9-a516-36c7150b6332@redhat.com> (Max Reitz's
 message of "Fri, 4 Oct 2019 21:03:16 +0200")
Message-ID: <875zl1j81y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 07 Oct 2019 08:04:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

> On 13.09.19 00:30, Maxim Levitsky wrote:
>> Currently only for changing crypto parameters
>
> Yep, that elegantly avoids most of the problems we=E2=80=99d have otherwi=
se. :-)
>
>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
[...]
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 4a6db98938..0eb4e45168 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -4294,6 +4294,7 @@
>>  # Driver specific image creation options for qcow2.
>>  #
>>  # @file             Node to create the image format on
>> +#                   Mandatory for create
>>  # @data-file        Node to use as an external data file in which all g=
uest
>>  #                   data is stored so that only metadata remains in the=
 qcow2
>>  #                   file (since: 4.0)
>> @@ -4301,6 +4302,7 @@
>>  #                   standalone (read-only) raw image without looking at=
 qcow2
>>  #                   metadata (default: false; since: 4.0)
>>  # @size             Size of the virtual disk in bytes
>> +#                   Mandatory for create
>>  # @version          Compatibility level (default: v3)
>>  # @backing-file     File name of the backing file if a backing file
>>  #                   should be used
>> @@ -4315,10 +4317,10 @@
>>  # Since: 2.12
>>  ##
>>  { 'struct': 'BlockdevCreateOptionsQcow2',
>> -  'data': { 'file':             'BlockdevRef',
>> +  'data': { '*file':            'BlockdevRef',
>>              '*data-file':       'BlockdevRef',
>>              '*data-file-raw':   'bool',
>> -            'size':             'size',
>> +            '*size':            'size',
>>              '*version':         'BlockdevQcow2Version',
>>              '*backing-file':    'str',
>>              '*backing-fmt':     'BlockdevDriver',
>>=20

My comments to the previous patch apply.

> Making these fields optional makes me wonder whether it actually make
> sense to have both create and amend share a single QAPI structure.
> Wouldn=E2=80=99t it better to have a separate amend structure that then a=
ctually
> reflects what we support?  (This would also solve the problem of how to
> express in the code what is and what isn=E2=80=99t supported through
> blockdev-amend.)

Good point.  As is, the schema is rather confusing, at least to me.  We
reduce or avoid the confusion in documentation or in code.  I'd prefer
code unless it leads to too much duplication.  "Too much" is of course
subjective.  Maxim, would you mind exploring it for us?

