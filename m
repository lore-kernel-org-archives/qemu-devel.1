Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20169CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E082021D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vsll/zTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E082021D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNyon-0007jF-JH
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNyc8-0000gM-NQ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNyc7-0007ro-Cc
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:22:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNyc7-0007rZ-8d
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572006162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UpGmtUyfdlvxlAtoSbViodlS/3ZIaP9VCEx3R5W0HcU=;
 b=Vsll/zTAb8rY/QylfbyGpKM24RZ/uIQD0j2HGGCbXVocS9YM2KeOica/JuRihhAurBF61Q
 bzFImkiCI2gdUhO0OGsAGMFvDvSqPnJeAR7KGLweigGjIr4Kwin/81SldIiL0/YQ0Ju25U
 R0hDFFFxJJ/Q0nTWfR7i/wkcrX/9V8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-JlaES2OqMICBY48LEhmXyA-1; Fri, 25 Oct 2019 08:22:40 -0400
X-MC-Unique: JlaES2OqMICBY48LEhmXyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7FA61800E00;
 Fri, 25 Oct 2019 12:22:39 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B1E760852;
 Fri, 25 Oct 2019 12:22:37 +0000 (UTC)
Date: Fri, 25 Oct 2019 13:51:45 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH] iothread: add set_iothread_poll_* commands
Message-ID: <20191025115145.GA13314@stefanha-x1.localdomain>
References: <5DAEB9D3.3080503@huawei.com>
 <20191023151903.GI9574@stefanha-x1.localdomain>
 <5DB1ACF2.9080500@huawei.com> <20191024135645.GG2877@work-vm>
 <5DB1B65C.3020104@huawei.com> <20191024143859.GJ2877@work-vm>
 <5DB258FC.2050506@huawei.com>
MIME-Version: 1.0
In-Reply-To: <5DB258FC.2050506@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, xiexiangyou@huawei.com,
 qemu-devel@nongnu.org, jiangyiwen <jiangyiwen@huawei.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2019 at 10:07:56AM +0800, Zhenyu Ye wrote:
>=20
>=20
> On 2019/10/24 22:38, Dr. David Alan Gilbert wrote:
> > * Zhenyu Ye (yezhenyu2@huawei.com) wrote:
> >>
> >>
> >> On 2019/10/24 21:56, Dr. David Alan Gilbert wrote:
> >>> * Zhenyu Ye (yezhenyu2@huawei.com) wrote:
> >>>>
> >>>>
> >>>> On 2019/10/23 23:19, Stefan Hajnoczi wrote:
> >>>>> On Tue, Oct 22, 2019 at 04:12:03PM +0800, yezhenyu (A) wrote:
> >>>>>> Since qemu2.9, QEMU added three AioContext poll parameters to stru=
ct
> >>>>>> IOThread: poll_max_ns, poll_grow and poll_shrink. These properties=
 are
> >>>>>> used to control iothread polling time.
> >>>>>>
> >>>>>> However, there isn't properly hmp commands to adjust them when the=
 VM is
> >>>>>> alive. It's useful to adjust them online when observing the impact=
 of
