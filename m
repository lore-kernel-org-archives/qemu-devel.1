Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749DECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3703B20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6UdFYih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3703B20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfxn-0005uJ-9b
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNfvB-0001FH-5L
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNfv9-0008KL-4y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:25:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNfv8-0008J6-Ra
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571934300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kCoSgfvK/2t5gR1vUEAXOo4jgxjVBFsuJyIk6a7YhRc=;
 b=W6UdFYihh0C5OAB6mVzf1P7Ogzt53Vu7LCcNMmLd9lmcDA46HI4fF2kUGWAxniUUtiAG6I
 ev4oOEXzX/vho4JeVzZeBPjjkgoex9jesSsWsLnwgBmz5YvEkDzU0lYDI6JD+km+HfWn5j
 QRxH+xoDFZs1xbekhtGkDToe3+JxLks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-xE5GD7PyN-mccVaOmbhqdQ-1; Thu, 24 Oct 2019 11:02:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F88261182;
 Thu, 24 Oct 2019 14:39:03 +0000 (UTC)
Received: from work-vm (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97C5210EC746;
 Thu, 24 Oct 2019 14:39:01 +0000 (UTC)
Date: Thu, 24 Oct 2019 15:38:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH] iothread: add set_iothread_poll_* commands
Message-ID: <20191024143859.GJ2877@work-vm>
References: <5DAEB9D3.3080503@huawei.com>
 <20191023151903.GI9574@stefanha-x1.localdomain>
 <5DB1ACF2.9080500@huawei.com> <20191024135645.GG2877@work-vm>
 <5DB1B65C.3020104@huawei.com>
MIME-Version: 1.0
In-Reply-To: <5DB1B65C.3020104@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xE5GD7PyN-mccVaOmbhqdQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 jiangyiwen <jiangyiwen@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zhenyu Ye (yezhenyu2@huawei.com) wrote:
>=20
>=20
> On 2019/10/24 21:56, Dr. David Alan Gilbert wrote:
> > * Zhenyu Ye (yezhenyu2@huawei.com) wrote:
> >>
> >>
> >> On 2019/10/23 23:19, Stefan Hajnoczi wrote:
> >>> On Tue, Oct 22, 2019 at 04:12:03PM +0800, yezhenyu (A) wrote:
> >>>> Since qemu2.9, QEMU added three AioContext poll parameters to struct
> >>>> IOThread: poll_max_ns, poll_grow and poll_shrink. These properties a=
re
> >>>> used to control iothread polling time.
> >>>>
> >>>> However, there isn't properly hmp commands to adjust them when the V=
M is
> >>>> alive. It's useful to adjust them online when observing the impact o=
f
> >>>> different property value on performance.
> >>>>
> >>>> This patch add three hmp commands to adjust iothread poll-* properti=
es
> >>>> for special iothread:
> >>>>
> >>>> set_iothread_poll_max_ns: set the maximum polling time in ns;
> >>>> set_iothread_poll_grow: set how many ns will be added to polling tim=
e;
> >>>> set_iothread_poll_shrink: set how many ns will be removed from polli=
ng
> >>>> time.
> >>>>
> >>>> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> >>>> ---
> >>>> hmp-commands.hx | 42 ++++++++++++++++++++
> >>>> hmp.c | 30 +++++++++++++++
> >>>> hmp.h | 3 ++
> >>>> include/sysemu/iothread.h | 6 +++
> >>>> iothread.c | 80 +++++++++++++++++++++++++++++++++++++++
> >>>> qapi/misc.json | 23 +++++++++++
> >>>> 6 files changed, 184 insertions(+)
> >>>
> >>> poll-max-ns, poll-grow, poll-shrink are properties of IOThread object=
s.
> >>> They can already be modified at runtime using:
> >>>
> >>>   $ qemu -object iothread,id=3Diothread1
> >>>   (qemu) qom-set /objects/iothread1 poll-max-ns 100000
> >>>
> >>> I think there is no need for a patch.
> >>>
> >>> Stefan
> >>>
> >>
> >> Thanks for your review. I have considered using the `qom-set` command =
to modify
> >> IOThread object's properties, however, this command is not friendly to=
 primary
> >> users. The help info for this command is only:
> >>
> >>     qom-set path property value -- set QOM property
> >>
> >> It's almost impossible to get the correct `path` parameter for primary=
 user.
> >=20
> > Is this just a matter of documenting how to do it?
> >=20
> > It sounds like there's no need for a new QMP command though;  if you
> > want an easier HMP command I'd probably still take it (because HMP is o=
k
> > at having things for convenience) - but not if it turns out that just
> > adding a paragraph of documentation is enough.
> >=20
> > Dave
> >=20
>=20
> I will show the differences in QMP and HMP:
> If I want to set iothread1.poll-max-ns=3D1000 and iothread1.poll-grow=3D2=
:
>=20
> Without this patch:
> QMP command:
>=20
>     qom-set /objects/iothread1 poll-max-ns 1000
>     qom-set /objects/iothread1 poll-grow 2
>=20
> HMP command:
>=20
>     { "execute": "qom-set", "arguments": { "path": "/objects/iothread1",
>                                            "property": "poll-max-ns", "va=
lue": 1000 } }
>     { "execute": "qom-set", "arguments": { "path": "/objects/iothread1",
>                                            "property": "poll-grow", "valu=
e": 2} }
>=20
> with this patch:
> QMP command:
>=20
>     iothread_set_parameter iothread1 max-ns 1000
>     iothread_set_parameter iothread1 grow 2
>=20
> HMP command:
>=20
>     { "execute": "set-iothread-poll-params", "arguments': { "iothread-id"=
: "iothread1",
>                                                             "max-ns": 100=
0, "grow": 2 } }
>=20
>=20
> I think the inconvenience of qom-set is how to get the correct `path` par=
ameter.
> Anyway, I will consider your advice.

So it depends how obvious the path is;  if it's just   /objects/
followed by whatever you used with id=3D  when you created the iothread
then I think it's easy - we just need to update the docs.
Is there a case where it's harder to know?

Dave

>=20
> >> This patch provides a more convenient and easy-use hmp&qmp interface t=
o modify
> >> these IOThread properties. I think this patch still has a little value=
.
> >>
> >> And I can implement this patch compactly by reusing your code.
> >>
> >> Waiting for your reply.
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
> >=20
> > .
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


