Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2105AC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 20:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC022081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 20:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC022081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irpTC-0000qK-W4
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 15:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1irpSE-0008VI-EW
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 15:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1irpSB-0004wK-BM
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 15:39:53 -0500
Received: from relay64.bu.edu ([128.197.228.104]:34950)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1irpSB-0004tW-7P
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 15:39:51 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 00FKchHZ021456
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 15 Jan 2020 15:38:47 -0500
Date: Wed, 15 Jan 2020 15:38:43 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 11/21] libqtest: make bufwrite rely on the TransportOps
Message-ID: <20200115203843.w34q4wldlo6s6l7y@mozz.bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-12-alxndr@bu.edu>
 <3745422f-0b12-d1ba-4c7c-b51ddf734012@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3745422f-0b12-d1ba-4c7c-b51ddf734012@redhat.com>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by relay64.bu.edu id
 00FKchHZ021456
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x [fuzzy]
X-Received-From: 128.197.228.104
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200103 1745, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/29/19 10:34 PM, Oleinik, Alexander wrote:
> > When using qtest "in-process" communication, qtest_sendf directly cal=
ls
> > a function in the server (qtest.c). Previously, bufwrite used
> > socket_send, which bypasses the TransportOps enabling the call into
> > qtest.c. This change replaces the socket_send calls with ops->send,
> > maintaining the benefits of the direct socket_send call, while adding
> > support for in-process qtest calls.
> >=20
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >   tests/libqtest.c | 4 ++--
> >   tests/libqtest.h | 3 +++
> >   2 files changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tests/libqtest.c b/tests/libqtest.c
> > index ac4b6ab5f0..a7df92319a 100644
> > --- a/tests/libqtest.c
> > +++ b/tests/libqtest.c
> > @@ -1080,8 +1080,8 @@ void qtest_bufwrite(QTestState *s, uint64_t add=
r, const void *data, size_t size)
> >       bdata =3D g_base64_encode(data, size);
> >       qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
> > -    socket_send(s->fd, bdata, strlen(bdata));
> > -    socket_send(s->fd, "\n", 1);
> > +    s->ops.send(s, bdata);
> > +    s->ops.send(s, "\n");
>=20
> Ah, is this the send_line() from patch #5?
>=20
> Now it makes sense to move the send("\n") there and call it send_line().
>=20
> Moving the send(\n) we get this in patch #5:
>=20
>  static void qtest_client_socket_send_line(QTestState *s,
>                                            const char *bufline)
>  {
>      socket_send(s->fd, bufline, strlen(bufline));
>      socket_send(s->fd, "\n", 1);
>  }

Would this also involve changing all of the
qtest_{clock_step,in,out,read,write...} functions to remove the '\n'
from the calls to qtest_sendf? Not that it matters much, but it also
seems to double the number of syscalls needed to send each qtest
command.

> >       qtest_rsp(s, 0);
> >       g_free(bdata);
> >   }
> > diff --git a/tests/libqtest.h b/tests/libqtest.h
> > index c9e21e05b3..0e9b8908ef 100644
> > --- a/tests/libqtest.h
> > +++ b/tests/libqtest.h
> > @@ -729,4 +729,7 @@ bool qtest_probe_child(QTestState *s);
> >    */
> >   void qtest_set_expected_status(QTestState *s, int status);
> > +QTestState *qtest_inproc_init(bool log, const char* arch,
> > +                    void (*send)(void*, const char*));
> > +void qtest_client_inproc_recv(void *opaque, const char *str);
> >   #endif
> >=20
>=20

