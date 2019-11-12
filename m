Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F9EC17440
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 12:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BAB206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 12:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqPjdRl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BAB206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUUy4-0000CR-J8
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 07:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iUUxE-00084R-FB
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 07:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iUUxB-0003UJ-5P
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 07:07:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49288
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iUUxA-0003Tt-PU
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 07:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573560443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZiATkY4EU6UkPsPn9LGSQcSmhTzj5Z/sbp9Uw9awJ0=;
 b=NqPjdRl5DBYFY2XcmMgd0Z9Y+7BiCv4bOoPnVwvN60NSKRm0LvAE6p3+o1mjNO8vOmXPXg
 PQKWbJyhTDClFMh3iWp+7c43xmv+qefIDaLUn+i7e20Ic3JBIuLn5JFBzqiyzlhxKan6Y1
 UdN8Ln4g2lLx97BbBCJLfbpUA3jQLmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-ynGjU3m1N4yveMLye8fntQ-1; Tue, 12 Nov 2019 07:07:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5F3A800EB3;
 Tue, 12 Nov 2019 12:07:21 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5A0F6106C;
 Tue, 12 Nov 2019 12:07:16 +0000 (UTC)
Message-ID: <5a9f329058f6633878eb7d1c7170ae2cfab7e235.camel@redhat.com>
Subject: Re: [PATCH v2 00/11] RFC crypto/luks: encryption key managment
 using amend interface
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Tue, 12 Nov 2019 14:07:15 +0200
In-Reply-To: <86918b16-a3c1-4b1e-7e21-1b8e84411065@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <fb2cd2e0-2718-215f-d6af-59b64b229b4f@redhat.com>
 <adcb2b6e5a28573c762f8b0d73541ae12d16fc0d.camel@redhat.com>
 <86918b16-a3c1-4b1e-7e21-1b8e84411065@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ynGjU3m1N4yveMLye8fntQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel
 P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-11-12 at 12:58 +0100, Max Reitz wrote:
> On 08.11.19 16:07, Maxim Levitsky wrote:
> > On Fri, 2019-10-04 at 21:10 +0200, Max Reitz wrote:
> > > On 13.09.19 00:30, Maxim Levitsky wrote:
> > > > This patch series is continuation of my work to add encryption
> > > > key managment to luks/qcow2 with luks.
> > > >=20
> > > > This is second version of this patch set.
> > > > The changes are mostly addressing the review feedback,
> > > > plus I tested (and fixed sadly) the somewhat ugly code
> > > > that allows to still write share a raw luks device,
> > > > while preveting the key managment from happening in this case,
> > > > as it is unsafe.
> > > > I added a new iotest dedicated to that as well.
> > > >=20
> > > > Best regards,
> > > > =09Maxim Levitsky
> > >=20
> > > At least for an RFC looks good from my perspective.  I didn=E2=80=99t=
 look at
> > > the crypto things very closely (assuming Dan would do so), and I didn=
=E2=80=99t
> > > check the iotests in detail.  (But it definitely doesn=E2=80=99t look=
 like they
> > > lack in breadth.  Maybe I=E2=80=99d like to see a test that you canno=
t have
> > > other useful nodes attached to the LUKS or qcow2 node while the
> > > amendment process is ongoing (because CONSISTENT_READ is unshared).  =
But
> > > that=E2=80=99s the only thing I can think of.)
> >=20
> > Could you elaborate on this?=20
> >=20
> > Inside the same process several users can access that luks node at the =
same
> > time while one of them changes encryption keys, since this doesn't affe=
ct IO of the data.
> >=20
> > Two users in same process I was *I think* told that can't do the amend =
in the same time
> > since qmp is protected with a lock. However since I use a block job (to=
 be consistent with blockdev-create)
> > I wonder if several qmp amend commands couldn't race one with another. =
These jobs is running
> > on the block device AIO context (I changed this recently after a review=
), but stil I am not sure
> > there can't be a race.
> >=20
> > And when there is access to the same image from multiple processes, I d=
o have a test that
> > checks that as long as more that one process has the image open, noone =
can change the encryption keys
> > (this is only relevant for raw luks format, since for qcow2 this is for=
bidden anyway).
>=20
> Yes, sorry, I don=E2=80=99t remember/know where I got the qcow2 part from=
.  (I
> probably just forgot during after reviewing that only LUKS=E2=80=99s perm=
issions
> are changed by this series.)
>=20
> But for LUKS, those changed permissions do apply.  If you can=E2=80=99t d=
o
> something between two different qemu instances, you can=E2=80=99t do it i=
n a
> single one: The file locks are equivalent to the internal permission mask=
.
>=20
> So if you can=E2=80=99t change the encryption keys while another process =
has the
> image open, you can=E2=80=99t change the encryption keys while another no=
de uses
> the file node in the same process.  For example, you can=E2=80=99t attach=
 two
> LUKS nodes to a single file node and then change the keys on one of the
> nodes.
>=20
> Max
>=20
Ah, I understand now. I'll add a test for that!

Best regards,
=09Maxim Levitsky


