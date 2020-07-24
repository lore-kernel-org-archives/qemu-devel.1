Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E759C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE6720714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gidCBKqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE6720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyriK-0007UV-2z
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 03:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyrhV-00074f-39
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:01:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20825
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyrhS-0002pj-H6
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595574056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ZhzurZ3jkx2f4JV7Mqj7UPcA6W5MhNpPEz1GMoAcKw=;
 b=gidCBKqGD8VPB7UcHVxBb1uETqHUctiPorEqxs9PuIeHevIRctSzROwuDpZ3XJuo9KBoTt
 X5l6ryCM5yAcRml5RZQMrOukadU0kiVRqsnznNPAKVyxKPJ3pD8Vk2HwYUQ1E+NavTY1xa
 Zsg8X1cINvKqSPNXq496Y3PUQJmp2zw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-tTM7jx4cN7C05x9Y-sgjBg-1; Fri, 24 Jul 2020 03:00:54 -0400
X-MC-Unique: tTM7jx4cN7C05x9Y-sgjBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7C72100AA23
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 07:00:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 886707AC80;
 Fri, 24 Jul 2020 07:00:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B2ED111CA26; Fri, 24 Jul 2020 09:00:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 3/3] scripts/qmp/qom-fuse: Fix getattr(),
 read() for files in /
References: <20200723142738.1868568-1-armbru@redhat.com>
 <20200723142738.1868568-4-armbru@redhat.com>
 <7850b7db-d1ec-638c-c044-3cc0e6d2a1a0@redhat.com>
Date: Fri, 24 Jul 2020 09:00:52 +0200
In-Reply-To: <7850b7db-d1ec-638c-c044-3cc0e6d2a1a0@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 23 Jul 2020 17:10:14
 +0200")
Message-ID: <87ft9he6sb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 01:23:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/23/20 4:27 PM, Markus Armbruster wrote:
>> path, prop =3D "type".rsplit('/', 1) sets path to "", which doesn't
>> work.  Correct to "/".
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qmp/qom-fuse | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
>> index 405e6ebd67..7c7cff8edf 100755
>> --- a/scripts/qmp/qom-fuse
>> +++ b/scripts/qmp/qom-fuse
>> @@ -45,8 +45,10 @@ class QOMFS(Operations):
>>              return False
>> =20
>>      def is_property(self, path):
>> +        path, prop =3D path.rsplit('/', 1)
>> +        if path =3D=3D '':
>> +            path =3D '/'
>>          try:
>> -            path, prop =3D path.rsplit('/', 1)
>
> Maybe worth adding an tiny root_path_split() helper?

The script goes back to commit 5ade767485 "qom: quick and dirty QOM
filesystem based on FUSE" (2014).  It's as "quick and dirty" as ever.
It could use a thorough rework.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

[...]


