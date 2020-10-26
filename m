Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ECCC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8807E20773
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8807E20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3rE-0003jk-Gi
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX3mZ-0007NW-7l
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:47:35 -0400
Received: from 7.mo52.mail-out.ovh.net ([188.165.59.253]:41585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX3mX-00020H-11
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:47:34 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.68])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id E06A61FFD66;
 Mon, 26 Oct 2020 15:47:28 +0100 (CET)
Received: from kaod.org (37.59.142.100) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 26 Oct
 2020 15:47:28 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003c3b2a2d3-5704-487b-aa99-9f8972f0b8ca,
 D69A261E470FD7A087455D2B3B9CC66C186A091D) smtp.auth=groug@kaod.org
Date: Mon, 26 Oct 2020 15:47:22 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 4/4] spapr: Improve spapr_reallocate_hpt() error reporting
Message-ID: <20201026154722.3b573be7@bahia.lan>
In-Reply-To: <b67330f6-797c-f088-b6fa-7e81075e2245@redhat.com>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
 <160371605460.305923.5890143959901241157.stgit@bahia.lan>
 <b67330f6-797c-f088-b6fa-7e81075e2245@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: d7dde868-e3a4-4be8-ba91-7c37d7606c7c
X-Ovh-Tracer-Id: 16248987459836221920
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkeejgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.59.253; envelope-from=groug@kaod.org;
 helo=7.mo52.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 10:47:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 14:49:34 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 10/26/20 1:40 PM, Greg Kurz wrote:
> > spapr_reallocate_hpt() has three users, two of which pass &error_fatal
> > and the third one, htab_load(), passes &local_err, uses it to detect
> > failures and simply propagates -EINVAL up to vmstate_load(), which will
> > cause QEMU to exit. It is thus confusing that spapr_reallocate_hpt()
> > doesn't return right away when an error is detected in some cases. Also,
> > the comment suggesting that the caller is welcome to try to carry on
> > seems like a remnant in this respect.
> >=20
> > This can be improved:
> > - change spapr_reallocate_hpt() to always report a negative errno on
> >    failure, either as reported by KVM or -ENOSPC if the HPT is smaller
> >    than what was asked,
> > - use that to detect failures in htab_load() which is preferred over
> >    checking &local_err,
> > - propagate this negative errno to vmstate_load() because it is more
> >    accurate than propagating -EINVAL for all possible errors.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> ...
>=20
> > -void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
> > -                          Error **errp)
> > +int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **=
errp)
> >   {
> >       ERRP_GUARD();
> >       long rc;
> > @@ -1496,7 +1495,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spap=
r, int shift,
> >  =20
> >       if (rc =3D=3D -EOPNOTSUPP) {
> >           error_setg(errp, "HPT not supported in nested guests");
> > -        return;
> > +        return -EOPNOTSUPP;
> >       }
> >  =20
> >       if (rc < 0) {
> > @@ -1504,8 +1503,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spap=
r, int shift,
> >           error_setg_errno(errp, errno, "Failed to allocate KVM HPT of =
order %d",
> >                            shift);
> >           error_append_hint(errp, "Try smaller maxmem?\n");
> > -        /* This is almost certainly fatal, but if the caller really
> > -         * wants to carry on with shift =3D=3D 0, it's welcome to try =
*/
> > +        return -errno;
>=20
> Maybe returning here should be in a previous patch.
> Otherwise patch looks good.
>=20

It could have been indeed...

> >       } else if (rc > 0) {
> >           /* kernel-side HPT allocated */
> >           if (rc !=3D shift) {
> > @@ -1513,6 +1511,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spap=
r, int shift,
> >                          "Requested order %d HPT, but kernel allocated =
order %ld",
> >                          shift, rc);
> >               error_append_hint(errp, "Try smaller maxmem?\n");
> > +            return -ENOSPC;

... along with this one.

I didn't go this way because it doesn't really affect the final behavior si=
nce
QEMU exits in all cases. It's mostly about propagating an appropriate errno=
 up
to VMState in the case of htab_load(). But if you find it clearer and I need
to post a v2, I can certainly do that.

> >           }
> >  =20
> >           spapr->htab_shift =3D shift;
> > @@ -1533,6 +1532,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spap=
r, int shift,
> >       /* We're setting up a hash table, so that means we're not radix */
> >       spapr->patb_entry =3D 0;
> >       spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
> > +    return 0;
> >   }
> >  =20
> >   void spapr_setup_hpt(SpaprMachineState *spapr)
> > @@ -2286,11 +2286,13 @@ static int htab_load(QEMUFile *f, void *opaque,=
 int version_id)
> >       }
> >  =20
> >       if (section_hdr) {
> > +        int ret;
> > +
> >           /* First section gives the htab size */
> > -        spapr_reallocate_hpt(spapr, section_hdr, &local_err);
> > -        if (local_err) {
> > +        ret =3D spapr_reallocate_hpt(spapr, section_hdr, &local_err);
> > +        if (ret < 0) {
> >               error_report_err(local_err);
> > -            return -EINVAL;
> > +            return ret;
> >           }
> >           return 0;
> >       }
> ...
>=20