> >>>>>> different property value on performance.
> >>>>>>
> >>>>>> This patch add three hmp commands to adjust iothread poll-* proper=
ties
> >>>>>> for special iothread:
> >>>>>>
> >>>>>> set_iothread_poll_max_ns: set the maximum polling time in ns;
> >>>>>> set_iothread_poll_grow: set how many ns will be added to polling t=
ime;
> >>>>>> set_iothread_poll_shrink: set how many ns will be removed from pol=
ling
> >>>>>> time.
> >>>>>>
> >>>>>> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> >>>>>> ---
> >>>>>> hmp-commands.hx | 42 ++++++++++++++++++++
> >>>>>> hmp.c | 30 +++++++++++++++
> >>>>>> hmp.h | 3 ++
> >>>>>> include/sysemu/iothread.h | 6 +++
> >>>>>> iothread.c | 80 +++++++++++++++++++++++++++++++++++++++
> >>>>>> qapi/misc.json | 23 +++++++++++
> >>>>>> 6 files changed, 184 insertions(+)
> >>>>>
> >>>>> poll-max-ns, poll-grow, poll-shrink are properties of IOThread obje=
cts.
> >>>>> They can already be modified at runtime using:
> >>>>>
> >>>>>   $ qemu -object iothread,id=3Diothread1
> >>>>>   (qemu) qom-set /objects/iothread1 poll-max-ns 100000
> >>>>>
> >>>>> I think there is no need for a patch.
> >>>>>
> >>>>> Stefan
> >>>>>
> >>>>
> >>>> Thanks for your review. I have considered using the `qom-set` comman=
d to modify
> >>>> IOThread object's properties, however, this command is not friendly =
to primary
> >>>> users. The help info for this command is only:
> >>>>
> >>>>     qom-set path property value -- set QOM property
> >>>>
> >>>> It's almost impossible to get the correct `path` parameter for prima=
ry user.
> >>>
> >>> Is this just a matter of documenting how to do it?
> >>>
> >>> It sounds like there's no need for a new QMP command though;  if you
> >>> want an easier HMP command I'd probably still take it (because HMP is=
 ok
> >>> at having things for convenience) - but not if it turns out that just
> >>> adding a paragraph of documentation is enough.
> >>>
> >>> Dave
> >>>
> >>
> >> I will show the differences in QMP and HMP:
> >> If I want to set iothread1.poll-max-ns=3D1000 and iothread1.poll-grow=
=3D2:
> >>
> >> Without this patch:
> >> QMP command:
> >>
> >>     qom-set /objects/iothread1 poll-max-ns 1000
> >>     qom-set /objects/iothread1 poll-grow 2
> >>
> >> HMP command:
> >>
> >>     { "execute": "qom-set", "arguments": { "path": "/objects/iothread1=
",
> >>                                            "property": "poll-max-ns", =
"value": 1000 } }
> >>     { "execute": "qom-set", "arguments": { "path": "/objects/iothread1=
",
> >>                                            "property": "poll-grow", "v=
alue": 2} }
> >>
> >> with this patch:
> >> QMP command:
> >>
> >>     iothread_set_parameter iothread1 max-ns 1000
> >>     iothread_set_parameter iothread1 grow 2
> >>
> >> HMP command:
> >>
> >>     { "execute": "set-iothread-poll-params", "arguments': { "iothread-=
id": "iothread1",
> >>                                                             "max-ns": =
1000, "grow": 2 } }
> >>
> >>
> >> I think the inconvenience of qom-set is how to get the correct `path` =
parameter.
> >> Anyway, I will consider your advice.
> >=20
> > So it depends how obvious the path is;  if it's just   /objects/
> > followed by whatever you used with id=3D  when you created the iothread
> > then I think it's easy - we just need to update the docs.
> > Is there a case where it's harder to know?
> >=20
> > Dave
> >=20
>=20
> You are right, it's just /objects/ followed by the id. Maybe we just need
> to update the docs for qom-set.

The documentation for qom-set will become very large and unwieldy if the
properties of all objects are documented there.

I will send a patch documenting -object iothread and CC you.

Stefan

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2y4c4ACgkQnKSrs4Gr
c8g3UQf/fcCQEWSjRtNXN6aRlj/b3m9yJpB14lFiVbbZiLHOaI/eJYCBBrTxmRdT
DOk8R9diFSzpBXMfgV37XOY3TcNME+Bb61TP0iTDuvDTol4PKDzRq2+fNyZzvyn4
uujpiVxBh8qGv200JuCaHiz1vfW2jEUF5kqTrkTrIMdlrCnRCYf6maV1uYLO1NVn
94aN/Vg8/PLgNCyKbWu3g7L7VYbOIBhNVhs4tZKb+1mJdIYJkhklzVqFnTs/ORr8
ATaBy6m7wEdw5rKOP2zNLi+UiiAmUQoUJ4y1AiRx3/BEiNnD2p/ia+dAaw+HQnUL
7QhSQqmaA6kyrqTQJQFd463/nDzx3A==
=atyU
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--


