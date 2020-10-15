Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FEBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B84321D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlBcctqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B84321D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5ia-0002g7-50
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT5fW-0000rK-EH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT5fU-0002gY-Pl
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602777591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=09JeDkoVMCzZEAn8jAqlQnccRUO2+gAFGP+MZh8QAQc=;
 b=hlBcctqZzT4dd2YBWQUDl7KZxBlgJySZxJrbpydJ4ijSppwjvoUQzj09mMNFGdCxLjlAa5
 ka73So3Cw9XYN8heJAyFfceB4ZxXHSUYyrUtDvkTqEpx91MeBfg102jrIOv9cfIqESabhQ
 yRBs36roV5o10JEomgMFp+Xd13lv75o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-O5-Pdg28MUGjglknd2Dgrw-1; Thu, 15 Oct 2020 11:59:49 -0400
X-MC-Unique: O5-Pdg28MUGjglknd2Dgrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A31201020904;
 Thu, 15 Oct 2020 15:59:48 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69EEB19C4F;
 Thu, 15 Oct 2020 15:59:43 +0000 (UTC)
Subject: Re: [PATCH v2 02/20] fuse: Allow exporting BDSs via FUSE
To: Kevin Wolf <kwolf@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-3-mreitz@redhat.com>
 <20201015085703.GB4610@merkur.fritz.box>
 <2db9dbfe-137a-4cdc-08ab-aaa1aed26423@redhat.com>
 <20201015154123.GK4610@merkur.fritz.box>
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
Message-ID: <256dd14e-f5c3-7f83-60e0-9bdacdcd5f99@redhat.com>
Date: Thu, 15 Oct 2020 17:59:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015154123.GK4610@merkur.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dmDStrMlmfgGInukuXDnJuQBIu6G1TFLH"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dmDStrMlmfgGInukuXDnJuQBIu6G1TFLH
Content-Type: multipart/mixed; boundary="gpfHs4WhK3wu2IpKSWUgF0E6kpw8SZj7V"

--gpfHs4WhK3wu2IpKSWUgF0E6kpw8SZj7V
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.10.20 17:41, Kevin Wolf wrote:
> Am 15.10.2020 um 16:46 hat Max Reitz geschrieben:
>> On 15.10.20 10:57, Kevin Wolf wrote:
>>> Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:

[...]

>>>> +static void fuse_export_shutdown(BlockExport *blk_exp)
>>>> +{
>>>> +    FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
>>>> +
>>>> +    if (exp->fuse_session) {
>>>> +        fuse_session_exit(exp->fuse_session);
>>>> +
>>>> +        if (exp->mounted) {
>>>> +            fuse_session_unmount(exp->fuse_session);
>>>> +            exp->mounted =3D false;
>>>> +        }
>>>> +
>>>> +        if (exp->fd_handler_set_up) {
>>>> +            aio_set_fd_handler(exp->common.ctx,
>>>> +                               fuse_session_fd(exp->fuse_session), tr=
ue,
>>>> +                               NULL, NULL, NULL, NULL);
>>>> +            exp->fd_handler_set_up =3D false;
>>>> +        }
>>>> +
>>>> +        fuse_session_destroy(exp->fuse_session);
>>>> +        exp->fuse_session =3D NULL;
>>>
>>> What happens if a request is still in flight?
>>>
>>> Oh, can't happen because the driver is fully synchronous after this
>>> series. Fair enough, making it asynchronous can come on top of it.
>>
>> (I had multiple approaches of handling parallel requests, but none made
>> a substantial performance difference, which is why I left the driver in
>> the most simple form for this first proposal.)
>=20
> I think the more relevant part is that we'd block the guest or anything
> else running in the main loop while doing I/O.
>=20
> Not a problem if you spawn a new qemu-storage-daemon just for this FUSE
> export, but if you want to have multiple exports, or export from the
> system emulator, you probably don't want to have synchronous operations.

Ah, hm.  Hmm. O:)

Does NBD work any different, though?  I had always assumed it runs in
the BB=E2=80=99s context.

Max


--gpfHs4WhK3wu2IpKSWUgF0E6kpw8SZj7V--

--dmDStrMlmfgGInukuXDnJuQBIu6G1TFLH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+Ice4ACgkQ9AfbAGHV
z0A+wwf43I78j5ybMn2TXKqTXEqWyauplvYusid+vdtzNqov7rD1+IPNYfO6vB6A
gTP0AnyzzZVUQXiqu5cW82y2EsAQwhsKIskmz7In2BePbQMfrCmdIbjUk8G52Pht
KESpkuID3uVqCoFztpmB0U+mGeN5ULtkKZkfgIjtozpZ1q+EEPqTz4g5ZPphjWDA
nQjkpFhKqihrcT+yq5YsMC0020eXv8Out7b2PlG+f/zSTHuB3fVUAUEBPTGv1u9V
o1H1HdrSSckJqMxektvQ4rQrDc53R4AZ1HLFRL7ofoxO3dUa5JLCE1q/UFQhcy1q
B9zEAkYpOWQ/vt4AhZ6/Mfq47qeL
=TEOg
-----END PGP SIGNATURE-----

--dmDStrMlmfgGInukuXDnJuQBIu6G1TFLH--


