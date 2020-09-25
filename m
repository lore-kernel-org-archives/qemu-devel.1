Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD8C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1075208A9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FG/hanbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1075208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoKg-0004nn-VJ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLo9z-0007kA-SD
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLo9u-0001IR-15
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:53:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601041989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BTJrFTNcJdz2v+DJj/OAeEgd2eDDcgpNnDPMqOZIIm8=;
 b=FG/hanbFrH58JxhAjDs+n7PmfqLn1fsB6LPYavFNZQztFb3OAN6NofzdCVvCTA10vKVb7p
 LnwLlDSKITZdbG0GTOu2fkEIKpAKUbDAFTK2Fd7FTAEYKdjGbiRgQM0Lx1kazE0W2p8Ib7
 nR/Fais20pXQmfy8qbi9sx0QY1bFPuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-a1utzr5-Ny2Lk_NEI_tr4A-1; Fri, 25 Sep 2020 09:52:58 -0400
X-MC-Unique: a1utzr5-Ny2Lk_NEI_tr4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8943184E247;
 Fri, 25 Sep 2020 13:52:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59CBA619B5;
 Fri, 25 Sep 2020 13:52:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E1CBD113865F; Fri, 25 Sep 2020 15:52:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 28/38] qapi/gen.py: update write() to be more idiomatic
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-29-jsnow@redhat.com>
 <20200923152624.GO3312949@habkost.net>
 <c0b8ed9e-c66a-a6fa-43e1-c3c61581d928@redhat.com>
 <20200924155959.GC191229@localhost.localdomain>
 <87r1qqro8i.fsf@dusky.pond.sub.org>
 <20200925132458.GJ2178035@redhat.com>
Date: Fri, 25 Sep 2020 15:52:55 +0200
In-Reply-To: <20200925132458.GJ2178035@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Fri, 25 Sep 2020 14:24:58 +0100")
Message-ID: <874knmq7yg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Sep 25, 2020 at 03:15:57PM +0200, Markus Armbruster wrote:
>> Cleber Rosa <crosa@redhat.com> writes:
>>=20
>> > On Wed, Sep 23, 2020 at 02:37:27PM -0400, John Snow wrote:
>> >> On 9/23/20 11:26 AM, Eduardo Habkost wrote:
>> >> > On Tue, Sep 22, 2020 at 05:00:51PM -0400, John Snow wrote:
>> >> > > Make the file handling here just a tiny bit more idiomatic.
>> >> > > (I realize this is heavily subjective.)
>> >> > >=20
>> >> > > Use exist_ok=3DTrue for os.makedirs and remove the exception,
>> >> > > use fdopen() to wrap the file descriptor in a File-like object,
>> >> > > and use a context manager for managing the file pointer.
>> >> > >=20
>> >> > > Signed-off-by: John Snow <jsnow@redhat.com>
>> >> >=20
>> >> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> >> >=20
>> >> > I really miss a comment below explaining why we use
>> >> > open(os.open(pathname, ...), ...) instead of open(pathname, ...).
>>=20
>> This code:
>>=20
>>         fd =3D os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
>>         f =3D open(fd, 'r+', encoding=3D'utf-8')
>>=20
>> >> Not known to me. It was introduced in 907b846653 as part of an effort=
 to
>> >> reduce rebuild times. Maybe this avoids a modification time change if=
 the
>> >> file already exists?
>> >>=20
>> >> Markus?
>> >
>> > AFACIT the change on 907b846653 is effective because of the "is new
>> > text different from old text?" conditional.  I can not see how the
>> > separate/duplicate open/fdopen would contribute to that.
>> >
>> > But, let's hear from Markus.
>>=20
>> This was my best attempt to open the file read/write, creating it if it
>> doesn't exist.
>>=20
>> Plain
>>=20
>>         f =3D open(pathname, "r+", encoding=3D'utf-8')
>>=20
>> fails instead of creates, and
>>=20
>>         f =3D open(pathname, "w+", encoding=3D'utf-8')
>>=20
>> truncates.
>>=20
>> If you know a better way, tell me!
>
> IIUC, you need  "a+" as the mode, rather than "w+"

Sure this lets me do

            f.seek(0)
            f.truncate(0)
            f.write(text)

to overwrite the old contents on all systems?

Documentation cautions:

    [...] 'a' for appending (which on some Unix systems, means that all
    writes append to the end of the file regardless of the current seek
    position).


