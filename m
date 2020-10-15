Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AC4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AD92225A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLP40KqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AD92225A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT59o-0004Md-FP
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT53j-0005u5-66
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT53f-0005tl-L9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602775247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sPkERPxQzU98YTG8x3RMDMyBMyx/8vrOFeEuoebNHwM=;
 b=HLP40KqBSKI8GUWmRuODhYhzdUbEtXVHfRgTeu7PKkDsNJEyDWxWmuCl5ecEqFyg+/qapG
 KXS8X3TTYaHyUYGr0myfmsb0TXcbVkuB9lM0LAhrRy1l1d5JSAY9uxq8pl9X2M9SdMhVZE
 tZMNqIVibQI5SEK3btEBivYbPueeb1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-uhdjOSFgNnyzuQJMory3vA-1; Thu, 15 Oct 2020 11:20:44 -0400
X-MC-Unique: uhdjOSFgNnyzuQJMory3vA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98B521091063;
 Thu, 15 Oct 2020 15:20:43 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6041519C66;
 Thu, 15 Oct 2020 15:20:39 +0000 (UTC)
Subject: Re: [PATCH v2 04/20] fuse: Allow growable exports
To: Kevin Wolf <kwolf@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-5-mreitz@redhat.com>
 <20201015104152.GD4610@merkur.fritz.box>
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
Message-ID: <4741b027-7ec2-9c0f-7826-1e1d92c9d2a7@redhat.com>
Date: Thu, 15 Oct 2020 17:20:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015104152.GD4610@merkur.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ql757v81T15NpIJ0dyYtK5yaAc41rS2Zm"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
--ql757v81T15NpIJ0dyYtK5yaAc41rS2Zm
Content-Type: multipart/mixed; boundary="rqmdPSRfXN48ACF6yrqKLwm2P0oWOSjqX"

--rqmdPSRfXN48ACF6yrqKLwm2P0oWOSjqX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.10.20 12:41, Kevin Wolf wrote:
> Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:
>> These will behave more like normal files in that writes beyond the EOF
>> will automatically grow the export size.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qapi/block-export.json |  6 +++++-
>>  block/export/fuse.c    | 12 +++++++++++-
>>  2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>> index cb5bd54cbf..cb26daa98b 100644
>> --- a/qapi/block-export.json
>> +++ b/qapi/block-export.json
>> @@ -183,10 +183,14 @@
>>  # @mountpoint: Path on which to export the block device via FUSE.
>>  #              This must point to an existing regular file.
>>  #
>> +# @growable: Whether writes beyond the EOF should grow the block node
>> +#            accordingly. (default: false)
>> +#
>>  # Since: 5.2
>>  ##
>>  { 'struct': 'BlockExportOptionsFuse',
>> -  'data': { 'mountpoint': 'str' },
>> +  'data': { 'mountpoint': 'str',
>> +            '*growable': 'bool' },
>>    'if': 'defined(CONFIG_FUSE)' }
>> =20
>>  ##
>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>> index 8fc667231d..f3a84579ba 100644
>> --- a/block/export/fuse.c
>> +++ b/block/export/fuse.c
>> @@ -45,6 +45,7 @@ typedef struct FuseExport {
>> =20
>>      char *mountpoint;
>>      bool writable;
>> +    bool growable;
>>  } FuseExport;
>> =20
>>  static GHashTable *exports;
>> @@ -101,6 +102,7 @@ static int fuse_export_create(BlockExport *blk_exp,
>> =20
>>      exp->mountpoint =3D g_strdup(args->mountpoint);
>>      exp->writable =3D blk_exp_args->writable;
>> +    exp->growable =3D args->growable;
>> =20
>>      ret =3D setup_fuse_export(exp, args->mountpoint, errp);
>>      if (ret < 0) {
>> @@ -436,7 +438,15 @@ static void fuse_write(fuse_req_t req, fuse_ino_t i=
node, const char *buf,
>> =20
>>      size =3D MIN(size, BDRV_REQUEST_MAX_BYTES);
>>      if (offset + size > length) {
>> -        size =3D length - offset;
>> +        if (exp->growable) {
>> +            ret =3D fuse_do_truncate(exp, offset + size, PREALLOC_MODE_=
OFF);
>=20
> Do we need BDRV_REQ_ZERO_WRITE for blk_truncate() in this case?

Ah, yes.  (Sorry, code is a bit old and I forgot when I revised it...)

> Actually, since we export a regular file, it would probably be good for
> the setattr case, too.

Yes.

> If someone actually uses this to sequentially write past the end of the
> file, it will be quite inefficient because fuse_do_truncate() temporarily
> acquires locks for each write request. It might be a good idea to
> acquire BLK_PERM_RESIZE from the start for growable exports (like image
> formats do for bs->file).

Oh, yes, that makes sense.

Max


--rqmdPSRfXN48ACF6yrqKLwm2P0oWOSjqX--

--ql757v81T15NpIJ0dyYtK5yaAc41rS2Zm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+IaMUACgkQ9AfbAGHV
z0CS9Af+PiQNr6bgJJpfOHrYf3fTm4+qxu6g1Bh6NNcIrQT+eilPyg+ycyT/55J1
zzldFFZxdlM0xUjFWdFyIKdYWeVujn1+ZkaYF6rqYP937jXFSc0JnFHBhR7+tftY
vhP5tnmMPCrBpIt7gdPWz35xmcUMzgrbUqqXUbafyTcRViADnXVn9DaowiRYPQjv
kr1FRT/blLgWFt3DJoyVumj2hqlYOV+wgTFdFej0oamKPsK1Lf2moS/um5V//kWj
M3iUqL1/whfLBjzSCM/ivevoi1qDxGUxRTMjQZ3ABSIVi5yEQ7M1LkRF6irEYo2T
kEPHfaRjuRbnGC7DOFnfi5rDHWeWQA==
=hxSX
-----END PGP SIGNATURE-----

--ql757v81T15NpIJ0dyYtK5yaAc41rS2Zm--


