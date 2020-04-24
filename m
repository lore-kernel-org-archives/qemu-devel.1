Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF0BC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576292071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3QTNBPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576292071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRvmH-0002La-CU
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 06:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRvlL-0001YH-SB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRvlK-0001Hu-Jm
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:40:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38202
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRvlK-0001EN-4g
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587724848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ue0z5EgI8Fzg/uVdVMdVCDoYtm3/AjUSmAzKK9UEDYU=;
 b=O3QTNBPC/x8Tegr+zT6nPXcIGCkhcV+iLr5ea5jqG81/lfQK3sdCYNcnxHL0DyFamW2MA/
 4elZLLh887lYLd7L30IX8FnLUuLWgWKW552wLz/MgCsAiSJtfdeWr4Oj2k8fUba+bFAvER
 wgjxSb0ViCtJ8g+wvTb6DVvp+1uadmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-Z6bGdK3ZM1W2i3N2OB2vRg-1; Fri, 24 Apr 2020 06:40:46 -0400
X-MC-Unique: Z6bGdK3ZM1W2i3N2OB2vRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D772800580;
 Fri, 24 Apr 2020 10:40:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-192.ams2.redhat.com
 [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F31BC60CD0;
 Fri, 24 Apr 2020 10:40:43 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] qcow2: Allow resize of images with internal
 snapshots
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200423221707.477404-1-eblake@redhat.com>
 <20200423221707.477404-3-eblake@redhat.com>
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
Message-ID: <d81b626f-25a0-7f88-9788-a44b6a6222ee@redhat.com>
Date: Fri, 24 Apr 2020 12:40:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423221707.477404-3-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jNDKCuQbJ55jxz5q1ihll6i9Iz2b4QVeS"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:11:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jNDKCuQbJ55jxz5q1ihll6i9Iz2b4QVeS
Content-Type: multipart/mixed; boundary="yPTa7I1YflnW0vjJvfet7v0txY8Lb6cUk"

--yPTa7I1YflnW0vjJvfet7v0txY8Lb6cUk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.04.20 00:17, Eric Blake wrote:
> We originally refused to allow resize of images with internal
> snapshots because the v2 image format did not require the tracking of
> snapshot size, making it impossible to safely revert to a snapshot
> with a different size than the current view of the image.  But the
> snapshot size tracking was rectified in v3, and our recent fixes to
> qemu-img amend (see 0a85af35) guarantee that we always have a valid
> snapshot size.  Thus, we no longer need to artificially limit image
> resizes, but it does become one more thing that would prevent a
> downgrade back to v2.  And now that we support different-sized
> snapshots, it's also easy to fix reverting to a snapshot to apply the
> new size.
>=20
> Upgrade iotest 61 to cover this (we previously had NO coverage of
> refusal to resize while snapshots exist).  Note that the amend process
> can fail but still have effects: in particular, since we break things
> into upgrade, resize, downgrade, a failure during resize does not roll
> back changes made during upgrade, nor does failure in downgrade roll
> back a resize.  But this situation is pre-existing even without this
> patch; and without journaling, the best we could do is minimize the
> chance of partial failure by collecting all changes prior to doing any
> writes - which adds a lot of complexity but could still fail with EIO.
> On the other hand, we are careful that even if we have partial
> modification but then fail, the image is left viable (that is, we are
> careful to sequence things so that after each successful cluster
> write, there may be transient leaked clusters but no corrupt
> metadata).  And complicating the code to make it more transaction-like
> is not worth the effort: a user can always request multiple 'qemu-img
> amend' changing one thing each, if they need finer-grained control
> over detecting the first failure than what they get by letting qemu
> decide how to sequence multiple changes.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-snapshot.c     | 20 ++++++++++++++++----
>  block/qcow2.c              | 25 ++++++++++++++++++++++---
>  tests/qemu-iotests/061     | 35 +++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/061.out | 28 ++++++++++++++++++++++++++++
>  4 files changed, 101 insertions(+), 7 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--yPTa7I1YflnW0vjJvfet7v0txY8Lb6cUk--

--jNDKCuQbJ55jxz5q1ihll6i9Iz2b4QVeS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6iwioACgkQ9AfbAGHV
z0Av2Qf+LIZQktE/zbtOeLLgf0vEJyCIqMIqi9AlxMlEVi3wTCGzYc6QzRh5hSCb
vt3T6Q2RWSagmp0Q8+prZOQT2B85sdYgJrQ6MJP2rY8LGEfrCvGhbQ9/nEE3KTuO
NKVw6fKeI3RKzhqVDbQDdrDXftszoG45zU+TEoYF89mzSAtygS9dL8XYaRh1C5WK
8LKwA3xQ7l+DqyVFXBm/Ap3TLWpKayO7xOtbm3j1dyzpCLJW9VzdFgGsX/2Q4Ikt
Ou4Z/kjzsMFVESrj/r39xYE3yrlxxXv/DW6lt7KXuEYLAx522wOmPxK4mk5ZJRPw
ign4Epj3w/RqP6TiEoWwNS7es1eREA==
=k9s0
-----END PGP SIGNATURE-----

--jNDKCuQbJ55jxz5q1ihll6i9Iz2b4QVeS--


