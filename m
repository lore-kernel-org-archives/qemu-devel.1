Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD6C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A638D20821
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A638D20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGTy4-0007lu-Kg
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 15:42:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hGTxJ-0007Tn-M5
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hGTxI-0000Dh-3m
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:41:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hGTxF-00009Q-BY
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A19C83092641;
	Tue, 16 Apr 2019 19:41:13 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com
	[10.18.17.132])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D38B219C67;
	Tue, 16 Apr 2019 19:41:10 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190415154503.6758-1-berrange@redhat.com>
	<20190415154503.6758-3-berrange@redhat.com>
Date: Tue, 16 Apr 2019 15:41:09 -0400
In-Reply-To: <20190415154503.6758-3-berrange@redhat.com> ("Daniel
	P. \=\?utf-8\?Q\?Berrang\=C3\=A9\=22's\?\= message of "Mon,
	15 Apr 2019 16:45:02 +0100")
Message-ID: <jpg5zrdbuwa.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 16 Apr 2019 19:41:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] usb-mtp: fix bounds check for guest
 provided filename
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
	Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416194109.V_OCeHFXm9Y1Fo-1frk4GJFM7FAI0ICaZcZgysfV8pM@z>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The ObjectInfo struct has a variable length array containing the UTF-16
> encoded filename. The number of characters of trailing data is given by
> the 'length' field in the struct and this must be validated against the
> size of the data packet received from the guest.
>
> Since the data is UTF-16, we must convert the byte count we have to a
> character count before validating. This must take care to truncate if
> a malicious guest sent an odd number of bytes.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 838cd74da6..6b7d1296e4 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1699,12 +1699,19 @@ static void usb_mtp_write_metadata(MTPState *s, u=
int64_t dlen)
>      MTPObject *o;
>      MTPObject *p =3D usb_mtp_object_lookup(s, s->dataset.parent_handle);
>      uint32_t next_handle =3D s->next_handle;
> +    size_t filename_chars =3D dlen - offsetof(ObjectInfo, filename);
> +
> +    /*
> +     * filename is utf-16. We're intentionally doing
> +     * integer division to truncate if malicious guest
> +     * sent an odd number of bytes.
> +     */
> +    filename_chars /=3D 2;
>=20=20
>      assert(!s->write_pending);
>      assert(p !=3D NULL);
>=20=20
> -    filename =3D utf16_to_str(MIN(dataset->length,
> -                                dlen - offsetof(ObjectInfo, filename)),
> +    filename =3D utf16_to_str(MIN(dataset->length, filename_chars),
>                              dataset->filename);
>=20=20
>      if (strchr(filename, '/')) {

Reviewed-by: Bandan Das <bsd@redhat.com>


