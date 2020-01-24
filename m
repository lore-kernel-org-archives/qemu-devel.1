Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EF0C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 05:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600B92070A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 05:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeuFMUha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600B92070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iurn1-0008Uw-Iq
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 00:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iurmN-0007wg-3C
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 00:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iurmL-0001BT-8B
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 00:45:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46531
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iurmK-00019E-PV
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 00:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579844711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPfhegMhVYtp7WdGZ7ghk+OtJa7mGpszbakQi+yQBh4=;
 b=VeuFMUhaC+QWdvIwnteQq2Lo73ScYrzSVNA7WV1+PuaXdQfrPCYJXJuAcYK9Y4XoLgrRoF
 Q6HHzzLHfwBvQ8g7hhl3SQrg2hR8vseCIq/jdkTNu8qw2MDydYJzoQBtKBTltGt+50uAZy
 6MRLVQV8WQkRedSccj3LGTlfTDqmmt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-mBVfPiosNsW5h9-sCZvjiA-1; Fri, 24 Jan 2020 00:45:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9B4810054E3;
 Fri, 24 Jan 2020 05:45:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73BA185790;
 Fri, 24 Jan 2020 05:45:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DCF271138600; Fri, 24 Jan 2020 06:45:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: qemu-img convert vs writing another copy tool
References: <20200123183500.GA27166@redhat.com>
 <ef3492f5-b1ab-52d2-9484-3c42e2b6af87@redhat.com>
 <20200123191709.GM3888@redhat.com>
Date: Fri, 24 Jan 2020 06:45:03 +0100
In-Reply-To: <20200123191709.GM3888@redhat.com> (Richard W. M. Jones's message
 of "Thu, 23 Jan 2020 19:17:09 +0000")
Message-ID: <875zh15rxc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: mBVfPiosNsW5h9-sCZvjiA-1
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
Cc: berrange@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 ptoscano@redhat.com, mkletzan@redhat.com, marnold@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Richard W.M. Jones" <rjones@redhat.com> writes:

> On Thu, Jan 23, 2020 at 07:53:57PM +0100, Max Reitz wrote:
>> On 23.01.20 19:35, Richard W.M. Jones wrote:
>> >  - NBD multi-conn.  In my tests this makes a really massive
>> >    performance difference in certain situations.  Again, virt-v2v has
>> >    a lot of information that we cannot pass to qemu: we know, for
>> >    example, exactly if the server supports the feature, how many
>> >    threads are available, in some situations even have information
>> >    about the network and backing disks that the data will travel over
>> >    / be stored on.
>>=20
>> As far as I understand it, you use qemu-img convert with an NBD source
>> or target, too?
>
> Virt-v2v has many modes, but yes generally there will be either an NBD
> source & target, or an NBD source to a local file target.
>
>> I suppose it=E2=80=99s always easier to let a specialized and freshly wr=
itten
>> tool handle such information.  But it sounds like if such information is
>> useful and makes that big of a difference, then it would be good to be
>> able to specify it to qemu=E2=80=99s NBD block driver, too.
>
> qemu-img convert has worked really well for us, and I'm actually _not_
> confident that I could do better with a specialized tool.  But there's
> definitely more info we could pass, such as the amount of parallelism
> we believe is available in the NBD server / processors / disks.
>
>> >  - Machine-parsable progress bars.  You can, sort of, parse the
>> >    progress bar from qemu-img convert, but it's not as easy as it
>> >    could be.  In particular it would be nice if the format was treated
>> >    as ABI, and if there was a way to have the tool write the progress
>> >    bar info to a precreated file descriptor.
>>=20
>> It doesn=E2=80=99t seem impossible to add this feature to qemu-img, alth=
ough I
>> wonder about the interface.  I suppose we could make it an alternative
>> progress output mode (with some command-line flag), and then the
>> information would be emitted to stdout (just like the existing progress
>> report).  You can of course redirect stdout to whatever fd you=E2=80=99d=
 like,
>> so I don=E2=80=99t know whether qemu-img itself needs that specific capa=
bility.
>>=20
>> OTOH, if you need this feature, why not just use qemu itself?  That is,
>> a mirror or a backup block job in an otherwise empty VM.
>
> I don't think we've really thought before about this approach.  Maybe
> the launching of a VM (even an empty / stopped one) could be a
> problem.  I guess this is what the new tool that was recently proposed
> upstream might help with?  (Was it called qemu-block-storage?  I can't
> find it right this minute)

Subject: [RFC PATCH 00/18] Add qemu-storage-daemon
To: qemu-block@nongnu.org
Date: Thu, 17 Oct 2019 15:01:46 +0200
Message-Id: <20191017130204.16131-1-kwolf@redhat.com>

[...]


