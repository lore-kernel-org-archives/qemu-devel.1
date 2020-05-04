Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8992EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527FA2075B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHRqMwmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527FA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVb9y-0008RF-G9
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVb9M-0007uW-IX
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:28:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40073
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVb9L-0003Ho-RZ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588598926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ArTO3f15g9+tIA1vP96wRxM6KoaDCT/8Is1f4TZJIDU=;
 b=fHRqMwmLeeaLJ2wayFmDAttI3VNQ+a7u4+fMajkl6JZnhDxsqbDO19jfHlpPqdOQOonTWN
 Ojou2M2MYLBFM6tLYHYAUgIlh6pKnZEHzx+9Peyc2c2yKIzdBlHlnWtKJdI5R8srIf6b6s
 4u9K+mufNNK2WSyHfMlf6azx8eda5Lg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-8GDAo5-sMOCRMbsdjY8DDQ-1; Mon, 04 May 2020 09:28:43 -0400
X-MC-Unique: 8GDAo5-sMOCRMbsdjY8DDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45CDA107ACF3;
 Mon,  4 May 2020 13:28:42 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E06165C1B2;
 Mon,  4 May 2020 13:28:41 +0000 (UTC)
Subject: Re: [PATCH v2 3/6] qemu-img: Add bitmap sub-command
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200421212019.170707-1-eblake@redhat.com>
 <20200421212019.170707-4-eblake@redhat.com>
 <1dcf85b6-d9e6-b952-537c-791daec34ad9@redhat.com>
 <9d4769d4-09ea-dced-d4bd-9ceb33044202@redhat.com>
 <d7c63e6a-a4a8-5b75-5dec-e4f392b3035d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f973e90e-1405-143b-b2c1-314be68ab2ce@redhat.com>
Date: Mon, 4 May 2020 08:28:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d7c63e6a-a4a8-5b75-5dec-e4f392b3035d@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 5:01 AM, Max Reitz wrote:

>>>> +.. option:: bitmap {--add [-g GRANULARITY] [--disabled] | --remove |
>>>> --clear | --enable | --disable | --merge SOURCE_BITMAP [-b
>>>> SOURCE_FILE [-F SOURCE_FMT]]} [--object OBJECTDEF] [--image-opts] [-f
>>>> FMT] FILENAME BITMAP
>>>
>>> So I can do multiple operations in one roll, but they all use the same
>>> BITMAP?=C2=A0 Sounds a bit weird.=C2=A0 It actually took me a while to =
understands
>>> this, because I thought for sure that each command would take a bitmap
>>> name.=C2=A0 (And was ready to complain that it looked like they don=E2=
=80=99t, but,
>>> well, that=E2=80=99s because they don=E2=80=99t.)
>>
>> All of the operations take one bitmap name (the final BITMAP).
>> Additionally, the --merge operation takes a second bitmap name
>> (SOURCE_BITMAP).=C2=A0 None of the other operations need a second bitmap
>> name, so only --merge requires an option argument.=C2=A0 As written, the=
 { a
>> | b | c } implies that operations are mutually exclusive: you can only
>> request one operation per qemu-img invocation.
>=20
> Well, as I found out later it=E2=80=99s supposed to imply that.  I always=
 expect
> {} to mean repetition.


>> In command line syntax, I'm most used to seeing repetition as '...',
>> optional as [], and mutually-exclusive choice as {|}.=C2=A0 Yes, that's
>> different than EBNF.
>=20
> It=E2=80=99s confusing is what it is, and unnecessarily so.  The | alread=
y
> signifies exclusion: Say there are -a and -b, if they=E2=80=99re not mutu=
ally
> exclusive, then the doc describe them as =E2=80=9C[-a] [-b]=E2=80=9D; if =
they are, it=E2=80=99d
> be =E2=80=9C-a | -b=E2=80=9D.  Maybe =E2=80=9C(-a | -b)=E2=80=9D.

Is s/{/(/ is all the more that would be needed to take this patch as-is?=20
  Or should I really try and re-write it to take a list of operations,=20
and iterate through the list until the first failure?

(At any rate, I'll probably end up trying that anyways, just for=20
comparison in the lines of code...)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


