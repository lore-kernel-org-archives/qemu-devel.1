Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371B1C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 20:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007E3214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 20:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlsFH4/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007E3214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUcav-0007gL-5k
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 15:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iUcaD-0007DH-VF
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 15:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iUcaA-00006F-5O
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 15:16:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60462
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iUca9-00005D-K9
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 15:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573589768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTAB+bhQUyGoE7iXKbW+GaFHgKl3QOzfk/vtOtBbFh4=;
 b=GlsFH4/W7c7LoGYm5fQnvHNgGkzibTcIHNchAeGvaRG1pb/AfX7Ox8Gt6IQVK+m29wqaXN
 9Mi5NAjvs+6iwRkOiCFOQ/IdqPkPBNBnUllXnQqEwtXCrQWIzINf9Mjj16ClHz2yHTIRzQ
 5O+1oyxkhfkr6QP9SRHsJ/AuVdvxkuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-cAsmu7yHP4-LDQF31e_35g-1; Tue, 12 Nov 2019 15:16:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E51DDB20;
 Tue, 12 Nov 2019 20:16:03 +0000 (UTC)
Received: from localhost (ovpn-116-59.gru2.redhat.com [10.97.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBEF961081;
 Tue, 12 Nov 2019 20:15:59 +0000 (UTC)
Date: Tue, 12 Nov 2019 17:15:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v14 03/11] tests: Add test for QAPI builtin type time
Message-ID: <20191112201558.GG3812@habkost.net>
References: <20191028075220.25673-1-tao3.xu@intel.com>
 <20191028075220.25673-4-tao3.xu@intel.com>
 <20191106205359.GR3812@habkost.net>
 <1f2fa942-0993-548b-1f5c-8345d564bf29@intel.com>
 <20191107133112.GS3812@habkost.net>
 <9ecafb7f-69b9-870b-b109-939fef47acde@intel.com>
 <87lfsqbxnj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87lfsqbxnj.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: cAsmu7yHP4-LDQF31e_35g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, Tao Xu <tao3.xu@intel.com>, "Du,
 Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 09:05:52AM +0100, Markus Armbruster wrote:
> Tao Xu <tao3.xu@intel.com> writes:
>=20
> > On 11/7/2019 9:31 PM, Eduardo Habkost wrote:
> >> On Thu, Nov 07, 2019 at 02:24:52PM +0800, Tao Xu wrote:
> >>> On 11/7/2019 4:53 AM, Eduardo Habkost wrote:
> >>>> On Mon, Oct 28, 2019 at 03:52:12PM +0800, Tao Xu wrote:
> >>>>> Add tests for time input such as zero, around limit of precision,
> >>>>> signed upper limit, actual upper limit, beyond limits, time suffixe=
s,
> >>>>> and etc.
> >>>>>
> >>>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> >>>>> ---
> >>>> [...]
> >>>>> +    /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set=
) */
> >>>>> +    qdict =3D keyval_parse("time1=3D9223372036854774784," /* 7ffff=
ffffffffc00 */
> >>>>> +                         "time2=3D9223372036854775295", /* 7ffffff=
ffffffdff */
> >>>>> +                         NULL, &error_abort);
> >>>>> +    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> >>>>> +    qobject_unref(qdict);
> >>>>> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> >>>>> +    visit_type_time(v, "time1", &time, &error_abort);
> >>>>> +    g_assert_cmphex(time, =3D=3D, 0x7ffffffffffffc00);
> >>>>> +    visit_type_time(v, "time2", &time, &error_abort);
> >>>>> +    g_assert_cmphex(time, =3D=3D, 0x7ffffffffffffc00);
> >>>>
> >>>> I'm confused by this test case and the one below[1].  Are these
> >>>> known bugs?  Shouldn't we document them as known bugs?
> >>>
> >>> Because do_strtosz() or do_strtomul() actually parse with strtod(), s=
o the
> >>> precision is 53 bits, so in these cases, 7ffffffffffffdff and
> >>> fffffffffffffbff are rounded.
> >>
> >> My questions remain: why isn't this being treated like a bug?
> >>
> > Hi Markus,
> >
> > I am confused about the code here too. Because in do_strtosz(), the
> > upper limit is
> >
> > val * mul >=3D 0xfffffffffffffc00
> >
> > So some data near 53 bit may be rounded. Is there a bug?
>=20
> No, but the design is surprising, and the functions lack written
> contracts, except for the do_strtosz() helper, which has one that sucks.
>=20
> qemu_strtosz() & friends are designed to accept fraction * unit
> multiplier.  Example: 1.5M means 1.5 * 1024 * 1024 with qemu_strtosz()
> and qemu_strtosz_MiB(), and 1.5 * 1000 * 1000 with
> qemu_strtosz_metric().  Whether supporting fractions is a good idea is
> debatable, but it's what we've got.
>=20
> The implementation limits the numeric part to the precision of double,
> i.e. 53 bits.  "8PiB should be enough for anybody."
>=20
> Switching it from double to long double raises the limit to the
> precision of long double.  At least 64 bit on common hosts, but hosts
> exist where it's the same 53 bits.  Do we support any such hosts?  If
> yes, then we'd make the precision depend on the host, which feels like a
> bad idea.
>=20
> A possible alternative is to parse the numeric part both as a double and
> as a 64 bit unsigned integer, then use whatever consumes more
> characters.  This enables providing full 64 bits unless you actually use
> a fraction.
>=20

This sounds like the right thing to do, if user input is an
integer and the code in the other end is consuming an integer.


> As far as I remember, the only problem we've ever had with the 53 bits
> limit is developer confusion :)
>=20

Developer confusion, I can deal with.  However, exposing this
behavior on external interfaces is a bug to me.

I don't know how serious the bug is because I don't know which
interfaces are affected by it.  Do we have a list?

> Patches welcome.

My first goal is to get the maintainers of that code to recognize
it as a bug.  Then I hope this will motivate somebody else to fix
it.  :)

--=20
Eduardo


