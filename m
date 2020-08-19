Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5928FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0931F2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHEDVGyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0931F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PO4-0004pY-5W
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8PNM-0003u7-CR
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8PNK-0003e1-Rp
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597848457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UfjLd5iRaNyvwPpArZC2dTAYqKpeQnDn0HC7lhuQaHw=;
 b=OHEDVGyKQpJBwFJ2vBxKZD9tPzqEUGkFD7tKFHzrgbxKS6LKy2XUpfpO90GtjKOxqID5KO
 ivqay2LCdL8GxzHl9DQWzRdqH2oZR23vR2ZM09vcE6tkNv1EZCkxR4lSGykcA6BPiJn8f/
 P6XjkFTW/egrsGWsnKFwn7ScGMUjRBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-iBIQWGAEPGSsPDd4s4PULQ-1; Wed, 19 Aug 2020 10:47:33 -0400
X-MC-Unique: iBIQWGAEPGSsPDd4s4PULQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05ECE1084C8F;
 Wed, 19 Aug 2020 14:47:32 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-120.ams2.redhat.com
 [10.36.113.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0B155C1D0;
 Wed, 19 Aug 2020 14:47:30 +0000 (UTC)
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Kevin Wolf <kwolf@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <20200818142851.GD6865@linux.fritz.box>
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
Message-ID: <59fe8d64-b073-aeff-1afb-b526e9a085f1@redhat.com>
Date: Wed, 19 Aug 2020 16:47:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818142851.GD6865@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="azRFbMc4OzYqnx7Mx8JQ7g90JXmBjF7RC"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 10:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--azRFbMc4OzYqnx7Mx8JQ7g90JXmBjF7RC
Content-Type: multipart/mixed; boundary="PR8o9sQbEqo0bwdQ3qSECuflBURFpAP5r"

--PR8o9sQbEqo0bwdQ3qSECuflBURFpAP5r
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.08.20 16:28, Kevin Wolf wrote:
> Am 25.06.2020 um 17:21 hat Max Reitz geschrieben:
>> Because of the (not so recent anymore) changes that make the stream job
>> independent of the base node and instead track the node above it, we
>> have to split that "bottom" node into two cases: The bottom COW node,
>> and the node directly above the base node (which may be an R/W filter
>> or the bottom COW node).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qapi/block-core.json |  4 +++
>>  block/stream.c       | 63 ++++++++++++++++++++++++++++++++------------
>>  blockdev.c           |  4 ++-
>>  3 files changed, 53 insertions(+), 18 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index b20332e592..df87855429 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2486,6 +2486,10 @@
>>  # On successful completion the image file is updated to drop the backin=
g file
>>  # and the BLOCK_JOB_COMPLETED event is emitted.
>>  #
>> +# In case @device is a filter node, block-stream modifies the first non=
-filter
>> +# overlay node below it to point to base's backing node (or NULL if @ba=
se was
>> +# not specified) instead of modifying @device itself.
>=20
> Not to @base's backing node, but to @base itself (or actually, to
> above_base's backing node, which is initially @base, but may have
> changed when the job is completed).

Oh, yes.

(I thought I had noticed that already at some point and fixed it
locally...  But apparently not.)

> Should we also document what using a filter node for @base means?

Hm.  What does it mean?  I think the more interesting case is what it
means if above_base is a filter, right?

Maybe we can put in somewhere in the =E2=80=9CIf a base file is specified t=
hen
sectors are not copied from that base file and its backing chain.=E2=80=9D =
 But
the more I think about it, the less I know what we could add to it.
What happens if there are filters above @base is that their data isn=E2=80=
=99t
copied, because that=E2=80=99s exactly the data in @base.

Max


--PR8o9sQbEqo0bwdQ3qSECuflBURFpAP5r--

--azRFbMc4OzYqnx7Mx8JQ7g90JXmBjF7RC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl89O4EACgkQ9AfbAGHV
z0Aojgf+PwDpbApo/7g3XZDl52ggNbItoIKEhp/2HYynQl9crIZk3W3QLifjkI9x
ITdrFkxb+A1nR3wzG42avnz4eDG0lptrciDG9tpj3FV4X+avSwkYbW6sv+jGmOzO
XPy8A17LUFmiiRwhTO37mpjkw9UnhGvOSnAMtZ0yrFJIpzB7zqfdOpslhej1u2kY
NRahrTwBVHGiwupnky2C3+iaNyN868vMi4V62r+ZH3W7NuArGYOY+RNpxtB5cF4M
ZN0ELkHRnwO37OuittGJXw/uIeSk4LRdvjDrGlxcte3an1dxHxHh/sHmql06+IDg
8llOU5Yb9S1ZzKa+VmL4UrpMeCts3Q==
=Lo+s
-----END PGP SIGNATURE-----

--azRFbMc4OzYqnx7Mx8JQ7g90JXmBjF7RC--


