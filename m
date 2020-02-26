Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F10C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C239B20838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cx7a6L86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C239B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vAY-00078J-SE
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6uv0-0002nw-VK
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6uuy-0003WU-LA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:31:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26268
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6uuy-0003TJ-2J
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582716715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0d2LzEbMYOs3lA1aaipDpYIU+ranAMMfzzQ4UpmFJO8=;
 b=Cx7a6L86+IEq9qZI3Bw3zGnfoXR6E2+IfSe2o90uFvdM+V6YnkINR1i1cMBtQarPd8dQAW
 9SeUlk3OthVz5kcg37fxtNnj3nQLy1/1eUfRmTHSNaV5afFP5mVzbXNkOdXpLH3Y7rEVuv
 8ryXpgv/JO9QI5Drvu47ZMD8DQQ1YfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-ur8IZiemN4SbGZE1xTTECA-1; Wed, 26 Feb 2020 06:31:47 -0500
X-MC-Unique: ur8IZiemN4SbGZE1xTTECA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37305DB20;
 Wed, 26 Feb 2020 11:31:46 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 683C026FCF;
 Wed, 26 Feb 2020 11:31:44 +0000 (UTC)
Subject: Re: [PATCH 2/2] iotests: modify test 040 to use JobRunner
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200226004425.1303-1-jsnow@redhat.com>
 <20200226004425.1303-3-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <cce4c6e0-f743-fb88-a441-405233467074@redhat.com>
Date: Wed, 26 Feb 2020 12:31:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226004425.1303-3-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XY5MXgcihhWvvZQKzH1ishBVYogZMOqrL"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XY5MXgcihhWvvZQKzH1ishBVYogZMOqrL
Content-Type: multipart/mixed; boundary="OG4yMKGX4wT1l24EjPOOvCDMDaXkswkE9"

--OG4yMKGX4wT1l24EjPOOvCDMDaXkswkE9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.02.20 01:44, John Snow wrote:
> Instead of having somewhat reproduced it for itself.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/040 | 51 +++++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 26 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
> index 90b59081ff..579dafc797 100755
> --- a/tests/qemu-iotests/040
> +++ b/tests/qemu-iotests/040
> @@ -483,34 +483,33 @@ class TestErrorHandling(iotests.QMPTestCase):
>                            file=3D('top-dbg' if top_debug else 'top-file'=
),
>                            backing=3D'mid-fmt')
> =20
> +
> +    class TestJobRunner(iotests.JobRunner):
> +        expected_events =3D ('BLOCK_JOB_COMPLETED',
> +                           'BLOCK_JOB_ERROR',
> +                           'BLOCK_JOB_READY')
> +
> +        def __init__(self, *args, test, **kwargs):
> +            super().__init__(*args, **kwargs)
> +            self.log =3D []
> +            self.test =3D test
> +
> +        def on_pause(self, event):
> +            result =3D self._vm.qmp('block-job-resume', device=3Dself._i=
d)
> +            self.test.assert_qmp(result, 'return', {})
> +            super().on_pause(event)

Not that it functionally matters, but I suppose I=E2=80=99d call
super().on_pause() before resuming (because the job isn=E2=80=99t exactly p=
aused
afterwards).

> +
> +        def on_block_job_event(self, event):
> +            if event['event'] not in self.expected_events:
> +                self.test.fail("Unexpected event: %s" % event)
> +            super().on_block_job_event(event)
> +            self.log.append(iotests.filter_qmp_event(event))

Hasn=E2=80=99t the event been through filter_qmp_event() already?

Max

> +
>      def run_job(self, expected_events, error_pauses_job=3DFalse):
> -        match_device =3D {'data': {'device': 'job0'}}
> -        events =3D {
> -            'BLOCK_JOB_COMPLETED': match_device,
> -            'BLOCK_JOB_CANCELLED': match_device,
> -            'BLOCK_JOB_ERROR': match_device,
> -            'BLOCK_JOB_READY': match_device,
> -        }
> -
> -        completed =3D False
> -        log =3D []
> -        while not completed:
> -            ev =3D self.vm.events_wait(events, timeout=3D5.0)
> -            if ev['event'] =3D=3D 'BLOCK_JOB_COMPLETED':
> -                completed =3D True
> -            elif ev['event'] =3D=3D 'BLOCK_JOB_ERROR':
> -                if error_pauses_job:
> -                    result =3D self.vm.qmp('block-job-resume', device=3D=
'job0')
> -                    self.assert_qmp(result, 'return', {})
> -            elif ev['event'] =3D=3D 'BLOCK_JOB_READY':
> -                result =3D self.vm.qmp('block-job-complete', device=3D'j=
ob0')
> -                self.assert_qmp(result, 'return', {})
> -            else:
> -                self.fail("Unexpected event: %s" % ev)
> -            log.append(iotests.filter_qmp_event(ev))
> -
> +        job =3D self.TestJobRunner(self.vm, 'job0', use_log=3DFalse, tes=
t=3Dself)
> +        job.run()
>          self.maxDiff =3D None
> -        self.assertEqual(expected_events, log)
> +        self.assertEqual(expected_events, job.log)
> =20
>      def event_error(self, op, action):
>          return {
>=20



--OG4yMKGX4wT1l24EjPOOvCDMDaXkswkE9--

--XY5MXgcihhWvvZQKzH1ishBVYogZMOqrL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5WVx4ACgkQ9AfbAGHV
z0DPBgf9HBWaG+kY6pPPEqhVyEQ9BX40yaC6dvkylo+YRjkf7DP8PoCmsBm2BONO
qwqxSlT2x2lytVJVcHBcBmxJM+q8zgmBBbCpt+9y72EPZrr0qVkxtd9hKw+O7H8n
DM2Wfw0APIBlHdvoyH+YWaqudgnSjt7FiZoowqt2s+K2gdqk2Zc3HjGqAbyxlJtk
wqxT0GETzokYM57tBGrrWKPXYAurx35YJ69y+FyDzOcBOhFqrpuplKWLctRXTXAy
e+r/TJYh7JpLeZftiOIy9bR0vFeaFtMVtlFnGpRG8q83HaLfrM5uYhZ9RNRfU7yk
vUjjDL4z+lpuBtFMs6tjX9ZQDRJUOQ==
=l0+K
-----END PGP SIGNATURE-----

--XY5MXgcihhWvvZQKzH1ishBVYogZMOqrL--


