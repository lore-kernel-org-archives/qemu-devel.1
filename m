Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED17C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAF42176D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHlorumP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAF42176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4PvR-0002TP-Rw
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4Pu5-0001Pk-JT
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4Pu3-0000gO-Ub
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:00:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21752
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4Pu3-0000fk-RB
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582120838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3i/InxT9JzSrF++DNrWjgeL7EZ+SBaEUF4oYWSb/xU=;
 b=cHlorumPsRZUf4j/iB+0nfo1cHSQDAji670xK2HuiUNRxCKW0drOoaZUvSMf51MSbH+rKT
 OWiNPeo2AEZKimvS0y5txe9GSJPM2cwOmvwNwE5ca9DSTqhVqVoM14AFe1nmyS9liaMkWz
 3uod8+NV6GIl/2licoVQW4/mCW/pS6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-8fTHce-QNXmol5ltJDfS8Q-1; Wed, 19 Feb 2020 09:00:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD3CA8010CA;
 Wed, 19 Feb 2020 14:00:27 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9F8B5C3FA;
 Wed, 19 Feb 2020 14:00:23 +0000 (UTC)
Subject: Re: [PATCH v2 00/22] Fix error handling during bitmap postcopy
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <33fa0ba7-714f-c78d-8ca5-1e15dcef5ac4@virtuozzo.com>
 <f44bfdb9-0ddc-3b1a-0279-7e9ebd9f399f@redhat.com>
 <b0e67ac9-987b-811e-f0ac-7a9c92a2771a@virtuozzo.com>
 <633ea62c-dad6-9cd6-1490-7a827f036417@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5fb2762d-785b-1d5f-cee2-eb3478f7b2b8@redhat.com>
Date: Wed, 19 Feb 2020 08:00:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <633ea62c-dad6-9cd6-1490-7a827f036417@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 8fTHce-QNXmol5ltJDfS8Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-stable@nongnu.org, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/19/20 7:36 AM, Eric Blake wrote:

>> +od: unrecognized option '--endian=3Dbig'
>> +Try 'od --help' for more information.
>> +od: invalid -N argument '--endian=3Dbig'
>> +qemu-img: Could not open 'TEST_DIR/t.IMGFMT': IMGFMT header exceeds=20
>> cluster size
>=20
> Which version of od are you using?=C2=A0 I do recall wondering whether=20
> reliance on the GNU coreutils extension --endian=3Dbig was going to cause=
=20
> problems later - well, here we are, it's later :)
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06781.html

coreutils documents that od --endian was added in 8.23, released in=20
2014-07-18.  Per https://wiki.qemu.org/Supported_Build_Platforms, we=20
still have support for RHEL 7 through 2022, and it was first released=20
2014-06-09 (all other supported distros have newer releases, but I=20
didn't check what coreutils version they included, or even if the BSD=20
builds which don't use coreutils would also be impacted by this=20
problem).  Still, I'd like to know your specific setup, and why the CI=20
tools have not flagged it.

But even one counterexample within the bounds of our supported distro=20
page is a good argument that use of od --endian is not yet portable.=20
Or, if your setup is not on the supported page, it becomes a question of=20
whether it should be added or whether you should upgrade to something=20
that is supported.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


