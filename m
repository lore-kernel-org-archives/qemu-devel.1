Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE55C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E999720787
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1+gpxPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E999720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5TE-0006Nm-7O
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw5Rm-00057m-RH
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:05:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22831
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw5Rj-0005UE-0f
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594911913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EqtAymNnWKHyK7ax1HuY9PiJGolkm4p8rJSpXIR4ByU=;
 b=X1+gpxPvScjzOP0GjQI3lduLfW88EJBhvjd9lCmWXYxaEqMjKq0uMu13iWLenalCDcStYA
 xviXADmhKOIo00oKPb8tT/nrXcXNmPNcpjOOTPLTBDAi/KBn6dszxprw61P+JcrM73eBq0
 YrfSma3tAKv3XoB7qt0KdyvcyCCgCz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-cX5-GlqePx2LDMw1V6I0Dw-1; Thu, 16 Jul 2020 11:04:54 -0400
X-MC-Unique: cX5-GlqePx2LDMw1V6I0Dw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D02A800470;
 Thu, 16 Jul 2020 15:04:53 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-160.ams2.redhat.com
 [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB84210013D0;
 Thu, 16 Jul 2020 15:04:51 +0000 (UTC)
Subject: Re: [PATCH v7 17/47] block: Re-evaluate backing file handling in
 reopen
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-18-mreitz@redhat.com>
 <cb80dda7-e3e1-afb1-10b5-18b09eb9669b@virtuozzo.com>
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
Message-ID: <a3e67faa-ca03-d950-2dcc-8a9d340c0fa6@redhat.com>
Date: Thu, 16 Jul 2020 17:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cb80dda7-e3e1-afb1-10b5-18b09eb9669b@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZnjDr1SOOMUnVl6lukaiM0BQ2IVJGC4Xg"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZnjDr1SOOMUnVl6lukaiM0BQ2IVJGC4Xg
Content-Type: multipart/mixed; boundary="I1WAJ9lh6Mlijs0OtbCIudsgfa7OzgRM0"

--I1WAJ9lh6Mlijs0OtbCIudsgfa7OzgRM0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.20 21:42, Andrey Shinkevich wrote:
> On 25.06.2020 18:21, Max Reitz wrote:
>> Reopening a node's backing child needs a bit of special handling because
>> the "backing" child has different defaults than all other children
>> (among other things).=C2=A0 Adding filter support here is a bit more
>> difficult than just using the child access functions.=C2=A0 In fact, we =
often
>> have to directly use bs->backing because these functions are about the
>> "backing" child (which may or may not be the COW backing file).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 block.c | 46 ++++++++++++++++++++++++++++++++++++++--------
>> =C2=A0 1 file changed, 38 insertions(+), 8 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 712230ef5c..8131d0b5eb 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -4026,26 +4026,56 @@ static int
>> bdrv_reopen_parse_backing(BDRVReopenState *reopen_state,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure that @bs can really handle backing fi=
les, because we are
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * about to give it one (or swap the existing o=
ne)
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (bs->drv->is_filter) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Filters always have a fil=
e or a backing child */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bs->backing) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_setg(errp, "'%s' is a %s filter node that does not
>> support a "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "backing ch=
ild", bs->node_name,
>> bs->drv->format_name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 } else if (!bs->drv->supports_backing) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Driver '%s=
' of node '%s' does not support
>> backing "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "files", bs->drv->format_name, bs->=
node_name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Find the "actual" backing file by=
 skipping all links that point
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to an implicit node, if any (e.g.=
 a commit filter node).
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We cannot use any of the bdrv_skip_*() funct=
ions here because
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * those return the first explicit node, while =
we are looking for
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * its overlay here.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 overlay_bs =3D bs;
>> -=C2=A0=C2=A0=C2=A0 while (backing_bs(overlay_bs) && backing_bs(overlay_=
bs)->implicit) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 overlay_bs =3D backing_bs(ov=
erlay_bs);
>> +=C2=A0=C2=A0=C2=A0 while (bdrv_filter_or_cow_bs(overlay_bs) &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_filte=
r_or_cow_bs(overlay_bs)->implicit)
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 overlay_bs =3D bdrv_filter_o=
r_cow_bs(overlay_bs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> I believe that little optimization would work properly:
>=20
>=20
> for (BlockDriverState *below_bs =3D bdrv_filter_or_cow_bs(overlay_bs);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 below_bs && below_bs->implicit;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 below_bs =3D bdrv_filter_or_cow_bs(o=
verlay_bs)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 overlay_bs =3D below_bs;
> }

Looks good, thanks.

>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If we want to replace the backi=
ng file we need some extra
>> checks */
>> -=C2=A0=C2=A0=C2=A0 if (new_backing_bs !=3D backing_bs(overlay_bs)) {
>> +=C2=A0=C2=A0=C2=A0 if (new_backing_bs !=3D bdrv_filter_or_cow_bs(overla=
y_bs)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check for impl=
icit nodes between bs and its backing file */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bs !=3D overl=
ay_bs) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_setg(errp, "Cannot change backing link if '%s' has "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "a=
n implicit backing file", bs->node_name);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EPERM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check if the backing link=
 that we want to replace is
>> frozen */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_is_backing_chain_fr=
ozen(overlay_bs,
>> backing_bs(overlay_bs),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 errp)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Check if the backing=
 link that we want to replace is frozen.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note that
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_filter_or_cow_c=
hild(overlay_bs) =3D=3D overlay_bs->backing,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * because we know that=
 overlay_bs =3D=3D bs, and that @bs
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * either is a filter t=
hat uses ->backing or a COW format BDS
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * with bs->drv->suppor=
ts_backing =3D=3D true.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_is_backing_chain_fr=
ozen(overlay_bs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0
>> child_bs(overlay_bs->backing), errp))
> What would be wrong with bdrv_filter_or_cow_bs(overlay_bs) here?

As the comment says, it=E2=80=99s the same thing.

I prefer ->backing here, because this function is about reopening the
->backing child.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EPERM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reopen_state->rep=
lace_backing_bs =3D true;
>> @@ -4196,7 +4226,7 @@ int bdrv_reopen_prepare(BDRVReopenState
>> *reopen_state, BlockReopenQueue *queue,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * its metadata. Otherwise the 'back=
ing' option can be omitted.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (drv->supports_backing && reopen_state=
->backing_missing &&
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (backing_bs(reopen_state->bs=
) ||
>> reopen_state->bs->backing_file[0])) {
> =3D BlockDriverState*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (reopen_state->bs->backing |=
|
>> reopen_state->bs->backing_file[0])) {
>=20
> =3D BdrvChild*
>=20
> Are we OK with that?

Sure, the question is whether it=E2=80=99s non-NULL, and BdrvChild.bs is al=
ways
non-NULL.

Max


--I1WAJ9lh6Mlijs0OtbCIudsgfa7OzgRM0--

--ZnjDr1SOOMUnVl6lukaiM0BQ2IVJGC4Xg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8QbJIACgkQ9AfbAGHV
z0Dy+gf7B+nz1yRFu6L8gf/JaKDBuxA3otKf/qNutGaNAVX1E9970fiHUSNzRddt
448qeSdNYy+4cCLjE54F8qNgJu8Kd0+kUrYMU7O0u/gx1jRnAfTf/F9ZY1oIWzFQ
f7/sY5fjbNEFAsnPXjwu5CVQMlKbj1w5TO/VvU2FNvbGpUK80/yru4d3DvDWesak
FQDCWZ/f6rSBLB+bnWOu0hq8FHjx7NrDRgX9lJjnl4xiARbSpw5teqCs+Sr9swG8
3eEYRukLDLofmJcG7uRe9UBT6/PcYGx2TkIfo8MC9MwiyqWLVnk37mgPTkVqrXqz
+Lo0bvzwk/ZQzN8gSyU3H2iims1JFw==
=z0tU
-----END PGP SIGNATURE-----

--ZnjDr1SOOMUnVl6lukaiM0BQ2IVJGC4Xg--


