Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771EAC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450FE222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diJMVwP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450FE222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwsr-0007HS-DV
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwlF-0006IK-9t
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwlD-0004v2-Oc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:26:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwlD-0004sO-H8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576765599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SL6Q++SW3R38i2YAwTRTNOmZbWdafyRodVx5XIi1TO8=;
 b=diJMVwP2RmDRK1eMwlGoTbckrd3qn2o2eCqOeY2qBnnOwSIhTSGA+Y7IE3X+0jPD1zEuZ3
 TexR0QozZRweLH3+BXkaM5RYCTXJM9OJRf6i1Cwx66z1K1CD8P1t/OiBL9kHKRPJ/PXZ87
 gRQOtUSpdWgKeomE3+XUx4SS8uOKy5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-NxZ0qHyCOpGdTMRxVXKmkw-1; Thu, 19 Dec 2019 09:26:35 -0500
X-MC-Unique: NxZ0qHyCOpGdTMRxVXKmkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B8D91B18BC3;
 Thu, 19 Dec 2019 14:26:34 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-138.brq.redhat.com
 [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BC9760BEC;
 Thu, 19 Dec 2019 14:26:32 +0000 (UTC)
Subject: Re: [PATCH 3/3] iotests: Test external snapshot with VM state
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191217145939.5537-1-kwolf@redhat.com>
 <20191217145939.5537-4-kwolf@redhat.com>
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
Message-ID: <e4212782-78ef-6bc9-f0e4-9a069c47a77b@redhat.com>
Date: Thu, 19 Dec 2019 15:26:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217145939.5537-4-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bT8J9WscWgjgl2LyBpsGIswG75brcyReC"
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bT8J9WscWgjgl2LyBpsGIswG75brcyReC
Content-Type: multipart/mixed; boundary="V9BSntgWk3yrlD9cKC9UcNEorPnYcneKV"

--V9BSntgWk3yrlD9cKC9UcNEorPnYcneKV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.12.19 15:59, Kevin Wolf wrote:
> This tests creating an external snapshot with VM state (which results in
> an active overlay over an inactive backing file, which is also the root
> node of an inactive BlockBackend), re-activating the images and
> performing some operations to test that the re-activation worked as
> intended.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/280     | 83 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/280.out | 50 +++++++++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 134 insertions(+)
>  create mode 100755 tests/qemu-iotests/280
>  create mode 100644 tests/qemu-iotests/280.out

[...]

> diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
> new file mode 100644
> index 0000000000..5d382faaa8
> --- /dev/null
> +++ b/tests/qemu-iotests/280.out
> @@ -0,0 +1,50 @@
> +Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> +
> +=3D=3D=3D Launch VM =3D=3D=3D
> +Enabling migration QMP events on VM...
> +{"return": {}}
> +
> +=3D=3D=3D Migrate to file =3D=3D=3D
> +{"execute": "migrate", "arguments": {"uri": "exec:cat > /dev/null"}}
> +{"return": {}}
> +{"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
> +{"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
> +{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
> +
> +VM is now stopped:
> +completed
> +{"execute": "query-status", "arguments": {}}
> +{"return": {"running": false, "singlestep": false, "status": "postmigrat=
e"}}

Hmmm, I get a finish-migrate status here (on tmpfs)...

Max


--V9BSntgWk3yrlD9cKC9UcNEorPnYcneKV--

--bT8J9WscWgjgl2LyBpsGIswG75brcyReC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl37iJcACgkQ9AfbAGHV
z0DodAgAtZt952h1uyDgkUX5WTorNfv1Y1D19TxWOtr5TWv4h+X9d8fVW9khxxnh
MA3IJJnuc9dPBtAMhzIa/86LOEOfptm9f156vORXW+vTgJHypOMZeP6CAixCRqIz
hZL/d1h73MgABhNdZOHoATq11PI1Fovm7+mZklKL8A2yqwo96cYNIb0WYu/jI4hD
jfle3JOhE61zgdJk0Vf3rTXOeBNDHevFclmxP96cul4L5IOdmy8AE1kitiVWq62q
DCWRexaxni3W782WpP3YSXrsaxJP0ljKd19252j67SVUWW3NPEmjsnF4tnD8YcKL
7sZXeIncKmu7aQZKlUrad6okPXTrgA==
=pZFj
-----END PGP SIGNATURE-----

--bT8J9WscWgjgl2LyBpsGIswG75brcyReC--


